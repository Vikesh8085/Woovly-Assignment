
//
//  APIManager.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    func getContent(completionHandler: @escaping (NetworkResult) -> Void) {
        
        guard let link = URL(string: Constant.APIString.videoList) else {return}
        
        URLSession.shared.dataTask(with: link) { (data, response, error) in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let httpStatusCode = HTTPStatusCodes(rawValue: statusCode) {
                switch httpStatusCode {
                case HTTPStatusCodes.success:
                    if let d = data, let obj = try? JSONDecoder().decode([MediaModel].self, from: d) {
                        if !obj.isEmpty {
                            completionHandler(NetworkResult.success(obj))
                        }
                    }
                case HTTPStatusCodes.tooManyRequests:
                    completionHandler(NetworkResult.failure(statusCode: HTTPStatusCodes.tooManyRequests, title: "429", subTitle: "Too many requests"))
                case HTTPStatusCodes.notFound:
                    completionHandler(NetworkResult.failure(statusCode: HTTPStatusCodes.notFound, title: "404", subTitle: "Not Found"))
                case HTTPStatusCodes.unAvailable:
                    completionHandler(NetworkResult.failure(statusCode: HTTPStatusCodes.unAvailable, title: "503", subTitle: "Un Available"))
                }
            }
        }.resume()
    }
}
