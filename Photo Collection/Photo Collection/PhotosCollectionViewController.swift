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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCollectionViewCell
        
        cell.photo = photoController.photos[indexPath.item]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    // MARK: - Navigation
    
    // come back and clean up
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoDetailViewController {
            photoVC.photoController = photoController
            photoVC.themeHelper = themeHelper
            
            if segue.identifier == "ShowDetails" {
                guard let indexPaths = collectionView?.indexPathsForSelectedItems,
                    let indexPath = indexPaths.first else {
                        return
                }
                photoVC.photo = photoController.photos[indexPath.item]
            }
            return
        }
        
        // Should only get to this code if it is not a photo detail view controller
        let settingsVC = segue.destination as! ThemeSelectionViewController
        settingsVC.themeHelper = themeHelper
    }
    
    
    // MARK: - Functions
    
    func setTheme() {
        guard let preference = themeHelper.themePreference else { return }
        switch preference {
            case "Dark":
                let dark = UIColor(hue: 131, saturation: 16, brightness: 31, alpha: 1)
                collectionView?.backgroundColor = dark
            default:
                let green = UIColor(hue: 89, saturation: 40, brightness: 75, alpha: 1)
                collectionView?.backgroundColor = green
        }
    }
    
    
    // MARK: - Properties
    
    let photoController = PhotoController()
    let themeHelper = ThemeHelper()

}
