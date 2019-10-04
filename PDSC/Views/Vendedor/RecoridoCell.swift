//
//  RecoridoCell.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/7/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class RecoridoCell: UICollectionViewCell {
    static let identifier = "RecorridoCell"
    @IBOutlet private var image: UIImageView!
    @IBOutlet private var label: UILabel!
    
    public func populate(image: UIImage, title: String) {
        self.image.image = image
        label.text       = title
    }
}
