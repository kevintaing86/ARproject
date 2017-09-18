//
//  Location.swift
//  AR-App
//
//  Created by Kevin Taing on 9/13/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import Foundation
import MapKit

class GeoCache : NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
