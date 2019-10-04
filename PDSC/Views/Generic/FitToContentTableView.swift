//
//  FitToContentTableView.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/6/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

class FitToContentTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
