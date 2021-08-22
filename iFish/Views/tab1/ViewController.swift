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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    var allAnnotations: [MKAnnotation]?
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var allFish = [fishAnnotation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerMapAnnotationViews()
        
        mediaListArray.forEach { MediaList in
            
            coordinate.latitude = MediaList.decimalLatitude ?? 0
            coordinate.longitude = MediaList.decimalLongitude ?? 0
            mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
            
            
            let mediaObject = MediaList.media.first
            let imageURL = mediaObject?.identifier
            let imageURLsplice = imageURL?.replacingOccurrences(of: "original", with: "small") ?? ""
            
            let url = URL(string: imageURLsplice)
            //print("url: \(url!)")
            
            let imageUI = UIImageView()
            imageUI.image?.withRenderingMode(.alwaysOriginal)
            imageUI.kf.setImage(with: url)
            
            let rightButton = UIButton(frame: CGRect(origin: CGPoint.zero,size: CGSize(width: 48, height: 48)))
            rightButton.setImage(imageUI.image?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            rightButton.imageView?.layer.cornerRadius = rightButton.frame.size.width / 2.0
            rightButton.imageView?.layer.borderWidth = 1.5
            rightButton.imageView?.layer.borderColor = UIColor.systemGray2.cgColor
            
            let eachFish = fishAnnotation()
            eachFish.coordinate.latitude = MediaList.decimalLatitude ?? 0
            eachFish.coordinate.longitude = MediaList.decimalLongitude ?? 0
            eachFish.title = MediaList.genericName
            eachFish.subtitle = MediaList.scientificName
            eachFish.imageUIButton = rightButton
            eachFish.imageURL = url
        
            allFish.append(eachFish)
            
            
            
        }
        
        //print("allFish: \(allFish)")
        mapView.addAnnotations(allFish)
        mapView.delegate = self
        
        allFish.forEach { fishAnnotation in
            print("fishAnnotation.imageURL: \(fishAnnotation.imageURL)")
        }
        
        
    }
    
    
    
    func registerMapAnnotationViews() {
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(fishAnnotation.self))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        if let annotation = annotation as? fishAnnotation {
                annotationView = setupFishAnnotationView(for: annotation, on: mapView)
        }
        return annotationView
    }
    
    func setupFishAnnotationView(for annotation: fishAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        let reuseIdentifier = NSStringFromClass(fishAnnotation.self)
        //let flagAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)
        let flagAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        flagAnnotationView.canShowCallout = true
        
        
        let imageUI = UIImageView(frame: CGRect(origin: CGPoint.zero,size: CGSize(width: 48, height: 48)))
        imageUI.image?.withRenderingMode(.alwaysOriginal)
        imageUI.kf.setImage(with: annotation.imageURL)
        //print("annotation.imageURL: \(annotation.imageURL!)")
        let fishImage = imageUI.image
        let fishImageView = UIImageView(image: fishImage)
        fishImageView.layer.cornerRadius = fishImageView.frame.width / 2.0
        fishImageView.layer.borderWidth = 1.5
        fishImageView.layer.borderColor = UIColor.systemGray2.cgColor
        
        
        let rightButton = UIButton(frame: CGRect(origin: CGPoint.zero,size: CGSize(width: 48, height: 48)))
        rightButton.setImage(imageUI.image?.withRenderingMode(.alwaysOriginal), for: .normal)
        rightButton.imageView?.layer.cornerRadius = rightButton.frame.size.width / 2.0
        rightButton.imageView?.layer.borderWidth = 1.5
        rightButton.imageView?.layer.borderColor = UIColor.systemGray2.cgColor
        
        // Provide the annotation view's image.
        let fishPin = #imageLiteral(resourceName: "map-icon")
        flagAnnotationView.image = fishPin
        
        //flagAnnotationView.leftCalloutAccessoryView = fishImageView
        flagAnnotationView.rightCalloutAccessoryView = rightButton
        
        return flagAnnotationView
        
    }
    
}
