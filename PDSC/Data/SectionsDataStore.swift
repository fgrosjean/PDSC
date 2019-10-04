//
//  Sections.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/3/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

enum SectionKind: Int, CaseIterable {
    case vendedor
    case informacion
    case casas
    case sanCristobal
    case galeria
    case cotizador
    case registro
    
    func getSectionTitle() -> String {
        switch self {
        case .vendedor     : return Constants.VENDEDOR_TITULO
        case .informacion  : return Constants.INFORMACION_TITULO
        case .casas        : return Constants.CASAS_TITULO
        case .sanCristobal : return Constants.SANCRISTOBAL_TITULO
        case .galeria      : return Constants.GALERIA_TITULO
        case .cotizador    : return Constants.COTIZADOR_TITULO
        case .registro     : return Constants.REGISTRO_TITULO
        }
    }
    
    func getSectionColor() -> UIColor {
        switch self {
        case .vendedor     : return #colorLiteral(red: 0.05098039216, green: 0.4705882353, blue: 0.9764705882, alpha: 1)
        case .informacion  : return #colorLiteral(red: 0.1490196078, green: 0.2, blue: 0.5764705882, alpha: 1)
        case .casas        : return #colorLiteral(red: 0.3960784314, green: 0.1098039216, blue: 0.5882352941, alpha: 1)
        case .sanCristobal : return #colorLiteral(red: 0.8196078431, green: 0.1450980392, blue: 0.1764705882, alpha: 1)
        case .galeria      : return #colorLiteral(red: 0.8941176471, green: 0.431372549, blue: 0.1254901961, alpha: 1)
        case .cotizador    : return #colorLiteral(red: 0.968627451, green: 0.6549019608, blue: 0.2549019608, alpha: 1)
        case .registro     : return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
    }
    
    func getSectionBackgroundImage() -> UIImage {
        switch self {
        case .vendedor     : return #imageLiteral(resourceName     : "fondo01r")
        case .informacion  : return #imageLiteral(resourceName  : "fondo02r")
        case .casas        : return #imageLiteral(resourceName        : "fondo03r")
        case .sanCristobal : return #imageLiteral(resourceName : "fondo04r")
        case .galeria      : return #imageLiteral(resourceName      : "fondo05r")
        case .cotizador    : return #imageLiteral(resourceName    : "fondo06r")
        case .registro     : return #imageLiteral(resourceName     : "fondo07r")
        }
    }
    
    func getSubsectionTitles() -> [String] {
        switch self {
        case .vendedor: return [
            Constants.SUBSECCION_TITULO_VENDEDOR_CHECKLIST,
            Constants.SUBSECCION_TITULO_VENDEDOR_PRESENTACION,
            Constants.SUBSECCION_TITULO_VENDEDOR_CLIENTE,
            Constants.SUBSECCION_TITULO_VENDEDOR_PASOS,
            Constants.SUBSECCION_TITULO_VENDEDOR_TIPS,
        ]
        case .informacion: return [
            Constants.SUBSECCION_TITULO_INFORMACION_ACCESOS,
            Constants.SUBSECCION_TITULO_INFORMACION_CONJUNTO,
            Constants.SUBSECCION_TITULO_INFORMACION_UBICACION,
            Constants.SUBSECCION_TITULO_INFORMACION_DETALLES,
            Constants.SUBSECCION_TITULO_INFORMACION_AMENIDADES,
        ]
        case .casas: return [
            Constants.SUBSECCION_TITULO_CASAS_ACCESOS,
            Constants.SUBSECCION_TITULO_CASAS_CONJUNTO,
            Constants.SUBSECCION_TITULO_CASAS_UBICACION,
            Constants.SUBSECCION_TITULO_CASAS_DETALLES,
        ]
        case .sanCristobal: return [
            Constants.SUBSECCION_TITULO_SANCRISTOBAL_HISTORIA,
            Constants.SUBSECCION_TITULO_SANCRISTOBAL_ACCESSOS,
            Constants.SUBSECCION_TITULO_SANCRISTOBAL_TRANSPORTE,
            Constants.SUBSECCION_TITULO_SANCRISTOBAL_SERVICIOS
        ]
        case .galeria   : return []
        case .cotizador : return []
        case .registro  : return []
        }
    }
    
    func getMenuIcon() -> UIImage {
        switch self {
        case .vendedor     : return PDSC_UI.imageOfVendedor_menuIcon.withRenderingMode(.alwaysTemplate)
        case .informacion  : return PDSC_UI.imageOfInformacion_MenuIcon.withRenderingMode(.alwaysTemplate)
        case .casas        : return PDSC_UI.imageOfCasas_MenuIcon.withRenderingMode(.alwaysTemplate)
        case .sanCristobal : return PDSC_UI.imageOfSanCristobal_MenuIcon.withRenderingMode(.alwaysTemplate)
        case .galeria      : return PDSC_UI.imageOfGaleria_MenuIcon.withRenderingMode(.alwaysTemplate)
        case .cotizador    : return PDSC_UI.imageOfCotizador_MenuIcon.withRenderingMode(.alwaysTemplate)
        case .registro     : return PDSC_UI.imageOfRegistro_MenuIcon.withRenderingMode(.alwaysTemplate)
        }
    }
}
