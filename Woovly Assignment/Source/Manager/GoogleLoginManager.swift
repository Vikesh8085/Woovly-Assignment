//
//  GoogleLoginManager.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import UIKit
import GoogleSignIn

class GoogleLoginManager: NSObject {
    public static let shared = GoogleLoginManager()
    var viewController: UIViewController!
    var completion: ((Bool) -> Void)?
    override init() {
        super.init()
    }
    public func doGoogleLogin(_ viewController:UIViewController,
                              completion: ((Bool) -> Void)?) {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
        self.viewController = viewController
        self.completion = completion
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.signIn()
    }
    public func isUserLogin() -> Bool {
        if GIDSignIn.sharedInstance()?.hasPreviousSignIn() == true {
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            
            guard let currentUser = GIDSignIn.sharedInstance()?.currentUser else {
                return false
            }
            
            if let expiredDate = currentUser.authentication?.idTokenExpirationDate,  expiredDate > Date() {
                if let _ = currentUser.authentication?.idToken {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }
}

extension GoogleLoginManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            DispatchQueue.main.async {
                if error.code == -5 { // user cancelled
                    self.completion?(false)
                    return
                }
                self.viewController.showToast(error.localizedDescription)
                self.completion?(false)
            }
            return
        }
        
        if let user = user, let _ = user.authentication.idToken {
            self.completion?(true)
        } else {
            self.completion?(false)
        }
    }
}

