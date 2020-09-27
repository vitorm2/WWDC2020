//
//  GameScene.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 11/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//

import SpriteKit

protocol GameManagerDelegate: class {
    func moveLeft(force: Double)
    func moveRight(force: Double)
    func jump(impulseForce: Double)
    func attack()
    func throwAttack()
    func restartScene()
    func newScene(enemyType: EnemyType)
    func showFinalScene()
}

enum EnemyType{
    case storyboard
    case viewController
}

var ground_y_level: CGFloat = 0.0

class GameScene: SKScene {
    
    var enemyType: EnemyType = .storyboard
    
    var backgroundNode: SKSpriteNode = SKSpriteNode()
    var playerNode: PlayerNode = PlayerNode()
    var enemyNode: EnemyNode?
    var playerStatusBar: StatusBar?
    var enemyStatusBar: StatusBar?
    
    var mapImageString = ""
    var enemyString = ""
    
    override func didMove(to view: SKView) {
        
        ground_y_level = self.size.height * 0.21
        
        physicsWorld.gravity = CGVector(dx:0 , dy: -9.8)
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: ground_y_level, width: frame.size.width, height: frame.height - self.size.height * 0.21))
        
        
        createBackground()
        addControlsHUD()
        setStatusBar()
        addPlayer()
        addEnemy()
        
    }
    
    func createBackground(){
        if enemyType == .viewController {
            mapImageString = "background1"
            enemyString = "viewControllerBoss"
        } else {
            mapImageString = "background2"
            enemyString = "storyBoardBoss"
        }
        
        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: mapImageString), size: self.size)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(backgroundNode)
    }
    
    func addControlsHUD(){
        
        let controlsHUDSize = CGSize(width: self.size.width, height: self.size.height * 0.5)
        let controlsHUD = ControlsHUD(texture: nil, color: .clear, size: controlsHUDSize)
        controlsHUD.position = CGPoint(x: 0, y: frame.midY * 0.2)
        controlsHUD.zPosition = 5
        controlsHUD.setGameManagerDelegate(gameManagerDelegate: self)
        self.addChild(controlsHUD)
    }
    
    func setStatusBar(){
        playerStatusBar = StatusBar(texture: SKTexture(imageNamed: "playerStatusBar"), color: .clear, size: CGSize(width: self.size.width * 0.2, height: self.size.width * 0.08), type: .player, iconTextureName: "playerIcon")
        playerStatusBar?.zPosition = 2
        playerStatusBar?.position = CGPoint(x: self.size.width * 0.01 + ((playerStatusBar?.size.width)!/2), y: self.size.height - ((playerStatusBar?.size.height)!/2))
        self.addChild(playerStatusBar ?? SKSpriteNode())
        
        
        var iconString = ""
        if enemyType == .storyboard { iconString = "enemyIcon" }
        else { iconString = "enemy2Icon" }
        
        enemyStatusBar = StatusBar(texture: SKTexture(imageNamed: "enemyStatusBar"), color: .clear, size: CGSize(width: self.size.width * 0.2, height: self.size.width * 0.08), type: .enemy, iconTextureName: iconString)
        enemyStatusBar?.zPosition = 2
        enemyStatusBar?.position = CGPoint(x: self.size.width * 0.99 - ((enemyStatusBar?.size.width)!/2), y: self.size.height - ((enemyStatusBar?.size.height)!/2))
        self.addChild(enemyStatusBar ?? SKSpriteNode())
        
    }
    
    func addPlayer(){
        
        let playerSize = CGSize(width: self.size.width * 0.04, height: self.size.height * 0.075)
        playerNode = PlayerNode(texture: SKTextureAtlas(named: "idle").textureNamed("idle1"), size: playerSize)
        playerNode.position = CGPoint(x: self.size.width * 0.1, y: ground_y_level + 1)
        playerNode.zPosition = 5
        playerNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerNode.size.width, height: playerNode.size.height))
        playerNode.physicsBody?.mass = CGFloat((scene?.size.height)! * 0.0008)
        playerNode.physicsBody?.affectedByGravity = true
        
        self.addChild(playerNode)
    }
    
    func addEnemy() {
        let enemySize = CGSize(width: self.size.width * 0.275, height: self.size.height * 0.55)
        enemyNode = EnemyNode(texture: SKTexture(imageNamed: enemyString), color: .clear, size: enemySize, enemyType: enemyType, enemyBehavior: EnemyBehavior(enemyType: enemyType))
        enemyNode?.position = CGPoint(x: self.size.width * 0.8, y: ground_y_level + scene!.size.height * 0.265)
        enemyNode?.zPosition = 3
        enemyNode?.name = "enemyNode"
        
        self.addChild(enemyNode ?? SKSpriteNode())
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        enemyNode?.updateEnemy()
        
        for node in self.children {
            if node.name == "projectilePlayer" && enemyNode!.contains(node.position) {
                node.removeFromParent()
                enemyNode?.receiveDamage(damage: 1)
                
                if enemyNode!.life == 0 {
                    if enemyType == .storyboard {
                        feedbackWonOrLose(feedbackType: .warning)
                    } else {
                        feedbackWonOrLose(feedbackType: .successful)
                    }
                    enemyStatusBar?.updateHealthBars(lifePercente: 0)
                } else if enemyNode!.life <= 10 && enemyNode!.life > 1 {
                    enemyStatusBar?.updateHealthBars(lifePercente: 10)
                } else {
                    enemyStatusBar?.updateHealthBars(lifePercente: Int(enemyNode!.life))
                }
                
            } else if node.name?.contains("projectileEnemy") ?? false && node.contains(playerNode.position) {
                
                switch node.name {
                case "projectileEnemyKamehameha":
                    playerNode.receiveDamage(damage: 0.25)
                case "projectileEnemyMeteor":
                    playerNode.receiveDamage(damage: 20.0)
                    node.removeFromParent()
                default:
                    playerNode.receiveDamage(damage: 10.0)
                    node.removeFromParent()
                }
                
                if playerNode.life == 0 {
                    playerStatusBar?.updateHealthBars(lifePercente: 0)
                    feedbackWonOrLose(feedbackType: .crashed)
                } else if playerNode.life <= 10 && playerNode.life > 1 {
                    playerStatusBar?.updateHealthBars(lifePercente: 10)
                } else {
                    playerStatusBar?.updateHealthBars(lifePercente: Int(playerNode.life))
                }
                
                
            }
        }
    }
    
    func feedbackWonOrLose(feedbackType: FeedbackType) {
        
        self.scene?.isPaused = true
        
        let feedbackNode = FeedbackNode(texture: nil, color: .clear, size: self.size, feedbackType: feedbackType)
        feedbackNode.setGameManagerDelegate(gameManagerDelegate: self)
        feedbackNode.zPosition = 6
        feedbackNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(feedbackNode)
        
    }
}

