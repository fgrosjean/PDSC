//
//  UIView.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/3/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(cornerRadius: Double, corners: CACornerMask) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = corners
    }
    
    func setSegmentedControlMaskWith(_ moduleHeight: CGFloat, segmentedControlContainer: UIView, currentSectionNeedsMask: Bool) {
        if currentSectionNeedsMask {
            let path = UIBezierPath(rect: CGRect(x: 0, y: moduleHeight, width: 1000, height: segmentedControlContainer.bounds.height))
            let maskLayer = CAShapeLayer()
            
            path.append(UIBezierPath(rect : self.superview!.bounds))
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        } else {
            self.layer.mask = nil
        }
    }
}
