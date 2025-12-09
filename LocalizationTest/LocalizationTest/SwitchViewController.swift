//
//  SwitchViewController.swift
//  LocalizationTest
//
//  Created by Kostiantyn Kolontai on 2025-12-06.
//

import UIKit

class SwitchViewController: UIViewController {
  var currentStatusOfSwiftche: Bool = false
  @IBOutlet var languageSwitch: UISwitch!
  @IBOutlet weak var languageLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let currentLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
       print("DEBUG viewDidLoad: AppLanguage = \(currentLanguage)")
       print("DEBUG viewDidLoad: AppleLanguages = \(UserDefaults.standard.array(forKey: "AppleLanguages") ?? [])")
       print("DEBUG viewDidLoad: preferredLocalizations = \(Bundle.main.preferredLocalizations)")

       languageSwitch?.isOn = (currentLanguage == "fr-CA")
  }

  @IBAction func switchWasSwitch(_ sender: UISwitch) {
    currentStatusOfSwiftche = sender.isOn
    let newLanguage = sender.isOn ? "fr-CA" : "en"

       print("DEBUG: Switching to \(newLanguage)")

       UserDefaults.standard.set(newLanguage, forKey: "AppLanguage")
       UserDefaults.standard.synchronize()

       // Verify it was saved
       print("DEBUG: Saved AppLanguage = \(UserDefaults.standard.string(forKey: "AppLanguage") ?? "nil")")

       let alert = UIAlertController(
         title: "Restart Required",
         message: "Language set to: \(newLanguage)\nPlease restart the app.",
         preferredStyle: .alert
       )
       alert.addAction(UIAlertAction(title: "Restart Now", style: .default) { _ in
         exit(0)
       })
       alert.addAction(UIAlertAction(title: "Later", style: .cancel))
       present(alert, animated: true)
  }
  }

