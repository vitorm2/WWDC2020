import PlaygroundSupport
import UIKit
import SpriteKit

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 1194, height: 834))

if let scene = InitialScene(fileNamed: "InitialScene") {

    scene.scaleMode = .aspectFit

    sceneView.presentScene(scene)
}


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

