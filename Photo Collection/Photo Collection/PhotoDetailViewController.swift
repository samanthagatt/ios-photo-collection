//
//  PhotoDetailViewController.swift
//  Photo Collection
//
//  Created by Samantha Gatt on 8/2/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
        setTheme()
    }
    
    
    // MARK: - Adopted Functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Selected image not a UIImage")
        }
        photoImageView.image = image
    }
    
    
    // MARK: - Functions
    
    func updateViews() {
        guard let thisPhoto = photo,
            let image = UIImage(data: thisPhoto.imageData) else {
                return
        }
        photoImageView.image = image
        photoTextField.text = thisPhoto.title
        navigationItem.title = thisPhoto.title
    }
    
    func setTheme() {
        guard let preference = themeHelper?.themePreference else { return }
        switch preference {
        case "Dark":
            let dark = UIColor(hue: 131, saturation: 16, brightness: 31, alpha: 1)
            view.backgroundColor = dark
        default:
            let green = UIColor(hue: 89, saturation: 40, brightness: 75, alpha: 1)
            view.backgroundColor = green
        }
    }
    
    func presentImagePickerController() {
        let imagePickerAvailable = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        if imagePickerAvailable == true {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            DispatchQueue.main.async {
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    
    func showPrivacyAlert() {
        let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        let alert = UIAlertController(title: "Photo Library Access Denied", message: "Photo Collection needs to access your photo library so you can add pictures. You can grant access by going to Settings -> Privacy -> Photos", preferredStyle: .alert)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func showSaveAlert() {
        let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        let alert = UIAlertController(title: "Not enough information", message: "Your photo doesn't seem to be complete. In order to save a photo, please fill out all prompts.", preferredStyle: .alert)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Actions
    
    @IBAction func addPhoto(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.presentImagePickerController()
                } else {
                    self.showPrivacyAlert()
                }
            }
        default:
            showPrivacyAlert()
        }
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        guard let title = photoTextField.text,
            let image = photoImageView.image,
            let imageData = UIImagePNGRepresentation(image) else {
                showSaveAlert()
                return
        }
        if let thisPhoto = photo {
            photoController?.update(photo: thisPhoto, title: title, imageData: imageData)
        } else {
            photoController?.create(title: title, imageData: imageData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTextField: UITextField!
    
    
    // MARK: - Properties
    
    var photoController: PhotoController?
    var photo: Photo?
    var themeHelper: ThemeHelper?
}
