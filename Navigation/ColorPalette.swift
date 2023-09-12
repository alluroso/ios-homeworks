//
//  ColorPalette.swift
//  Navigation
//
//  Created by Алексей Калинин on 12.09.2023.
//

import Foundation
import UIKit

struct Palette {
    
    static var blackWhite = UIColor.createColor(lightMode: .black, darkMode: .white)
    static var whiteBlack = UIColor.createColor(lightMode: .white, darkMode: .black)
    static var gray62 = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray2)
    static var whiteGray2 = UIColor.createColor(lightMode: .white, darkMode: .systemGray2)
    static var grayWhite = UIColor.createColor(lightMode: .gray, darkMode: .white)
    
    static var feedBackground = UIColor.createColor(lightMode: .systemIndigo, darkMode: .black)
    static var profileBackground = UIColor.createColor(lightMode: .systemGray6, darkMode: .black)
}
