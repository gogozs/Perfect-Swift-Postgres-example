//
//  PGConnectionExtension.swift
//  PerfectAPI
//
//  Created by Antoine Cormery on 31/12/2015.
//  Copyright © 2015 Antoine Cormery. All rights reserved.
//

import Foundation
import PostgreSQL

extension PGConnection {
    public func stringStatus() -> String {
        switch(self.status()) {
        case .OK:
            return "OK"
        case .Bad:
            return "Bad"
        }
    }
}