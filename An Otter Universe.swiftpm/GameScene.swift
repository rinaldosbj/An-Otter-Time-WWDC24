//
//  GameScene.swift
//  An Otter Universe
//
//  Created by rsbj on 09/01/24.
//

import SwiftUI
import SpriteKit

enum Directions : String {
    case LEFT,RIGHT,UP,DOWN
}

class GameScene: SKScene {
    var level: Int
    var gameModel: GameModel
    
    var grid = SKSpriteNode()
    var rocket = SKSpriteNode()
    
    var right = SKSpriteNode()
    var left = SKSpriteNode()
    var up = SKSpriteNode()
    var down = SKSpriteNode()
    
    var startSimulationButton = SKSpriteNode()
    var undoButton = SKSpriteNode()
    var infoButton = SKSpriteNode()
    
    var closeInfoButton = SKSpriteNode()
    var info = SKSpriteNode()
    var infoRocket = SKSpriteNode()
    var infoInstruction1 = SKSpriteNode()
    var infoInstruction2 = SKSpriteNode()
    var infoExit = SKSpriteNode()
    var infoText = SKLabelNode()
    var infoRock = SKSpriteNode()
    
    var moveSequence: [String] = []
    
    var isMoving = false;
    var startPosition = CGPoint()
    
    var instruction1 = SKSpriteNode()
    var instruction2 = SKSpriteNode()
    var instruction3 = SKSpriteNode()
    var instruction4 = SKSpriteNode()
    
    var animationTime = 0.4
    
    var exit = SKSpriteNode()
    
    var lost = false
    var isInfoHidden = true
    
    @Binding var won: Bool
    
