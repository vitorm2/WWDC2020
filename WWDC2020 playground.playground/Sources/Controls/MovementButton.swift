//
//  MovementButton.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 11/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//

import SpriteKit

class MovementButton: SKSpriteNode {

    weak var gameManagerDelegate: GameManagerDelegate?
    
    var moveButton: SKShapeNode = SKShapeNode()
    var centerPoint: CGPoint = CGPoint()
    var beginPoint: CGPoint = CGPoint()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        
        let path =  CGMutablePath()
        path.addArc(center: CGPoint.zero, radius: ground_y_level * 0.5, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        moveButton = SKShapeNode(path: path)
        moveButton.fillColor = .black
        moveButton.alpha = 0.6
        moveButton.zPosition = 2
        
        let path2 =  CGMutablePath()
        path2.addArc(center: CGPoint.zero, radius: ground_y_level * 0.15, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        let centerMoveButtonNode = SKShapeNode(path: path2)
        centerMoveButtonNode.fillColor = .white
        centerMoveButtonNode.alpha = 0.4
        centerMoveButtonNode.zPosition = 2
        centerMoveButtonNode.name = "centerMoveButtonNode"
        moveButton.addChild(centerMoveButtonNode)
        
        centerPoint = moveButton.position
        
        self.addChild(moveButton)
    }
    
    func setGameManagerDelegate(gameManagerDelegate: GameManagerDelegate) {
        self.gameManagerDelegate = gameManagerDelegate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        beginPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
    
        let touchLocation = touch.location(in: self)
        
        if moveButton.path?.contains(touchLocation) ?? false  {
            self.moveButton.childNode(withName: "centerMoveButtonNode")?.position = touchLocation
        }
        
        if touchLocation.x > beginPoint.x { // RIGHT
            gameManagerDelegate?.moveRight(force: Double((scene?.size.height)!))
        } else if touchLocation.x < beginPoint.x { // LEFT
            gameManagerDelegate?.moveLeft(force: Double((scene?.size.height)!))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.moveButton.childNode(withName: "centerMoveButtonNode")?.position = centerPoint
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func distance(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
        return sqrt(pow(pointA.x, pointB.x) + pow(pointA.y, pointB.y))
    }
    
    
}


