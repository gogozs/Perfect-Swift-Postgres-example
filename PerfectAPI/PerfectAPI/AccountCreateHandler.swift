//
//  AccountCreateHandler.swift
//  PerfectAPI
//
//  Created by Antoine Cormery on 31/12/2015.
//  Copyright © 2015 Antoine Cormery. All rights reserved.
//

import Foundation
import PerfectLib
import PostgreSQL

class AccountCreateHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        var repStatus: ResponseStatus!
        
        if let usernames: [String] = request.params("username"), let emails: [String] = request.params("email") where request.params("username")?.count ?? 0 > 0 && request.params("email")?.count ?? 0 > 0 {
            
            let username: String = usernames[0]
            let email: String = emails[0]
            
            let pgsl: PGConnection = PostgreSQL.PGConnection()
            pgsl.connectdb("host='\(dbhost)' dbname='\(dbname)' user='\(dbusername)' password='\(dbuserpassword)'");
            
            if pgsl.status() == .Bad {
                repStatus = ResponseStatus(status: ResponseStatusValue.Error, value: 1000, message: pgsl.errorMessage())
            } else {
                let result: PGResult = pgsl.exec("SELECT ADD_ACCOUNT('\(username)', '\(email)')")
                let s: PGResult.StatusType = result.status()
                if s == .CommandOK || s == .TuplesOK {
                    if result.numFields() > 0 && result.numTuples() > 0 && result.getFieldBool(0, fieldIndex: 0) {
                        repStatus = ResponseStatus(status: ResponseStatusValue.OK, value: 1, message: "")
                    } else {
                        repStatus = ResponseStatus(status: ResponseStatusValue.Error, value: 1001, message: "Pseudo already exist!")
                    }
                } else {
                    repStatus = ResponseStatus(status: ResponseStatusValue.Error, value: 1002, message: result.errorMessage())
                }
            }
            pgsl.close()
        } else {
            repStatus = ResponseStatus(status: ResponseStatusValue.Error, value: 1003, message: "Username and/or email missing on body!")
        }
        
        response.addHeader("Content-Type", value: "application/json")
        response.appendBodyString(repStatus.toJSON())
        response.requestCompletedCallback()
    }
}
