
import SpriteKit


enum FeedbackType {
    case successful
    case crashed
    case warning
}

class FeedbackNode: SKSpriteNode {
    
    var gameManagerDelegate: GameManagerDelegate?
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, feedbackType: FeedbackType){
        super.init(texture: texture, color: color, size: size)
        
        isUserInteractionEnabled = true
        
        var textureName = ""
        var buttonName = ""
        
        switch (feedbackType) {
        case .crashed:
            textureName = "appCrashed"
            buttonName = "tryAgainButton"
        case .warning:
            textureName = "appWarning"
            buttonName = "nextButton"
        case .successful:
            textureName = "appUpload"
            buttonName = "doneButton"
        }
        
        let backBackgroundNode = SKSpriteNode(texture: nil, color: .black, size: self.size)
        backBackgroundNode.zPosition = 7
        backBackgroundNode.alpha = 0.3
        backBackgroundNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(backBackgroundNode)
        
        
        let statusNode = SKSpriteNode(texture: SKTexture(imageNamed: textureName), size: CGSize(width: self.size.width * 0.6, height: self.size.height * 0.6))
        statusNode.zPosition = 8
        statusNode.position = CGPoint(x: self.frame.midX, y: statusNode.size.height * 0.2)
        self.addChild(statusNode)
        
        
        let button = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: self.size.width * 0.125, height: self.size.height * 0.05))
        button.zPosition = 8
        button.position = CGPoint(x: statusNode.size.width * 0.34, y: -(statusNode.size.height * 0.375))
        button.name = buttonName
        statusNode.addChild(button)
    }
    
    func setGameManagerDelegate(gameManagerDelegate: GameManagerDelegate) {
        self.gameManagerDelegate = gameManagerDelegate
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        guard let nodeName = touchedNode.name else { return }
        
        
        switch nodeName {
        case "tryAgainButton":
            self.removeFromParent()
            self.gameManagerDelegate?.restartScene()
        case "nextButton":
            self.removeFromParent()
            self.gameManagerDelegate?.newScene(enemyType: .viewController)
        case "doneButton":
            self.removeFromParent()
            self.gameManagerDelegate?.showFinalScene()
        default:
            break
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
