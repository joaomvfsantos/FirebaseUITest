//
//  ViewController.swift
//  FirebaseUITest
//
//  Created by João Santos on 12/08/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            print("--> Presenting Firebase UI Auth Controller")
            self.present(appDelegate.authUI!.authViewController(), animated: true)
        }
    }


}

