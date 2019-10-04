//
//  NivelCell.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/6/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

class CasasNivelCell: UITableViewCell {
    @IBOutlet var nivelTitleLabel           : UILabel!
    @IBOutlet var plantaImageView           : UIImageView!
    @IBOutlet var nivelNumberContainer      : UIView!
    @IBOutlet var nivelNumberLabel          : UILabel!
    @IBOutlet var nivelDescriptionTableView : UITableView! {
        didSet {
            nivelDescriptionTableView.delegate   = self
            nivelDescriptionTableView.dataSource = self
        }
    }
    
    static let identifier = "NivelCell"
    var levelDescriptions: [String]!
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nivelNumberContainer.layer.borderColor = SectionKind.casas.getSectionColor().cgColor
        nivelNumberContainer.layer.borderWidth = 1.5
    }

    // MARK: - Population
    // -------------------------------------------------------------------------
    func populateCell(nivelTitle        : String,
                      plantaImage       : String,
                      nivelNumber       : Int,
                      levelDescriptions : [String]) {
        nivelTitleLabel.text   = nivelTitle
        plantaImageView.image  = UIImage(named : plantaImage)
        nivelNumberLabel.text  = "\(nivelNumber)"
        self.levelDescriptions = levelDescriptions
    }
}

extension CasasNivelCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levelDescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nivelDescriptionCell", for: indexPath)
        
        let item = levelDescriptions[indexPath.row]
        cell.textLabel?.text = item
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
