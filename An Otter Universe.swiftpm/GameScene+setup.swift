//
//  GameScene+setup.swift
//  An Otter Universe
//
//  Created by rsbj on 19/01/24.
//

import SpriteKit
import SwiftUI

extension GameScene {
    func setup(){
        let gridSize = CGSize(width: gameModel.levelsGridCellSize[level], height: gameModel.levelsGridCellSize[level])
        
        grid = SKSpriteNode(imageNamed: "Grid\(gameModel.levelsGridCellSize[level])")
        grid.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(grid)
        
        exit = SKSpriteNode(imageNamed: "Exit")
        exit.name = "Exit"
        let exitX = gameModel.levelsExitCordinates[level][0]*gridSize.width
        let exitY = gameModel.levelsExitCordinates[level][1]*gridSize.height
        exit.size = gridSize
        exit.position = CGPoint(x: (exit.size.width/2)+5+exitX, y: (exit.size.height/2)+57+exitY)
        addChild(exit)
        
        var rockNumber = 1
        for i in 0..<gameModel.levelsRocksQuantityAndCordinates[level][0] {
            let rock = SKSpriteNode(imageNamed: "Rock")
            rock.name = "Rock"
            let rockX = CGFloat(gameModel.levelsRocksQuantityAndCordinates[level][i+rockNumber])*gridSize.width
            let rockY = CGFloat(gameModel.levelsRocksQuantityAndCordinates[level][i+rockNumber+1])*gridSize.height
            rock.size = gridSize
            rock.position = CGPoint(x: (rock.size.width/2)+5+rockX, y: (rock.size.height/2)+57+rockY)
            let randomInt = Int.random(in: 1...8)
            if (i != 0) {
                rock.zRotation = 2 * .pi/CGFloat(randomInt)
            }
            addChild(rock)
            rockNumber += 1
        }
        
        rocket = SKSpriteNode(imageNamed: "Rocket-Deactivated")
        let rocketX = gameModel.levelsRocketCordinates[level][0]*gridSize.width
        let rocketY = gameModel.levelsRocketCordinates[level][1]*gridSize.height
        rocket.size = gridSize
        rocket.position = CGPoint(x: (rocket.size.width/2)+5+rocketX, y: (rocket.size.height/2)+57+rocketY)
        addChild(rocket)
        
        instruction1.position = CGPoint(x: 20, y: 19)
        addChild(instruction1)
        instruction2.position = CGPoint(x: 40, y: 19)
        addChild(instruction2)
        instruction3.position = CGPoint(x: 60, y: 19)
        addChild(instruction3)
        instruction4.position = CGPoint(x: 80, y: 19)
        addChild(instruction4)
        
        startSimulationButton = SKSpriteNode(imageNamed: "Simulate-Button-Pressed")
        startSimulationButton.name = "Start"
        startSimulationButton.position = CGPoint(x: (startSimulationButton.size.width/2)+104, y: (startSimulationButton.size.height/2)+11)
        addChild(startSimulationButton)
        
        undoButton = SKSpriteNode(imageNamed: "Undo-Button-Pressed")
        undoButton.name = "Undo"
        undoButton.position = CGPoint(x: (undoButton.size.width/2)+129, y: (undoButton.size.height/2)+32)
        addChild(undoButton)
        
        infoButton = SKSpriteNode(imageNamed: "Info-Button")
        infoButton.name = "Info"
        infoButton.position = CGPoint(x: (infoButton.size.width/2)+104, y: (infoButton.size.height/2)+31)
        addChild(infoButton)
        
        left = SKSpriteNode(imageNamed: "LEFT-Button")
        left.name = Directions.LEFT.rawValue
        left.position = CGPoint(x: left.size.width+165, y: (left.size.height/2)+20)
        addChild(left)
        
        down = SKSpriteNode(imageNamed: "DOWN-Button")
        down.name = Directions.DOWN.rawValue
        down.position = CGPoint(x: down.size.width + left.position.x+1, y: (down.size.height/2)+6)
        addChild(down)
        
        up = SKSpriteNode(imageNamed: "UP-Button")
        up.name = Directions.UP.rawValue
        up.position = CGPoint(x: down.position.x, y: down.position.y+(up.size.height)+1)
        addChild(up)
        
        right = SKSpriteNode(imageNamed: "RIGHT-Button")
        right.name = Directions.RIGHT.rawValue
        right.position = CGPoint(x: right.size.width + left.position.x + up.size.width + 2, y: left.position.y)
        addChild(right)
        
        setupInfo()
        changeFilteringMode(self.children)
    }
    
    func changeFilteringMode(_ group: [SKNode]){
        for node in group {
            let sprite = node as? SKSpriteNode
            sprite?.texture?.filteringMode = .nearest
        }
    }
}
