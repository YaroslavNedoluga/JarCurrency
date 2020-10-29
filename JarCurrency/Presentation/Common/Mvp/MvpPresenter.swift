import Foundation

protocol Presenter {
}

class MvpPresenter<View> : Presenter {
    var view: View?
    
    func bindView (view: View){
        guard view is MvpView else { fatalError("View must implement MvpView or extended view's protocol!") }
        self.view = view
    }
    
    func unbindView(){
        self.view = nil
    }
}
