//
//  PDSCButton.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/4/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

@IBDesignable final class PDSCButton: UIButton {
    @IBInspectable var bgColor: UIColor = UIColor.black {
        didSet { backgroundColor = bgColor }
    }
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 6
        clipsToBounds      = true
        backgroundColor    = bgColor
    }
    
    // MARK: - Handle Touches
    // -------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: [], animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
