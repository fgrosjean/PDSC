//
//  LinedTextView.swift
//  PDSC
//
//  Created by Fernando Grosjean on 11/18/18.
//  Copyright © 2018 Fernando Grosjean. All rights reserved.
//

import UIKit

final class NotepadTextView: UITextView {
    
    private var sizeCheck = CGSize(width: 0, height: 0)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        self.backgroundColor = UIColor(red:0.94, green:0.90, blue:0.64, alpha:1.0)
        self.textContainerInset = UIEdgeInsets(top: 40, left: 90, bottom: 30, right: 90)
    }
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeCheck = self.bounds.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if sizeCheck != self.bounds.size {
            self.setNeedsDisplay()
            sizeCheck = self.bounds.size
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        
        // MARK: - Multilines
        // -------------------------------------------------------------------------
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor(red:0.89, green:0.85, blue:0.59, alpha:1.0).cgColor)
        context.setLineWidth(1.0);
        context.beginPath()
        
        let numberOfLines = (self.contentSize.height + self.bounds.size.height) / self.font!.lineHeight
        let baselineOffset: CGFloat = 20.0
        
        for num in 1...Int(numberOfLines) {
            context.move(to: CGPoint(x: self.bounds.origin.x, y: self.font!.lineHeight * CGFloat(num) + baselineOffset))
            context.addLine(to: CGPoint(x: CGFloat(self.bounds.size.width), y: self.font!.lineHeight * CGFloat(num) + baselineOffset))
        }
     
        context.closePath()
        context.strokePath()
        
        // MARK: - Red Line
        // -------------------------------------------------------------------------
        let context2: CGContext = UIGraphicsGetCurrentContext()!
        context2.move(to: CGPoint(x: 45, y: 0))
        context2.addLine(to: CGPoint(x: 45, y: self.frame.size.height))
        
        context2.move(to: CGPoint(x: 50, y: 0))
        context2.addLine(to: CGPoint(x: 50, y: self.frame.size.height))
        
        context2.setStrokeColor(UIColor(red:1.00, green:0.06, blue:0.09, alpha:1.0).cgColor)
        context2.setLineWidth(1.0);
        
        context2.closePath()
        context2.strokePath()
    }
}
