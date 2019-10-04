//
//  PinRecorrido.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/7/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class PinRecorrido: UIControl {
    public var mensaje = "Not Set"
    public var viewControllerPresenting: UIViewController!
    
    override func awakeFromNib() {
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        let mensajeViewController = UIAlertController(title: mensaje, message: nil, preferredStyle: .actionSheet)
        mensajeViewController.view.tintColor = UIColor.black
        mensajeViewController.popoverPresentationController?.sourceView = self
        mensajeViewController.popoverPresentationController?.sourceRect = self.bounds
        mensajeViewController.popoverPresentationController?.permittedArrowDirections = [.down]
        
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .natural
        mensajeViewController.setValue(NSAttributedString(string: mensaje, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.paragraphStyle : titleParagraphStyle]), forKey: "attributedTitle")

        viewControllerPresenting.present(mensajeViewController, animated: true, completion: nil)
    }
}
