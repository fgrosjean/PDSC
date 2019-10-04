//
//  DropdownAppeareance.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/4/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import TinyConstraints

final class PDSCDropdown: UIControl {
    enum DropdownState { case valid, invalid }
    var label: UILabel!
    var iconView: UIImageView!
    var originalTitle: String!
    
    @IBInspectable var lineColor: UIColor = UIColor.black {
        didSet { layer.borderColor = lineColor.cgColor }
    }
    
    @IBInspectable var title: String = "" {
        didSet { label?.text = title }
    }

    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func awakeFromNib() {
        clipsToBounds = true
        layer.cornerRadius = 6
        layer.borderWidth = 1
        backgroundColor = UIColor.clear
        
        addIcon()
        addLabel()
        setState(.valid)
        
        originalTitle = title
    }
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    func addLabel() {
        label = UILabel(frame: .zero)
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        addSubview(label)
        
        label.centerInSuperview()
        label.leadingToSuperview(offset: 15)
        label.trailingToLeading(of: iconView, offset: 15)
    }
    
    func addIcon() {
        iconView = UIImageView(image: PDSC_UI.imageOfDropdownIcon)
        
        addSubview(iconView)
        
        iconView.size(CGSize(width: 20, height: 20))
        iconView.centerY(to: self)
        iconView.trailingToSuperview(offset: 10)
        
    }
    
    func setState(_ dropdownState: DropdownState) {
        switch dropdownState {
        case .valid:
            label.textColor = lineColor
            iconView.tintColor = lineColor
            backgroundColor = UIColor.clear
            layer.borderColor = lineColor.cgColor
        case .invalid:
            label.textColor = UIColor.white
            iconView.tintColor = UIColor.white
            backgroundColor = UIColor.red
            layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func setTitle(_ newTitle: String?) {
        if let newTitle = newTitle {
            title = "\(originalTitle!): \(newTitle)"
        }
    }
    
    func presentAlertController(actions: [UIAlertAction], pressentingViewController: UIViewController, buttonsColor: UIColor) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = buttonsColor
        alertController.popoverPresentationController?.sourceView = self
        alertController.popoverPresentationController?.sourceRect = bounds
        alertController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        
        actions.forEach(alertController.addAction)
        pressentingViewController.present(alertController, animated: true)
    }
}
