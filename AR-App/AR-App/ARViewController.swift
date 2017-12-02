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
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var arScene: ARSCNView!
    @IBOutlet var arMenu: UIView!
    var capsuleLocation: CLLocation!
    var userLocation: CLLocation = CLLocation()
    var prevDistanceFromCapsule: Double!
    
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
        
        updateUserLocation(newLocation: nil)
    }
    
    @IBAction func openCapsule(_ sender: Any) {
        performSegue(withIdentifier: "toOpenCapsule", sender: nil)
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
    
    func updateUserLocation(newLocation: CLLocation?) {
        if let newUserLocation = newLocation {
            self.userLocation = newUserLocation
            setLocationLabelHints()
        }
        else {
            self.locationLabel.text = "Start moving!"
        }
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
    
    
    func setLocationLabelHints() {
        let distanceInMeters = userLocation.distance(from: capsuleLocation)
        
        if (distanceInMeters < 3) {
            locationLabel.text = "Ok! Start looking for it!"
            loadCapsule()
        }
        else if (distanceInMeters < prevDistanceFromCapsule) {
            locationLabel.text = "Getting warmer..."
        }
        else if (distanceInMeters > prevDistanceFromCapsule) {
            locationLabel.text = "Getting colder..."
        }
        
        else {
            locationLabel.text = "Keep moving!"
        }
        
        prevDistanceFromCapsule = distanceInMeters
    }
    
}
