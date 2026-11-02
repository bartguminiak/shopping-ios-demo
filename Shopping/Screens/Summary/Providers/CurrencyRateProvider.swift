import Foundation

class CurrencyRateProvider: CurrencyRateProviding {

    init(quotes: [String] = ["EUR", "GBP", "CAD", "PLN", "CHF", "NOK"],
         session: CurrencyRateSession = URLSession.shared,
         currencyRatesUrl: String = "https://apilayer.net/api/live") {
        self.quotes = quotes
        self.session = session
        self.currencyRatesUrl = currencyRatesUrl
    }

    func getCurrencies(completion: @escaping ([Currency], Error?) -> Void) {
        guard var urlComponents = URLComponents(string: currencyRatesUrl) else {
            replaceTask(nil, id: nil)?.cancel()
            Self.complete([], URLError(.badURL), completion: completion)
            return
        }
        urlComponents.query = query
        guard let url = urlComponents.url,
              let scheme = url.scheme?.lowercased(),
              ["http", "https"].contains(scheme),
              let host = url.host, !host.isEmpty else {
            replaceTask(nil, id: nil)?.cancel()
            Self.complete([], URLError(.badURL), completion: completion)
            return
        }

        let id = UUID()
        let task = session.makeDataTask(with: url) { [weak self] data, response, error in
            self?.clearTask(for: id)

            if let error = error {
                Self.complete([], error, completion: completion)
                return
            }
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data else {
                Self.complete([], URLError(.badServerResponse), completion: completion)
                return
            }
            do {
                let currencyResponse = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                let currencies = currencyResponse.quotes.map { Currency(name: $0.key, rate: $0.value) }
                Self.complete(currencies, nil, completion: completion)
            } catch {
                Self.complete([], error, completion: completion)
            }
        }
        let previousTask = replaceTask(task, id: id)
        previousTask?.cancel()
        task.resume()
    }

    private let session: CurrencyRateSession
    private let taskLock = NSLock()
    private var dataTask: CurrencyRateDataTask?
    private var requestID: UUID?
    private let currencyRatesUrl: String
    private let quotes: [String]

    private var query: String {
        let quotesString = quotes.reduce("", { $0 + "," + $1 })
        let yourAPIKey = ""
        return "access_key=\(yourAPIKey)&currencies=\(quotesString)&source=USD&format=1"
    }

    private func replaceTask(_ task: CurrencyRateDataTask?, id: UUID?) -> CurrencyRateDataTask? {
        taskLock.lock()
        defer { taskLock.unlock() }
        let previousTask = dataTask
        dataTask = task
        requestID = id
        return previousTask
    }

    private func clearTask(for id: UUID) {
        taskLock.lock()
        defer { taskLock.unlock() }
        if requestID == id {
            dataTask = nil
            requestID = nil
        }
    }

    private static func complete(_ currencies: [Currency], _ error: Error?,
                                 completion: @escaping ([Currency], Error?) -> Void) {
        DispatchQueue.main.async {
            completion(currencies, error)
        }
    }
}

protocol CurrencyRateDataTask: AnyObject {
    func resume()
    func cancel()
}

protocol CurrencyRateSession {
    func makeDataTask(with url: URL,
                      completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> CurrencyRateDataTask
}

extension URLSessionDataTask: CurrencyRateDataTask {}

extension URLSession: CurrencyRateSession {
    func makeDataTask(with url: URL,
                      completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> CurrencyRateDataTask {
        dataTask(with: url, completionHandler: completionHandler)
    }
}
