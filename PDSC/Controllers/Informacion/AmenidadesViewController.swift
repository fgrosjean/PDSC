//
//  AmenidadesViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/8/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import AXPhotoViewer

final class AmenidadesViewController: UIViewController {
    enum PhotosKind { case casaClub, canchas, juegos}
    
    @IBOutlet private var casaClub01Button: UIButton!
    @IBOutlet private var casaClub02Button: UIButton!
    @IBOutlet private var casaClub03Button: UIButton!
    
    @IBOutlet private var canchas01Button: UIButton!
    @IBOutlet private var canchas02Button: UIButton!
    
    @IBOutlet private   var juegos01Button: UIButton!
    @IBOutlet private   var juegos02Button: UIButton!
    
    private let casaClubPhotos = [UIImage(named: "casaClub1g"), UIImage(named: "casaClub2g"), UIImage(named: "casaClub3g")]
    private let canchasPhotos  = [UIImage(named: "casaClub4g"), UIImage(named: "casaClub5g")]
    private let juegosPhotos   = [UIImage(named: "casaClub6g"), UIImage(named: "casaClub7g")]
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    private func showPhotoOverlay(kind: PhotosKind, index: Int) {
        var photos: [AXPhoto]
        switch kind {
        case .casaClub : photos = casaClubPhotos.map { AXPhoto(image : $0!) }
        case .canchas  : photos = canchasPhotos.map { AXPhoto(image  : $0!) }
        case .juegos   : photos = juegosPhotos.map { AXPhoto(image   : $0!) }
        }
        
        let transitionInfo = AXTransitionInfo(interactiveDismissalEnabled : true, startingView : nil, endingView : nil)
        let dataSource     = AXPhotosDataSource(photos: photos, initialPhotoIndex: index)
        
        let photosViewController = AXPhotosViewController(dataSource: dataSource, pagingConfig: nil, transitionInfo: transitionInfo)
        photosViewController.overlayView.rightBarButtonItem = nil
        
        self.present(photosViewController, animated: true)
    }
    
    // MARK: - Actions
    // -------------------------------------------------------------------------
    @IBAction private func casaClubTapped(_ sender: UIButton) {
        switch sender {
        case casaClub01Button: showPhotoOverlay(kind: .casaClub, index: 0)
        case casaClub02Button: showPhotoOverlay(kind: .casaClub, index: 1)
        case casaClub03Button: showPhotoOverlay(kind: .casaClub, index: 2)
        default: break
        }
    }
    
    @IBAction private func canchasTapped(_ sender: UIButton) {
        switch sender {
        case canchas01Button: showPhotoOverlay(kind: .canchas, index: 0)
        case canchas02Button: showPhotoOverlay(kind: .canchas, index: 1)
        default: break
        }
    }
    
    @IBAction private func juegosTapped(_ sender: UIButton) {
        switch sender {
        case juegos01Button: showPhotoOverlay(kind: .juegos, index: 0)
        case juegos02Button: showPhotoOverlay(kind: .juegos, index: 1)
        default: break
        }
    }
}
