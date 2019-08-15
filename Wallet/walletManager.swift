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
    
    func getWalletData(completionHandler: @escaping (Result<[WalletModel]>) -> Void) {
        
        let url = "https://api.dev1.opaapp.com/wallet"
        let headers = ["token": TOKEN,
                       "Content-Type": "application/x-www-form-urlencoded"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseString { response in
            
            let result = self.checkForWalletError(response: response)
            completionHandler(result)
            print("myResult: \(result)")
        }
    }
    
    func getWalletTransaction(completionHandler: @escaping (Result<[WalletTransactionModel]>) -> Void) {
        let url = "https://api.dev1.opaapp.com/wallet/A"
        let headers = ["token": TOKEN,
                       "Content-Type": "application/x-www-form-urlencoded"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseString { response in
            
            let value = response.result.value
            let json = JSON(value)
            print("WalletTransaction: \(json)")
            
            let result = self.checkForWalletTransactionError(response: response)
//            completionHandler(result)
            print("myResult: \(result)")
        }
        
    }
    
    // Check for any error in Wallet
    private func checkForWalletError(response: DataResponse<String>) -> Result<[WalletModel]> {
        
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
        guard let data = value["data"].dictionary else {return .failure(WalletAPIManagerError.network(error: response.result.error!))}
        let sortedData = data.sorted(by: { $0 < $1 })
        print("myData: \(sortedData)")
        for (key, value) in sortedData {
            print("key:\(key): value:\(value)")
            walletArray.append(WalletModel(key: key, value: value)!)
        }
        
        return .success(walletArray)
        
    }
    
    private func checkForWalletTransactionError(response: DataResponse<String>) -> Result<[WalletTransactionModel]> {
        
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
        var walletTransactionArray = [WalletTransactionModel]()
        
        let value = json.data(using: String.Encoding.utf8).flatMap({try? JSON(data: $0)}) ?? JSON(NSNull())
        //print("myValue: \(value)")
        guard let data = value["data"].dictionary else {return .failure(WalletAPIManagerError.network(error: response.result.error!))}
        guard let transaction = data["transaction"]?.array else {return .failure(WalletAPIManagerError.network(error: response.result.error!))}
        for item in transaction {
            walletTransactionArray.append(WalletTransactionModel(item: item)!)
        }
        
        print("myTransactionData: \(walletTransactionArray)")
        
        return .success(walletTransactionArray)
        
    }

    
}
