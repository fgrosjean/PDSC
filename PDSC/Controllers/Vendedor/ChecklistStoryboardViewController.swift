//
//  ChecklistViewController.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/4/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import TinyConstraints
import PKHUD

final class ChecklistStoryboardViewController: UIViewController {
    @IBOutlet private var checklistContainer : UIView!
    @IBOutlet private var checklistHeight    : NSLayoutConstraint!
    @IBOutlet private var resetButton        : UIButton!
    
    private var checklistTableView: UITableView!
    private var pickedImage: UIImage?
    
    // MARK: - View Lifecycle
    // -------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadChecklist()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        checklistHeight.constant = checklistTableView.contentSize.height
    }
    
    // MARK: - Setup
    // -------------------------------------------------------------------------
    private func loadChecklist() {
        let checklistViewController = ChecklistViewController()
        let dataSource = DataStore.instance.checklistItems.map { ChecklistModel(name: $0, completed: false) }
        
        checklistViewController.data = dataSource
        checklistViewController.clearAllbutton = resetButton
        checklistViewController.sendPhotoTapped = photoButtonTappedHandler
        
        self.addChild(checklistViewController)
        checklistContainer.addSubview(checklistViewController.view)
        checklistTableView = checklistViewController.tableView
        checklistViewController.view.edgesToSuperview()
        checklistViewController.willMove(toParent: self)
    }
    
    private func photoButtonTappedHandler() {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        imagePickerViewController.delegate = self
        
        present(imagePickerViewController, animated: true)
    }
    
    // MARK: - Send Email
    // -------------------------------------------------------------------------
    private func sendEmail() {
        guard let pickedImage = pickedImage else { return }
        HUD.show(.progress)
        
        let resizedImage = pickedImage.imageWithImage(scaledToWidth: 400)
        let imageData    = resizedImage.jpegData(compressionQuality: 0.5)!
        let imageToSend  = String(data: imageData.base64EncodedData(), encoding: .utf8)!
        
        let email = Email(
            personalizations : [Email.Personalizations(to: [Email.To(email: "grosjeanfernando@gmail.com", name: "PDSC Apps")])],
            subject          : "New image from PDSC app",
            content          : [Email.Content(value: "<h1>New image from PDSC app<h1>")],
            attachments      : [Email.Attachments(content: imageToSend, filename: "photo.jpg", type: "image/jpeg", content_id: "photo")]
        )
        
        do {
            let emailToJson = try JSONEncoder().encode(email)
            MailerService.instace.sendEmail(data: emailToJson) { (error) in
                switch error {
                case nil : DispatchQueue.main.asyncAfter(deadline: .now() + 1) { HUD.flash(.success, delay: 1) }
                default  : DispatchQueue.main.asyncAfter(deadline: .now() + 1) { HUD.flash(.error, delay: 1) }
                }
            }
        } catch let error { print(error.localizedDescription) }
    }
}

extension ChecklistStoryboardViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        pickedImage = image
        
        picker.dismiss(animated: true) { self.sendEmail() }
    }
}
