//
//  MenuModel.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import Foundation

struct Menu : Codable , Identifiable , Hashable{
    let id : Int
    let name : String
    let image : String
}
