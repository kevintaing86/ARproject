//
//  AnnotationPopoverView.swift
//  AR-App
//
//  Created by Kevin Taing on 9/23/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import UIKit

protocol AnnotationPopoverDelegate: class {
    func goButtonClicked()
}

class AnnotationPopoverView: UIView {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    var delegate: AnnotationPopoverDelegate?
    
    @IBAction func goButtonClicked(_ sender: Any) {
        self.delegate?.goButtonClicked()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
