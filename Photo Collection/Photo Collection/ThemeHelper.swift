//
//  ThemeHelper.swift
//  Photo Collection
//
//  Created by Samantha Gatt on 8/2/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class ThemeHelper {
    
    
    // MARK: - Initializer
    
    // Sets the theme to green first time the app runs since the user hasn't selected a theme preference (themePreference = nil)
    init() {
        guard let _ = themePreference else {
            setThemePreferenceToGreen()
            return
        }
    }
    
    
    // MARK: - Properties
    
    let themePreferenceKey = "ThemePreference"
    
    var themePreference: String? {
        return UserDefaults.standard.string(forKey: themePreferenceKey)
    }
    
    
    // MARK: - Methods
    
    func setThemePreferenceToDark() {
        UserDefaults.standard.set("Dark", forKey: themePreferenceKey)
    }
    
    func setThemePreferenceToGreen() {
        UserDefaults.standard.set("Green", forKey: themePreferenceKey)
    }
}
