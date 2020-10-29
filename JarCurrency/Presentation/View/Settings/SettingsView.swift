//
//  SettingsView.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 29.10.2020.
//

import UIKit

final class SettingsViewController: UIViewController {
    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var ivEng: UIImageView!
    @IBOutlet weak var ivRus: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isEng = UserDefaults.standard.getUserLocale() == Language.English.code()
        ivEng.isHidden = !isEng
        ivRus.isHidden = isEng
        lTitle.text = "Settings.Lang".toLocalizable()
    }
    
    @IBAction func engClicked(_ sender: Any) {
        changeLang(lang: Language.English)
    }
    
    @IBAction func rusClicked(_ sender: Any) {
        changeLang(lang: Language.Russian)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func changeLang(lang: Language){
        let alert =  UIAlertController(title: "\("Settings.Lang.Change".toLocalizable()) \(lang.rawValue.lowercased())?", message: "Settings.Lang.Reload".toLocalizable(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".toLocalizable(), style: .default, handler: { _ in
            UserDefaults.standard.setUserLocale(locale: lang.code())
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainView")
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }))
        alert.addAction(UIAlertAction(title: "Cancel".toLocalizable(), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
