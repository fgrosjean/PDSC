//
//  RegistroDropdownData.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/5/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

struct RegistroData {
    enum RegistroDropdownType { case hijos, ingresos, casa, enteroProyecto}
    
    // MARK: - Dropdown Data
    // -------------------------------------------------------------------------
    static func getActionsForDropdown(type: RegistroDropdownType, onDismiss: @escaping (String) -> Void) -> [UIAlertAction] {
        switch type {
        case .hijos: return [
            UIAlertAction(title: "Si", style: .default) { (_) in onDismiss("Si") },
            UIAlertAction(title: "No", style: .default) { (_) in onDismiss("No") }
            ]
        case .ingresos: return [
            UIAlertAction(title: "Comerciante/Empresario", style: .default) { (_) in onDismiss("Comerciante/Empresario") },
            UIAlertAction(title: "En Relación de Dependecia", style: .default) { (_) in onDismiss("En Relación de Dependecia") },
            ]
        case .casa: return [
            UIAlertAction(title: "Florencia", style: .default) { (_) in onDismiss("Florencia") },
            UIAlertAction(title: "Milan", style: .default) { (_) in onDismiss("Milan") },
            UIAlertAction(title: "Roma", style: .default) { (_) in onDismiss("Roma") },
            UIAlertAction(title: "Roma con Loft", style: .default) { (_) in onDismiss("Roma con Loft") },
            UIAlertAction(title: "Siena", style: .default) { (_) in onDismiss("Siena") },
            UIAlertAction(title: "Siena con Loft", style: .default) { (_) in onDismiss("Siena con Loft") }
            ]
        case .enteroProyecto: return [
            UIAlertAction(title: "Vallas", style: .default) { (_) in onDismiss("Vallas") },
            UIAlertAction(title: "Prensa Libre", style: .default) { (_) in onDismiss("Prensa Libre") },
            UIAlertAction(title: "Inmobilia", style: .default) { (_) in onDismiss("Inmobilia") },
            UIAlertAction(title: "Internet", style: .default) { (_) in onDismiss("Internet") },
            UIAlertAction(title: "Referido", style: .default) { (_) in onDismiss("Referido") },
            UIAlertAction(title: "Expocasa", style: .default) { (_) in onDismiss("Expocasa") }
            ]
        }
    }
    
    // MARK: - Construct Data to Send on Email
    // -------------------------------------------------------------------------
    static func getRegistroFormData(registroViewController: RegistroViewController) -> String {
        return """
        <h1>Nuevo Registro</h1>
        <ul>
        <li>nombres           : \(registroViewController.nombreTextField.text!)</li>
        <li>apellidos         :  \(registroViewController.apellidosTextField.text!)</li>
        <li>telefono          :  \(registroViewController.telefonoTextField.text!)</li>
        <li>celular           :  \(registroViewController.celularTextField.text!)</li>
        <li>email             :  \(registroViewController.emailTextField.text!)</li>
        <li>zonaDeResidencia  :  \(registroViewController.zonaResidenciaTextField.text!)</li>
        <li>zonaDeTrabajo     :  \(registroViewController.zonaTrabajoTextField.text!)</li>
        <li>tieneHijos        :  \(registroViewController.tieneHijos!)</li>
        <li>ingresos          :  \(registroViewController.fuenteIngresos!)</li>
        <li>casaDeInteres     :  \(registroViewController.casaDeInteres!)</li>
        <li>enteroDelProyecto :  \(registroViewController.enteroDelProyecto!)</li>
        </ul>
        """
    }
}
