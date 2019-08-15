//
//  walletModel.swift
//  Wallet
//
//  Created by russell on 15/8/19.
//  Copyright © 2019 Cole. All rights reserved.
//

import Foundation
import SwiftyJSON

class WalletModel {
    
    var opened: Bool
    var key: String
    var value: Double
    
    required init(opened: Bool,key: String, value: Double) {
        self.opened = opened
        self.key = key
        self.value = value
    }
    
    convenience init?(key: String, value: JSON) {
        guard let data = value["total"].double else {return nil}
        self.init(opened: false, key: key, value: data)
    }

}
