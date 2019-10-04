//
//  ValidationService.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/5/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

class ValidationService {
    enum TestToValidate { case emptyState, isNumber }
    
    // MARK: - Validation
    // -------------------------------------------------------------------------
    func validateTextFieldState(textFields: [FormTextField?], testToValidate: TestToValidate) -> [Bool] {
        var valuesToReturn = [Bool]()
        var conditionToValidate: Bool!
        
        for textField in textFields {
            switch testToValidate {
            case .isNumber: conditionToValidate = !(isNumber(testStr: textField!.text!))
            case .emptyState: conditionToValidate = textField!.text!.isEmpty || textField!.text == " "
            }
            
            if conditionToValidate {
                textField?.setState(.invalid)
                valuesToReturn.append(false)
            } else {
                textField?.setState(.valid)
            }
        }
        
        return valuesToReturn
    }
    
    // MARK: - Valid Email
    // -------------------------------------------------------------------------
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - Valid Number
    // -------------------------------------------------------------------------
    func isNumber(testStr:String) -> Bool {
        return !(testStr.isEmpty) && testStr.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func validateDrodpdowns(_ dropDown: PDSCDropdown, value: String?) -> Bool {
        if value == nil {
            dropDown.setState(.invalid)
            return false
        } else {
            dropDown.setState(.valid)
            return true
        }
    }
}
