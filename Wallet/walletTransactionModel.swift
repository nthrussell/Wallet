//
//  walletTransactionModel.swift
//  Wallet
//
//  Created by russell on 16/8/19.
//  Copyright © 2019 Cole. All rights reserved.
//

import Foundation
import SwiftyJSON


class transactionModel {
    var transactionModel = [WalletTransactionModel]()
    var slugsModel = [WalletSlugsModel]()
    
    required init(transactionModel: [WalletTransactionModel], slugsModel: [WalletSlugsModel]) {
        self.transactionModel = transactionModel
        self.slugsModel = slugsModel
    }
    
    convenience init?(item: JSON) {
        guard let data = item["data"].dictionary,
            let transaction = data["transaction"]?.array,
            let slugs = data["slugs"]?.array else { return nil}
        
        var transactionArray = [WalletTransactionModel]()
        for item in transaction {
            transactionArray.append(WalletTransactionModel(item: item)!)
        }
        
        var slugArray = [WalletSlugsModel]()
        for item in slugs {
            slugArray.append(WalletSlugsModel(item: item)!)
        }
        
        self.init(transactionModel:transactionArray, slugsModel:slugArray)
    }
    
}

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

class WalletSlugsModel {
    var id: String
    var name: String
    
    required init(id:String, name:String) {
        self.id = id
        self.name = name
    }
    
    convenience init?(item: JSON) {
        guard let id = item["_id"].string,
            let name = item["name"].string else { return nil}
        
        self.init(id:id, name:name)
    }
    
}
