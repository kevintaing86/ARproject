//
//  CustomPinAnnotation.swift
//  AR-App
//
//  Created by Kevin Taing on 9/23/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import UIKit
import MapKit

class CustomPinAnnotation: MKPinAnnotationView {
    var customCalloutView: AnnotationPopoverView?
    var calloutDelegate: AnnotationPopoverDelegate?
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.canShowCallout = false // this is to prevent the default MK bubble to show
        //self.image = UIImage(named: "PinIcon")!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.canShowCallout = false // this is to prevent the default MK bubble to show
        //self.image = UIImage(named: "PinIcon")!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.customCalloutView?.removeFromSuperview()
            
            if let newCalloutView = loadPopoverView() {
                newCalloutView.frame.origin.x -= newCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCalloutView.frame.origin.y -= newCalloutView.frame.height
                
                self.addSubview(newCalloutView)
                self.customCalloutView = newCalloutView
            }
            
            if animated {
                self.customCalloutView!.alpha = 0.0
                UIView.animate(withDuration: 0.1, animations: {
                    self.customCalloutView!.alpha = 1.0
                })
            }
            
        }
        else {
            if self.customCalloutView != nil {
                if animated {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let parentHitView = super.hitTest(point, with: event) { return parentHitView }
        else {
            if customCalloutView != nil {
                return customCalloutView!.hitTest(convert(point, to: customCalloutView!), with: event)
            } else { return nil }
        }
    }
    
    func loadPopoverView() -> AnnotationPopoverView? {
        if let views = Bundle.main.loadNibNamed("AnnotationPopoverView", owner: self, options: nil) as? [AnnotationPopoverView], views.count > 0 {
            let calloutView = views.first!
            if let geocache = annotation as? GeoCache {
                calloutView.locationLabel.text = geocache.title
                calloutView.delegate = self.calloutDelegate
            }
            
            return calloutView
        }
        
        return nil
    }
}
