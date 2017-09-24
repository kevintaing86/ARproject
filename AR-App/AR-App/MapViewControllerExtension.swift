//
//  MapViewControllerExtension.swift
//  AR-App
//
//  Created by Kevin Taing on 9/16/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let visibleRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
        self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {return nil}
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        
        if annotationView == nil {
            annotationView = CustomPinAnnotation(annotation: annotation, reuseIdentifier: "pin")
            (annotationView as! CustomPinAnnotation).calloutDelegate = self
        }
        else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}










