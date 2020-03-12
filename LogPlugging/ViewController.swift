//
//  ViewController.swift
//  LogPlugging
//
//  Created by Luis Romero on 3/11/20.
//  Copyright © 2020 Luis Romero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  fileprivate let dataService = IPDataService()
  @IBOutlet weak var statusLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    statusLabel.text = "Cargando IP..."

    dataService.myIp { (ip, errorMessage) in
      if let ip = ip {
        self.statusLabel.text = "My ip is:\n\(ip)"
      } else {
        self.statusLabel.text = "Error: \(errorMessage ?? "")"
      }
    }
  }
}

