//
//  ServiceAssembler.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation
import Alamofire
import Swinject

final class CurrencyServiceAssembler: Assembly {
    func assemble(container: Container) {
        container
            .register(CurrencyService.self) { r in return CurrencyService(
                localRepository: r.resolve(SymbolsLocalRepository.self)!,
                remoteRepository: r.resolve(CurrencyRemoteRepository.self)!) }
            .inObjectScope(.container)
    }
}
