protocol CurrencyRateProviding {
    func getCurrencies(completion: @escaping ([Currency], Error?) -> Void)
}
