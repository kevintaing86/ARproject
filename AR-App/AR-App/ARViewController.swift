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
    @IBOutlet var arMenu: UIView!
    var userLocation: CLLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        arScene.scene = scene
        
        // arMenu configurations
        arMenu.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        arScene.session.run(configuration)
        
        loadCapsule()
    }
    
    @IBAction func openCapsule(_ sender: Any) {
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.arMenu.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.arMenu.alpha = 1
        }) { ( success: Bool ) in
            self.arMenu.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: arScene)
            let hitList = arScene.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                self.openModal()
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
    
    func openModal() {
        self.view.addSubview(arMenu)
        arMenu.center = self.view.center
        
        arMenu.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        arMenu.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.arMenu.alpha = 1
            self.arMenu.transform = CGAffineTransform.identity
        }
    }

    
}
