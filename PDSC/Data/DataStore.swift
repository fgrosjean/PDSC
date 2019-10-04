//
//  DataStore.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/8/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import Foundation

class DataStore {
    enum CasaKind: Int, CaseIterable { case florencia, milan, roma, siena }
    
    static let instance = DataStore()
    
    var checklistItems = [String]()
    var presentacion   = [String]()
    var vendedor       = [String]()
    var vendedora      = [String]()
    var videos         = [Video]()
    var recorridoData  = [(image: String, title: String)]()
    var pinData        = [String]()
    private var casas  = [Casa]()
    
    private init() {
        createVendedorData()
        createCasasData()
        createVideoData()
        createRecorridoData()
        createPinsData()
    }
    
    // MARK: - Vendedor
    // -------------------------------------------------------------------------
    private func createVendedorData() {
        guard let vendedorFile = Bundle.main.path(forResource: "VededorData_ES", ofType: "plist") else { fatalError("No Casas Plist file") }
        let data = NSDictionary(contentsOfFile: vendedorFile) as! [String : Any]
        
        checklistItems = data["checklist"] as! [String]
        presentacion   = data["presentacion"] as! [String]
        vendedor       = data["vendedores"] as! [String]
        vendedora      = data["vendedoras"] as! [String]
    }
    
    private func createRecorridoData() {
        guard let vendedorFile = Bundle.main.path(forResource: "VededorData_ES", ofType: "plist") else { fatalError("No Casas Plist file") }
        let data = NSDictionary(contentsOfFile: vendedorFile) as! [String : Any]
        
        let pasosData = data["pasosRecorrido"] as! [[String : String]]
        for pasos in pasosData {
            recorridoData.append((image: pasos["image"]!, title: pasos["title"]!))
        }
    }
    
    private func createPinsData() {
        guard let vendedorFile = Bundle.main.path(forResource: "VededorData_ES", ofType: "plist") else { fatalError("No Casas Plist file") }
        let data = NSDictionary(contentsOfFile: vendedorFile) as! [String : Any]
        
        let pins = data["pinData"] as! [String]
        for pin in pins { pinData.append(pin) }
    }
    
    // MARK: - Casas
    // -------------------------------------------------------------------------
    private func createCasasData() {
        guard let casasFile = Bundle.main.url(forResource: "CasasData_ES", withExtension: "plist") else { fatalError("No Casas Plist file") }
        do {
            let casasData = try Data(contentsOf: casasFile)
            self.casas    = try PropertyListDecoder().decode([Casa].self, from: casasData)
        } catch {
            fatalError("Can't Produce Casas From Data")
        }
    }
    
    public func getDataFor(casa: CasaKind) -> Casa {
        switch casa {
        case .florencia : return casas[0]
        case .milan     : return casas[1]
        case .roma      : return casas[2]
        case .siena     : return casas[3]
        }
    }
    
    // MARK: - Videos
    // -------------------------------------------------------------------------
    private func createVideoData() {
        guard let videoFile = Bundle.main.path(forResource: "VideosData", ofType: "plist") else { fatalError("No Video Plist file") }
        let data = NSArray(contentsOfFile: videoFile) as! [[String : String]]
        
        videos = data.map{ Video(image: $0["image"]!, url: $0["url"]!) }
    }
}
