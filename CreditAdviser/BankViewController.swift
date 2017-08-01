
//
//  DemoTableViewController.swift
//  FoldingCellProgrammatically
//
//  Created by Alex K. on 09/06/16.
//  Copyright © 2016 Alex K. All rights reserved.
//
import UIKit
import FoldingCell
struct BankRow{
    var item: Bank
    var rating: Double
    var rata: Double
    var allToPay:Double
    var image: UIImage

    init(item: Bank,rating: Double,rata: Double,allToPay:Double,image:UIImage){
        self.item = item
        self.rating = rating
        self.rata = rata
        self.allToPay = allToPay
        self.image = image

    }
}
class BankViewController: UITableViewController {
    var chosenBank = [Bank]()
    var ranking = [Double]()
    let closeHeight: CGFloat = 91
    let openHeight: CGFloat = 250
    var itemHeight = [CGFloat]()
    var bankRows = [BankRow]()
    var s0=[Double]()
    var s1=[[Double]]()
    var sub_s=[Double]()
    
    init(initWithData chosenBank: [Bank], ranking: [Double],s1:[[Double]],s0:[Double],sub_s:[Double]) {
        self.chosenBank = chosenBank
        self.ranking = ranking
        self.s0=s0
        self.s1=s1
        self.sub_s=sub_s
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Szczegóły"
        
        let defaults = UserDefaults.standard
        let creditValue:String = defaults.string(forKey: "creditValue")!
        let creditTime:String = defaults.string(forKey: "creditTime")!
        for i in 0..<chosenBank.count{
            var rata = o_rata(kwotaKredytu: creditValue.doubleValue, ilosc_rat: creditTime.doubleValue, rate: chosenBank[i].rate.doubleValue)
            var row = BankRow(item: chosenBank[i], rating: ranking[i], rata: rata, allToPay: 12*rata*chosenBank[i].rate.doubleValue*creditTime.doubleValue, image: UIImage(named: imageDictionary[chosenBank[i].name]!)!)
            bankRows.append(row)
        }
        bankRows.sort { (first: BankRow, second: BankRow) -> Bool in
            first.rating>second.rating
        }
        itemHeight = Array(repeating: 91, count: bankRows.count)
        registerCell()
        let saveButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width/10, height: self.view.frame.width/10))
        saveButton.setImage(UIImage(named:"graph"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveOption), for: .touchUpInside)
        let barButton = UIBarButtonItem()
        barButton.customView = saveButton
        self.navigationItem.setRightBarButton(barButton, animated: true)
      
    }
    func saveOption(){
        self.navigationController?.pushViewController(ChartViewController.init(ranking: ranking, banks: chosenBank,s0:s0), animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = .white
        nav?.barTintColor = darkMintColor
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        
        
    }
}

// MARK: Helpers
extension BankViewController {
    
    func registerCell() {
        tableView.register(BankFoldingCell.self, forCellReuseIdentifier: "bankCell")
        
    }
    func o_rata(kwotaKredytu: Double,ilosc_rat: Double,rate: Double)->Double{
        var wsp_q = 1+(rate/100/12)
        var rata: Double = kwotaKredytu*pow(wsp_q,ilosc_rat*12)*((wsp_q-1)/(pow(wsp_q,ilosc_rat*12)-1))
        print(rata)
        return rata
    }
    
}

// MARK: - Table view data source
extension BankViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemHeight.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bankCell", for: indexPath as IndexPath) as! BankFoldingCell
        //setup headers
        cell.textLabelf.text = bankRows[indexPath.row].item.name
        cell.rateLabelf.text =  "\((bankRows[indexPath.row].rating).roundTo(places:4))"
        cell.imageViewf.image = bankRows[indexPath.row].image
    
        //setupExpandView
        cell.ofertaName.text = bankRows[indexPath.row].item.extraInfo
        cell.textRatac.text = "\((bankRows[indexPath.row].rata).roundTo(places: 2))"
        cell.textLabelc.text = bankRows[indexPath.row].item.name
        cell.ratingLabelc.text = "\((bankRows[indexPath.row].rating).roundTo(places: 2))"
        cell.textRatec.text = bankRows[indexPath.row].item.rate
        cell.textAllToPayc.text = "\((bankRows[indexPath.row].allToPay).roundTo(places: 2))"
        cell.imageViewc.image = bankRows[indexPath.row].image
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight[indexPath.row]
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        var duration = 0.0
        if itemHeight[indexPath.row] == closeHeight { // open cell
            itemHeight[indexPath.row] = openHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            itemHeight[indexPath.row] = closeHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    }

