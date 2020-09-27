//
//  HealthBarsNode.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 14/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//

import SpriteKit

class HealthBarsNode: SKSpriteNode {
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: StatusBarType, lifePercent: Int) {
        super.init(texture: texture, color: color, size: size)
        
        let separatorPercent: CGFloat = 0.105
        var initialPosition: CGFloat = 0
        let numberOfNodes = lifePercent/10
        let barWidth = (self.size.width / 10) - self.size.width * 0.02
        
        switch type {
        case .enemy:
            initialPosition = size.width * 0.975
            
            for _ in 0..<numberOfNodes {
                let healthNode = SKSpriteNode(texture: SKTexture(imageNamed: "enemyLifeNode"), size: CGSize(width: barWidth, height: self.size.height))
                healthNode.position = CGPoint(x: initialPosition - (self.size.width/2), y: 0)
                addChild(healthNode)
                initialPosition -= self.size.width * separatorPercent
            }
        case .player:
            initialPosition = size.width * 0.025
            
            for _ in 0..<numberOfNodes {
                let healthNode = SKSpriteNode(texture: SKTexture(imageNamed: "playerLifeNode"), size: CGSize(width: barWidth, height: self.size.height))
                healthNode.position = CGPoint(x: initialPosition - (self.size.width/2), y: 0)
                addChild(healthNode)
                initialPosition += self.size.width * separatorPercent
            }
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
