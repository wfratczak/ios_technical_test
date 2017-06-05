//
//  RepositoryCell.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roundedView: UIView!
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadowIfNeeded()
    }
    
    private func addShadowIfNeeded() {
        guard shadowLayer == nil else {return}
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: roundedView.frame, cornerRadius: 0).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = UIColor.white.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 5
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
}
