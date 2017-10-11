//
//  Capsule.swift
//  AR-App
//
//  Created by Kevin Taing on 10/7/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import ARKit

class Capsule: SCNNode {
    func loadModal() {
        guard let virtualObjectScene = SCNScene(named: "capsule.scn") else { print("modal broke"); return }
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
    }
}
