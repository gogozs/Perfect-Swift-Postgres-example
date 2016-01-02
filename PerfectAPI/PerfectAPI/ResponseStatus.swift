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
    let json: String

    init(status: ResponseStatusValue, value: Int, message: String) {
        self.status = status
        self.value = value
        let msg: String = message.toCorrectForm()
        let rep = ["status": self.status.getStatus(), "value": "\(self.value)", "message": msg]
        self.json = rep.toJSONString()
    }
    
    init(status: ResponseStatusValue, value: Int, message: [[String: String]]) {
        self.status = status
        self.value = value
        self.json = "{ \"status\": \"\(self.status.getStatus())\", \"value\": \"\(self.value)\", \"message\": \(message.toJSONString())}"
    }

    func toJSON() -> String {
        return json
        /*do {
            let json: NSData = try NSJSONSerialization.dataWithJSONObject(rep, options: NSJSONWritingOptions.PrettyPrinted)
            if let str: NSString = NSString(data: json, encoding: NSUTF8StringEncoding) {
                return String(str)
            } else {
                return "{}"
            }
        } catch {
            return "{}"
        }*/
    }
}

extension String {
    func toCorrectForm() -> String {
        var str: String = ""
        for elt in self.characters {
            if elt != "\n" && elt != "\"" {
                str += "\(elt)"
            }
        }
        return str
    }
}

extension Dictionary {
    func toJSONString() -> String {
        var str: String = "{"
        
        for (key, val) in self {
            if key is String && val is String {
                if str != "{" {
                    str += ", "
                }
                str += "\"\(key)\": \"\(val)\""
            } else if key is String && val is Array<String> {
                if str != "{" {
                    str += ", "
                }
                str += "\"\(key)\": \((val as! Array<String>).toJSONString())"
            } else if key is String && val is [[String: String]] {
                if str != "{" {
                    str += ", "
                }
                str += "\"\(key)\": ["
                var i: Int = 0
                for elt in (val as! [[String: String]]) {
                    if i > 0 {
                        str += ", "
                    }
                    str += elt.toJSONString()
                    i += 1
                }
                str += "]"
            }
        }
        str += "}"
        return str
    }
}

extension Array {
    func toJSONString() -> String {
        var str: String = "["
        for elt in self {
            if str != "[" {
                str += ", "
            }
            if elt is String {
                str += "\"\(elt)\""
            } else if elt is [String: String] {
                str += (elt as! [String: String]).toJSONString()
            }
        }
        str += "]"
        return str
    }
}
