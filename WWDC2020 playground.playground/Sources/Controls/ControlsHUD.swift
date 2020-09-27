//
//  ControlsHUD.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 11/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//

import SpriteKit

class ControlsHUD: SKSpriteNode {
    
    weak var gameManagerDelegate: GameManagerDelegate?
    var movimentButton: MovementButton!

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true // Set the HUD touchable
    
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.name = "ControlsHUD"
        
        self.movimentButton = MovementButton()
        movimentButton.position = CGPoint(x: size.width * 0.1, y: movimentButton.frame.height/2 + size.height * 0.15)
        addChild(movimentButton)
        addAttackButtons()
    }
    
    func setGameManagerDelegate(gameManagerDelegate: GameManagerDelegate) {
        self.gameManagerDelegate = gameManagerDelegate
        movimentButton.setGameManagerDelegate(gameManagerDelegate: gameManagerDelegate)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        guard let nodeName = touchedNode.name else { return }
        
        switch nodeName {
        case "attackButton":
            gameManagerDelegate?.attack()
            self.run(SoundManager.shared.playSound(gameSound: .shot))
        case "specialAttackButton":
            gameManagerDelegate?.throwAttack()
            self.run(SoundManager.shared.playSound(gameSound: .shot2))
        case "jumpButton":
            gameManagerDelegate?.jump(impulseForce: Double((scene?.size.height)! * 0.9))
        default:
            break
        }
    }
    
    
    func addAttackButtons(){
        
        let path =  CGMutablePath()
        path.addArc(center: CGPoint.zero, radius: ground_y_level * 0.4, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        let attackButton = SKShapeNode(path: path)
        attackButton.fillColor = .black
        attackButton.alpha = 0.6
        attackButton.zPosition = 2
        attackButton.position = CGPoint(x: size.width * 0.9, y: attackButton.frame.height/2)
        attackButton.name = "attackButton"
        self.addChild(attackButton)
        
        let path2 =  CGMutablePath()
        path2.addArc(center: CGPoint.zero, radius: ground_y_level * 0.3, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        let specialAttackButton = SKShapeNode(path: path2)
        specialAttackButton.fillColor = .black
        specialAttackButton.alpha = 0.6
        specialAttackButton.zPosition = 2
        specialAttackButton.position = CGPoint(x: size.width * 0.9, y: specialAttackButton.frame.height/2 + size.height * 0.4)
        specialAttackButton.name = "specialAttackButton"
        self.addChild(specialAttackButton)
        
        let jumpButton = SKShapeNode(path: path2)
        jumpButton.fillColor = .black
        jumpButton.alpha = 0.6
        jumpButton.zPosition = 2
        jumpButton.position = CGPoint(x: attackButton.position.x - (attackButton.frame.width), y: jumpButton.frame.height * 0.6)
        jumpButton.name = "jumpButton"
        self.addChild(jumpButton)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
