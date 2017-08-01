//
//  UserData.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 06/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit

class UserData: NSObject {
    let creditValue:Int
    let creditTime:Int
    init(value:Int,time:Int){
        self.creditTime = time
        self.creditValue = value
    }

}
