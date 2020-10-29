//
//  RemoteRepositoriesAssembler.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Alamofire
import RxSwift
import Swinject

final class CurrencyRemoteRepositoriesAssembler: Assembly {
    func assemble(container: Container) {
        container.register(CurrencyRemoteRepository.self) { _ in CurrencyRemoteRepositoryImpl() }.inObjectScope(.container)
    }
}
