//
//  PresentersAssembler.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Alamofire
import RxSwift
import Swinject

final class CurrencyPresentersAssembler: Assembly {
    func assemble(container: Container) {
        container.register(CurrencyPresenter.self){ r in CurrencyPresenterImpl(service: r.resolve(CurrencyService.self)!) }
    }
}
