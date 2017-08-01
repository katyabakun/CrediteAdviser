//
//  BankFilterView.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 13/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import Cartography

class BankFilterView: UIView {
    
    let expandTableView = UITableView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstrains()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        
        
        self.addSubview(self.expandTableView)
        
    }
    
    func setupConstrains() {
        
        constrain(self.expandTableView){picker in
            picker.centerX == picker.superview!.centerX
            picker.top == picker.superview!.top
            picker.size == picker.superview!.size
            
            
        }
        
    }
    
    
    
}

