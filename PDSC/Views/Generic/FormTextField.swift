//
//  TextLabel.swift
//  PDSC
//
//  Created by Fernando Grosjean on 11/19/18.
//  Copyright © 2018 Fernando Grosjean. All rights reserved.
//

import UIKit

final class FormTextField: UITextField {
    enum TextfieldState { case valid, invalid }
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    @IBInspectable var maxNumberOfCharacters: Int = 0
    
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextField()
        
        self.inputAssistantItem.leadingBarButtonGroups.removeAll()
        self.inputAssistantItem.trailingBarButtonGroups.removeAll()
        
        setState(.valid)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if maxNumberOfCharacters > 0 {
            addTarget(self, action: #selector(fixMe), for: .editingChanged)
        }
    }
    
    override func textRect(forBounds bounds        : CGRect) -> CGRect { return bounds.inset(by: padding) }
    override func placeholderRect(forBounds bounds : CGRect) -> CGRect { return bounds.inset(by: padding) }
    override func editingRect(forBounds bounds     : CGRect) -> CGRect { return bounds.inset(by: padding) }
    
    func setState(_ state: TextfieldState) {
        switch state {
        case .valid   : layer.borderColor = UIColor.white.cgColor
        case .invalid : layer.borderColor = UIColor.red.cgColor
            
        }
    }
    
    @objc private func fixMe() { text = safelyLimitedTo(length: maxNumberOfCharacters, testString: text!) }
    func safelyLimitedTo(length n: Int, testString: String) -> String {
        if (testString.count <= n) {
            return testString
        }
        return String( Array(testString).prefix(upTo: n) )
    }
    
    
    // MARK: - Helpers
    // -------------------------------------------------------------------------
    func setupTextField() {
        borderStyle           = .line
        layer.borderWidth     = 1
        backgroundColor       = UIColor.white
        layer.cornerRadius    = 4
        clipsToBounds         = true
        attributedPlaceholder = NSAttributedString(string : self.placeholder!, attributes : [NSAttributedString.Key.foregroundColor  : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
    }
}

