import Foundation
import UIKit

class MvpController<View, Presenter> : BaseViewController, MvpView {
    
    var presenter: Presenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = injectPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let view = (self as? View) else { fatalError("You must implements mvpView's or extended protocols and send it as View!") }
        (presenter as? MvpPresenter<View>)?.bindView(view: view)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (presenter as? MvpPresenter<View>)?.unbindView()
    }
    
    func injectPresenter() -> Presenter? {
        fatalError("Abstract method! You must override this func")
    }
    
}
