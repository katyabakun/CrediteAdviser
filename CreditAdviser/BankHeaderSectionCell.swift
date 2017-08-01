//
//  BankHeaderSectionCell.swift
//  CreditAdviser
//
//  Created by Katerina Bakun on 13/06/2017.
//  Copyright © 2017 Katerina Bakun. All rights reserved.
//

import UIKit
import Cartography
protocol BankTableViewHeaderDelegate {
    func toggleSection(header: BankHeaderSectionCell, section: Int)
}
class BankHeaderSectionCell: UITableViewHeaderFooterView {
    var delegate: BankTableViewHeaderDelegate?
    var section: Int = 0
    
    let toggledLabel = UILabel()
    let titleLabel = UILabel()
    let bankImage = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(self.bankImage)
        bankImage.image = UIImage(named: "sun")
        //MARK: Setup textLabel
        self.titleLabel.allowsDefaultTighteningForTruncation = true
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 3
        self.addSubview(self.titleLabel)
        //MARK: Setup toggledButton
        self.toggledLabel.text = "+"
        self.addSubview(self.toggledLabel)
        self.setupConstraints()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BankHeaderSectionCell.tapHeader(gestureRecognizer:))))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints(){
        
        constrain(self.titleLabel,self.toggledLabel,self.bankImage){title, button, image in
            
            image.centerY == image.superview!.centerY
            image.left == image.superview!.left+20
            image.height == image.superview!.height/2
            image.width == image.height
            
            title.centerY == title.superview!.centerY
            title.left == image.right + 20
            
            button.centerY == button.superview!.centerY
            button.right == button.superview!.right - 15
            button.height == button.superview!.height
            button.width == button.height
        }
    }
    func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? BankHeaderSectionCell else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    func setCollapsed(collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        self.toggledLabel.text = collapsed ? "-":"+"
    }


}
