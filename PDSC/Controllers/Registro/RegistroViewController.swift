//
//  RegistroViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/5/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import PKHUD

final class RegistroViewController: UIViewController {
    @IBOutlet var nombreTextField         : FormTextField!
    @IBOutlet var apellidosTextField      : FormTextField!
    @IBOutlet var telefonoTextField       : FormTextField!
    @IBOutlet var celularTextField        : FormTextField!
    @IBOutlet var emailTextField          : FormTextField!
    @IBOutlet var zonaResidenciaTextField : FormTextField!
    @IBOutlet var zonaTrabajoTextField    : FormTextField!
    @IBOutlet var hijosDropdown           : PDSCDropdown!
    @IBOutlet var ingresosDropdown        : PDSCDropdown!
    @IBOutlet var casaDropdown            : PDSCDropdown!
    @IBOutlet var enteroDropdown          : PDSCDropdown!
    
    lazy var validationService = ValidationService()
    lazy var alltextFields = [nombreTextField, apellidosTextField, telefonoTextField, celularTextField, emailTextField, zonaResidenciaTextField, zonaTrabajoTextField ]
    var allDropdowns: [(dropdown: PDSCDropdown, value: String?)] { return [(dropdown: hijosDropdown!, value: tieneHijos), (dropdown: ingresosDropdown!, value: fuenteIngresos), (dropdown: casaDropdown!, value: casaDeInteres), (dropdown: enteroDropdown!, value: enteroDelProyecto)] }
    var sectionColor = SectionKind.registro.getSectionColor()
    
    var tieneHijos: String?
    var fuenteIngresos: String?
    var casaDeInteres: String?
    var enteroDelProyecto: String?
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alltextFields.forEach { $0?.delegate = self }
        PKHUD.sharedHUD.dimsBackground = false
    }
    
    // MARK: - Validation
    // -------------------------------------------------------------------------
    func validateTextfields() -> Bool {
        // empty state
        let allTextFieldsFilled = validationService.validateTextFieldState(textFields: alltextFields, testToValidate: .emptyState)
        
        // email validation
        let isEmailValid = validationService.isValidEmail(testStr: emailTextField.text!)
        if isEmailValid == false { emailTextField.setState(.invalid)}
        
        // numbers validation
        let numberTextFields = [telefonoTextField, celularTextField, zonaResidenciaTextField, zonaTrabajoTextField]
        let allNumbersTextFieldsAreNumbers = validationService.validateTextFieldState(textFields: numberTextFields, testToValidate: .isNumber)
        
        // validate dropdowns
        var allDropdownsFilled = [Bool]()
        allDropdowns.forEach { (value) in
            let result = validationService.validateDrodpdowns(value.dropdown, value: value.value)
            allDropdownsFilled.append(result)
        }
        
        if allTextFieldsFilled.contains(false) || allNumbersTextFieldsAreNumbers.contains(false) || isEmailValid == false || allDropdownsFilled.contains(false) { return false }
        return true
    }

    
    // MARK: - Actions
    // -------------------------------------------------------------------------
    @IBAction func guardarTapped(_ sender: Any? = nil) {
        let isFormValid = validateTextfields()
        
        if isFormValid {
            HUD.show(.progress)
            view.endEditing(true)
            
            let registroFormDataToSend = RegistroData.getRegistroFormData(registroViewController: self)
            
            let email = Email(personalizations : [Email.Personalizations(to: [Email.To(email: "grosjeanfernando@gmail.com", name: "Prados de San Cristóbal")])],
                                      subject  : "Nuevo Registro PDSC App",
                                      content  : [Email.Content.init(value: registroFormDataToSend)],
                                      attachments : nil
            )
            
            do {
                let registroToJson = try JSONEncoder().encode(email)
                MailerService.instace.sendEmail(data: registroToJson){ (error) in
                    switch error {
                    case nil:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            HUD.flash(.success, delay: 1)
                            self.resetFormTapped(nil)
                        }
                    default: DispatchQueue.main.asyncAfter(deadline: .now() + 1) { HUD.flash(.error, delay: 1) }
                    }
                }
            } catch let error { print(error.localizedDescription) }
        }
    }
    
    @IBAction func resetFormTapped(_ sender: Any?) {
        for textField in alltextFields {
            textField!.text?.removeAll()
            textField!.setState(.valid)
        }
        
        for value in allDropdowns {
            value.dropdown.setState(.valid)
            value.dropdown.title = value.dropdown.originalTitle
        }
        
        tieneHijos = nil
        fuenteIngresos = nil
        casaDeInteres = nil
        enteroDelProyecto = nil
    }
    
    // MARK: - Dropdowns
    // -------------------------------------------------------------------------
    @IBAction func hijosDropdownTapped(_ sender: PDSCDropdown) {
        func setValue(_ value: String) { self.tieneHijos = value; sender.setTitle(self.tieneHijos)}
        let actions = RegistroData.getActionsForDropdown(type: .hijos, onDismiss: setValue)
        sender.presentAlertController(actions: actions, pressentingViewController: self, buttonsColor: sectionColor)
    }
    
    @IBAction func ingresosDropdownTapped(_ sender: PDSCDropdown) {
        func setValue(_ value: String) { self.fuenteIngresos = value; sender.setTitle(self.fuenteIngresos)}
        let actions = RegistroData.getActionsForDropdown(type: .ingresos, onDismiss: setValue)
        sender.presentAlertController(actions: actions, pressentingViewController: self, buttonsColor: sectionColor)
    }
    
    @IBAction func interesTapped(_ sender: PDSCDropdown) {
        func setValue(_ value: String) { self.casaDeInteres = value; sender.setTitle(self.casaDeInteres)}
        let actions = RegistroData.getActionsForDropdown(type: .casa, onDismiss: setValue)
        sender.presentAlertController(actions: actions, pressentingViewController: self, buttonsColor: sectionColor)
    }
    
    @IBAction func enteroProyectoTapped(_ sender: PDSCDropdown) {
        func setValue(_ value: String) { self.enteroDelProyecto = value; sender.setTitle(self.enteroDelProyecto)}
        let actions = RegistroData.getActionsForDropdown(type: .enteroProyecto, onDismiss: setValue)
        sender.presentAlertController(actions: actions, pressentingViewController: self, buttonsColor: sectionColor)
    }
}

extension RegistroViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guardarTapped()
        return true
    }
}
