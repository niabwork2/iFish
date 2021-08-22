//
//  ViewController.swift
//  ARoundUs
//
//  Created by niab on Mar/21/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: GalleryTableViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaListArray.forEach { MediaList in
          
            coordinate.latitude = MediaList.decimalLatitude ?? 0
            coordinate.longitude = MediaList.decimalLongitude ?? 0
            mapView.setRegion(MKCoordinateRegion(center: coordinate,span:
                                                MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)),animated: false)
            
            addCustomPin(title: MediaList.genericName, subtitle: MediaList.scientificName)
        }

        
        
        mapView.delegate = self
        
        
    }
    
    private func addCustomPin(title:String, subtitle:String) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = title
        pin.subtitle = subtitle
        mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            // Create the view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            
            
            let rightButton = UIButton(type: .detailDisclosure)
            
            mediaListArray.forEach { MediaList in
                let mediaObject = MediaList.media.first
                let imageURL = mediaObject?.identifier
                let url = URL(string: imageURL ?? "")
                
                let imageUI = UIImageView()
                imageUI.kf.setImage(with: url)
                imageUI.layer.cornerRadius = imageUI.frame.height / 2
                imageUI.layer.borderWidth = 2
                imageUI.layer.borderColor = UIColor.systemGray.cgColor
                rightButton.setImage(imageUI.image?.withRenderingMode(.alwaysOriginal), for: .normal)
                annotationView!.rightCalloutAccessoryView = rightButton
            }
            
        
           
            //rightButton.setImage( UIImage(named: "fish"), for: .normal)
           
            
            
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "map-icon")
        
        
        
        
        
        
        return annotationView
    }
    
}


