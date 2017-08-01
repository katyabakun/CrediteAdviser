//
//  ViewController.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 31/05/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import CircleMenu
import Cartography

class MainMenuViewController: BaseViewController <MainMenuView>,CircleMenuDelegate {
    let circleMenu = CircleMenu(
    frame: CGRect(x: 130, y: 130, width: 50, height: 50),
    normalIcon:"Menu",
    selectedIcon:"close",
    buttonsCount: 3,
    duration: 2,
    distance: 200)
    var userInPutButton = UIButton()

    let items: [(icon: String, color: UIColor)] = [
        ("settings", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
        ("checklist", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
        ("graph", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
        
        ]
    let controller : [String] = ["FilterViewController","VC"]
    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = mintColor1
        self.view.addSubview(circleMenu)
        // Do any additional setup after loading the view, typically from a nib.
        self.circleMenu.delegate = self
        constrain(self.circleMenu){mainB in
            guard let superview = mainB.superview else {
                return
            }
            mainB.center == superview.center
            mainB.width == 120
            mainB.height == mainB.width
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
        if(atIndex==1){
            
            self.navigationController?.pushViewController(FilterViewController(), animated: true)
        }
        else if (atIndex==2){
//            self.navigationController?.pushViewController(BankViewController(), animated: true)
        }
        else {
//            self.navigationController?.pushViewController(ChartViewController(), animated: true)
        }
       
     }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
 
    }
    
}

enum UIModalTransitionStyle : Int {
    case CoverVertical = 0
    case FlipHorizontal
    case CrossDissolve
    case PartialCurl
}

extension UIColor {
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            colorLiteralRed: Float(1.0) / Float(255.0) * Float(red),
            green: Float(1.0) / Float(255.0) * Float(green),
            blue: Float(1.0) / Float(255.0) * Float(blue),
            alpha: alpha)
    }
}
