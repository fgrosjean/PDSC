//
//  UserDefaults.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/3/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Keys {
        static let section                       = "Section"
        static let currentVendedorSubsection     = "currentVendedorSubsection"
        static let currentInformacionSubsection  = "currentInformacionSubsection"
        static let currentCasasSubsection        = "currentCasasSubsection"
        static let currentSanCristobalSubsection = "currentSanCristobalSubsection"
    }
    
    // MARK: - Section
    // -------------------------------------------------------------------------
    static func setCurrent(section: SectionKind) {
        UserDefaults.standard.set(section.rawValue, forKey: UserDefaults.Keys.section)
    }
    
    static func getCurrentSection() -> SectionKind {
        return SectionKind(rawValue: UserDefaults.standard.integer(forKey: UserDefaults.Keys.section)) ?? .vendedor
    }
    
    // MARK: - Vendedor Subsection
    // -------------------------------------------------------------------------
    static func setCurrentVendedor(subsection index: Int) {
        UserDefaults.standard.set(index, forKey: UserDefaults.Keys.currentVendedorSubsection)
    }
    
    static func getCurrentVendedorSubsection() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaults.Keys.currentVendedorSubsection)
    }
    
    // MARK: - Informacion Subsection
    // -------------------------------------------------------------------------
    static func setCurrentInformacion(subsection index: Int) {
        UserDefaults.standard.set(index, forKey: UserDefaults.Keys.currentInformacionSubsection)
    }
    
    static func getCurrentInformacionSubsection() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaults.Keys.currentInformacionSubsection)
    }
    
    // MARK: - Casas Subsection
    // -------------------------------------------------------------------------
    static func setCurrentCasas(subsection index: Int) {
        UserDefaults.standard.set(index, forKey: UserDefaults.Keys.currentCasasSubsection)
    }
    
    static func getCurrentCasasSubsection() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaults.Keys.currentCasasSubsection)
    }
    
    // MARK: - SanCristobal Subsection
    // -------------------------------------------------------------------------
    static func setCurrentSanCristobal(subsection index: Int) {
        UserDefaults.standard.set(index, forKey: UserDefaults.Keys.currentSanCristobalSubsection)
    }
    
    static func getCurrentSanCristobalSubsection() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaults.Keys.currentSanCristobalSubsection)
    }
}
