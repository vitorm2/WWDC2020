//
//  PlayerNode.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 11/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//

import SpriteKit

public class PlayerNode: SKSpriteNode {
    
    
    var life: Double = 100
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        animateIdle()
    
    }
    
    func animateIdle(){
        let textures = self.getTextures(textureName: "idle", numberOfTextures: 1)
        
        self.run(SKAction.repeatForever(
            SKAction.animate(with: textures,
                             timePerFrame: 0.5,
                             resize: false,
                             restore: false)))
    }
    
    func receiveDamage(damage: Double) {
        
        
        if self.action(forKey: GameSound.playerDamage.rawValue) == nil {
            self.run(SoundManager.shared.playSound(gameSound: .playerDamage), withKey: GameSound.playerDamage.rawValue)
        }
        
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
    
    func moveLeft(force: Double){
        self.physicsBody?.applyForce(CGVector(dx: -(force), dy: 0))
        
    
        
         let player_y_position = self.position.y - (self.size.height/2)
        
        if (player_y_position) < (ground_y_level + 10) && (player_y_position) > (ground_y_level - 3) && (self.action(forKey: "moveLeft") == nil) {
            let textures = self.getTextures(textureName: "run", numberOfTextures: 9)
            
            let runAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
            self.run(runAnimation, withKey: "moveLeft")
        }
    }
    
    func moveRight(force: Double){
        
        self.physicsBody?.applyForce(CGVector(dx: force, dy: 0))
        
        let player_y_position = self.position.y - (self.size.height/2)
        
        if (player_y_position) < (ground_y_level + 10) && (player_y_position) > (ground_y_level - 3) && (self.action(forKey: "moveRight") == nil) {
            let textures = self.getTextures(textureName: "run", numberOfTextures: 9)
            
            let runAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
            self.run(runAnimation, withKey: "moveRight")
        }
        
        
    }
    
    func jump(impulseForce: Double){
        let player_y_position = self.position.y - (self.size.height/2)
        
        if (player_y_position) < (ground_y_level * 1.5) && (player_y_position) > (ground_y_level - 3) {
            self.physicsBody?.applyImpulse(CGVector(dx:0 , dy: impulseForce))
            
            
            self.run(SoundManager.shared.playSound(gameSound: .jump))
            let textures = self.getTextures(textureName: "jump", numberOfTextures: 8)
            
            let runAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
            self.run(runAnimation)
        }
    }
    
    func attack(){
        let textures = self.getTextures(textureName: "attack", numberOfTextures: 5)
        
        let runAnimation = SKAction.animate(with: textures, timePerFrame: 0.05)
        self.run(runAnimation)
        
        shotSimulatorProjectile()
    }
    
    func throwAttack(){
        let textures = self.getTextures(textureName: "throw", numberOfTextures: 8)
        
        let runAnimation = SKAction.animate(with: textures, timePerFrame: 0.05)
        self.run(runAnimation)
        
        shotBuildProjectile()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func shotBuildProjectile(){
        
        let projectile = SKSpriteNode(texture: SKTexture(imageNamed: "projectileBuild"), color: .clear, size: self.size)
        projectile.position = self.position
        projectile.zPosition = 2
        projectile.name = "projectilePlayer"
        
        self.scene?.addChild(projectile)
        
        let actionMove = SKAction.move(to: CGPoint(x: scene!.size.width, y: self.position.y), duration: 0.75)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func shotSimulatorProjectile(){
        
        let projectile = SKSpriteNode(texture: SKTexture(imageNamed: "projectileSimulator"), color: .clear, size: self.size)
        projectile.position = self.position
        projectile.zPosition = 2
        projectile.name = "projectilePlayer"
        
        self.scene?.addChild(projectile)
        
        let actionMove = SKAction.move(to: CGPoint(x: scene!.size.width, y: self.position.y), duration: 0.75)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
}


extension SKSpriteNode {
    
    func getTextures(textureName: String, numberOfTextures: Int) -> [SKTexture] {
        var frames: [SKTexture] = []
        
        for i in 1...numberOfTextures {
            let textureName = "\(textureName)\(i)"
            frames.append(SKTexture(imageNamed: textureName))
        }
        
        return frames
    }
}
