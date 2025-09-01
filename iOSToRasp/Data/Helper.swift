//
//  Helper.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 8/31/25.
//
//

import Foundation
import CoreBluetooth

extension CBUUID {
    static func fromLocalizedKey(_ key: String) -> CBUUID {
        CBUUID(string: NSLocalizedString(key, comment: ""))
    }
}
