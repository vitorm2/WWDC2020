//
//  EnemyAttacks.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 14/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//
import SpriteKit

enum EnemyAttackType {
    case errorTripleAttack
    case searchBarKamehamehaAttack
    case storyboardRainLeft
    case storyboardRainRight
    case xibMeteor
    case warningGroundAttack
    case restart
}

extension EnemyNode {
    
    func errorTripleAttack(){
        
        let numberProjectiles: Int = 3
        var projectileList: [SKSpriteNode] = []
        var projectileActions: [SKAction] = []
        
        
        var projectile: SKSpriteNode = SKSpriteNode()
        var verticalDistance: CGFloat = 0
        
        var projectileString = ""
        
        if enemyType == .storyboard { projectileString = "projectileError" }
        else { projectileString = "projectileMemoryLeak" }
        
        
        for _ in 0..<numberProjectiles {
            
            projectile = SKSpriteNode(texture: SKTexture(imageNamed: projectileString), color: .clear, size: CGSize(width: (self.scene?.size.width)! * 0.05, height: (self.scene?.size.width)! * 0.05))
            projectile.position = self.position
            projectile.zPosition = 2
            projectile.name = "projectileEnemy"
            
            projectileList.append(projectile)
            self.scene?.addChild(projectile)
            
            let actionMove = SKAction.move(to: CGPoint(x: 0, y:  ground_y_level + verticalDistance), duration: 1)
            let actionMoveDone = SKAction.removeFromParent()
            projectileActions.append(SKAction.sequence([actionMove, actionMoveDone]))
            
            verticalDistance += 250
        }
        
        for i in 0..<numberProjectiles {
            projectileList[i].run(projectileActions[i])
        }
        
        self.run(SoundManager.shared.playSound(gameSound: .enemyShot2))
        
    }
    
    
    func searchBarKamehamehaAttack(){
        
        let searchBarNode = SKSpriteNode(texture: nil, size: CGSize(width: (scene?.size.width ?? 100) * 0.75 , height: self.size.height * 0.6))
        
        searchBarNode.anchorPoint = CGPoint(x: 1, y: 0.7)
        searchBarNode.position = self.position
        searchBarNode.name = "projectileEnemyKamehameha"
        searchBarNode.zPosition = 4
        
        self.scene?.addChild(searchBarNode)
        
        let textures = self.getTextures(textureName: "searchBarAttack", numberOfTextures: 4)
        
        searchBarNode.run(SKAction.sequence([SKAction.repeat(
            SKAction.animate(with: textures,
                             timePerFrame: 0.075,
                             resize: false,
                             restore: false), count: 4), SKAction.removeFromParent()]))
        
        self.run(SoundManager.shared.playSound(gameSound: .enemyShot))
        
    }
    
    func storyboardRain(rainType: EnemyAttackType) {
        let numberProjectiles: Int = 8
        var projectileList: [SKSpriteNode] = []
        var projectileActions: [SKAction] = []
        
        var projectile: SKSpriteNode = SKSpriteNode()
        
        var horizontalDistance: CGFloat = 0

        if rainType == .storyboardRainLeft {
            horizontalDistance = (scene?.size.width)! * 0.05
        } else if rainType == .storyboardRainRight {
            horizontalDistance = (scene?.size.width)! * 0.15
        }
        
        var projectileString = ""
        
        if enemyType == .storyboard { projectileString = "projectileStoryboard" }
        else { projectileString = "projectileSwift" }
        
            // Create projectiles
            for _ in 0..<numberProjectiles {
                
                projectile = SKSpriteNode(texture: SKTexture(imageNamed: projectileString), color: .clear, size: CGSize(width: self.size.height * 0.1, height: self.size.height * 0.1))
                projectile.position = CGPoint(x: horizontalDistance, y: scene?.size.height ?? 100)
                projectile.zPosition = 2
                projectile.name = "projectileEnemy"
                
                projectileList.append(projectile)
                self.scene?.addChild(projectile)
                
                let actionMove = SKAction.move(to: CGPoint(x: projectile.position.x, y: projectile.position.y - (scene?.size.height ?? 100)), duration: 1)
                let actionMoveDone = SKAction.removeFromParent()
                projectileActions.append(SKAction.sequence([actionMove, actionMoveDone]))
                
                horizontalDistance += (scene?.size.width)! * 0.15
            }
            
            // Run projectile Actions
            for i in 0..<numberProjectiles {
                projectileList[i].run(projectileActions[i])
            }
        
        self.run(SoundManager.shared.playSound(gameSound: .enemyShot2))
           
        }
    
    func xibMeteor(){
        
        var projectileString = ""
        
        if enemyType == .storyboard { projectileString = "projectileXib" }
        else { projectileString = "" }
        
        let xibMeteor = SKSpriteNode(texture: SKTexture(imageNamed: projectileString), size: CGSize(width: (scene?.size.height)! * 0.3, height:  (scene?.size.height)! * 0.3))
        
        xibMeteor.position = CGPoint(x: (scene?.size.height)! + xibMeteor.size.height/2, y: (scene?.size.height)!)
        xibMeteor.zPosition = 2
        xibMeteor.name = "projectileEnemyMeteor"
        self.scene?.addChild(xibMeteor)
        
        let actionMove = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 1)
        let actionMoveDone = SKAction.removeFromParent()
        xibMeteor.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        self.run(SoundManager.shared.playSound(gameSound: .enemyShot))
        
    }
    
    func warningGroundAttack() {
        
        var projectileString = ""
        
        if enemyType == .storyboard { projectileString = "projectileWarning" }
        else { projectileString = "projectileInfoplist" }
        
        let warningNode = SKSpriteNode(texture: SKTexture(imageNamed: projectileString), color: .clear, size: CGSize(width: (self.scene?.size.width)! * 0.05, height: (self.scene?.size.width)! * 0.05))
        warningNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        warningNode.position = CGPoint(x: self.position.x, y: self.position.y - (self.size.height/2) + warningNode.size.height/2)
        warningNode.zPosition = 2
        warningNode.name = "projectileEnemy"
        
        self.scene?.addChild(warningNode)
        
        let actionMove = SKAction.move(to: CGPoint(x: warningNode.position.x - (scene?.size.height)!, y: warningNode.position.y), duration: 1)
        let actionMoveDone = SKAction.removeFromParent()
        warningNode.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        self.run(SoundManager.shared.playSound(gameSound: .enemyShot2))
        
    }
    
    
    
}
