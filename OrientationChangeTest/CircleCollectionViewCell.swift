//
//  CircleCollectionViewCell.swift
//  OrientationChangeTest
//
//  Created by K Y on 12/23/19.
//  Copyright © 2019 Yu. All rights reserved.
//

import UIKit

extension UIView {
    func makeCircleOutline(borderColor: UIColor = .black, borderWidth: CGFloat = 4.0) {
        let l = layer
        l.masksToBounds = false
        l.cornerRadius = bounds.size.width / 2.0
        l.borderWidth = borderWidth
        l.borderColor = borderColor.cgColor
    }
}

class CircleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var label: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.makeCircleOutline()
    }
}
