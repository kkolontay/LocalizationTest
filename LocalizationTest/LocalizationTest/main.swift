//
//  main.swift
//  LocalizationTest
//
//  Created by Kostiantyn Kolontai on 2025-12-08.
//

import UIKit

// Debug: Print current state before setting
print("DEBUG: Before setting language")
print("DEBUG: AppLanguage = \(UserDefaults.standard.string(forKey: "AppLanguage") ?? "nil")")
print("DEBUG: AppleLanguages = \(UserDefaults.standard.array(forKey: "AppleLanguages") ?? [])")

// Set language BEFORE UIApplicationMain - this is critical!
if let language = UserDefaults.standard.string(forKey: "AppLanguage") {
    UserDefaults.standard.set([language], forKey: "AppleLanguages")
    UserDefaults.standard.synchronize()
    print("DEBUG: Set AppleLanguages to [\(language)]")
}

// Debug: Print after setting
print("DEBUG: After setting language")
print("DEBUG: AppleLanguages = \(UserDefaults.standard.array(forKey: "AppleLanguages") ?? [])")
print("DEBUG: Bundle preferred localizations = \(Bundle.main.preferredLocalizations)")

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(AppDelegate.self)
)
