//
//  GalleryTableViewController.swift
//  ARoundUs
//
//  Created by niab on Jun/06/21.
//

import UIKit

class GalleryTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //var MediaArray: Array<Any> = []
    var limit = 100
    
    var AllDataAPIArray = [DataObject]()
    var AllSpeciesAPIArray = [MediaList]()
    
    var mediaListArray = [MediaList]()
    var mediaObjectArray = [[MediaObject]]()
    var mediaStringArray = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        //tableView.reloadData()
        DispatchQueue.main.async {
            self.navigationItem.title = "All gallery items: \(self.AllDataAPIArray.count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.delegate = self
        //tableView.dataSource = self
        
        fetchJSON()
        
        //print("AllSpeciesAPIArray length: \(AllSpeciesAPIArray.count)")
        //print("mediaListArray: \(mediaListArray)")
        
        //        mediaListArray.forEach { MediaList in
        //            mediaObjectArray.append(MediaList.media)
        //        }
        
        //print("mediaObjectArray: \(mediaObjectArray)")
        
        //        mediaObjectArray.forEach { media in
        //            let firstImageURL = media.identifier
        //            mediaStringArray.append(firstImageURL!)
        //        }
        
        DispatchQueue.main.async {
            self.navigationItem.title = "All gallery items: \(self.AllDataAPIArray.count)"
        }
        
    }
    
    func fetchJSON() {
        // Fetch JSON from API
        let urlString = "https://api.gbif.org/v1/occurrence/search?datasetKey=3633e0e7-8c25-4c3d-b9c7-078c0be25665&limit=\(limit)"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                
                //print("data size: \(data)")
                print("AllDataAPIArray length: \(AllDataAPIArray.count)")
                //print("AllDataAPIArray: \(AllDataAPIArray)")
                
            } else {
                showError()
            }
        }
        
        
        if AllDataAPIArray.isEmpty {
            print("Empty AllDataAPIArray!")
        } else {
            
            AllDataAPIArray.forEach { DataObject in
                let speciesKey = DataObject.speciesKey
                let urlString2 = "https://api.gbif.org/v1/occurrence/search?speciesKey=\(speciesKey)&limit=1"
                
                if let url = URL(string: urlString2) {
                    if let data2 = try? Data(contentsOf: url) {
                        parse2(json: data2)
                        
                        //print("data size: \(data2)")
                        //print("AllSpeciesAPIArray length: \(AllSpeciesAPIArray.count)")
                        //print("AllSpeciesAPIArray: \(AllSpeciesAPIArray)")
                        
                    } else {
                        showError()
                    }
                }
            }
        }
        
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonAllData = try? decoder.decode(DataAll.self, from: json) {
            AllDataAPIArray = jsonAllData.results
            
            //print("JSON data: \(AllDataAPIArray)")
        }
    }
    
    func parse2(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonAllData = try? decoder.decode(SpeciesAll.self, from: json) {
            AllSpeciesAPIArray = jsonAllData.results
            
            
            //print("JSON MediaList: \(AllSpeciesAPIArray.first)")
            AllSpeciesAPIArray.forEach { MediaList in
                
                mediaListArray.append(MediaList)
                //print("mediaListArray length: \(mediaListArray.count)")
                
            }
            
            
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        
        let selectedRow = mediaListArray[tableView.indexPathForSelectedRow!.row]
        let galleryDetailVC = segue.destination as! GalleryDetailViewController
        galleryDetailVC.gallery = selectedRow
        
        
    }
    
}


extension GalleryTableViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllDataAPIArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let gallery = mediaListArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell") as! GalleryCell
        
        //cell.delegate = self
        cell.setGallery(gallery: gallery)
        
        //    mediaObjectArray.forEach { each in
        //
        //    }
        
        return cell
    }
    
}


