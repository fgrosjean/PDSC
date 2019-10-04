//
//  GaleriaViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/4/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import AVKit
import HCVimeoVideoExtractor

final class GaleriaViewController: UIViewController {
    @IBOutlet private var collectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionViewHeightContraint.constant = collectionView.contentSize.height
    }
}

extension GaleriaViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataStore.instance.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GaleriaCell", for: indexPath) as! VideoCell
        cell.populate(image: DataStore.instance.videos[indexPath.item].image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIApplication.shared.statusBarOrientation {
        case .portrait, .portraitUpsideDown: return CGSize(width: (collectionView.bounds.width / 2) - 4, height: 200)
        case .landscapeLeft, .landscapeRight: return CGSize(width: (collectionView.bounds.width / 3) - 6, height: 200)
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = URL(string: "https://vimeo.com/265045525")!
        HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            if let err = error { print("Error = \(err.localizedDescription)"); return }
            guard let vid = video else { print("Invalid video object"); return }
            
            if let videoURL = vid.videoURL[.Quality1080p] {
                let player = AVPlayer(url: videoURL)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.present(playerController, animated: true) {
                    player.play()
                }
            }
        })
    }
    
}
