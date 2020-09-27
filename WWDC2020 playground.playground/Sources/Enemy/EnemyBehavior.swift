//
//  EnemyBehavior.swift
//  WWDC2020
//
//  Created by Vitor Demenighi on 14/05/20.
//  Copyright © 2020 Vitor Demenighi. All rights reserved.
//

import Foundation


class EnemyBehavior {
    var dic: [Int : EnemyAttackType] = [:]
    
    init(enemyType: EnemyType) {
        
        if enemyType == .storyboard {
        
            dic[140] = .errorTripleAttack
            dic[165] = .errorTripleAttack
            dic[190] = .errorTripleAttack
            
            dic[300] = .errorTripleAttack
            dic[325] = .errorTripleAttack
            dic[350] = .errorTripleAttack
            
            dic[450] = .storyboardRainLeft
            dic[500] = .storyboardRainRight
            dic[550] = .storyboardRainLeft
            dic[600] = .storyboardRainRight
            
            dic[800] = .searchBarKamehamehaAttack
            dic[1000] = .searchBarKamehamehaAttack
            
            dic[1200] = .errorTripleAttack
            dic[1250] = .errorTripleAttack
            dic[1300] = .errorTripleAttack
            
            dic[1400] = .warningGroundAttack
            dic[1410] = .warningGroundAttack
            dic[1420] = .warningGroundAttack
            
            dic[1450] = .warningGroundAttack
            dic[1460] = .warningGroundAttack
            dic[1470] = .warningGroundAttack
            
            dic[1650] = .xibMeteor
            
            dic[1700] = .restart
            
        } else {
            
            dic[50] = .errorTripleAttack
            dic[75] = .errorTripleAttack
            dic[100] = .errorTripleAttack
            
            dic[125] = .storyboardRainLeft
            dic[150] = .storyboardRainRight
            
            dic[200] = .errorTripleAttack
            dic[225] = .errorTripleAttack
            dic[250] = .errorTripleAttack
            
            dic[450] = .xibMeteor
            
            dic[525] = .warningGroundAttack
            dic[535] = .warningGroundAttack
            dic[545] = .warningGroundAttack
            
            dic[575] = .warningGroundAttack
            dic[585] = .warningGroundAttack
            dic[595] = .warningGroundAttack
            
            dic[700] = .xibMeteor
            dic[750] = .xibMeteor
            
            dic[800] = .storyboardRainLeft
            dic[850] = .storyboardRainRight
            dic[900] = .storyboardRainLeft
            dic[950] = .storyboardRainRight
        
            
            dic[1000] = .errorTripleAttack
            dic[1050] = .errorTripleAttack
            dic[1100] = .errorTripleAttack
            
            dic[1250] = .errorTripleAttack
            dic[1275] = .errorTripleAttack
            dic[1300] = .errorTripleAttack
            
            dic[1500] = .restart
            
        }
    }
}
