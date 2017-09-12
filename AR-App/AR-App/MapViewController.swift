//
//  MapViewController.swift
//  AR-App
//
//  Created by Kevin Taing on 9/11/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocation(latitude: 33.5843, longitude: -101.8783)
        let regionRadius: CLLocationDistance = 1000
        
        centerMapAtLocation(location: location, with: regionRadius)

    }
    
    func centerMapAtLocation(location: CLLocation, with regionRadius: CLLocationDistance) {
        let coordinateLocation = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        self.mapView.setRegion(coordinateLocation, animated: true)
    }

}
