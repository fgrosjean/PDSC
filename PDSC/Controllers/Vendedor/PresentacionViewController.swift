//
//  PresentacionViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/4/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class PresentacionViewController: UIViewController {
    enum ChecklistType: CaseIterable { case presentacion, vendedor, vendedora }
    
    @IBOutlet private var presentacionContainer       : UIView!
    @IBOutlet private var presentacionContainerHeight : NSLayoutConstraint!
    @IBOutlet private var presentacionClearAllButton  : UIButton!
    @IBOutlet private var vendedorContainer           : UIView!
    @IBOutlet private var vendedorContainerHeight     : NSLayoutConstraint!
    @IBOutlet private var vendedorClearAllButton      : UIButton!
    @IBOutlet private var vendedorasContainer         : UIView!
    @IBOutlet private var vendedorasContainerHeight   : NSLayoutConstraint!
    @IBOutlet private var vendedorasClearAllButton    : UIButton!
    
    private var presentacionTableView : UITableView!
    private var vendedorTableView     : UITableView!
    private var vendedoraTableView    : UITableView!
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        ChecklistType.allCases.forEach { loadChecklistFor(checklistType: $0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setContentHeight()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            self.setContentHeight()
        })
    }
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    private func setContentHeight() {
        presentacionContainerHeight.constant = presentacionTableView.contentSize.height
        vendedorContainerHeight.constant     = vendedorTableView.contentSize.height
        vendedorasContainerHeight.constant   = vendedoraTableView.contentSize.height
    }
    
    private func loadChecklistFor(checklistType: ChecklistType) {
        var container: UIView!
        let viewController = ChecklistViewController()
        viewController.hideSendPhotoButton = true
        
        switch checklistType {
        case .presentacion:
            container = presentacionContainer
            viewController.data = DataStore.instance.presentacion.map { ChecklistModel(name: $0, completed: false) }
            viewController.clearAllbutton = presentacionClearAllButton
        case .vendedor:
            container = vendedorContainer
            viewController.data = DataStore.instance.vendedor.map { ChecklistModel(name: $0, completed: false) }
            viewController.clearAllbutton = vendedorClearAllButton
        case .vendedora:
            container = vendedorasContainer
            viewController.data = DataStore.instance.vendedora.map { ChecklistModel(name: $0, completed: false) }
            viewController.clearAllbutton = vendedorasClearAllButton
        }
        
        self.addChild(viewController)
        container.addSubview(viewController.view)
        
        switch checklistType {
        case .presentacion : presentacionTableView = viewController.tableView
        case .vendedor     : vendedorTableView     = viewController.tableView
        case .vendedora    : vendedoraTableView    = viewController.tableView
        }
        
        viewController.view.edgesToSuperview()
        viewController.willMove(toParent: self)
    }
}
