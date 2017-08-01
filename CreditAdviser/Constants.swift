//
//  Constants.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 19/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit


let mintColor1 = UIColor(red: 91/255, green: 182/255, blue: 154/255, alpha: 0.4)
let darkMintColor = UIColor(red: 77/255, green: 155/255, blue: 131/255, alpha: 1.0)
extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}
let imageDictionary:[String:String]=["PKO":"pko","BOS":"bos","mBank":"mbank","BZ WBK":"bz_wbk","ING":"ing","eurobank":"eurobank","Deutsche Bank":"Deutsche","Bank Pekao":"bankpekao","Milleniium":"millennium","BANK BGZ BNP PARIBAS":"bgz_bnp_paribas","GETIN BANK":"getin","Raiffeisen POLBANK":"raiffeisen","ALIOR BANK":"alior","CREDIT AGRICOLE":"credit_agricole"]
extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
