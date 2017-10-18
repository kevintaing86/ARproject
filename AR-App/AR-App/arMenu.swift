//
//  arMenu.swift
//  AR-App
//
//  Created by Kevin Taing on 10/17/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import SpriteKit

class arMenu: SKScene {
    var randomButtonNode: SKSpriteNode!
    
    // similar to viewDidLoad but for SK
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.blue
        
        randomButtonNode = SKSpriteNode()
        randomButtonNode.anchorPoint = CGPoint(x: 0, y: 0)
        randomButtonNode.size = CGSize(width: 700, height: 220)
        self.addChild(randomButtonNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if self.nodes(at: location).first?.name == "randomButton" {
                self.removeFromParent()
            }
        }
    }
}
