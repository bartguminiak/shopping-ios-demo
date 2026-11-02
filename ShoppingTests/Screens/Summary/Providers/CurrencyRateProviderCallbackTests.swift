import Foundation
import Testing
@testable import Shopping

@Suite
struct CurrencyRateProviderCallbackTests {
    @Test
    func successUsesMainQueue() async throws {
        let session = SessionStub()
        let provider = CurrencyRateProvider(session: session)
        let result = CallbackRecorder()
        provider.getCurrencies(completion: result.record)
        let task = try #require(session.createdTasks.first)
        task.finish(data: Data(#"{"success":true,"quotes":{"USDPLN":4.0}}"#.utf8),
                    response: try response())
        await drainMainQueue()
        #expect(result.calls.count == 1)
        #expect(result.calls.first?.0.first?.name == "USDPLN")
        #expect(result.calls.first?.0.first?.rate == 4)
        #expect(result.calls.first?.1 == nil)
    }

    @Test(arguments: 0..<5)
    func failuresCompleteOnMainQueue(scenario: Int) async throws {
        let session = SessionStub()
        let provider = CurrencyRateProvider(session: session)
        let result = CallbackRecorder()
        provider.getCurrencies(completion: result.record)
        let task = try #require(session.createdTasks.first)
        switch scenario {
        case 0:
            task.finish(error: URLError(.notConnectedToInternet))
        case 1:
            task.finish(data: Data(), response: try response(status: 500))
        case 2:
            task.finish(data: Data("invalid JSON".utf8), response: try response())
        case 3:
            task.finish(response: try response())
        default:
            task.finish(data: Data())
        }
        await drainMainQueue()
        #expect(result.calls.count == 1)
        #expect(result.calls.first?.0.isEmpty == true)
        #expect(result.calls.first?.1 != nil)
    }

    @Test(arguments: ["https://[", "", "relative/path", "ftp://example.com"])
    func invalidURLCompletes(url: String) async {
        let session = SessionStub()
        let provider = CurrencyRateProvider(session: session, currencyRatesUrl: url)
        let result = CallbackRecorder()
        provider.getCurrencies(completion: result.record)
        await drainMainQueue()
        #expect(session.createdTasks.isEmpty)
        #expect(result.calls.count == 1)
        #expect((result.calls.first?.1 as? URLError)?.code == .badURL)
    }

    @Test
    func cancellationKeepsCallbacksAndCurrentTaskSeparate() async throws {
        let session = SessionStub()
        let provider = CurrencyRateProvider(session: session)
        let first = CallbackRecorder()
        let second = CallbackRecorder()
        let third = CallbackRecorder()
        provider.getCurrencies(completion: first.record)
        provider.getCurrencies(completion: second.record)
        #expect(session.createdTasks[0].wasCancelled)

        session.createdTasks[0].finish(error: URLError(.cancelled))
        await drainMainQueue()
        #expect(first.calls.count == 1)
        #expect((first.calls.first?.1 as? URLError)?.code == .cancelled)
        #expect(second.calls.isEmpty)

        provider.getCurrencies(completion: third.record)
        #expect(session.createdTasks[1].wasCancelled)
        session.createdTasks[1].finish(error: URLError(.cancelled))
        session.createdTasks[2].finish(data: Data(#"{"success":true,"quotes":{"USDCHF":0.9}}"#.utf8),
                                response: try response())
        await drainMainQueue()
        #expect(first.calls.count == 1)
        #expect(second.calls.count == 1)
        #expect((second.calls.first?.1 as? URLError)?.code == .cancelled)
        #expect(third.calls.count == 1)
        #expect(third.calls.first?.0.first?.name == "USDCHF")
        #expect(third.calls.first?.1 == nil)
    }

    @Test
    func completionSurvivesProviderDeallocation() async throws {
        let session = SessionStub()
        var provider: CurrencyRateProvider? = CurrencyRateProvider(session: session)
        let isProviderReleased = { [weak provider] in provider == nil }
        let result = CallbackRecorder()
        provider?.getCurrencies(completion: result.record)
        provider = nil
        #expect(isProviderReleased())
        let task = try #require(session.createdTasks.first)
        task.finish(error: URLError(.timedOut))
        await drainMainQueue()
        #expect(result.calls.count == 1)
        #expect((result.calls.first?.1 as? URLError)?.code == .timedOut)
    }

    @Test
    func synchronousCancellationCallbackDoesNotDeadlock() async throws {
        let session = SessionStub()
        let provider = CurrencyRateProvider(session: session)
        let first = CallbackRecorder()
        let second = CallbackRecorder()
        provider.getCurrencies(completion: first.record)
        let firstTask = try #require(session.createdTasks.first)
        firstTask.completesOnCancel = true

        provider.getCurrencies(completion: second.record)
        let secondTask = try #require(session.createdTasks.last)
        secondTask.finish(error: URLError(.timedOut))
        await drainMainQueue()

        #expect(first.calls.count == 1)
        #expect((first.calls.first?.1 as? URLError)?.code == .cancelled)
        #expect(second.calls.count == 1)
        #expect((second.calls.first?.1 as? URLError)?.code == .timedOut)
    }

    @Test
    func synchronousResumeCallbackDoesNotDeadlock() async {
        let session = SessionStub()
        session.completesOnResume = true
        let provider = CurrencyRateProvider(session: session)
        let result = CallbackRecorder()
        provider.getCurrencies(completion: result.record)
        await drainMainQueue()
        #expect(result.calls.count == 1)
        #expect((result.calls.first?.1 as? URLError)?.code == .timedOut)
    }

    @Test
    func queuedSuccessKeepsItsOriginalCallback() async throws {
        let session = SessionStub()
        let provider = CurrencyRateProvider(session: session)
        let first = CallbackRecorder()
        let second = CallbackRecorder()
        let successResponse = try response()

        await MainActor.run {
            provider.getCurrencies(completion: first.record)
            session.createdTasks[0].finish(
                data: Data(#"{"success":true,"quotes":{"USDPLN":4.0}}"#.utf8),
                response: successResponse)
            provider.getCurrencies(completion: second.record)
            #expect(!session.createdTasks[0].wasCancelled)
            #expect(first.calls.isEmpty)
            #expect(second.calls.isEmpty)
            session.createdTasks[1].finish(error: URLError(.timedOut))
        }
        await drainMainQueue()
        #expect(first.calls.count == 1)
        #expect(first.calls.first?.0.first?.name == "USDPLN")
        #expect(first.calls.first?.1 == nil)
        #expect(second.calls.count == 1)
        #expect((second.calls.first?.1 as? URLError)?.code == .timedOut)
    }

    private func response(status: Int = 200) throws -> HTTPURLResponse {
        let url = try #require(URL(string: "https://example.com"))
        return try #require(HTTPURLResponse(url: url, statusCode: status,
                                            httpVersion: nil, headerFields: nil))
    }

    private func drainMainQueue() async {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.async { continuation.resume() }
        }
    }
}

