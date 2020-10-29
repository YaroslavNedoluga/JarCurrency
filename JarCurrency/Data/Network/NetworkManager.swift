import Foundation

class NetworkManager {
    private init() {}
    static let instance = NetworkManager()
    
    static func getServerEndpoint() -> String {
        return "http://data.fixer.io/api/"
    }
    
    static func getAPIKey() -> String {
        return "1b78cbae170417a05e4ab6238a9c27dd"
    }
}
