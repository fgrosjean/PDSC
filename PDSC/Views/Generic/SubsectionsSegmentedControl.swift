//
//  SubsectionsSegmentedControl.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/3/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class SubsectionsSegmentedControl: UISegmentedControl {
    var subsectionsTitles: [String]!
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    public func setupSegmenteControlFor(_ currentSection: SectionKind) {
        removeAllSegments()
        
        subsectionsTitles = currentSection.getSubsectionTitles()
        var currentSubSectionSelected: Int {
            switch currentSection {
            case .vendedor     : return UserDefaults.getCurrentVendedorSubsection()
            case .informacion  : return UserDefaults.getCurrentInformacionSubsection()
            case .casas        : return UserDefaults.getCurrentCasasSubsection()
            case .sanCristobal : return UserDefaults.getCurrentSanCristobalSubsection()
            default            : return 0
            }
        }
        
        for (index, subsectionTitle) in subsectionsTitles.enumerated() {
            insertSegment(withTitle: subsectionTitle, at: index, animated: false)
        }
        
        tintColor                = currentSection.getSectionColor()
        selectedSegmentIndex     = currentSubSectionSelected
        self.superview!.isHidden = subsectionsTitles.isEmpty ? true : false
    }
    
    // MARK: - User Defaults Setter
    // -------------------------------------------------------------------------
    func setUserDefaultsFor(_ currentSection: SectionKind, subsection: Int) {
        switch currentSection {
        case .vendedor     : UserDefaults.setCurrentVendedor(subsection: subsection)
        case .informacion  : UserDefaults.setCurrentInformacion(subsection: subsection)
        case .casas        : UserDefaults.setCurrentCasas(subsection: subsection)
        case .sanCristobal : UserDefaults.setCurrentSanCristobal(subsection: subsection)
        default            : break
        }
    }
}
