//
//  VideoCell.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/6/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    func populate(image: String) {
        imageView.image = UIImage(named: image)
    }
}
