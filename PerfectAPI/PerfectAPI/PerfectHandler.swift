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
let dbusername: String = "root"
let dbuserpassword: String = ""
let dbname: String = "simpleperfectapi"

public func PerfectServerModuleInit() -> Void {
    
    print("###########################################")
    print("Load: PerfectServerModuleInit() -> Start...")
    
    if enableMustacheFile {
        PageHandlerRegistry.addPageHandler("Default") {
            return DefaultHandler()
        }
    } else {
        Routing.Handler.registerGlobally()
        
        Routing.Routes["POST" , "/account/"] = { _ in
            return AccountCreateHandler()
        }
        
        Routing.Routes["GET" , "/account/"] = { _ in
            return AccountGetListHandler()
        }
        
        /*Routing.Routes["/"] = { _ in
            return DefaultHandler()
        }*/
        print("\(Routing.Routes.description)")
    }
    print("########################################")
}
