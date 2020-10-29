//
//  CurrencyRemoteRepository.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation
import Alamofire
import RxSwift

protocol CurrencyRemoteRepository {
    func getSymbols() -> Observable<TSymbols>
    func getRates() -> Observable<TRates>
}

fileprivate struct Api {
    static let symbolsPath = "symbols"
    static let latestPath = "latest"
}

final class CurrencyRemoteRepositoryImpl: CurrencyRemoteRepository {
    
    func getSymbols() -> Observable<TSymbols> {
        let url = NetworkManager.getServerEndpoint() + Api.symbolsPath
        
        return requestAlamofire(url: url, urlQueryItems: nil, httpMethod: "GET")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .decodeDataObject(type: TSymbols.self)
            .observeOn(MainScheduler.instance)
    }
    
    func getRates() -> Observable<TRates> {
        let url = NetworkManager.getServerEndpoint() + Api.latestPath
        
        return requestAlamofire(url: url, urlQueryItems: nil, httpMethod: "GET")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .decodeDataObject(type: TRates.self)
            .observeOn(MainScheduler.instance)
    }
    
}
