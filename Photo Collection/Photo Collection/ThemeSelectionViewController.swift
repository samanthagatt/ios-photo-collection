//
//  ThemeSelectionViewController.swift
//  Photo Collection
//
//  Created by Samantha Gatt on 8/2/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class ThemeSelectionViewController: UIViewController {

    
    // MARK: - Actions
    
    @IBAction func selectGreenTheme(_ sender: Any) {
        themeHelper?.setThemePreferenceToGreen()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectDarkTheme(_ sender: Any) {
        themeHelper?.setThemePreferenceToDark()
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Properties
    
    var themeHelper: ThemeHelper?

}
