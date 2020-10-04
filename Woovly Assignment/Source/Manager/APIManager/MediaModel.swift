//
//  MediaModel.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import Foundation

// MARK: - WelcomeElement
struct MediaModel: Codable {
    let welcomeDescription, id: String
    let thumb: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case welcomeDescription = "description"
        case id, thumb, title, url
    }
}

typealias MediaModelElement = [MediaModel]
