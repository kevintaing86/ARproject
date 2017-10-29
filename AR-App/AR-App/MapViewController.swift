//
//  MapViewController.swift
//  AR-App
//
//  Created by Kevin Taing on 9/11/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//
//  NOTE: The mapDelegate is stored in the extension group

import UIKit
import MapKit
import CoreLocation

// This is used to send user location data to another view controller
protocol UserLocationDelegate: class {
    func updateUserLocation(newLocation: CLLocation)
}

class MapViewController: UIViewController, AnnotationPopoverDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    var arDelegate: UserLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        
        // configure user location manager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // configure test location for the TTU comp sci building
        let regionRadius: CLLocationDistance = 500
        let geocache = GeoCache(title: "CS Building", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: 33.5875, longitude: -101.8757))
        
        mapView.showsUserLocation = true
        mapView.addAnnotation(geocache)
        centerMapAtLocation(location: userLocation, with: regionRadius)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toARView"){
            self.arDelegate = segue.destination as! ARViewController
            
            (segue.destination as! ARViewController).capsuleLocation = CLLocation(latitude: CLLocationDegrees(33.5875), longitude: CLLocationDegrees(-101.8757))
            
            (segue.destination as! ARViewController).prevDistanceFromCapsule = self.userLocation.distance(from: CLLocation(latitude: CLLocationDegrees(33.5875), longitude: CLLocationDegrees(-101.8757)))
        }
    }
    
    func centerMapAtLocation(location: CLLocation, with regionRadius: CLLocationDistance) {
        let coordinateLocation = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        self.mapView.setRegion(coordinateLocation, animated: true)
    }
    
    func goButtonClicked() {
        self.performSegue(withIdentifier: "toARView", sender: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        self.userLocation = currentLocation
        
        self.arDelegate?.updateUserLocation(newLocation: currentLocation)
    }
}
