//
//  LoadingView.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 12/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import Cartography

class LoadingView: UIView {
    
    lazy var backgroundImageView = UIImageView()
    lazy var blurImageView = UIVisualEffectView()
    lazy var topImageView = UIImageView()
    lazy var reservationStateLabel = UILabel()
    let gradientLayer = CAGradientLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews(){
        
        //Adding background image
        self.backgroundImageView.image = UIImage(named: "clouds")
        self.addSubview(self.backgroundImageView)
        
        //Adding blur effects
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        self.blurImageView.effect = blurEffect
        self.addSubview(self.blurImageView)
        
        //Adding top image
        self.topImageView.image = UIImage(named: "settings")
        self.addSubview(self.topImageView)
        
        //Adding reservation state label
        self.reservationStateLabel.text = "Poczekaj chwile przetwarzamy dane"
        self.reservationStateLabel.sizeToFit()
        self.reservationStateLabel.textColor = UIColor.white
        self.addSubview(self.reservationStateLabel)
        
        
    }
    func setupConstraints(){
        let x = self.bounds.width
        
        constrain(self.backgroundImageView){background in
            background.top == background.superview!.top
            background.right == background.superview!.right
            background.width == background.superview!.width
            background.height == background.superview!.height
        }
        
        constrain(self.blurImageView){blur in
            blur.top == blur.superview!.top
            blur.right == blur.superview!.right
            blur.width == blur.superview!.width
            blur.height == blur.superview!.height
        }
        
        constrain(self.topImageView,self.reservationStateLabel){topimage , statelabel in
            topimage.center == topimage.superview!.center
            topimage.width == x/2.6
            topimage.height == topimage.width
            
            statelabel.centerX == topimage.centerX
            statelabel.top == topimage.bottom + 20
            
        }
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.topImageView.layer.cornerRadius = self.topImageView.bounds.height/2
        self.topImageView.clipsToBounds = true
        
        
    }
    
    func showAnimation() {
        let radius = self.bounds.width/5
        let circle = CAShapeLayer()
        circle.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.0*radius, height: 2.0*radius), cornerRadius: CGFloat(radius)).cgPath
        
        circle.position = CGPoint(x: self.topImageView.frame.origin.x-3.2, y: self.topImageView.frame.origin.y - 3)
        
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.white.cgColor
        circle.lineWidth = 5.0
        
        self.layer.addSublayer(circle)
        let basicAnimation =  CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = 2.0
        basicAnimation.repeatCount = 0
        
        basicAnimation.fromValue = NSNumber(value: 0.0)
        basicAnimation.toValue = NSNumber(value: 1.0)
        basicAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        
        circle.add(basicAnimation, forKey: "strokeEnd")
    }
    
}
