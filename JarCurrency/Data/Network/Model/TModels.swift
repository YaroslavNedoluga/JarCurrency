
struct TSymbols: Codable {
    let success: Bool
    let symbols: [String : String]
}

struct TRates: Codable {
    let success: Bool
    let timestamp: Int64
    let base: String
    let date: String
    let rates: [String : Double]
}

struct TRatesBundle {
    let symbols: TSymbols
    let rates: TRates
}
