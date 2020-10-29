//
//  ViewController.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import UIKit

protocol CurrencyView: MvpView {
    func contentLoaded(_ content: [DRates])
    func loadingContent()
    func errorWhileLoadingContent()
}

class CurrencyViewController: MvpController<CurrencyView, CurrencyPresenter> {
    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var sbSearch: UISearchBar!
    @IBOutlet weak var tvList: UITableView!
    
    @IBOutlet weak var vLoading: UIView!
    @IBOutlet weak var btnLoading: UIButton!
    @IBOutlet weak var lLoading: UILabel!
    
    private var rates: [DRates] = []
    
    // MARK: MVP
    
    override func injectPresenter() -> CurrencyPresenter? { return self.diAssembler.resolver.resolve(CurrencyPresenter.self) }
    
    // MARK: UIViewController
    
    deinit {
        debugPrint("CurrencyViewController deint!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvList.register(UINib(nibName:"LogisticTariffCell", bundle: nil), forCellReuseIdentifier: "LogisticTariffCell")
        tvList.tableFooterView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        loadingContent()
        presenter?.loadContent()
    }
    
    // MARK: Action
    
    @IBAction func langClicked(_ sender: Any) {
        
    }
    
    @IBAction func retryClicked(_ sender: Any) {
        
    }
    
    
    
}

extension CurrencyViewController: CurrencyView {
    func contentLoaded(_ content: [DRates]) {
        rates = content
        
        
    }
    
    func loadingContent() {
//        vContainer.isHidden = true
//        vLoading.isHidden = false
//        btnLoading.isHidden = isEmptyDataError
//        lLoading.text = isEmptyDataError ? CustomLocalisedString("Coordination.No_data") : CustomLocalisedString("Error.Error_while_getting_info")
    }
    
    func errorWhileLoadingContent() {
//        vContainer.isHidden = true
//        vLoading.isHidden = false
//        btnLoading.isHidden = isEmptyDataError
//        lLoading.text = isEmptyDataError ? CustomLocalisedString("Coordination.No_data") : CustomLocalisedString("Error.Error_while_getting_info")
    }
}

extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