    public init(size: CGSize,level: Int, gameModel: GameModel, won: Binding<Bool>){
        self.level = level
        self.gameModel = gameModel
        _won = won
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isMoving) {
            for touch: UITouch in touches {
                let location = touch.location(in: self)
                let touchedNode = atPoint(location)
                let nodeName = touchedNode.name
                
                switch nodeName {
                case Directions.RIGHT.rawValue:
                    clickedDirection(nodeName!, node: right)
                case Directions.LEFT.rawValue:
                    clickedDirection(nodeName!, node: left)
                case Directions.UP.rawValue:
                    clickedDirection(nodeName!, node: up)
                case Directions.DOWN.rawValue:
                    clickedDirection(nodeName!, node: down)
                case "Info":
                    isInfoHidden.toggle()
                default: break
                }
                
                if (moveSequence.count > 0) {
                    startAndUndoAreEnable(true)
                    
                    if (nodeName == "Start") {
                        clickedButton(startSimulationButton, image: "Simulate")
                        isMoving = true
                        rocket.run(SKAction.animate(with: [TextureFiltered("Rocket")], timePerFrame: 0))
                        startPosition = rocket.position
                        RecursionFunction(rocket.position,recursionCounter: 0)
                    }
                    else if (nodeName == "Undo") {
                        moveSequence.remove(at: moveSequence.count-1)
                        if (moveSequence.count == 0){
                            startAndUndoAreEnable(false)
                        }
                    }
                }
                
                updateInstructions()
            }
        }
    }
    
    func startAndUndoAreEnable(_ isTrue: Bool) {
        if (isTrue) {
            startSimulationButton.run(SKAction.animate(with: [TextureFiltered("Simulate-Button")], timePerFrame: 0))
            undoButton.run(SKAction.animate(with: [TextureFiltered("Undo-Button")], timePerFrame: 0))
        }
        else {
            startSimulationButton.run(SKAction.animate(with: [TextureFiltered("Simulate-Button-Pressed")], timePerFrame: 0))
            undoButton.run(SKAction.animate(with: [ TextureFiltered("Undo-Button-Pressed")], timePerFrame: 0))
        }
    }
    
    func TextureFiltered(_ name: String) -> SKTexture {
        let texture = SKTexture(imageNamed: name)
        texture.filteringMode = .nearest
        return texture
    }
    
    func clickedDirection(_ direction: String, node: SKSpriteNode) {
        clickedButton(node, image: direction)
        if (moveSequence.count < 4) {
            moveSequence.append(direction)
        }
    }
    
    func clickedButton(_ node: SKSpriteNode, image: String) {
        node.run(SKAction.animate(with:[
            TextureFiltered("\(image)-Button-Pressed"),
            TextureFiltered("\(image)-Button")], timePerFrame: animationTime/2))
    }
    
    func updateInstructions() {
        switch moveSequence.count {
        case 0:
            selectInstruction(nextInstruction: instruction1)
        case 1:
            selectInstruction(curentInstruction: instruction1, nextInstruction: instruction2)
        case 2:
            selectInstruction(curentInstruction: instruction2, nextInstruction: instruction3)
        case 3:
            selectInstruction(curentInstruction: instruction3, nextInstruction: instruction4)
        case 4:
            selectInstruction(curentInstruction: instruction4)
        default:
            print("Unknown value in updateInstructions")
        }
    }
    
    func selectInstruction(curentInstruction: SKSpriteNode = SKSpriteNode(), nextInstruction: SKSpriteNode = SKSpriteNode()) {
        curentInstruction.run(SKAction.unhide())
        if(moveSequence.last == "LEFT" || moveSequence.last == "RIGHT")
        {
            curentInstruction.size = CGSize(width: 13, height: 11)
        }
        else {
            curentInstruction.size = CGSize(width: 11, height: 13)
        }
        curentInstruction.run(SKAction.animate(with: [TextureFiltered("Screen-Arrow-Unactive-\(moveSequence.last ?? "")")], timePerFrame: 0))
        nextInstruction.run(SKAction.hide())
    }
    
    func animateInstructions(count: Int) {
        switch count {
        case 0:
            runAnimationOn(instruction1, count: count)
        case 1:
            runAnimationOn(instruction2, count: count)
        case 2:
            runAnimationOn(instruction3, count: count)
        case 3:
            runAnimationOn(instruction4, count: count)
        default:
            print("Unknown value in animateInstructions")
        }
    }
    
    func runAnimationOn(_ instruction: SKSpriteNode, count: Int){
        instruction.run(SKAction.animate(with: [
            TextureFiltered("Screen-Arrow-\(moveSequence[count])"),
            TextureFiltered("Screen-Arrow-Unactive-\(moveSequence[count])")
        ],timePerFrame: animationTime))
    }
    
    // MARK: Recursive Function
    func RecursionFunction(_ rocketPosition: CGPoint,recursionCounter: Int) {
        animateInstructions(count: recursionCounter)
        
        let desiredPosition = getDesiredPosition(moveSequence[recursionCounter],position: rocketPosition)
        
        if(isPositionViable(desiredPosition)) {
            rocket.run(SKAction.move(to: desiredPosition, duration: animationTime))
            // Dlay just for visual purposes
            DispatchQueue.main.asyncAfter(deadline: .now() + animationTime + 0.05) { [self] in
                if (rocket.position == exit.position) {
                    won.toggle() // WON!
                }
                else if (recursionCounter == moveSequence.count-1) {
                    // Got back to the start of the instructions
                    if (rocket.position == startPosition) {
                        // Looped
                        lost = true
                    }
                    else {
                        startPosition = rocket.position
                        RecursionFunction(rocket.position,recursionCounter: 0)
                    }
                }
                else { RecursionFunction(rocket.position,recursionCounter: recursionCounter+1) }
            }
        }
        else { lost = true }
    }
    
    func isPositionViable(_ desiredPosition: CGPoint) -> Bool {
        if (desiredPosition.x < 0 || desiredPosition.x > frame.maxX || desiredPosition.y < 55 || desiredPosition.y > frame.maxY){
            // out of bounds
            return false
        }
        else {
            return true
        }
    }
    
    func getDesiredPosition(_ direction: String,position rocketPosition: CGPoint) -> CGPoint {
        var desiredPosition = rocketPosition
        switch direction{
        case Directions.RIGHT.rawValue:
            desiredPosition = CGPoint(x: rocketPosition.x+rocket.size.width, y: rocketPosition.y)
        case Directions.LEFT.rawValue:
            desiredPosition = CGPoint(x: rocketPosition.x-rocket.size.width, y: rocketPosition.y)
        case Directions.UP.rawValue:
            desiredPosition = CGPoint(x: rocketPosition.x, y: rocketPosition.y+rocket.size.height)
        case Directions.DOWN.rawValue:
            desiredPosition = CGPoint(x: rocketPosition.x, y: rocketPosition.y-rocket.size.height)
        default:
            print("Unknown value in getDesiredPosition")
        }
        
        var willColideWithARock: Bool = false
        for node in self.children {
            let sprite = node as? SKSpriteNode
            if(sprite?.name == "Rock" && sprite?.position == desiredPosition){
                willColideWithARock = true
            }
        }
        
        return willColideWithARock ? rocketPosition : desiredPosition
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (info.isHidden != isInfoHidden){
            info.run(animationInfo())
        }
        
        if(lost) {
            // Had to do this way because of how to lose system works when the device rotates
            // Don't know why it was reseting an unlinked scene and crashing the game
            lose()
        }
    }
    
    func animationInfo() -> SKAction {
        let fadeOut = SKAction.fadeOut(withDuration: animationTime/2)
        let fadeIn = SKAction.fadeIn(withDuration: animationTime/2)
        let updateIsHidden = SKAction.run { [self] in
            info.isHidden = isInfoHidden
        }
        
        return isInfoHidden ?
        SKAction.sequence([fadeOut, updateIsHidden]) :
        SKAction.sequence([fadeIn, updateIsHidden])
    }
    
    func lose() {
        removeAllChildren()
        removeAllActions()
        let newScene = GameScene(size: size, level: level, gameModel: gameModel, won: $won)
        newScene.scaleMode = self.scaleMode
        let animation = SKTransition.fade(withDuration: 1.0)
        self.view?.presentScene(newScene, transition: animation)
    }
}
