import Foundation
import UIKit

class LocalizationManager {
    static let shared = LocalizationManager()

    private var bundle: Bundle = .main

    var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
        }
        set {
            guard newValue != currentLanguage else { return }

            UserDefaults.standard.set(newValue, forKey: "AppLanguage")
            UserDefaults.standard.synchronize()

            loadBundle(for: newValue)

            DispatchQueue.main.asyncAfter(deadline: .now() + 4.1) {
                self.restartApp()
            }
        }
    }

    private init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
        loadBundle(for: savedLanguage)
    }

    private func loadBundle(for language: String) {
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
           let languageBundle = Bundle(path: path) {
            bundle = languageBundle
        } else {
            bundle = .main
        }
    }

    func localized(_ key: String, comment: String = "") -> String {
        return bundle.localizedString(forKey: key, value: key, table: "Main")
    }

    private func restartApp() {
        guard let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {
            return
        }

        UIView.transition(with: window, duration: 0.9, options: .transitionCrossDissolve) {
            window.rootViewController = rootVC
        }
    }
}

extension String {
    var localized: String {
        LocalizationManager.shared.localized(self)
    }
}
