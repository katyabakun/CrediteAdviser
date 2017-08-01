//
//  FilterViewController.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 01/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import Eureka
import Cartography
import  CSVImporter
class FilterViewController: FormViewController {
    var chosenBank = [Bank]()
    var banks = [Bank]()
    var buffer = [Bank]()
    var wartoscKredutu: Int=0
    var okresSplat: Int=0
    var rodzajKredytu = [String:[String]]()
    weak var weakParentViewContrller: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Filtracja"
        form +++ Section("Dane kredytu")
            <<< IntRow(){ row in
                row.title = "Wartość: "
                row.placeholder = "Wprowadź wartość kredytu"
                
                
            }.onChange({ (row) in
                self.wartoscKredutu = row.value!
            })
            <<< IntRow(){ row in
                row.title = "Czas: "
                row.placeholder = "Wprowadź okres spłaty"
                }.onChange({ (row) in
                    self.okresSplat = row.value!
                })
        let path = "/Users/katerina/Desktop/kredyt.csv"
        let importer = CSVImporter<Bank>(path: path)
        
        importer.startImportingRecords { recordValues -> Bank in
      
            
            return Bank(name: recordValues[0], rate: recordValues[1], rrs: recordValues[2], provision: recordValues[3], rata: recordValues[4],alltoPay: recordValues[5], extraInfo: recordValues[6], max_okres_kred:  recordValues[7],zawieszenie_w_roku : recordValues[8], waluta : recordValues[9],przewalutowanie:recordValues[10], rodzajHredytu: recordValues[11])
            
            print (recordValues)
            }.onFinish { importedRecords in
                self.banks = importedRecords

                
        }
        self.navigationItem.title = "Filtruj"
        rodzajKredytu = ["Kredyt na mieszkanie":["mieszkanie","mieszkanie i dzialka"], "Kredyt na działkę":["dzialka","mieszkanie i dzialka"],"Kredyt na konsolidację zadłużenia":["konsolidacja zadluzenia"]]
        form +++ SelectableSection<ImageCheckRow<String>>("Rodzaj kredytu hipotecznego", selectionType: .singleSelection(enableDeselection: true))
        let r = rodzajKredytu.flatMap(){ $0.0 }
        
        for item in r {
            form.last! <<< ImageCheckRow<String>(item){ lrow in
                lrow.title = item
                lrow.selectableValue = item
                lrow.value = nil
                }.cellSetup { cell, _ in
                    cell.trueImage = UIImage(named: "selected")!
                    cell.falseImage = UIImage(named: "unselected")!
            }
        }

        let options = ["Okres kredytowania powyżej 30 lat", "Kredyt walutowy", "Możliwość zawieszenia kredytu"]
         form +++ SelectableSection<ImageCheckRow<String>>("Filtrowanie zaawansowane", selectionType: .multipleSelection)
        
        for option in options {
            form.last! <<< ImageCheckRow<String>(option){ lrow in
                lrow.title = option
                lrow.selectableValue = option
                lrow.value = nil
                }.cellSetup { cell, _ in
                    cell.trueImage = UIImage(named: "selected")!
                    cell.falseImage = UIImage(named: "unselected")!
                }
        }
       
        form +++ Section("Zapisz dane")
            <<< ButtonRow("Save"){ row in
                row.title = "Save"
                
                
                }.onCellSelection{ [weak self] (cell, row) in
                self?.saveButtonClick()
        }
       
        

    
    }
    override func valueHasBeenChanged(for row: BaseRow, oldValue: Any?, newValue: Any?) {
      if( row.section == form[1]){
            print("Single Selection:\((row.section as! SelectableSection<ImageCheckRow<String>>).selectedRow()?.baseValue ?? "No row selected")")
            for item in banks {
                let row = (row.section as! SelectableSection<ImageCheckRow<String>>).selectedRow()?.baseValue ?? "No row selected"
                for x in rodzajKredytu[row as! String]!{
                if item.rodzajKredytu == x {
                    self.chosenBank.append(item)
                }
                }
            }
        }else  if( row.section === form[2]){
            print("Mutiple Selection:\((row.section as! SelectableSection<ImageCheckRow<String>>).selectedRows().map({$0.baseValue}))")

            for item in chosenBank{
                let row = (row.section as! SelectableSection<ImageCheckRow<String>>).selectedRows().map({$0.baseValue}) as! [String]
                for r in row{
                if r == "Okres kredytowania powyżej 30 lat" {
                    if item.max_okres_kred == "35" {
                        buffer.append(item)
                    }
                }
                else if r == "Kredyt walutowy"{
                    if item.waluta == "1"{
                        buffer.append(item)
                    }
                }
                else {
                    if item.zawieszenie_w_roku == "1"
                        {
                        buffer.append(item)
                    }
                    }
                }
        }
        buffer = buffer.unique
        print(buffer)
        }
    }
    
    func saveButtonClick() {
        let defaults = UserDefaults.standard
        print(wartoscKredutu)
        print(okresSplat)
    
        defaults.set(wartoscKredutu, forKey: "creditValue")
        defaults.set(okresSplat, forKey: "creditTime")
        defaults.synchronize()
        if !buffer.isEmpty{
            let loadingVC = LoadingViewController.init(initWithData: buffer)
            loadingVC.weakParentViewContrller = self
                self.present(loadingVC, animated: true, completion: nil)
        
        }
    else{
    let loadingVC = LoadingViewController.init(initWithData: banks)
    loadingVC.weakParentViewContrller = self
    self.present(loadingVC, animated: true, completion: nil)}


//        self.navigationController?.pushViewController(BankViewController.init(initWithData: chosenBank!), animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = .white
        nav?.barTintColor = darkMintColor
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
