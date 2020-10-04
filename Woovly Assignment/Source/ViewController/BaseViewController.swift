//
//  BaseViewController.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func handleLoginSuccess() {
        navigateToHomeScreen()
    }
    //Navigate to home screen on successful login
    func navigateToHomeScreen() {
        let homeViewCntrl = HomeViewController.instantiateFromAppStoryBoard(appStoryBoard: .main)
        let navigationController = UINavigationController(rootViewController: homeViewCntrl)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        self.present(navigationController, animated: true, completion: nil)
    }
}
