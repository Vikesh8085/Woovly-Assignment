//
//  LoginViewController.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func gmalLoginAction(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        GoogleLoginManager.shared.doGoogleLogin(self) {[weak self] (success) in
            sender.isUserInteractionEnabled = true
            if success {
                DispatchQueue.main.async {[weak self] in
                    self?.handleLoginSuccess()
                }
            }
        }
    }
}

