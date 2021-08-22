//
//  GalleryCell.swift
//  ARoundUs
//
//  Created by niab on Jun/06/21.
//

import UIKit
import SwipeCellKit
import Kingfisher

class GalleryCell: UITableViewCell {

    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var galleryTitle: UILabel!
    @IBOutlet weak var gallerySubtitle1: UILabel!
    @IBOutlet weak var gallerySubtitle2: UILabel!
    
    func setGallery(gallery: MediaList) {
       
      
        let mediaObject = gallery.media.first
        let imageURL = mediaObject?.identifier
        
        //https://inaturalist-open-data.s3.amazonaws.com/photos/110433730/original.jpeg?1610918943"
        //https://inaturalist-open-data.s3.amazonaws.com/photos/110433730/medium.jpeg?1610918943
        let imageURLsplice = imageURL?.replacingOccurrences(of: "original", with: "small") ?? ""
        
        let url = URL(string: imageURLsplice)
        galleryImageView.kf.setImage(with: url)
        
        let imgWidth = galleryImageView.image?.cgImage?.width
        let imgHeight = galleryImageView.image?.cgImage?.height
        
        
        
        print("imageURLsplice: \(imageURLsplice)")
        print("dimension: \(imgWidth ?? 0) x \(imgHeight ?? 0)")
        print("================================================================================================")
     
        
       
        //galleryImageView.image = UIImage(data: data!)
        galleryImageView.layer.borderWidth = 2
        galleryImageView.layer.borderColor = UIColor.systemGray.cgColor
        galleryImageView.layer.cornerRadius = galleryImageView.frame.height / 2
  
        galleryTitle.text = gallery.scientificName
        gallerySubtitle1.text = gallery.genericName
        gallerySubtitle2.text = gallery.country ?? "N/A"
        
    }
    
   
    
}

