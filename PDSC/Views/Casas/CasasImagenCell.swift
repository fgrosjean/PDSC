//
//  CasasImagenCell.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/6/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

class CasasImagenCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    static let identifier = "CasasImagenCell"

    func populateCell(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
