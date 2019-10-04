//
//  CotizadorData.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/5/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

struct CotizadorData {
    enum CotizadorDropdownType { case casa, plazo }
    
    static func getActionsForDropdown(type: CotizadorDropdownType, onDismiss: @escaping (String) -> Void) -> [UIAlertAction] {
        switch type {
        case .casa: return [
            UIAlertAction(title: "Florencia", style: .default) { (_) in onDismiss("Florencia") },
            UIAlertAction(title: "Milan", style: .default) { (_) in onDismiss("Milan") },
            UIAlertAction(title: "Roma", style: .default) { (_) in onDismiss("Roma") },
            UIAlertAction(title: "Roma con Loft", style: .default) { (_) in onDismiss("Roma con Loft") },
            UIAlertAction(title: "Siena", style: .default) { (_) in onDismiss("Siena") },
            ]
        case .plazo: return [
            UIAlertAction(title: "25 Años", style: .default) { (_) in onDismiss("25 Años") },
            UIAlertAction(title: "20 Años", style: .default) { (_) in onDismiss("20 Años") },
            UIAlertAction(title: "15 Años", style: .default) { (_) in onDismiss("15 Años") },
            UIAlertAction(title: "10 Años", style: .default) { (_) in onDismiss("10 Años") },
            UIAlertAction(title: "5 Años", style: .default) { (_) in onDismiss("5 Años") },
            ]
        }
    }
    
    static func getImageForCasa(selectedHouse: String) -> UIImage {
        switch selectedHouse {
        case "Florencia": return UIImage(named: "cotizador_florencia")!
        case "Milan": return UIImage(named: "cotizador_milan")!
        case "Roma": return UIImage(named: "cotizador_roma")!
        case "Roma con Loft": return UIImage(named: "cotizador_romaLoft")!
        case "Siena": return UIImage(named: "cotizador_siena")!
        default: return UIImage(named: "cotizador_default")!
        }
    }
    
    static func setValuesOnLabels(cotizadorViewController: CotizadorViewController) {
        switch cotizadorViewController.modelDeCasa {
        case "Florencia":
            cotizadorViewController.cantidadEngancheTextField.text = "Q.76,500.00"
            cotizadorViewController.tasaDeInteresTextField.text    = "7.5%"
            cotizadorViewController.precioDeVentaLabel.text        = "Q.765,000.00"
            cotizadorViewController.tasaDeInteresLabel.text        = "7.5%"
            cotizadorViewController.iusiLabel.text                 = "Q." + String(format: "%.2f", (((765000 / 1.12) * 0.009) / 12))
            cotizadorViewController.seguroContraIncendioLabel.text = "Q." + String(format: "%.2f", (((765000 / 1.12) * 0.04529 * 12) / 12) / 100)
            
        case "Milan":
            cotizadorViewController.cantidadEngancheTextField.text = "Q.87,000.00"
            cotizadorViewController.tasaDeInteresTextField.text    = "7.5%"
            cotizadorViewController.precioDeVentaLabel.text        = "Q.870,000.00"
            cotizadorViewController.tasaDeInteresLabel.text        = "7.5%"
            cotizadorViewController.iusiLabel.text                 = "Q." + String(format: "%.2f", (((870000 / 1.12) * 0.009) / 12))
            cotizadorViewController.seguroContraIncendioLabel.text = "Q." + String(format: "%.2f", (((870000 / 1.12) * 0.04529 * 12) / 12) / 100)

        case "Roma":
            cotizadorViewController.cantidadEngancheTextField.text = "Q.94,300.00"
            cotizadorViewController.tasaDeInteresTextField.text    = "7.5%"
            cotizadorViewController.precioDeVentaLabel.text        = "Q.943,000.00"
            cotizadorViewController.tasaDeInteresLabel.text        = "7.5%"
            cotizadorViewController.iusiLabel.text                 = "Q." + String(format: "%.2f", (((943000 / 1.12) * 0.009) / 12))
            cotizadorViewController.seguroContraIncendioLabel.text = "Q." + String(format: "%.2f", (((943000 / 1.12) * 0.04529 * 12) / 12) / 100)
            
        case "Roma con Loft":
            cotizadorViewController.cantidadEngancheTextField.text = "Q.103,500.00"
            cotizadorViewController.tasaDeInteresTextField.text    = "7.5%"
            cotizadorViewController.precioDeVentaLabel.text        = "Q.1,035,000.00"
            cotizadorViewController.tasaDeInteresLabel.text        = "7.5%"
            cotizadorViewController.iusiLabel.text                 = "Q." + String(format: "%.2f", (((1035000 / 1.12) * 0.009) / 12))
            cotizadorViewController.seguroContraIncendioLabel.text = "Q." + String(format: "%.2f", (((1035000 / 1.12) * 0.04529 * 12) / 12) / 100)
            
        case "Siena":
            cotizadorViewController.cantidadEngancheTextField.text = "Q.116,000.00"
            cotizadorViewController.tasaDeInteresTextField.text    = "7.5%"
            cotizadorViewController.precioDeVentaLabel.text        = "Q.1,160,000.00"
            cotizadorViewController.tasaDeInteresLabel.text        = "7.5%"
            cotizadorViewController.iusiLabel.text                 = "Q." + String(format: "%.2f", (((1160000 / 1.12) * 0.009) / 12))
            cotizadorViewController.seguroContraIncendioLabel.text = "Q." + String(format: "%.2f", (((1160000 / 1.12) * 0.04529 * 12) / 12) / 100)
            
        default: break
        }
        
    }
}
