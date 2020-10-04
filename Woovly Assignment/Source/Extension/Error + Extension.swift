//
//  Error + Extension.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import Foundation
/**
 All extension functions of Error is mentioned here
 */
extension Error {
    /**
     This property is used for get error code from error.
     */
    var code: Int { return (self as NSError).code }
    /**
     This property is used for get error domain from error.
     */
    var domain: String { return (self as NSError).domain }
    /**
     This property is used for check whether this error is internet error or not.
     */
    /*var isInternetError: Bool {
     return code == InternalErrorCode.hostNotFound.errorCode ||
     code == InternalErrorCode.sslError.errorCode ||
     code == InternalErrorCode.noInternet.errorCode ||
     code == InternalErrorCode.timeOut.errorCode ||
     code == InternalErrorCode.softwareAbort.errorCode ||
     code == InternalErrorCode.timedOut.errorCode ||
     code == InternalErrorCode.certificateInvalid.errorCode
     }*/
}
