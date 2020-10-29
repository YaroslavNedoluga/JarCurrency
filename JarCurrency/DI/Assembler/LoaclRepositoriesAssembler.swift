//
//  LoaclRepositoriesAssembler.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Alamofire
import RxSwift
import Swinject

final class CurrencyLoaclRepositoriesAssembler: Assembly {
    func assemble(container: Container) {
        container.register(SymbolsLocalRepository.self) { _ in SymbolsLocalRepositoryImpl() }.inObjectScope(.container)
    }
}
