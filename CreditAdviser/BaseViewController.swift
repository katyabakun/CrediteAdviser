//
//  BaseView.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 31/05/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit

class BaseViewController<TView: UIView> : UIViewController {
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        
        print("init in BaseViewController -> \(type(of: self))")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var aView: TView {
        return self.view as! TView
    }
    
    override func loadView() {
        let view = TView(frame: UIScreen.main.bounds)
        
        self.view = view
    }
    
    //MARK: deinit
    deinit {
        
        print("deinit in BaseViewController -> \(type(of: self))")
    }
    
    
}

