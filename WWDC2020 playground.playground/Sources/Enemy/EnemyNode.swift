//
//  EnemyNode.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 13/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//

import SpriteKit

enum EnemyPosition {
    case left
    case right
}

class EnemyNode: SKSpriteNode {
    
    var enemyType: EnemyType
    var update: Int = 0
    var enemyBehavior: EnemyBehavior
    var life: Double = 100
    var enemyPositon: EnemyPosition = .right
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, enemyType: EnemyType, enemyBehavior: EnemyBehavior) {
        self.enemyType = enemyType
        self.enemyBehavior = enemyBehavior
        super.init(texture: texture, color: color, size: size)
        animateIdle()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIdle(){
        
        var textureString = ""
        var numberOfTextures = 0
        
        if enemyType == .storyboard {
            textureString = "storyBoardBoss"
            numberOfTextures = 4
        } else {
            textureString = "viewControllerBoss"
            numberOfTextures = 8
        }
        
        let textures = self.getTextures(textureName: textureString, numberOfTextures: numberOfTextures)
        
        self.run(SKAction.repeatForever(
            SKAction.animate(with: textures,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: false)))
    }
    
    func receiveDamage(damage: Double) {
        
        self.run(SoundManager.shared.playSound(gameSound: .enemyDamage))
        
        if (life - damage) <= 0 {
            life = 0
        } else {
            life -= damage
        }
        
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.1)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.15)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        self.run(blink)
    }
    
    func updateEnemy(){
        
        update += 1
        
        if enemyBehavior.dic[update] != nil {
            
            switch enemyBehavior.dic[update] {
            case .errorTripleAttack:
                self.errorTripleAttack()
            case .searchBarKamehamehaAttack:
                self.searchBarKamehamehaAttack()
            case .storyboardRainLeft:
                self.storyboardRain(rainType: .storyboardRainLeft)
            case .storyboardRainRight:
                self.storyboardRain(rainType: .storyboardRainRight)
            case .xibMeteor:
                self.xibMeteor()
            case .warningGroundAttack:
                self.warningGroundAttack()
            case .restart:
                self.update = 0
            case .none:
                break
            }
        }
            
    }
    
    
}
