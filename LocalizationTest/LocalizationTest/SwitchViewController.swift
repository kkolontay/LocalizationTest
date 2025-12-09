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
    languageSwitch.isOn = LocalizationManager.shared.currentLanguage == "en"
    languageLabel.text = LocalizationManager.shared.currentLanguage
  }

  @IBAction func switchWasSwitch(_ sender: UISwitch) {
    currentStatusOfSwiftche = sender.isOn
    if sender.isOn {
      LocalizationManager.shared.currentLanguage = "en"
      print("TEST: \("ZtN-df-oph.text".localized)")
    } else {
      LocalizationManager.shared.currentLanguage = "fr-CA"
      print("TEST: \("ZtN-df-oph.text".localized)")
    }
  }

}
