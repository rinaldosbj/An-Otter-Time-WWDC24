//
//  GameSceneView.swift
//  An Otter Universe
//
//  Created by rsbj on 23/01/24.
//

import SwiftUI
import SpriteKit

struct GameSceneView: View {
    
    var level: Int
    var gameModel: GameModel
    
    var sceneSize = CGSize(width: 250, height: 302)
    
    var scene: SKScene
    
    init(level: Int, gameModel: GameModel, won: Binding<Bool>) {
        self.level = level
        self.gameModel = gameModel
        
        let scene = GameScene(size: sceneSize, level: level, gameModel: gameModel, won: won)
        scene.scaleMode = .aspectFit
        self.scene = scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .aspectRatio(sceneSize.width/sceneSize.height, contentMode: .fit)
            .padding(20)
    }
}

