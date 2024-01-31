//
//  GameScene+infoSetup.swift
//  An Otter Universe
//
//  Created by rsbj on 25/01/24.
//

import SwiftUI
import SpriteKit

extension GameScene {
    func setupInfo() {
        let infoBg = SKSpriteNode(imageNamed: "InfoBackground")
        infoBg.position = CGPoint(x: frame.midX, y: frame.midY)
        info.addChild(infoBg)
        
        closeInfoButton = SKSpriteNode(imageNamed: "Close-Button")
        closeInfoButton.name = "Info"
        closeInfoButton.position = CGPoint(x: frame.maxX - 7 - closeInfoButton.size.width/2, y: frame.maxY - 7 - closeInfoButton.size.height/2)
        
        infoText = SKLabelNode(text: gameModel.infoText)
        infoText.fontName = "VT323-Regular"
        infoText.fontSize = 100
        infoText.setScale(0.1)
        infoText.fontColor = .black
        infoText.numberOfLines = 100
        infoText.preferredMaxLayoutWidth = 1800
        infoText.position = CGPoint(x: frame.midX, y: frame.midY-35)
        info.addChild(infoText)
        
        infoExit = SKSpriteNode(imageNamed: "Info-Exit")
        infoExit.setScale(1.3)
        infoExit.position = CGPoint(x: frame.midX + 60, y: frame.midY + 55)
        info.addChild(infoExit)
        
        infoRocket = SKSpriteNode(imageNamed: "Info-Rocket")
        infoRocket.setScale(1.3)
        infoRocket.position = CGPoint(x: frame.midX - 10, y: frame.midY + 15)
        info.addChild(infoRocket)
        
        infoInstruction1 = SKSpriteNode(imageNamed: "Screen-Arrow-Unactive-RIGHT")
        infoInstruction1.setScale(1.3)
        infoInstruction1.position = CGPoint(x: frame.minX + 55, y: frame.midY + 45)
        info.addChild(infoInstruction1)
        
        infoInstruction2 = SKSpriteNode(imageNamed: "Screen-Arrow-Unactive-UP")
        infoInstruction2.setScale(1.3)
        infoInstruction2.position = CGPoint(x: frame.minX + 80, y: frame.midY + 45)
        info.addChild(infoInstruction2)
        
        info.addChild(closeInfoButton)
        addChild(info)
        
        infoRock = SKSpriteNode(imageNamed: "Info-Rock")
        infoRock.setScale(1.3)
        infoRock.position = CGPoint(x: frame.midX, y: frame.midY - 55)
        info.addChild(infoRock)

        changeFilteringMode(info.children)
        
        let rocketDistanceX = infoExit.position.x - infoRocket.position.x
        let rocketDistanceY = infoExit.position.y - infoRocket.position.y
        let rocketFirstPosition = infoRocket.position
        
        
        infoRocket.run(SKAction.repeatForever(SKAction.sequence([
            moveInfoRocketToXAction(rocketDistanceX/3),
            moveInfoRocketToYAction(rocketDistanceY/2),
            moveInfoRocketToXAction((rocketDistanceX/3)*2),
            moveInfoRocketToYAction(rocketDistanceY),
            moveInfoRocketToXAction(rocketDistanceX),
            SKAction.wait(forDuration: animationTime),
            SKAction.move(to: rocketFirstPosition, duration: 0)])))
        
        infoInstruction1.run(SKAction.repeatForever(SKAction.animate(with: [
            TextureFiltered("Screen-Arrow-RIGHT"),
            TextureFiltered("Screen-Arrow-Unactive-RIGHT"),
            TextureFiltered("Screen-Arrow-RIGHT"),
            TextureFiltered("Screen-Arrow-Unactive-RIGHT"),
            TextureFiltered("Screen-Arrow-RIGHT"),
            TextureFiltered("Screen-Arrow-Unactive-RIGHT")], timePerFrame: animationTime)))
        infoInstruction2.run(SKAction.repeatForever(SKAction.animate(with: [
            TextureFiltered("Screen-Arrow-Unactive-UP"),
            TextureFiltered("Screen-Arrow-UP"),
            TextureFiltered("Screen-Arrow-Unactive-UP"),
            TextureFiltered("Screen-Arrow-UP"),
            TextureFiltered("Screen-Arrow-Unactive-UP"),
            TextureFiltered("Screen-Arrow-Unactive-UP")], timePerFrame: animationTime)))

        
        if (level == 0) {
            isInfoHidden = false
        }
        else {
            info.isHidden = true
        }
    }
    
    func moveInfoRocketToXAction(_ distance: CGFloat) -> SKAction {
        SKAction.moveTo(x: infoRocket.position.x + distance, duration: animationTime)
    }
    func moveInfoRocketToYAction(_ distance: CGFloat) -> SKAction {
        SKAction.moveTo(y: infoRocket.position.y + distance, duration: animationTime)
    }
}
