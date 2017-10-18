//
//  ARViewController.swift
//  AR-App
//
//  Created by Kevin Taing on 9/26/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import UIKit
import MapKit
import ARKit

@available(iOS 11.0, *)
class ARViewController: UIViewController, UserLocationDelegate{
    
    @IBOutlet weak var arScene: ARSCNView!
    var userLocation: CLLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        arScene.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        arScene.session.run(configuration)
        
        loadCapsule()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: arScene)
            let hitList = arScene.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                arScene.overlaySKScene = arMenu(size: self.view.bounds.size)
            }
        }
    }
    
    func loadCapsule() {
        let xPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPos = randomPosition(lowerBound: -1, upperBound: -2)
        let capsule = Capsule()
        capsule.loadModal()
        
        capsule.position = SCNVector3(xPos, yPos, -5)
        arScene.scene.rootNode.addChildNode(capsule)
    }
    
    func randomPosition(lowerBound lower: Float, upperBound upper: Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    func updateUserLocation(newLocation: CLLocation) {
        userLocation = newLocation
        print("hi")
    }

    
}
