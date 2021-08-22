//
//  MediaList.swift
//  iFish
//
//  Created by niab on Aug/15/21.
//

import Foundation
import UIKit

struct MediaList: Codable {
    var genericName: String
    var scientificName: String
    //var continent: String?
    var country: String?
    
    var kingdom: String
    var phylum: String
    var order: String
    var family: String
    var genus: String
    var species: String
    
    var decimalLongitude: Double?
    var decimalLatitude: Double?
        
    var media: [MediaObject]
}


//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//            else { return }
//            DispatchQueue.main.async() { [weak self] in
//                self?.image = image
//            }
//        }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}
