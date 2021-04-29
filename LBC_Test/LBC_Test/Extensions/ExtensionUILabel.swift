//
//  ExtensionUILabel.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 29/04/2021.
//

import UIKit

extension UILabel {
    
    //  MARK: - Extension UILabel
    
    func setLabel(label:UILabel,textAlignment:NSTextAlignment,numberOfLines:Int,ofSize:CGFloat,weight:UIFont.Weight,textColor:UIColor){
        label.numberOfLines = numberOfLines
        label.font = UIFont.systemFont(ofSize: ofSize,weight:weight)
        label.textAlignment = textAlignment
        label.textColor = textColor
    }
}
