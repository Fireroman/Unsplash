//
//  DetailViewController.swift
//  Unsplash
//
//  Created by Roman Kuryanov (aka Matovsky) on 09/08/2022.
//  Copyright © 2022 Roman Matovsky (aka Kuryanov). All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailPhoto: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var keyword: String?
    var indexPathItem = UserDefaults.standard.integer(forKey: "indexPath.item")
    
    // MARK: - Entry point
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Detail image
        AF.request("https://api.unsplash.com/search/photos?page=1&query=\(keyword!)&\(Model.Parameters.accessKey)").responseJSON { response in
                    
            switch response.result {
            case .success:

                if let json = response.data {
                    do {
                        let jsondata = try JSON(data: json)
                        
                        DispatchQueue.main.async { [self] in
                            let photo = jsondata[Model.Parameters.results][indexPathItem][Model.Parameters.urls][Model.Parameters.regular]
                            
                            if photo != JSON.null {
                                let photoURL = URL(string: "\(photo)")
                                let photoData = NSData(contentsOf: photoURL! as URL)
                                detailPhoto.image = UIImage(data: photoData! as Data)
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
    }
    
    // MARK: - Dismiss Button
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
