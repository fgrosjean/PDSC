//
//  PlantaViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/7/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import ImageScrollView

final class ConjuntoViewController: UIViewController {
    @IBOutlet private weak var segmentedControl     : UISegmentedControl!
    @IBOutlet private weak var contentContainer     : UIView!
    @IBOutlet private weak var generalContainer     : UIView!
    @IBOutlet private weak var generalScrollView    : ImageScrollView!
    @IBOutlet private weak var disponibleContainer  : UIView!
    @IBOutlet private weak var disponibleScrollView : ImageScrollView!
    @IBOutlet private weak var containerHeight      : NSLayoutConstraint!
    
    private lazy var plantasContainers = [generalContainer!, disponibleContainer!]
    private lazy var plantasScrollViews: [ImageScrollView] = [generalScrollView, disponibleScrollView]
    
   
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { self.setupPlantas() }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            self.containerHeight.constant = (self.view.superview?.bounds.height)! - 248
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    private func setupPlantas() {
        for container in plantasContainers {
            contentContainer.insertSubview(container, at: 0)
            container.edgesToSuperview()
            container.isHidden = true
        }
        
        for (index, scrollview) in plantasScrollViews.enumerated() {
            let imageToDisplay = index == 0 ? "planta" : "planta2"
            scrollview.setup()
            scrollview.display(image: UIImage(named: imageToDisplay)!)
        }
        
        generalContainer.isHidden = false
    }
    
    // MARK: - Actions
    // -------------------------------------------------------------------------
    @IBAction private func segmentedControlTapped(_ sender: UISegmentedControl) {
        generalContainer.isHidden    = sender.selectedSegmentIndex == 0 ? false : true
        disponibleContainer.isHidden = sender.selectedSegmentIndex == 0 ? true  : false
    }
}
