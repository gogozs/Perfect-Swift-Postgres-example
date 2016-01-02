//
//  AccountGetListHandler.swift
//  PerfectAPI
//
//  Created by Antoine Cormery on 31/12/2015.
//  Copyright © 2015 Antoine Cormery. All rights reserved.
//

import Foundation
import PerfectLib
import PostgreSQL

class AccountGetListHandler: RequestHandler {
    
    func handleRequest(request: WebRequest, response: WebResponse) {
        var repStatus: ResponseStatus!
        
        let pgsl: PGConnection = PostgreSQL.PGConnection()
        pgsl.connectdb("host='\(dbhost)' dbname='\(dbname)' user='\(dbusername)' password='\(dbuserpassword)'");
        
        if pgsl.status() == .Bad {
            repStatus = ResponseStatus(status: ResponseStatusValue.Error, value: 1000, message: pgsl.errorMessage())
        } else {
            let result: PGResult = pgsl.exec("SELECT * FROM account ORDER BY pseudo ASC")
            let s: PGResult.StatusType = result.status()
            if s == .CommandOK || s == .TuplesOK {
                if result.numFields() > 0 && result.numTuples() > 0 {
                    let numFields: Int = result.numFields()
                    let numTuples: Int = result.numTuples()
                    
                    var accounts: [[String: String]] = []
                    var tuple: Int = 0
                    while tuple < numTuples {
                        var account: [String: String] = [:]
                        var field: Int = 0
                        while field < numFields {
                            account[result.fieldName(field) ?? ""] = result.getFieldString(tuple, fieldIndex: field)
                            field += 1
                        }
                        accounts.append(account)
                        tuple += 1
                    }
                    
                    repStatus = ResponseStatus(status: ResponseStatusValue.OK, value: 1, message: accounts)
                } else {
                    repStatus = ResponseStatus(status: ResponseStatusValue.Error, value: 1001, message: "Fail request!")
                }
            } else {
                repStatus = ResponseStatus(status: ResponseStatusValue.Error, value: 1002, message: result.errorMessage())
            }
        }
        pgsl.close()
        
        response.addHeader("Content-Type", value: "application/json")
        response.appendBodyString(repStatus.toJSON())
        response.requestCompletedCallback()
    }
}
