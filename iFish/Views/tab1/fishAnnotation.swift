//
//  fishAnnotation.swift
//  iFish
//
//  Created by niab on Aug/22/21.
//

import MapKit

class fishAnnotation: NSObject, MKAnnotation {
    
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var title: String? = "title"
    
    var subtitle: String? = "subtitle"
    
    var imageUIButton = UIButton()
    
    var imageURL = URL(string: "")
}
