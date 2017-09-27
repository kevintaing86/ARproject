//
//  ARViewController.swift
//  AR-App
//
//  Created by Kevin Taing on 9/26/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import UIKit
import ARKit

@available(iOS 11.0, *)
class ARViewController: UIViewController {
    
    
    @IBOutlet weak var arScene: ARSCNView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        arScene.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        arScene.session.run(configuration)
    }
    
}
