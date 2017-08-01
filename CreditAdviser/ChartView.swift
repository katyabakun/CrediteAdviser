//
//  ChartView.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 20/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import Charts
import EasyPeasy

class ChartView: BarChartView{

    let barChartView = BarChartView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(barChartView)
        self.backgroundColor = .white
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
