//
//  ViewController + Extension.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiateFromAppStoryBoard(appStoryBoard: AppStoryboard) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    func showToast(_ message: String) {
        self.view.makeToast(message)
    }
    
    var sceneDelegate: SceneDelegate? {
        return self.view.window?.windowScene?.delegate as? SceneDelegate
    }
    
    func showAlert(title: String?, message: String?,preferredStyle: UIAlertController.Style , alertActions: [(title: String?, style: UIAlertAction.Style)], completion:((Int) -> Void)?) {
           let alertController = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
           for (index, action) in alertActions.enumerated() {
               let alertAction = UIAlertAction(title: action.title, style: action.style) { (_) in
                   completion?(index)
               }
               alertController.addAction(alertAction)
           }
           self.present(alertController, animated: true, completion: nil)
       }
}
