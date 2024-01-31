//
//  PositionView.swift
//  An Otter Universe
//
//  Created by rsbj on 31/01/24.
//

import SwiftUI
import SpriteKit

struct PositionView: View {
    @Environment(\.presentationMode) var presentation
    var soundManager = SoundManager.shared
    let colors = Colors()
    
    var scene: SKScene {
        let scene = PositionScene()
        scene.size = CGSize(width: 2000, height: 2000)
        scene.scaleMode = .aspectFit
        return scene
    }
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(colors.DARKBLUE)
                .ignoresSafeArea()
            ZStack {
                VStack {
                    Text("This app was developed to be played in the Portrait, please make sure your IPad is in the correct position and click OK")
                        .font(Font(.init(.alertHeader, size: 35)))
                        .foregroundColor(colors.WHITE)
                        .padding(80)
                        .padding(.top, 100)
                    SpriteView(scene: scene)
                        .scaledToFit()
                    Button (action: {
                        soundManager.playTheme()
                        presentation.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Rectangle()
                                .stroke(colors.DARKBLUE, lineWidth: 10)
                                .background(colors.WHITE)
                            HStack {
                                Text("OK")
                                    .font(Font(.init(.alertHeader, size: 40)))
                                    .foregroundStyle(colors.DARKBLUE)
                            }
                        }
                    }.frame(maxWidth: 260,maxHeight: 100).padding(80)
                }
            }
    }
    }
}


class PositionScene: SKScene {
    let colors = Colors()
    var ipadNode = SKSpriteNode()
    var spriteSheetIpad = [SKTexture]()
    
    override func didMove(to view: SKView) {
        for i in 1...5 {
            let textureName = "rotateIpad\(i)"
            spriteSheetIpad.append(SKTexture(imageNamed: textureName))
        }
        backgroundColor = UIColor(colors.DARKBLUE)
        ipadNode = SKSpriteNode(texture: spriteSheetIpad[0], size: self.size)
        ipadNode.position = CGPoint(x: self.frame.midX, y: self.frame.midX)
        ipadNode.zRotation = .pi/2
        addChild(ipadNode)
        ipadNode.run(.repeatForever(.animate(with: spriteSheetIpad, timePerFrame: 0.7)))
    }
    
    
}