extension GameScene: GameManagerDelegate {
    
    
    func moveLeft(force: Double) {
        playerNode.moveLeft(force: force)
    }
    
    func moveRight(force: Double) {
        playerNode.moveRight(force: force)
    }
    
    func jump(impulseForce: Double) {
        playerNode.jump(impulseForce: impulseForce)
    }
    
    func attack() {
        playerNode.attack()
    }
    
    func throwAttack() {
        playerNode.throwAttack()
    }
    
    
    func newScene(enemyType: EnemyType) {
        self.enemyType = enemyType
        
        backgroundNode.removeFromParent()
        playerNode.removeFromParent()
        enemyNode?.removeFromParent()
        playerStatusBar?.removeFromParent()
        enemyStatusBar?.removeFromParent()
        
        createBackground()
        setStatusBar()
        addPlayer()
        addEnemy()
        
        scene?.isPaused = false
    }
    
    func restartScene() {
        playerNode.removeFromParent()
        enemyNode?.removeAllActions()
        enemyNode?.removeFromParent()
        playerStatusBar?.removeFromParent()
        enemyStatusBar?.removeFromParent()
        
        setStatusBar()
        addPlayer()
        addEnemy()
        
        scene?.isPaused = false
    }
    
    func showFinalScene() {
        
        self.removeAllChildren()
        
        guard let view = view else { return }
        let initialScene = InitialScene(size: view.bounds.size)
        
        audioNode.removeFromParent()
        
        initialScene.scaleMode = .aspectFit
        self.scene?.view?.presentScene(initialScene)
    }
}
