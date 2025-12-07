//
//  LocalizationManager.swift
//  LocalizationTest
//
//  Created by Kostiantyn Kolontai on 2025-12-06.
//

import Foundation
import UIKit

class LocalizationManager {
  static let shared = LocalizationManager()
  static let languageChangedNotification = Notification.Name("LanguageChanged")

  private var bundle: Bundle = Bundle.main

  var currentLanguage: String {
    get {
      return UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
    }
    set {
      guard newValue != currentLanguage else { return }

      UserDefaults.standard.set(newValue, forKey: "AppLanguage")
      UserDefaults.standard.synchronize()

      // Update the bundle for the new language
      if let path = Bundle.main.path(forResource: newValue, ofType: "lproj"),
         let languageBundle = Bundle(path: path) {
        bundle = languageBundle
      } else {
        bundle = Bundle.main
      }

      // Post notification to update UI
      NotificationCenter.default.post(name: LocalizationManager.languageChangedNotification, object: nil)
    }
  }

  private init() {
    // Initialize with saved language or default
    let language = currentLanguage
    if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
       let languageBundle = Bundle(path: path) {
      bundle = languageBundle
    } else {
      bundle = Bundle.main
    }
  }

  func localizedString(for key: String, value: String? = nil) -> String {
    return bundle.localizedString(forKey: key, value: value, table: nil)
  }

  func localizedString(for key: String, tableName: String? = nil, value: String? = nil, comment: String = "") -> String {
    return bundle.localizedString(forKey: key, value: value, table: tableName)
  }
}

// Extension to make localization easier
extension String {
  var localized: String {
    return LocalizationManager.shared.localizedString(for: self, value: self)
  }

  func localized(tableName: String? = nil, comment: String = "") -> String {
    return LocalizationManager.shared.localizedString(for: self, tableName: tableName, value: self, comment: comment)
  }
}

// MARK: - Automatic UI Updates using Associated Objects

private var localizationKeyHandle: UInt8 = 0

extension UILabel {
  // Store the localization key with the label
  var localizationKey: String? {
    get {
      return objc_getAssociatedObject(self, &localizationKeyHandle) as? String
    }
    set {
      objc_setAssociatedObject(self, &localizationKeyHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      if let key = newValue {
        self.text = key.localized
      }
    }
  }

  // Convenience method to set text with auto-localization
  func setLocalizedText(_ key: String) {
    self.localizationKey = key
    self.text = key.localized
  }
}

extension UIButton {
  // Store the localization key with the button
  var localizationKey: String? {
    get {
      return objc_getAssociatedObject(self, &localizationKeyHandle) as? String
    }
    set {
      objc_setAssociatedObject(self, &localizationKeyHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      if let key = newValue {
        self.setTitle(key.localized, for: .normal)
      }
    }
  }

  // Convenience method to set title with auto-localization
  func setLocalizedTitle(_ key: String, for state: UIControl.State = .normal) {
    self.localizationKey = key
    self.setTitle(key.localized, for: state)
  }
}

extension UIViewController {
  // Automatically update all localized UI elements in the view hierarchy
  func updateLocalization() {
    updateLocalization(in: view)
  }

  private func updateLocalization(in view: UIView) {
    // Update labels
    if let label = view as? UILabel, let key = label.localizationKey {
      label.text = key.localized
    }

    // Update buttons
    if let button = view as? UIButton, let key = button.localizationKey {
      button.setTitle(key.localized, for: .normal)
    }

    // Recursively update all subviews
    for subview in view.subviews {
      updateLocalization(in: subview)
    }
  }
}
