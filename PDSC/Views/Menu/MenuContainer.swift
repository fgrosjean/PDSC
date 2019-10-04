//
//  MenuContainer.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/3/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

protocol MenuContainerDelegate: class {
    func menuButtonTapped()
}

final class MenuContainer: UIStackView {
    var delegate: MenuContainerDelegate?
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    public func setupMenu() {
        let nib = UINib.init(nibName: "MenuButton", bundle: Bundle.main)
        let currentSection = UserDefaults.getCurrentSection()
        
        for section in SectionKind.allCases {
            let menuButton = nib.instantiate(withOwner: nil).first as! MenuButton
            menuButton.section = section
            menuButton.icon.image = section.getMenuIcon()
            menuButton.sectionColorIndicator.backgroundColor = section.getSectionColor()
            menuButton.backgroundColor = currentSection == section ? #colorLiteral(red: 0.07518328266, green: 0.462745098, blue: 0.02976492903, alpha: 0) : #colorLiteral(red: 0.07518328266, green: 0.462745098, blue: 0.02976492903, alpha: 0.8)
            menuButton.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
            menuButton.icon.tintColor = currentSection == section ? currentSection.getSectionColor() : UIColor(white: 1, alpha: 0.25)
            
            addArrangedSubview(menuButton)
        }
    }
    
    // MARK: - Handle Button Tap
    // -------------------------------------------------------------------------
    @objc private func menuButtonTapped(_ tappedButton: MenuButton) {
        subviews.forEach { (menuButton) in
            let menuButton = menuButton as! MenuButton
            menuButton.backgroundColor = #colorLiteral(red: 0.07518328266, green: 0.462745098, blue: 0.02976492903, alpha: 0.8)
            menuButton.icon.tintColor = UIColor(white: 1, alpha: 0.25)
            
        }
        tappedButton.backgroundColor = UIColor.clear
        UserDefaults.setCurrent(section: tappedButton.section)
        tappedButton.icon.tintColor = tappedButton.section.getSectionColor()
        delegate?.menuButtonTapped()
    }
}
