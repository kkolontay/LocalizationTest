//
//  SwitchViewController.swift
//  LocalizationTest
//
//  Created by Kostiantyn Kolontai on 2025-12-06.
//

import UIKit

class SwitchViewController: UIViewController {
  var currentStatusOfSwiftche: Bool = false
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func switchWasSwitch(_ sender: UISwitch) {
    currentStatusOfSwiftche = sender.isOn
    print("\(currentStatusOfSwiftche)")
  }
  
}
