//
//  RecorridoViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/7/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class PasosViewController: UIViewController {
    @IBOutlet private var pin1  : PinRecorrido!
    @IBOutlet private var pin2  : PinRecorrido!
    @IBOutlet private var pin3  : PinRecorrido!
    @IBOutlet private var pin4  : PinRecorrido!
    @IBOutlet private var pin5  : PinRecorrido!
    @IBOutlet private var pin6  : PinRecorrido!
    @IBOutlet private var pin7  : PinRecorrido!
    @IBOutlet private var pin8  : PinRecorrido!
    @IBOutlet private var pin9  : PinRecorrido!
    @IBOutlet private var pin10 : PinRecorrido!
    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    lazy private var pins = [pin1, pin2, pin3, pin4, pin5, pin6, pin7, pin8, pin9, pin10]
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = DataStore.instance.recorridoData.count
        setPins()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    private func setPins() {
        pins.forEach{ $0?.viewControllerPresenting = self }
        for (index, pin) in pins.enumerated() { pin!.mensaje = DataStore.instance.pinData[index] }
    }
}

extension PasosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataStore.instance.recorridoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecoridoCell.identifier, for: indexPath) as! RecoridoCell
        let item = DataStore.instance.recorridoData[indexPath.item]
        cell.populate(image: UIImage(named: item.image)!, title: item.title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
    }
}
