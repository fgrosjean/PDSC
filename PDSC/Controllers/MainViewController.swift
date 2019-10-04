//
//  ViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/3/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Outlets
    // -------------------------------------------------------------------------
    @IBOutlet private weak var contentContainer              : UIView!
    @IBOutlet private(set) weak var contentScrollView        : UIScrollView!
    @IBOutlet private weak var titleContainer                : UIVisualEffectView!
    @IBOutlet private(set) weak var titleLabel               : UILabel!
    @IBOutlet private(set) weak var titleSeparator           : UIView!
    @IBOutlet private weak var titleHeightConstraint         : NSLayoutConstraint!
    @IBOutlet private weak var menuTopConstraint             : NSLayoutConstraint!
    @IBOutlet private weak var menuHeightConstraint          : NSLayoutConstraint!
    @IBOutlet private weak var menuWidthContraint            : NSLayoutConstraint!
    @IBOutlet private(set) weak var backgroundImage          : UIImageView!
    @IBOutlet private(set) weak var segmenteControlContainer : UIView!
    @IBOutlet private(set) weak var segmentedControl         : SubsectionsSegmentedControl!
    @IBOutlet private weak var menuContainer                 : MenuContainer! {
        didSet {
            menuContainer.setupMenu()
            menuContainer.delegate = self
        }
    }
    
    private(set) var moduleHeight: CGFloat!
    lazy private var loaderManager = LoaderManager(mainViewController: self)
    
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleContainer.roundCorners(cornerRadius: 10, corners: [.layerMinXMinYCorner])
        loaderManager.loadSection()
        contentScrollView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutViews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [unowned self] (_) in self.layoutViews() })
    }

    // MARK: - Layout
    // -------------------------------------------------------------------------
    private func layoutViews() {
        let numberOfButtonsInMenu = CGFloat(SectionKind.allCases.count)
        let contentContainerHeight = contentContainer.bounds.height

        switch UIApplication.shared.statusBarOrientation {
        case .portrait, .portraitUpsideDown  : moduleHeight = 100
        case .landscapeLeft, .landscapeRight : moduleHeight = contentContainerHeight / (numberOfButtonsInMenu + 1)
        default                              : moduleHeight = 0
        }
        
        titleHeightConstraint.constant = moduleHeight
        menuTopConstraint.constant     = moduleHeight + 10
        menuHeightConstraint.constant  = moduleHeight * numberOfButtonsInMenu
        menuWidthContraint.constant    = moduleHeight
        
        setSegmentedControlMask()
    }
    
    private func setSegmentedControlMask() {
        contentContainer.setSegmentedControlMaskWith(moduleHeight,
                                                     segmentedControlContainer: segmenteControlContainer,
                                                     currentSectionNeedsMask: !(segmentedControl.subsectionsTitles.isEmpty))
    }
    
    
    
    // MARK: - Actions
    // -------------------------------------------------------------------------
    @IBAction private func segmentedControlTapped(_ segmentedControlTapped: UISegmentedControl) {
        segmentedControl.setUserDefaultsFor(loaderManager.currentSection, subsection: segmentedControlTapped.selectedSegmentIndex)
        loaderManager.loadSubsection()
    }
}

extension MainViewController: MenuContainerDelegate {
    func menuButtonTapped() {
        loaderManager.loadSection()
        setSegmentedControlMask()
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
}
