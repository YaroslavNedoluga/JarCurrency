//
//  CurrencyPresenter.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import RxSwift

protocol CurrencyPresenter: Presenter {
    func loadContent()
}

final class CurrencyPresenterImpl: MvpPresenter<CurrencyView>, CurrencyPresenter {
    private let service: CurrencyService
    private let disposer = DisposeBag()
    
    init(service: CurrencyService) {
        self.service = service
    }
    
    
    func loadContent() {
        service.getRates()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] it in debugPrint("content loaded"); self?.view?.contentLoaded(it) },
                onError: {[weak self] error in debugPrint(error.localizedDescription); self?.view?.errorWhileLoadingContent() })
            .disposed(by: disposer)
    }
    
    
}
