//
//  PerfectHandlers.swift
//  SimpleAPI
//
//  Created by Antoine Cormery on 30/12/2015.
//  Copyright © 2015 Antoine Cormery. All rights reserved.
//

import PerfectLib

let enableMustacheFile: Bool = false

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
        Routing.Routes["/*"] = { _ in
            print("Default Request Handler")
            return DefaultHandler()
        }
        Routing.Routes["/"] = { _ in
            print("Default Request Handler")
            return DefaultHandler()
        }
        print("\(Routing.Routes.description)")
    }
    print("########################################")
}