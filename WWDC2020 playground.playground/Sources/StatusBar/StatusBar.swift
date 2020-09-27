//
//  StatusBar.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 14/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//

import SpriteKit

enum StatusBarType {
    case player
    case enemy
}

class StatusBar: SKSpriteNode {
    
    var statusBarType: StatusBarType
    var healthBarsNode: HealthBarsNode?
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: StatusBarType, iconTextureName: String) {
        statusBarType = type
        
        super.init(texture: texture, color: color, size: size)
        
        var iconNode: SKSpriteNode = SKSpriteNode()
        
        switch statusBarType {
        case .enemy:
            
            iconNode = SKSpriteNode(texture: SKTexture(imageNamed: iconTextureName), size: CGSize(width: self.size.height * 0.3, height: self.size.height * 0.3))
            iconNode.position = CGPoint(x: (self.size.width * 0.33), y: self.frame.midY)
            iconNode.zPosition = 3
            self.addChild(iconNode)
        case .player:
            iconNode = SKSpriteNode(texture: SKTexture(imageNamed: iconTextureName), size: CGSize(width: self.size.height * 0.3, height: self.size.height * 0.3))
            iconNode.position = CGPoint(x: -(self.size.width * 0.33), y: self.frame.midY)
            iconNode.zPosition = 3
            self.addChild(iconNode)
        }
        
        updateHealthBars(lifePercente: 100)
    }
    
    func updateHealthBars(lifePercente: Int) {
        
        healthBarsNode?.removeFromParent()
        healthBarsNode = HealthBarsNode(texture: nil, color: .clear, size: CGSize(width: self.size.width * 0.6, height: self.size.height * 0.35), type: statusBarType, lifePercent: lifePercente)
        
        if statusBarType == .player {
            healthBarsNode?.position = CGPoint(x: self.size.width  * 0.0875, y: 0)
        } else {
            healthBarsNode?.position = CGPoint(x: -(self.size.width  * 0.0875), y: 0)
        }
        
        healthBarsNode?.zPosition = 3
        self.addChild(healthBarsNode ?? SKSpriteNode())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
