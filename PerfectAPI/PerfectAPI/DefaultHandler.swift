//
//  DefaultHandler.swift
//  PerfectAPI
//
//  Created by Antoine Cormery on 30/12/2015.
//  Copyright © 2015 Antoine Cormery. All rights reserved.
//

import Foundation
import PerfectLib

class DefaultHandler: PageHandler {
    func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
        
        if let response = context.webResponse, let request = context.webRequest {
            let auth = request.httpAuthorization()
            
            response.setStatus(200, message: "OK")
            
            print("###################")
            print("response: \(response)")
            print("request: \(request)")
            print("auth: \(auth)")
            print("http accept: \(request.httpAccept())")
            
        } else {
            fatalError("This is not a web request")
        }
        
        var value: [String: Any] = [:]
        value["json"] = true
        value["response"] = "Hello World!"
        return value
    }
}

extension DefaultHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        let auth = request.httpAuthorization()
        
        response.setStatus(200, message: "OK")
        
        print("###################")
        print("response: \(response)")
        print("request: \(request)")
        print("auth: \(auth)")
        print("http accept: \(request.httpAccept())")
        
        response.appendBodyString("Default pages: requestURI: \(request.requestURI()), variables: \(request.urlVariables)")
        response.requestCompletedCallback()
    }
}