//
//  Constant.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import Foundation
import SwiftUI

// Data

let menus :[Menu] = Bundle.main.decode("menu.json")
let infos : [InfoModel] = Bundle.main.decode("info.json")

// Color

let grayWhite : Color = Color("color-graywhite")
let black : Color = Color("color-black")
let orange : Color = Color("color-orange")
let red : Color = Color("color-red")

// Layout

let columnSpacing : CGFloat = 10
let rowSpacing : CGFloat = 10
var gridLayout : [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing),count: 2)
}


