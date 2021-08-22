//
//  GalleryDetailViewController.swift
//  ARoundUs
//
//  Created by niab on Jun/20/21.
//

import UIKit

class GalleryDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel_01: UILabel!
    @IBOutlet weak var subtitleLabel_02: UILabel!
    @IBOutlet weak var subtitleLabel_03: UILabel!
    @IBOutlet weak var subtitleLabel_04: UILabel!
    @IBOutlet weak var subtitleLabel_05: UILabel!
    @IBOutlet weak var subtitleLabel_06: UILabel!
    @IBOutlet weak var subtitleLabel_07: UILabel!
    @IBOutlet weak var subtitleLabel_08: UILabel!
    @IBOutlet weak var subtitleLabel_09: UILabel!
    @IBOutlet weak var subtitleLabel_10: UILabel!
    
    
    
    //var gallery = DataObject(genericName: "", scientificName: "", continent: "", country: "", kingdom: "", phylum: "", order: "", family: "", genus: "", species: "", decimalLongitude: 0, decimalLatitude: 0, speciesKey: -1, references: "")
    
    var gallery = MediaList(genericName: "", scientificName: "", country: "", kingdom: "", phylum: "", order: "", family: "", genus: "", species: "", decimalLongitude: 0, decimalLatitude: 0, media: [MediaObject]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        
        let mediaObject = gallery.media.first
        let imageURL = mediaObject?.identifier
        
        let url = URL(string: imageURL ?? "")
        //let data = try? Data(contentsOf: url!)
        //let convertImg = UIImage(data: data!)
        imageView.kf.setImage(with: url)
        
        let imgWidth = imageView?.image?.cgImage?.width
        let imgHeight = imageView?.image?.cgImage?.height
        
        print("imageURL: \(imageURL ?? "")")
        print("dimension: \(imgWidth ?? 0) x \(imgHeight ?? 0)")
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        //imageView.image = convertImg
        
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.cornerRadius = 20
        
        titleLabel.text = gallery.scientificName
        subtitleLabel_01.text = gallery.genericName
        subtitleLabel_02.text = gallery.country ?? "N/A"
        
        subtitleLabel_03.text = gallery.kingdom
        subtitleLabel_04.text = gallery.phylum
        subtitleLabel_05.text = gallery.order
        subtitleLabel_06.text = gallery.family
        subtitleLabel_07.text = gallery.genus
        subtitleLabel_08.text = gallery.species
        
        subtitleLabel_09.text = String(gallery.decimalLongitude ?? 0)
        subtitleLabel_10.text = String(gallery.decimalLatitude ?? 0)
        
    }
    
    
    
}