private final class CallbackRecorder {
    private let lock = NSLock()
    private var storedCalls: [([Currency], Error?)] = []

    var calls: [([Currency], Error?)] {
        lock.lock()
        defer { lock.unlock() }
        return storedCalls
    }

    func record(_ currencies: [Currency], _ error: Error?) {
        #expect(Thread.isMainThread)
        lock.lock()
        defer { lock.unlock() }
        storedCalls.append((currencies, error))
    }
}

private final class SessionStub: CurrencyRateSession {
    var createdTasks: [TaskStub] = []
    var completesOnResume = false

    func makeDataTask(with url: URL,
                           completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> CurrencyRateDataTask {
        let task = TaskStub(completion: completionHandler)
        task.completesOnResume = completesOnResume
        createdTasks.append(task)
        return task
    }
}

private final class TaskStub: CurrencyRateDataTask {
    private let completion: (Data?, URLResponse?, Error?) -> Void
    private(set) var wasCancelled = false
    var completesOnCancel = false
    var completesOnResume = false

    init(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completion = completion
    }

    func resume() {
        if completesOnResume {
            finish(error: URLError(.timedOut))
        }
    }

    func cancel() {
        wasCancelled = true
        if completesOnCancel {
            finish(error: URLError(.cancelled))
        }
    }

    func finish(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        completion(data, response, error)
    }
}
