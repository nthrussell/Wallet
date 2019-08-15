//
//  walletManager.swift
//  Wallet
//
//  Created by russell on 15/8/19.
//  Copyright © 2019 Cole. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum WalletAPIManagerError: Error {
    case network(error: Error)
    case apiProvidedError(reason: String)
    case authCouldNot(reason: String)
    case authLost(reason: String)
    case objectSerialization(reason: String)
}

class WalletManager {
    static let sharedInstance = WalletManager()
    
    func getWalletData() {
        
        let url = "https://api.dev1.opaapp.com/wallet"
        let headers = ["token": TOKEN,
                       "Content-Type": "application/x-www-form-urlencoded"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            let value = response.result.value
            let json = JSON(value)
            print("value is: \(json)")
            
            let result = self.checkForError(response: response)
            print("myResult: \(result)")
        }
    }
    
    // Check for any error
    private func checkForError(response: DataResponse<Any>) -> Result<Any> {
        
        // For Network Error
        guard response.result.error == nil else {
            print("Wallet network error:")
            print(response.result.error!)
            return .failure(WalletAPIManagerError.network(error: response.result.error!))
        }
        
        // JSON Serialization Error
        guard let json = response.result.value else {
            print("did not get userState object as JSON from API")
            return .failure(WalletAPIManagerError.objectSerialization(reason: "Did not get JSON dictionary in response for WalletModel"))
        }
        
        let value = JSON(json)
        
        return .success(value)
        
    }
    
}
