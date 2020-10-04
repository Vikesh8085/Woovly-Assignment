//
//  HomeViewModel.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    public var completionHandler: ((Bool, String?) -> (Void))?
    var contentArray = [String]()
    private var homeViewController: HomeViewController?
    
    init(listViewController: HomeViewController) {
        self.homeViewController = listViewController
    }
    
    func fetchContent() {
        
        if ReachabilityWrapper.shared.isNetworkAvailable() {
            self.homeViewController?.view.showIndicator()
            APIManager.shared.getContent { (result) in
                DispatchQueue.main.async {
                    self.homeViewController?.view.hideIndicator()
                }
                switch result {
                case let  .failure(_, title, _):
                    DispatchQueue.main.async {
                        self.showToast(title)
                    }
                    if let completion = self.completionHandler {
                        
                        completion(false,nil)
                    }
                case let .success(content):
                    self.handleData(data: content)
                }
            }
        } else {
            self.showToast(InternetAvailability.message.rawValue)
        }
        
    }
    
    private func handleData(data: [MediaModel]) {
        self.contentArray = data.map { $0.url }
        print(self.contentArray)
        if let completion = self.completionHandler {
            completion(true,nil)
        }
    }
    
    func showToast(_ message: String) {
        self.homeViewController?.view.makeToast(message, duration: 2.0, position: .bottom)
    }
}
