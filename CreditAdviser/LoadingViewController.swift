//
//  LoadingViewController.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 12/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit

class LoadingViewController: BaseViewController<LoadingView> {
    
    
    var bankModel: [Bank]
    
    
    weak var weakParentViewContrller: UIViewController?
    init(initWithData banks: [Bank]){
        self.bankModel = banks
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissMeAfterTime), name: NSNotification.Name(rawValue: "dismissViewController"), object: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
//            self.aView.showAnimation()
            self.perform(#selector(LoadingViewController.showWeatherDiscription), with: nil, afterDelay: 6.0)
            
        }
    }
    func dismissMeAfterTime() {
        
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.removeObserver(self)
    }
                    
    func showWeatherDiscription() {
 
        
        print(self.weakParentViewContrller)
        self.dismiss(animated: false) { [unowned self] in
            self.weakParentViewContrller?.navigationController?.pushViewController(BankFilterViewController.init(initWithData: self.bankModel), animated: true)
//            self.weakParentViewContrller!.present(BankViewController.init(initWithData banks: bankModel), animated: false, completion: nil)
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
