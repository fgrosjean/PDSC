//
//  MenuButton.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/3/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class MenuButton: UIControl {
    @IBOutlet var icon: UIImageView!
    @IBOutlet var sectionColorIndicator: UIView!
    
    var section: SectionKind!
}
