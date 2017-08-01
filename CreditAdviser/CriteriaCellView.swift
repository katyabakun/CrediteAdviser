//
//  CreteriaCellView.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 14/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import FoldingCell
import EasyPeasy

class CriteriaCellView: FoldingCell {
    var animationView: UIView?
    let textLabelf = UILabel()
    let imageViewf = UIImageView()
    let imageViewfb = UIImageView()
    let textLabelfb = UILabel()
    let rateLabelf = UILabel()
    let lineViewf = UIView()
    let lineViewfb = UIView()
    let rrsoLabel = UILabel()
    let rrscoText = UILabel()
    let ofertaName = UILabel()
    let textRatec = UILabel()
    let textLabelc = UILabel()
    let imageViewc = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.containerView = createContainerView()
        self.foregroundView = createForegroundView()
        
      
        

        
        // super class method configure views
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: AnimationType) -> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
}

// MARK: Configure
extension CriteriaCellView {
    
    
    func createForegroundView() -> RotatedView {
        let foregroundView = RotatedView()
        foregroundView.backgroundColor = .lightGray
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        
        
        contentView.addSubview(foregroundView)
        //add more
       
        // add constraints
        textLabelf.text = "BankNameA"
        textLabelfb.font = UIFont.systemFont(ofSize: 12.0)
        imageViewf.image = UIImage(named: "rating")
        lineViewf.backgroundColor = .gray
        lineViewfb.backgroundColor = .gray
        imageViewfb.image = UIImage(named: "rating")
        textLabelfb.text = "BankNameB"
        textLabelf.font = UIFont.systemFont(ofSize: 12.0)
        foregroundView.addSubview(textLabelf)
        foregroundView.addSubview(imageViewf)
        foregroundView.addSubview(textLabelfb)
        foregroundView.addSubview(imageViewfb)
        foregroundView.addSubview(rateLabelf)
        foregroundView.addSubview(lineViewf)
        foregroundView.addSubview(lineViewfb)
        
        imageViewf <- [
            Top(10).to(foregroundView),
            Bottom(10).to(foregroundView),
            Left(10).to(foregroundView),
            Width(60)
        ]
        lineViewf <- [
            Height().like(imageViewf),
            Top(10).to(foregroundView),
            Left(10).to(imageViewf),
            Width(1)
        ]
        textLabelf <- [
            CenterY(),
            Left(10).to(lineViewf)
        ]
        imageViewfb <- [
            Top(10).to(foregroundView),
            Bottom(10).to(foregroundView),
            Right(10).to(foregroundView),
            Width(60)
        ]
        lineViewfb <- [
            Height().like(imageViewf),
            Top(10).to(foregroundView),
            Right(10).to(imageViewfb),
            Width(1)
        ]
        textLabelfb <- [
            CenterY(),
            Right(10).to(lineViewfb)
        ]
        
        rateLabelf <- [
            Right(20).to(foregroundView),
            CenterY()
        ]
        foregroundView <- [
            Height(75),
            Left(8),
            Right(8),
            
        ]
        
        // add identifier
        let top = (foregroundView <- [Top(5)]).first
        self.foregroundViewTop = top
        
        foregroundView.layoutIfNeeded()
        
        return foregroundView
    }
    
    func createContainerView() -> UIView {
        let containerView = UIView()
        
        containerView.backgroundColor = mintColor1
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //add more
        
        let textRatingc = UILabel()
        let rateLabelc = UILabel()
        let lineViewc = UIView()
        let rataLabelc = UILabel()
        let allToPayLabelc = UILabel()
        
        
        // add constraints
        textLabelc.text = "BankName"
        textLabelc.font = UIFont (name: "Georgia-Bold", size: 18)
        
        imageViewc.image = UIImage(named: "rating")
        lineViewc.backgroundColor = .gray

        rateLabelc.text = "Oprocentowanie"
        rateLabelc.font = UIFont (name: "Georgia-Bold", size: 18)
        textRatec.text = "Rate id here"

        
        ofertaName.text = "NazwaOferty bardzo długa nazwa ...no bardzo bardzo"
        ofertaName.font = UIFont(name: "Helvetica-Oblique", size: 14.0)
        ofertaName.lineBreakMode = .byWordWrapping
        ofertaName.numberOfLines = 0
        ofertaName.sizeToFit()
        rrscoText.text = "0"
        rrsoLabel.text = "RRSO"
        rrsoLabel.font = UIFont(name: "Georgia-Bold", size: 18)
        containerView.addSubview(textLabelc)
        containerView.addSubview(imageViewc)
        
        containerView.addSubview(lineViewc)
        
        containerView.addSubview(textRatec)
        containerView.addSubview(rateLabelc)
        
        
        containerView.addSubview(allToPayLabelc)
        
        containerView.addSubview(ofertaName)
        containerView.addSubview(rrsoLabel)
        containerView.addSubview(rrscoText)
        
        imageViewc <- [
            Top(10).to(containerView),
            Height(60),
            Left(10).to(containerView),
            Width(60)
        ]
        lineViewc <- [
            Height().like(imageViewc),
            Top(10).to(containerView),
            Left(10).to(imageViewc),
            Width(1)
        ]

        ofertaName <- [
            CenterY(),
            Left(10).to(lineViewc),
            Right(50).to(containerView)
        ]

        

        self.contentView.addSubview(containerView)
        //add more
        
        
        // add constraints
        
        containerView <- [
            Height(CGFloat(91 )),
            Left(8),
            Right(8),
        ]
        
        // add identifier
        
        let top = (containerView <- [
            
            Top(5)]).first
        self.containerViewTop = top
        
        containerView.layoutIfNeeded()
        
        return containerView
    }
}
