//
//  ViewController.swift
//  Unsplash
//
//  Created by Roman Kuryanov (aka Matovsky) on 09/08/2022.
//  Copyright © 2022 Roman Matovsky (aka Kuryanov). All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchKeywords: String?
    
    // MARK: - For Cells position
    struct Storyboard {
        static let leftAndRightPadding: CGFloat = 5.0
        static let numbersOfItemsPerRaw: CGFloat = 3.0
        static let sectionInset: CGFloat = 5.0
        let sectionInset: UIEdgeInsets
    }

    // MARK: - Entry point
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = searchKeywords
    }
    
    // MARK: - Position and resize of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = UIScreen.main.bounds.size.width
        let cellWidth = (collectionViewWidth - Storyboard.leftAndRightPadding) / Storyboard.numbersOfItemsPerRaw - Storyboard.sectionInset
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout.itemSize
    }
    
    // MARK: - Count cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // MARK: - Every cell content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        AF.request("https://api.unsplash.com/search/photos?page=1&query=\(searchKeywords!)&\(Model.Parameters.accessKey)").responseJSON { response in
                    
            switch response.result {
            case .success:

                if let json = response.data {
                    do {
                        let jsondata = try JSON(data: json)
                        
                        DispatchQueue.main.async {
                            let photo = jsondata[Model.Parameters.results][indexPath.item][Model.Parameters.urls][Model.Parameters.thumb]
                            
                            if photo != JSON.null {
                                let photoURL = URL(string: "\(photo)")
                                let photoData = NSData(contentsOf: photoURL! as URL)
                                cell.imageUnsplash.image = UIImage(data: photoData! as Data)
                            }
                        }

                    } catch {
                        print("JSON Error")
                    }
                }

            case .failure(let error):
                print(error)
            }
        }
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    // MARK: - Action when push on Cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        DispatchQueue.main.async(){
            self.view.endEditing(true)
            let segueID = "ditailPhoto"
            self.performSegue(withIdentifier: segueID, sender: self)
        }

        print(indexPath.item)
        UserDefaults.standard.set(indexPath.item, forKey: "indexPath.item")
        
    }
    
    // MARK: - Prepare to segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ditailPhoto" {
        
            let VController = segue.destination as! DetailViewController
            let searchText = searchKeywords
            VController.keyword = searchText
        }
    }


}

