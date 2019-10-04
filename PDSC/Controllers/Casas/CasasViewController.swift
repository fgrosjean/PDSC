//
//  CasasViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/6/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import AXPhotoViewer

final class CasasViewController: UIViewController {
    @IBOutlet private var heroImage: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var imagesCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet private var nivelesTableView: UITableView! {
        didSet {
            nivelesTableView.delegate   = self
            nivelesTableView.dataSource = self
        }
    }
    @IBOutlet var imagesCollectionView: UICollectionView! {
        didSet {
            imagesCollectionView.delegate   = self
            imagesCollectionView.dataSource = self
        }
    }
    
    public var currentIndex : Int!
    private var casaData: Casa { return DataStore.instance.getDataFor(casa: DataStore.CasaKind(rawValue: currentIndex)!) }

    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroImage.image = UIImage(named: casaData.heroImagen)
        descriptionLabel.text = casaData.descripcion
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // fix layout height issues
        nivelesTableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imagesCollectionView.collectionViewLayout.invalidateLayout()
        imagesCollectionViewHeight.constant = imagesCollectionView.contentSize.height
    }
}

// MARK: - Table View
// -------------------------------------------------------------------------
extension CasasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casaData.niveles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CasasNivelCell.identifier, for: indexPath) as! CasasNivelCell
        
        let item = casaData.niveles[indexPath.row]
        cell.populateCell(nivelTitle        : item.titulo,
                          plantaImage       : item.imagen,
                          nivelNumber       : item.numero,
                          levelDescriptions : item.descripcion)
        
        return cell
    }
}

// MARK: - Collection View
// -------------------------------------------------------------------------
extension CasasViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casaData.imagenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CasasImagenCell.identifier, for: indexPath) as! CasasImagenCell
        
        cell.populateCell(imageName: casaData.imagenes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIApplication.shared.statusBarOrientation {
        case .portrait, .portraitUpsideDown  : return CGSize(width: (collectionView.bounds.width / 5) - 8, height: (collectionView.bounds.width / 5) - 8)
        case .landscapeLeft, .landscapeRight : return CGSize(width: (collectionView.bounds.width / 7) - 10, height: (collectionView.bounds.width / 7) - 10)
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photos         = casaData.imagenes.map { AXPhoto(image: UIImage(named: $0)!) }
        let transitionInfo = AXTransitionInfo(interactiveDismissalEnabled : true, startingView : nil, endingView : nil)
        let dataSource     = AXPhotosDataSource(photos: photos, initialPhotoIndex: indexPath.row)
        
        let photosViewController = AXPhotosViewController(dataSource: dataSource, pagingConfig: nil, transitionInfo: transitionInfo)
        photosViewController.overlayView.rightBarButtonItem = nil
        
        self.present(photosViewController, animated: true)
    }
}
