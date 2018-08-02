//
//  PhotosCollectionViewCell.swift
//  Photo Collection
//
//  Created by Samantha Gatt on 8/2/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    func updateViews() {
        guard let title = photo?.title,
            let imageData = photo?.imageData,
            let image = UIImage(data: imageData) else {
                return
        }
        photoImageView.image = image
        photoLabel.text = title
    }
    
    
    // MARK: - Properties
    
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
}
