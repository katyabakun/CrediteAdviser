//
//  DemoFoldingCell.swift
//  FoldingCellProgrammatically
//
//  Created by Alex K. on 09/06/16.
//  Copyright © 2016 Alex K. All rights reserved.
//
import UIKit
import FoldingCell
import EasyPeasy
import Cartography
class BankFoldingCell: FoldingCell {
    var animationView: UIView?
    let textLabelf = UILabel()
    let imageViewf = UIImageView()
    let rateLabelf = UILabel()
    let lineViewf = UIView()
    let rrsoLabel = UILabel()
    let rrscoText = UILabel()
    let ofertaName = UILabel()
    let textAllToPayc = UILabel()
    let textRatac = UILabel()
    let textRatec = UILabel()
    let ratingLabelc = UILabel()
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
extension BankFoldingCell {

    
     func createForegroundView() -> RotatedView {
        let foregroundView = RotatedView()
            foregroundView.backgroundColor = .lightGray
            foregroundView.translatesAutoresizingMaskIntoConstraints = false
        
        
        contentView.addSubview(foregroundView)
        //add more
         let textRatingf = UILabel()
        // add constraints
        textLabelf.text = "BankName"
        rateLabelf.text = "Here ist rating"
        imageViewf.image = UIImage(named: "rating")
        lineViewf.backgroundColor = .gray
        textRatingf.font = UIFont (name: "Georgia-Bold", size: 14)
        textRatingf.text = "Rating"
        foregroundView.addSubview(textLabelf)
        foregroundView.addSubview(imageViewf)
        foregroundView.addSubview(rateLabelf)
        foregroundView.addSubview(lineViewf)
        foregroundView.addSubview(textRatingf)
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
        textRatingf <- [
            Right(20).to(foregroundView),
            Top(10).to(foregroundView)
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
        ratingLabelc.text = "Here is rating"
        imageViewc.image = UIImage(named: "rating")
        lineViewc.backgroundColor = .gray
        textRatingc.font = UIFont (name: "Georgia-Bold", size: 18)
        textRatingc.text = "Rating"
        rateLabelc.text = "Oprocentowanie"
        rateLabelc.font = UIFont (name: "Georgia-Bold", size: 18)
        textRatec.text = "Rate id here"
        rataLabelc.text = "Rata w miesiącu"
        rataLabelc.font = UIFont (name: "Georgia-Bold", size: 18)
        textRatac.text = "Rata is here.."
        allToPayLabelc.font = UIFont (name: "Georgia-Bold", size: 18)
        allToPayLabelc.text = "Całość do zapłaty"
        textAllToPayc.text = "Całość w zł/inne"
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
        containerView.addSubview(ratingLabelc)
        containerView.addSubview(lineViewc)
        containerView.addSubview(textRatingc)
        containerView.addSubview(textRatec)
        containerView.addSubview(rateLabelc)
        containerView.addSubview(rataLabelc)
        containerView.addSubview(textRatac)
        containerView.addSubview(allToPayLabelc)
        containerView.addSubview(textAllToPayc)
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
        textLabelc <- [
            Top(5).to(containerView),
            Left(10).to(lineViewc)
        ]
        ofertaName <- [
            Top(5).to(textLabelc),
            Left(10).to(lineViewc),
            Right(50).to(containerView)
        ]
        textRatingc <- [
            Left(10).to(containerView),
            Top(10).to(imageViewc)
        ]
        ratingLabelc <- [
            Right(20).to(containerView),
            Top(10).to(imageViewc)
        ]
        rateLabelc <- [
            Left(10).to(containerView),
            Top(10).to(textRatingc)
        ]
        textRatec <- [
            Right(20).to(containerView),
            CenterY().to(rateLabelc)
        ]
        rataLabelc <- [
            Left(10).to(containerView),
            Top(20).to(rateLabelc)
        ]
        textRatac <- [
            Right(10).to(containerView),
            CenterY().to(rataLabelc)
        ]
        allToPayLabelc <- [
            Left(10).to(containerView),
            Top(20).to(textRatac)
        ]
        textAllToPayc <- [
            Right(10).to(containerView),
            CenterY().to(allToPayLabelc)
        ]
        self.contentView.addSubview(containerView)
        //add more 
        

        // add constraints

        containerView <- [
            Height(CGFloat(250 )),
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

