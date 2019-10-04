//
//  DetallesViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/8/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import TinyConstraints

final class DetallesViewController: UIViewController {
    @IBOutlet private var acabadosView      : UIView!
    @IBOutlet private var instalacionesView : UIView!
    @IBOutlet private var construcionView   : UIView!
    @IBOutlet private var bañosView         : UIView!
    @IBOutlet private var drenajesView      : UIView!
    
    @IBOutlet private var acabadosButton      : UIButton!
    @IBOutlet private var instalacionesButton : UIButton!
    @IBOutlet private var construccionButton  : UIButton!
    @IBOutlet private var bañosButton         : UIButton!
    @IBOutlet private var drenajesButton      : UIButton!
    
    @IBOutlet private var contentContainer: UIView!
    @IBOutlet private var contentContainerHeight: NSLayoutConstraint!
    
    private lazy var tempViews = [acabadosView, instalacionesView, construcionView, bañosView, drenajesView]
    private lazy var buttons = [acabadosButton, instalacionesButton, construccionButton, bañosButton, drenajesButton]
    
    private var loadedView: UIView!
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.contentContainerHeight.constant = self.loadedView.bounds.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.contentContainerHeight.constant = self.loadedView.bounds.height
    }
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    private func loadViews() {
        for tempView in tempViews {
            contentContainer.addSubview(tempView!)
            tempView?.edgesToSuperview(excluding: .bottom)
        }
        
        loadNew(viewToLoad: acabadosView, button: acabadosButton)
    }
    
    private func loadNew(viewToLoad: UIView, button: UIButton) {
        tempViews.forEach { $0?.isHidden = true }
        viewToLoad.isHidden = false
        loadedView = viewToLoad
        
        for button in buttons {
            button?.backgroundColor = UIColor.clear
            button?.setTitleColor(SectionKind.informacion.getSectionColor(), for: .normal)
        }
        
        button.backgroundColor = SectionKind.informacion.getSectionColor()
        button.setTitleColor(UIColor.white, for: .normal)
        
        contentContainerHeight.constant = loadedView.bounds.height
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        switch sender {
        case acabadosButton      : loadNew(viewToLoad: acabadosView, button: sender)
        case instalacionesButton : loadNew(viewToLoad: instalacionesView, button: sender)
        case construccionButton  : loadNew(viewToLoad: construcionView, button: sender)
        case bañosButton         : loadNew(viewToLoad: bañosView, button: sender)
        case drenajesButton      : loadNew(viewToLoad: drenajesView, button: sender)
        default: break
        }
    }
}
