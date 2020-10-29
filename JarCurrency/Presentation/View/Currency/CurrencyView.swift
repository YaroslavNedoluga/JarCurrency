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
    private var visibleRates: [DRates] = []
    
    private lazy var nf: NumberFormatter = {
        $0.numberStyle = .decimal
        $0.maximumFractionDigits = 2
        return $0
    }(NumberFormatter())
    
    // MARK: MVP
    
    override func injectPresenter() -> CurrencyPresenter? { return self.diAssembler.resolver.resolve(CurrencyPresenter.self) }
    
    // MARK: UIViewController
    
    deinit {
        debugPrint("CurrencyViewController deint!")
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvList.register(UINib(nibName:"CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        tvList.tableFooterView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        lTitle.text = "Currencies".toLocalizable()
        btnLoading.setTitle("Loading.Retry", for: .normal)
        
        loadingContent()
        presenter?.loadContent()
    }
    
    // MARK: Action
    
    @IBAction func langClicked(_ sender: Any) {
        navigationController?.pushViewController(UIStoryboard.loadSettingsView(), animated: true)
    }
    
    @IBAction func retryClicked(_ sender: Any) {
        loadingContent()
        presenter?.loadContent()
    }
    
}

extension CurrencyViewController: CurrencyView {
    func contentLoaded(_ content: [DRates]) {
        rates = content.sorted(by: { $0.symbol < $1.symbol })
        search()
        
        vLoading.isHidden = true
    }
    
    func loadingContent() {
        vLoading.isHidden = false
        btnLoading.isHidden = true
        lLoading.text = "Loading.Getting_info".toLocalizable()
    }
    
    func errorWhileLoadingContent() {
        vLoading.isHidden = true
        btnLoading.isHidden = false
        lLoading.text = "Loading.Error_while_getting_info".toLocalizable()
    }
    
    // MARK: Private
    
    private func search(){
        let word = sbSearch.text ?? ""
        
        visibleRates = rates
            .filter {
                if !word.isEmpty && !$0.symbol.uppercased().starts(with: word.uppercased()) { return false }
                return true
            }
            .sorted(by: { $0.symbol < $1.symbol })
        tvList.reloadData()
    }
}

extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.set(visibleRates[indexPath.row], numberFormatter: nf)
        return cell
    }
}

extension CurrencyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        search()
    }
}

