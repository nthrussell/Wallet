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
    
//    var A: String
//    var ATotal: Double
//
//    var B: String
//    var BTotal: Double
//
//    var C: String
//    var CTotal: Double
//
//    var D: String
//    var DTotal: Double
//
//    var E: String
//    var ETotal: Double
//
//    var F: String
//    var FTotal: Double
//
//    var G: String
//    var GTotal: Double
//
//    var H: String
//    var HTotal: Double
//
//    var I: String
//    var ITotal: Double
//
//    var J: String
//    var JTotal: Double


    
//    required init(A: String, B: String, C: String, D: String, E: String, F: String, G: String, H: String, I: String, J: String, ATotal: Double, BTotal: Double, CTotal: Double, DTotal: Double, ETotal: Double, FTotal: Double, GTotal: Double, HTotal: Double, ITotal: Double, JTotal: Double) {
//        self.A = A
//        self.B = B
//        self.C = C
//        self.D = D
//        self.E = E
//        self.F = F
//        self.G = G
//        self.H = H
//        self.I = I
//        self.J = J
//
//        self.ATotal = ATotal
//        self.BTotal = BTotal
//        self.CTotal = CTotal
//        self.DTotal = DTotal
//        self.ETotal = ETotal
//        self.FTotal = FTotal
//        self.GTotal = GTotal
//        self.HTotal = HTotal
//        self.ITotal = ITotal
//        self.JTotal = JTotal
//
//    }
    
//    convenience init?(json: JSON) {
//        guard let data = json["data"].dictionary,
//               let A = data["A"]?.dictionary,
//                let B = data["B"]?.dictionary,
//                 let C = data["C"]?.dictionary,
//                  let D = data["D"]?.dictionary,
//                   let E = data["E"]?.dictionary,
//                    let F = data["F"]?.dictionary,
//                     let G = data["G"]?.dictionary,
//                      let H = data["H"]?.dictionary,
//                       let I = data["I"]?.dictionary,
//                        let J = data["J"]?.dictionary,
//                        let ATotal = A["total"]?.double,
//                       let BTotal = B["total"]?.double,
//                      let CTotal = C["total"]?.double,
//                     let DTotal = D["total"]?.double,
//                    let ETotal = E["total"]?.double,
//                   let FTotal = F["total"]?.double,
//                  let GTotal = G["total"]?.double,
//                 let HTotal = H["total"]?.double,
//                let ITotal = I["total"]?.double,
//               let JTotal = J["total"]?.double else { return nil }
//
//        self.init(A: "A", B: "B", C: "C", D: "D", E: "E", F: "F", G: "G", H: "H", I: "I", J: "J", ATotal: ATotal, BTotal: BTotal, CTotal: CTotal, DTotal: DTotal, ETotal: ETotal, FTotal: FTotal, GTotal: GTotal, HTotal: HTotal, ITotal: ITotal, JTotal: JTotal)
//    }
    
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
