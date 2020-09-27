import SpriteKit

enum GameMusic: String {
    case gameTheme = "gameTheme.mp3"
}

enum GameSound: String {
    case shot = "shot.wav"
    case shot2 = "shot2.wav"
    case playerDamage = "playerDamage.wav"
    case enemyDamage = "enemyDamage.mp3"
    case enemyShot = "enemyShot.mp3"
    case enemyShot2 = "enemyShot2.wav"
    case jump = "jump.wav"
}

class SoundManager {
    
    static let shared = SoundManager()
    
    
    func playSound(gameSound: GameSound) -> SKAction {
        return SKAction.playSoundFileNamed(gameSound.rawValue, waitForCompletion: true)
    }
    
    func playMusic(gameMusic: GameMusic) -> SKAction {
        return SKAction.repeat(SKAction.playSoundFileNamed(gameMusic.rawValue, waitForCompletion: false), count: 2)
    }
    
}

