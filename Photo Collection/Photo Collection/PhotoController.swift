//
//  PhotoController.swift
//  Photo Collection
//
//  Created by Samantha Gatt on 8/2/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class PhotoController {
    
    
    
    // MARK: - Properties
    
    var photos: [Photo] = []
    
    
    
    
    // MARK: - Persistence
    
    init() {
        loadFromPersistentStore()
    }
    
    var photosURL: URL? {
        let fm = FileManager.default
        let fileName = "Photos.plist"
        
        guard let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let photoDir = docDir.appendingPathComponent(fileName)
        
        return photoDir
    }
    
    func saveToPersistentStore() {
        guard let url = photosURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(photos)
            try data.write(to: url)
        } catch {
            NSLog("Error saving photos data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = photosURL else { return }
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let decodedPhotos = try decoder.decode([Photo].self, from: data)
            
            photos = decodedPhotos
        } catch {
            NSLog("Error loading photos data: \(error)")
        }
    }
    
    
    
    // MARK: - Methods
    
    func create(title: String, imageData: Data) {
        let photo = Photo(title: title, imageData: imageData)
        photos.append(photo)
        
        saveToPersistentStore()
    }
    
    func update(photo: Photo, title: String, imageData: Data) {
        guard let index = photos.index(of: photo) else { return }
        photos[index].title = title
        photos[index].imageData = imageData
        
        saveToPersistentStore()
    }
    
    func delete(photo: Photo) {
        guard let index = photos.index(of: photo) else { return }
        photos.remove(at: index)
        
        saveToPersistentStore()
    }
}
