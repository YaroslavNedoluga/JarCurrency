//
//  CurrencyService.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import RxSwift

final class CurrencyService {
    private let localRepository: SymbolsLocalRepository
    private let remoteRepository: CurrencyRemoteRepository
    
    init(localRepository: SymbolsLocalRepository, remoteRepository: CurrencyRemoteRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    // MARK: Public
    
    func getRates() -> Observable<[DRates]> {
        return Observable.zip(getTSymbols(), remoteRepository.getRates()){ symbols, rates in TRatesBundle(symbols: symbols, rates: rates) }
            .map { $0.toRates() } 
    }
    
    // MARK: Private
    
    private func getTSymbols() -> Observable<TSymbols> {
        debugPrint("Getting symbols")
        
        func getCatalogFromDB(dbCatalog: DbSymbols?) -> Observable<TSymbols>{
            debugPrint("Getting symbols from local.")
            guard let it = dbCatalog, let data = JSONDecoder().decodeOrNil(TSymbols.self, from: it.jsonData.toData()) else {
                return Observable.error(NSError(domain: "JarCurrency.com", code: -999, userInfo: [NSLocalizedDescriptionKey: "Error while decoding catalog from local db"]))
            }
            return Observable.just(data)
        }
        
        func getCatalogFromNetworkAndSave(dbCatalog: DbSymbols?) -> Observable<TSymbols> {
            debugPrint("Getting symbols from network.")
            return remoteRepository.getSymbols().do(onNext: { it in
                guard let data = JSONEncoder().encodeOrNil(it)?.toString() else { return }
                let _ = self.localRepository.saveOrUpdateSymbols(jsonData: data, dbCatalog).subscribe()}
            )
        }
        
        return localRepository.getSymbols()
            .flatMap { dbCatalog -> Observable<TSymbols> in
                return Date().toMillis() - (dbCatalog?.timestamp ?? 0) > (3600000 * 2) ? getCatalogFromNetworkAndSave(dbCatalog: dbCatalog) : getCatalogFromDB(dbCatalog: dbCatalog)
            }
    }
}
