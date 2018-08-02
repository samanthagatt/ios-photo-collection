//
//  PhotosCollectionViewController.swift
//  Photo Collection
//
//  Created by Samantha Gatt on 8/2/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
        setTheme()
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotosCollectionViewCell
        
        cell.photo = photoController.photos[indexPath.item]
    
        return cell
    }
    
    
    // MARK: - Navigation
    
    // come back and clean up
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let photoVC = segue.destination as? PhotoDetailViewController {
//            photoVC.photoController = photoController
//            photoVC.themeHelper = themeHelper
//
//            if segue.identifier == "ShowDetails" {
//                guard let indexPaths = collectionView?.indexPathsForSelectedItems,
//                    let indexPath = indexPaths.first else {
//                        return
//                }
//                photoVC.photo = photoController.photos[indexPath.item]
//            }
//            return
//        }
//
//        // Should only get to this code if it is not a photo detail view controller
//        let settingsVC = segue.destination as! ThemeSelectionViewController
//        settingsVC.themeHelper = themeHelper
        
        if segue.identifier == "ShowSettings" {
            let destVC = segue.destination as! ThemeSelectionViewController
            destVC.themeHelper = themeHelper
        } else if segue.identifier == "ShowAddPhoto" {
            let destVC = segue.destination as! PhotoDetailViewController
            destVC.themeHelper = themeHelper
            destVC.photoController = photoController
        }
        if segue.identifier == "ShowDetails" {
            let destVC = segue.destination as! PhotoDetailViewController
            destVC.themeHelper = themeHelper
            destVC.photoController = photoController
            
            guard let indexPaths = collectionView?.indexPathsForSelectedItems,
                let indexPath = indexPaths.first else {
                    return
            }
            destVC.photo = photoController.photos[indexPath.item]
        }
    }
    
    
    // MARK: - Functions
    
    func setTheme() {
        guard let preference = themeHelper.themePreference else { return }
        switch preference {
            case "Dark":
                let dark = UIColor(hue: 131/255, saturation: 16/255, brightness: 31/255, alpha: 1)
                collectionView?.backgroundColor = dark
            default:
                let green = UIColor(hue: 89/255, saturation: 40/255, brightness: 75/255, alpha: 1)
                collectionView?.backgroundColor = green
        }
    }
    
    
    // MARK: - Properties
    
    let photoController = PhotoController()
    let themeHelper = ThemeHelper()

}
