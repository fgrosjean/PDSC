//
//  LoaderManager.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/4/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import TinyConstraints

final class LoaderManager {
    unowned let mainViewController: MainViewController
    init(mainViewController: MainViewController) { self.mainViewController = mainViewController }
    
    var viewControllerSubsectionToLoad: UIViewController?
    var currentSection: SectionKind!
    var currentIndex: Int!
    
    // MARK: - Load Section
    // -------------------------------------------------------------------------
    func loadSection() {
        currentSection = UserDefaults.getCurrentSection()
        mainViewController.segmentedControl.setupSegmenteControlFor(currentSection)
        loadSubsection()
        
        let sectionColor = currentSection.getSectionColor()
        
        mainViewController.titleLabel.text                = currentSection.getSectionTitle()
        mainViewController.titleLabel.textColor           = sectionColor
        mainViewController.titleSeparator.backgroundColor = sectionColor
        
        UIView.transition(with       : mainViewController.backgroundImage,
                          duration   : 0.33,
                          options    : .transitionCrossDissolve,
                          animations : { self.mainViewController.backgroundImage.image = self.currentSection.getSectionBackgroundImage() },
                          completion : nil)
    }
    
    // MARK: - Load Subsection
    // -------------------------------------------------------------------------
    func loadSubsection() {
        if viewControllerSubsectionToLoad?.parent != nil {
            viewControllerSubsectionToLoad?.removeFromParent()
            viewControllerSubsectionToLoad?.view.removeFromSuperview()
        }
        
        currentIndex = mainViewController.segmentedControl.selectedSegmentIndex
        
        switch currentSection! {
        case .vendedor:
            switch currentIndex {
            case 0 : setViewControllerToLoad(storyBoardName: "Vendedor", storyboardID: "Checklist")
            case 1 : setViewControllerToLoad(storyBoardName: "Vendedor", storyboardID: "Presentacion")
            case 2 : setViewControllerToLoad(storyBoardName: "Vendedor", storyboardID: "ElCliente")
            case 3 : setViewControllerToLoad(storyBoardName: "Vendedor", storyboardID: "Pasos")
            case 4 : setViewControllerToLoad(storyBoardName: "Vendedor", storyboardID: "Tips")
            default: break
            }
        case .informacion:
            switch currentIndex {
            case 0 : setViewControllerToLoad(storyBoardName: "Informacion", storyboardID: "Accesos")
            case 1 : setViewControllerToLoad(storyBoardName: "Informacion", storyboardID: "Conjunto")
            case 2 : setViewControllerToLoad(storyBoardName: "Informacion", storyboardID: "Urbanizacion")
            case 3 : setViewControllerToLoad(storyBoardName: "Informacion", storyboardID: "Detalles")
            case 4 : setViewControllerToLoad(storyBoardName: "Informacion", storyboardID: "Amenidades")
            default: break
            }
        case .casas:
            switch currentIndex {
            case 0 : setViewControllerToLoad(storyBoardName: "Casas", storyboardID: "Casas")
            case 1 : setViewControllerToLoad(storyBoardName: "Casas", storyboardID: "Casas")
            case 2 : setViewControllerToLoad(storyBoardName: "Casas", storyboardID: "Casas")
            case 3 : setViewControllerToLoad(storyBoardName: "Casas", storyboardID: "Casas")
            default: break
            }
        case .sanCristobal:
            switch currentIndex {
            case 0 : setViewControllerToLoad(storyBoardName: "SanCristobal", storyboardID: "Historia")
            case 1 : setViewControllerToLoad(storyBoardName: "SanCristobal", storyboardID: "Acessos")
            case 2 : setViewControllerToLoad(storyBoardName: "SanCristobal", storyboardID: "Transporte")
            case 3 : setViewControllerToLoad(storyBoardName: "SanCristobal", storyboardID: "Servicios")
            default: break
            }
        case .galeria   : setViewControllerToLoad(storyBoardName: "Galeria", storyboardID: "Galeria")
        case .cotizador : setViewControllerToLoad(storyBoardName: "Cotizador", storyboardID: "Cotizador")
        case .registro  : setViewControllerToLoad(storyBoardName: "Registro", storyboardID: "Registro")
        }
        
        DispatchQueue.main.async { self.insertSection() }
    }
    
    func insertSection() {
        mainViewController.addChild(viewControllerSubsectionToLoad!)
        mainViewController.contentScrollView.addSubview(viewControllerSubsectionToLoad!.view)
        
        let topMargin = mainViewController.moduleHeight + (mainViewController.segmenteControlContainer.isHidden ? 0 : mainViewController.segmenteControlContainer.bounds.height ) - 30
        viewControllerSubsectionToLoad!.view.edgesToSuperview(excluding: [.top, .bottom], insets: TinyEdgeInsets.zero)
        viewControllerSubsectionToLoad!.view.widthToSuperview()
        viewControllerSubsectionToLoad!.view.topToSuperview(offset: topMargin)
        viewControllerSubsectionToLoad!.view.bottomToSuperview(offset: -30)
        mainViewController.contentScrollView.scrollIndicatorInsets = UIEdgeInsets(top: topMargin + 35, left: 0, bottom: 5, right: 0)
        
        viewControllerSubsectionToLoad!.willMove(toParent: mainViewController)
    }
    
    func setViewControllerToLoad(storyBoardName: String, storyboardID: String) {
        switch currentSection! {
        case .casas:
            viewControllerSubsectionToLoad = UIStoryboard(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboardID)
            (viewControllerSubsectionToLoad as! CasasViewController).currentIndex = currentIndex
        default: viewControllerSubsectionToLoad = UIStoryboard(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboardID)
        }
        
    }
}
