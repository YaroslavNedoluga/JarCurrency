//
//  DIAssembler.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Swinject

final class DIAssembler {
    private let assebler = Assembler()
    var resolver: Resolver { return assebler.resolver }
    
    init() {
        // MARK: NetworkRepository
        assebler.apply(assembly: CurrencyRemoteRepositoriesAssembler())
        
        // MARK: LocalRepository
        assebler.apply(assembly: CurrencyLoaclRepositoriesAssembler())
        
        // MARK: Service
        assebler.apply(assembly: CurrencyServiceAssembler())
        
        // MARK: Presenters
        assebler.apply(assembly: CurrencyPresentersAssembler())
    }
}
