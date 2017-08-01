//
//  BankFilterCell.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 13/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import Cartography

class BankFilterCell: UITableViewCell{
    
    let titleLabel = UILabel()
    let bankImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.bankImage)
       
        
        //bankImage.image = UIImage(named: "unselected")
        //MARK: Setup textLabel
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.backgroundColor = .clear
        self.titleLabel.layer.masksToBounds = true
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping

        self.addSubview(self.titleLabel)

        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints(){
        
        constrain(self.titleLabel,self.bankImage){title, image in
            
            image.centerY == image.superview!.centerY
            image.right == image.superview!.right-20
            image.height == image.superview!.height/2
            image.width == image.height
            
            title.centerY == title.superview!.centerY
            title.width == title.superview!.width - 70
            title.left == title.superview!.left + 20

        }
    }
    func setCheck(isCheck: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        self.bankImage.image = isCheck ? UIImage(named:"selected"):UIImage(named:"unselected")
    }
}
