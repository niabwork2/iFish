//
//  memes.swift
//  ARoundUs
//
//  Created by niab on May/31/21.
//

import Foundation
import UIKit

struct DataObject: Codable {

//    var name: String
//    var details: String
//    var imageData: Data
    
    var genericName: String
    var scientificName: String
    var continent: String?
    var country: String?
    
    var kingdom: String
    var phylum: String
    var order: String
    var family: String
    var genus: String
    var species: String
    
    var decimalLongitude: Double?
    var decimalLatitude: Double?
    
    var speciesKey: Int
    var references: String?
 
}
