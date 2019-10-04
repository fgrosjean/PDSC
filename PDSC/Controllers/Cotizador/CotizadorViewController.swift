//
//  CotizadorViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/4/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class CotizadorViewController: UIViewController {
    @IBOutlet var heroImageView             : UIImageView!
    @IBOutlet var cantidadEngancheTextField : FormTextField!
    @IBOutlet var emailTextField            : FormTextField!
    @IBOutlet var tasaDeInteresTextField    : FormTextField!
    @IBOutlet var precioDeVentaLabel        : UILabel!
    @IBOutlet var tasaDeInteresLabel        : UILabel!
    @IBOutlet var montoFinanciarLabel       : UILabel!
    @IBOutlet var cuotaNiveladaLabel        : UILabel!
    @IBOutlet var iusiLabel                 : UILabel!
    @IBOutlet var seguroContraIncendioLabel : UILabel!
    @IBOutlet var cuotaAproximadaLabel      : UILabel!
    
    var modelDeCasa: String? {
        didSet {
            setHeroCasaImage()
            CotizadorData.setValuesOnLabels(cotizadorViewController: self)
        }
    }
    
    var plazoDePago: String?
    var sectionColor = SectionKind.cotizador.getSectionColor()
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------    
    func setHeroCasaImage() {
        let image = CotizadorData.getImageForCasa(selectedHouse: modelDeCasa!)
        heroImageView.image = image
    }
    
    // MARK: - Dropdowns
    // -------------------------------------------------------------------------
    @IBAction func casaDropdownTapped(_ sender: PDSCDropdown) {
        func setValue(_ value: String) { self.modelDeCasa = value; sender.setTitle(self.modelDeCasa)}
        let actions = CotizadorData.getActionsForDropdown(type: .casa, onDismiss: setValue)
        sender.presentAlertController(actions: actions, pressentingViewController: self, buttonsColor: sectionColor)
    }
    
    @IBAction func plazoDropdownTapped(_ sender: PDSCDropdown) {
        func setValue(_ value: String) { self.plazoDePago = value; sender.setTitle(self.plazoDePago)}
        let actions = CotizadorData.getActionsForDropdown(type: .plazo, onDismiss: setValue)
        sender.presentAlertController(actions: actions, pressentingViewController: self, buttonsColor: sectionColor)
    }
    
    // MARK: - Enviar
    // -------------------------------------------------------------------------
    @IBAction func enviarButtonTapped(_ sender: PDSCButton) {
    }
}
