//
//  BankFilterViewController.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 12/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import Cartography

struct SectionS {
    var name: String!
    var items: [Items]!
    var collapsed: Bool!
    
    
    init(name: String, items:[Items], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}
struct Items{

    var name:String!
    var isCheck: Bool!
    init(name: String,isCheck:Bool = false) {
        self.name=name
        self.isCheck=isCheck
    }
}
class BankFilterViewController: UITableViewController {
    var chosenBank : [Bank]
    var isExpanded = false
    var sections = [String]()
    var items=[[Items]]()
    var sectionS = [SectionS]()
    var selectedOffers = [String]()
    
    init(initWithData banks: [Bank]){
        self.chosenBank = banks
        
        super.init(nibName: nil, bundle: nil)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Adding delegate to tableViewcell
        
        let saveButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width/6, height: self.view.frame.width/6))
self.navigationItem.title = "Wybierz banki"
        
        saveButton.setTitle("Save >", for: .normal)
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveOption), for: .touchUpInside)
        let barButton = UIBarButtonItem()
        barButton.customView = saveButton
        self.navigationItem.setRightBarButton(barButton, animated: true)
  
        
        var buffer: String = " "
        for item in chosenBank{
            if item.name != buffer{
                buffer = item.name
                sections.append(buffer)
            }
        }
        sections =  sections.unique
        tableView.register(BankFilterCell.self, forCellReuseIdentifier: "cell")
        for item in sections{
            
            var r_items = [Items]()
            for name in chosenBank{
                if name.name == item {
                    var row = Items(name: name.extraInfo)
                    r_items.append(row)
                }
                
            }
            items.append(r_items)
        }
        print(items)
        for item in 0..<sections.count{
            let sec = SectionS(name: sections[item], items: items[item])
            sectionS.append(sec)
        }
            print(sectionS.count)

    }

    
}
    extension BankFilterViewController {
        

        override func numberOfSections(in tableView: UITableView) -> Int {
            return sectionS.count
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sectionS[section].items.count
        }
        
        // Cell
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! BankFilterCell
            cell.titleLabel.text = sectionS[indexPath.section].items[indexPath.row].name
            cell.setCheck(isCheck: sectionS[indexPath.section].items[indexPath.row].isCheck)
            return cell
        }
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return sectionS[indexPath.section].collapsed! ? 44.0 : 0

        }
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? BankHeaderSectionCell ?? BankHeaderSectionCell(reuseIdentifier: "header")
            
            header.titleLabel.text = sectionS[section].name
            header.toggledLabel.text = "+"
            header.setCollapsed(collapsed: sectionS[section].collapsed)
            
            header.section = section
            header.delegate = self
            
            return header
        }
        
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50.0
        }
        

        override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 1.0
        }
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! BankFilterCell
            
            let isCheck = !sectionS[indexPath.section].items[indexPath.row].isCheck
            sectionS[indexPath.section].items[indexPath.row].isCheck = isCheck
            print(isCheck)
            tableView.reloadData()
            if selectedOffers.count<5{
                if isCheck{
                    selectedOffers.append(cell.titleLabel.text!)

                }else{
                    if let index = selectedOffers.index(of: cell.titleLabel.text!) {
                        selectedOffers.remove(at: index)
                    }
                    
                }
                
            }
            else{
                let alertController = UIAlertController(title: "Za dużo wybrałeś", message:
                    "Proszę zmniejsz liczbę banków do porównywania!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            
            
            }
            
        }
        func saveOption(){
            var prossbank=[Bank]()
            for item in 0..<chosenBank.count{
                for x in 0..<selectedOffers.count{
                    if chosenBank[item].extraInfo == selectedOffers[x]{
                        prossbank.append(chosenBank[item])
                    }
                }
            }
            self.navigationController?.pushViewController(CriteriaViewController.init(initWithData: prossbank), animated: true)
        }
        
    }
extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}
extension BankFilterViewController: BankTableViewHeaderDelegate {
    func toggleSection(header: BankHeaderSectionCell, section: Int) {
        let collapsed = !sectionS[section].collapsed
        // Toggle collapse
        sectionS[section].collapsed = collapsed
        header.setCollapsed(collapsed: collapsed)
        // Adjust the height of the rows inside the section
        tableView.beginUpdates()
        for i in 0 ..< sectionS[section].items.count {
            
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
            
        }
        tableView.endUpdates()
    }
}

