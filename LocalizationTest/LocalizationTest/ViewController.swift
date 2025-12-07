//
//  ViewController.swift
//  LocalizationTest
//
//  Created by Kostiantyn Kolontai on 2025-12-06.
//

import UIKit

class MainViewController: UIViewController {
  @IBOutlet weak var label: UILabel!

  // Reference to other UI elements (will be found automatically)
  private var helloWorldLabel: UILabel?
  private var pushButton: UIButton?

  override func viewDidLoad() {
    super.viewDidLoad()

    // Find UI elements
    findUIElements()

    // Set localization keys ONCE - they'll auto-update when language changes!
    label.setLocalizedText("acw-rj-eOb.text")
    helloWorldLabel?.setLocalizedText("5hl-tv-GGo.text")
    pushButton?.setLocalizedTitle("jnO-LQ-yWT.configuration.title")

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
    // Find the hello world label and button in the stack view
    if let stackView = view.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
      for subview in stackView.arrangedSubviews {
        if let label = subview as? UILabel, label != self.label {
          helloWorldLabel = label
        } else if let button = subview as? UIButton {
          pushButton = button
        }
      }
    }
  }

  @objc private func languageDidChange() {
    // This ONE line automatically updates ALL labels and buttons
    // that have localization keys set! 🎉
    updateLocalization()
  }

  @IBAction func buttonPressed(_ sender: Any) {
    // Your button action
  }
}
