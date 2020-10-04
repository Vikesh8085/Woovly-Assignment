//
//  NetworkResult.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import Foundation


enum NetworkResult {
    case success([MediaModel])
    case failure(statusCode: HTTPStatusCodes, title: String, subTitle: String)
}

enum HTTPStatusCodes: Int, Equatable {
    case success = 200
    case notFound = 404
    case tooManyRequests = 429
    case unAvailable = 503
}
