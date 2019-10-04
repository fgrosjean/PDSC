//
//  ChecklistViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/4/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit

final class ChecklistViewController: UIViewController {
    @IBOutlet private var sendPhotoButton    : UIButton!
    @IBOutlet private var completedLabel     : UILabel!
    @IBOutlet private var completedContainer : UIView!
    @IBOutlet private var percentageLabel    : UILabel!
    @IBOutlet private(set) var tableView     : UITableView! {
        didSet {
            tableView.delegate        = self
            tableView.dataSource      = self
            tableView.tableFooterView = UIView(frame : CGRect.zero)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ChecklistCell")
        }
    }
    
    private var sectionColor        : UIColor!
    public var clearAllbutton      : UIButton? { didSet { clearAllbutton?.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside) } }
    public var data                = [ChecklistModel]()
    public var hideSendPhotoButton : Bool = false
    public var sendPhotoTapped     : ( () -> Void )?
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionColor = percentageLabel.textColor
        sendPhotoButton.isHidden = hideSendPhotoButton
        sendPhotoButton.setImage(PDSC_UI.imageOfSendPhotoIcon, for: .normal)
        tableView.contentInset = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    }
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    private func calculatePercentage() -> Int {
        let numberOfItems = data.count
        let doneItems = data.filter { $0.completed }
        return (doneItems.count * 100) / numberOfItems
    }
    
    private func setCompletedStatus() {
        let percentageValue = calculatePercentage()
        percentageLabel.text                 = "\(percentageValue)%"
        completedContainer.backgroundColor   = percentageValue == 100 ? #colorLiteral(red   : 0.2352941176, green   : 0.5529411765, blue   : 0.2509803922, alpha   : 1) : UIColor.clear
        percentageLabel.textColor            = percentageValue == 100 ? #colorLiteral(red            : 1, green            : 1, blue            : 1, alpha            : 1) : sectionColor
        completedLabel.textColor             = percentageValue == 100 ? #colorLiteral(red             : 1, green             : 1, blue             : 1, alpha             : 1) : sectionColor
        completedContainer.layer.borderColor = percentageValue == 100 ? #colorLiteral(red : 0.2352941176, green : 0.5529411765, blue : 0.2509803922, alpha : 1) : sectionColor.cgColor
    }
    
    // MARK: - Actions
    // -------------------------------------------------------------------------
    @IBAction private func sendPhotoTapped(_ sender: UIButton) { sendPhotoTapped?() }
    
    @objc private func clearAllButtonTapped() {
        for (index, _) in data.enumerated() { data[index].completed = false }
        setCompletedStatus()
        tableView.reloadData()
    }
}

extension ChecklistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath)
        let item = data[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = item.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.accessoryType = item.completed ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.row].completed.toggle()
        tableView.reloadRows(at: [indexPath], with: .fade)
        tableView.deselectRow(at: indexPath, animated: true)
        setCompletedStatus()
    }
}
