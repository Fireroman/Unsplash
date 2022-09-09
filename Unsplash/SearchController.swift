//
//  SearchController.swift
//  Unsplash
//
//  Created by Roman Kuryanov (aka Matovsky) on 09/08/2022.
//  Copyright © 2022 Roman Matovsky (aka Kuryanov). All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchOutlet: UITextField!
    
    // MARK: - Entry point
    override func viewDidLoad() {
        super.viewDidLoad()
         searchOutlet.delegate = self
    }
    
    @IBAction func nextButton(_ sender: Any) {
        DispatchQueue.main.async(){
            self.view.endEditing(true)
            let segueID = "Collection"
            self.performSegue(withIdentifier: segueID, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Collection" {
        
            let VController = segue.destination as! ViewController
            let searchText = searchOutlet.text
            VController.searchKeywords = searchText
            
        }
    }
    
    
}
