//
//  SwitchViewController.swift
//  LocalizationTest
//
//  Created by Kostiantyn Kolontai on 2025-12-06.
//

import UIKit

class SwitchViewController: UIViewController {

  private var switchLanguageLabel: UILabel?
  private var languageSwitch: UISwitch?

  var currentStatusOfSwiftche: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()

    // Find UI elements
    findUIElements()

    // Set localization key ONCE - it will auto-update when language changes!
    switchLanguageLabel?.setLocalizedText("ZtN-df-oph.text")

    // Set initial switch state based on current language
    let currentLang = LocalizationManager.shared.currentLanguage
    currentStatusOfSwiftche = (currentLang == "fr-CA")
    languageSwitch?.isOn = currentStatusOfSwiftche

    // Listen for language changes
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(languageDidChange),
      name: LocalizationManager.languageChangedNotification,
      object: nil
    )
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  private func findUIElements() {
    // Find the label and switch in the stack view
    if let stackView = view.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
      for subview in stackView.arrangedSubviews {
        if let label = subview as? UILabel {
          switchLanguageLabel = label
        } else if let switchControl = subview as? UISwitch {
          languageSwitch = switchControl
        }
      }
    }
  }

  @objc private func languageDidChange() {
    // Automatically update ALL localized elements! 🎉
    updateLocalization()
  }

  @IBAction func switchWasSwitch(_ sender: UISwitch) {
    currentStatusOfSwiftche = sender.isOn

    // Toggle between English and French-Canadian
    if currentStatusOfSwiftche {
      LocalizationManager.shared.currentLanguage = "fr-CA"
      print("Language switched to: French-Canadian")
    } else {
      LocalizationManager.shared.currentLanguage = "en"
      print("Language switched to: English")
    }
  }
}

