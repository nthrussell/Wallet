//
//  walletTransactionModel.swift
//  Wallet
//
//  Created by russell on 16/8/19.
//  Copyright © 2019 Cole. All rights reserved.
//

import Foundation
import SwiftyJSON

class WalletTransactionModel {
    var slug: String
    var pos: Int
    var amount: Double
    
    required init(slug: String, pos: Int, amount: Double) {
        self.slug = slug
        self.pos = pos
        self.amount = amount
    }
    
    convenience init?(item: JSON) {
        guard let slug = item["slug"].string,
               let pos = item["pos"].int,
            let amount = item["amount"].double else { return nil}
        
        self.init(slug: slug, pos: pos, amount: amount)
    }
    
}
