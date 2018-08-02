//
//  Photo.swift
//  Photo Collection
//
//  Created by Samantha Gatt on 8/2/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

struct Photo: Equatable, Codable {
    var title: String
    var imageData: Data
}
