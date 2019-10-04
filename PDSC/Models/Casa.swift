//
//  Casa.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/6/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import Foundation

struct Casa: Codable {
    let heroImagen: String
    let descripcion: String
    let niveles: [Nivel]
    let imagenes: [String]
}

struct Nivel: Codable {
    let titulo: String
    let imagen: String
    let numero: Int
    let descripcion: [String]
}
