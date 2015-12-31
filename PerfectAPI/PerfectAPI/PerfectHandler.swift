//
//  PerfectHandlers.swift
//  SimpleAPI
//
//  Created by Antoine Cormery on 30/12/2015.
//  Copyright © 2015 Antoine Cormery. All rights reserved.
//

import PerfectLib

let enableMustacheFile: Bool = false

let dbhost: String = "localhost"
let dbusername: String = "perfect"
let dbuserpassword: String = "password"
let dbname: String = "simpleperfectapi"

public func PerfectServerModuleInit() -> Void {
    
    print("###########################################")
    print("Load: PerfectServerModuleInit() -> Start...")
    
    if enableMustacheFile {
        PageHandlerRegistry.addPageHandler("Default") {
            print("Default Page Handler")
            return DefaultHandler()
        }
    } else {
        Routing.Handler.registerGlobally()
        
        Routing.Routes["POST" , "/account/"] = { _ in
            print("Create Account Request Handler")
            return AccountCreateHandler()
        }
        
        Routing.Routes["GET" , "/account/"] = { _ in
            print("Get list Account Request Handler")
            return AccountGetListHandler()
        }
        
        Routing.Routes["/"] = { _ in
            print("Default Request Handler")
            return DefaultHandler()
        }
        print("\(Routing.Routes.description)")
    }
    print("########################################")
}