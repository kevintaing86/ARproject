//
//  HomeViewController.swift
//  AR-App
//
//  Created by Kevin Taing on 9/9/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var mapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func mapButtonClicked(_ sender: Any) {
        mapButton.backgroundColor = UIColor(red: 3/255,green: 169/255,blue: 244/255,alpha: 1)
    }
    
    @IBAction func mapButtonClick(_ sender: Any) {
        mapButton.backgroundColor = UIColor(red: 3/255,green: 100/255,blue: 244/255,alpha: 1)
    }
}
