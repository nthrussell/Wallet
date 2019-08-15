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
    
    func fetchWalletData() {
        
        let url = "https://api.dev1.opaapp.com/wallet"
        let headers = ["token": TOKEN,
                       "Content-Type": "application/x-www-form-urlencoded"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseString { response in
            
            let value = response.result.value
            let json = JSON(value)
            print("myFetchedResult: \(json)")
        }
    }
    
    func getWalletData(completionHandler: @escaping (Result<[WalletModel]>) -> Void) {
        
        let url = "https://api.dev1.opaapp.com/wallet"
        let headers = ["token": TOKEN,
                       "Content-Type": "application/x-www-form-urlencoded"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseString { response in
            
            let result = self.checkForError(response: response)
            completionHandler(result)
            print("myResult: \(result)")
        }
    }
    
    // Check for any error
    private func checkForError(response: DataResponse<String>) -> Result<[WalletModel]> {
        
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
        var walletArray = [WalletModel]()
        
        let value = json.data(using: String.Encoding.utf8).flatMap({try? JSON(data: $0)}) ?? JSON(NSNull())
        //print("myValue: \(value)")
        let data = value["data"].dictionary
        //print("myData: \(data)")
        for (key, value) in data! {
            print("key:\(key): value:\(value)")
            walletArray.append(WalletModel(key: key, value: value)!)
        }
        
        return .success(walletArray)
        
    }
    
}
