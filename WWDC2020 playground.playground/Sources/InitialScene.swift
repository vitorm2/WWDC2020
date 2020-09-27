import SpriteKit

public var audioNode: SKAudioNode  = SKAudioNode(fileNamed: GameMusic.gameTheme.rawValue)
var backBackgroundNode: SKSpriteNode = SKSpriteNode()
var aboutNode: SKSpriteNode = SKSpriteNode()

public class InitialScene: SKScene {

    public override func didMove(to view: SKView) {
        
        self.backgroundColor = #colorLiteral(red: 0.1600896716, green: 0.1646011472, blue: 0.1861824989, alpha: 1)
        
        let backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "initialScene"), size: CGSize(width: self.size.width * 0.8, height: self.size.height * 0.8))
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(backgroundNode)
        
        addButtons()
    }
    
    
    func addButtons() {
        
        let playButton = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: self.size.width * 0.3, height: self.size.height * 0.085))
        playButton.position = CGPoint(x: self.size.width * 0.585, y: self.size.height * 0.835)
        playButton.anchorPoint = CGPoint(x: 0, y: 0.5)
        playButton.zPosition = 3
        playButton.name = "playButton"
        self.addChild(playButton)
        
        
        let aboutButton = SKSpriteNode(texture: nil, color: .clear, size: playButton.size)
        aboutButton.position = CGPoint(x: playButton.position.x, y: playButton.position.y - aboutButton.size.height)
        aboutButton.anchorPoint = CGPoint(x: 0, y: 0.5)
        aboutButton.zPosition = 3
        aboutButton.name = "aboutButton"
        self.addChild(aboutButton)
    }
    
    
    func showAboutNode() {
        
        backBackgroundNode = SKSpriteNode(texture: nil, color: .black, size: self.size)
        backBackgroundNode.zPosition = 3
        backBackgroundNode.alpha = 0.3
        backBackgroundNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(backBackgroundNode)
        
        aboutNode = SKSpriteNode(texture: SKTexture(imageNamed: "aboutNode"), size: CGSize(width: self.size.width * 0.7, height: self.size.height * 0.5) )
        aboutNode.zPosition = 4
        aboutNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(aboutNode)
        
        
        let closeButton = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: aboutNode.size.width * 0.275, height: aboutNode.size.height * 0.1))
        closeButton.position = CGPoint(x: (scene?.size.width)! * 0.225, y: -((scene?.size.height)! * 0.175))
        closeButton.name = "closeButton"
        aboutNode.addChild(closeButton)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        guard let nodeName = touchedNode.name else { return }
        
        if nodeName == "playButton" {
            
            
            if let gameScene = GameScene(fileNamed: "GameScene") {
                
                gameScene.addChild(audioNode)
                
                gameScene.enemyType = .storyboard
                gameScene.scaleMode = .aspectFit
                self.scene?.view?.presentScene(gameScene)
            }
 
        } else if nodeName == "aboutButton" {
            showAboutNode()
        } else if nodeName == "closeButton" {
            backBackgroundNode.removeFromParent()
            aboutNode.removeFromParent()
        }
    }



}
