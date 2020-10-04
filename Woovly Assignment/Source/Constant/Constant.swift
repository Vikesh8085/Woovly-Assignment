//
//  Constant.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import Foundation

struct Constant {
    struct Home {
        static let title = "Video Player"
        static let logout = "Logout"
    }
    struct APIString {
        static let videoList = "https://woo-3a3e6.firebaseio.com/media.json?print=pretty"
    }
}


enum Strings {
    static let view_controller_error_text = "View Controller Is Not Of Type or Class"
}


enum InternetAvailability: String {
    case title = "Internet"
    case message = "Internet not Avaiable"
}
