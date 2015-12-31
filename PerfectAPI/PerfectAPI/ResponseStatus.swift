//
//  ResponseHelper.swift
//  PerfectAPI
//
//  Created by Antoine Cormery on 31/12/2015.
//  Copyright © 2015 Antoine Cormery. All rights reserved.
//

import Foundation

enum ResponseStatusValue {
    case OK
    case Error
    
    func getStatus() -> String {
        switch(self) {
        case .OK:
            return "OK"
        case .Error:
            return "Error"
        }
    }
}

class ResponseStatus {
    let status: ResponseStatusValue
    let value: Int
    let message: AnyObject
    
    init(status: ResponseStatusValue, value: Int, message: AnyObject) {
        self.status = status
        self.value = value
        self.message = message
    }
    
    func toJSON() -> String {
        let rep: [String: AnyObject] = ["status": self.status.getStatus(), "value": self.value, "message": self.message]
        do {
            let json: NSData = try NSJSONSerialization.dataWithJSONObject(rep, options: NSJSONWritingOptions.PrettyPrinted)
            if let str: NSString = NSString(data: json, encoding: NSUTF8StringEncoding) {
                return str as String
            } else {
                return "{}"
            }
        } catch {
            return "{}"
        }
    }
}