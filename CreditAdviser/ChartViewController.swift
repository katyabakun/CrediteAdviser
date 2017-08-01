//
//  ChartViewController.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 20/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import  Foundation
import Charts




class ChartViewController: BaseViewController<ChartView> {
//    override init() {
//        super.init()
//    }
    var chosenBank = [Bank]()
    var rankingGlobalny = [Double]()
    var banks = [BankRating]()
    var s0 = [Double]()
    init(ranking:[Double],banks: [Bank],s0:[Double]){
        
        self.rankingGlobalny = ranking
        self.chosenBank = banks
        self.s0 = s0
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.title = "Ranking Globalny"
        for i in 0..<chosenBank.count{
            let row = BankRating(name: chosenBank[i].name, value: rankingGlobalny[i]*100)
            banks.append(row)
        }
        let saveButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width/10, height: self.view.frame.width/10))
        saveButton.setImage(UIImage(named:"graph"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveOption), for: .touchUpInside)
        let barButton = UIBarButtonItem()
        barButton.customView = saveButton
        self.navigationItem.setRightBarButton(barButton, animated: true)
        
    

        // Initialize an array to store chart data entries (values; y axis)
        var banksEntries = [ChartDataEntry]()
        
        
        // Initialize an array to store months (labels; x axis)
        var bankName = [String]()
        
        var i = 0.0
        for bank in banks {
            // Create single chart data entry and append it to the array
            let bankEntry = BarChartDataEntry(x: Double(i), yValues: [bank.value])
            banksEntries.append(bankEntry)
            
            // Append the month to the array
            bankName.append(bank.name)
            
            i += 1.0
        }
        
        // Create bar chart data set containing salesEntries
        let chartDataSet = BarChartDataSet(values: banksEntries, label: "Ranking")
        
        
        // Create bar chart data with data set and array with values for x axis
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        
        // Set bar chart data to previously created data
        self.aView.data = chartData
        self.aView.descriptionText = " "
        self.aView.xAxis.labelPosition = .bottom
        self.aView.xAxis.valueFormatter = IndexAxisValueFormatter(values: bankName)
        //Also, you probably want to add:
        
        self.aView.xAxis.granularity = 1
        self.aView.leftAxis.axisMinimum = 0.0
        self.aView.leftAxis.axisMaximum = 100.0
        chartDataSet.colors = [.red, .yellow, .green]
        
        // Or this way. There are also available .liberty,
        // .pastel, .colorful and .vordiplom color sets.
        chartDataSet.colors = ChartColorTemplates.joyful()
        self.aView.legend.enabled = false
        self.aView.scaleYEnabled = false
        self.aView.scaleXEnabled = false
        self.aView.pinchZoomEnabled = false
        self.aView.doubleTapToZoomEnabled = false
        self.aView.highlighter = nil
        self.aView.rightAxis.enabled = false
        self.aView.xAxis.drawGridLinesEnabled = false
        self.aView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
    }
    func saveOption(){
        self.navigationController?.pushViewController(Chart2ViewC.init(ranking: rankingGlobalny, banks: chosenBank, s0: s0), animated: true)
    }


}
