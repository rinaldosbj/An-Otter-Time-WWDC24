//
//  GameViewModel.swift
//  An Otter Universe
//
//  Created by rsbj on 08/01/24.
//

import SwiftUI

public class GameViewModel: ObservableObject {
    
    var gameModel: GameModel
    
    var tutorialTitle: String
    
    @Published var level = 0
    
    @Published var text: String
    
    @Published var joyImage: String
    
    @Published var slideImage: String
    
    @Published var shouldShowGame: Bool
    
    @Published var canSkip: Bool
    
    @Published var isInSlide: Bool
    
    var sceneCounter = 0
    
    var slide = 0
    
    init(gameModel: GameModel = GameModel.shared, tutorialTitle: String = "", sceneCounter: Int = 0) {
        self.gameModel = gameModel
        self.tutorialTitle = gameModel.Texts[0]
        self.joyImage = gameModel.JoyImages[0]
        self.text = gameModel.Texts[sceneCounter]
        self.shouldShowGame = false
        self.isInSlide = false
        self.canSkip = false
        self.slideImage = gameModel.SlideImages[slide]
    }
    
    func hasPrevious() -> Bool {
        return sceneCounter > 0
    }
    
    func hasNext() -> Bool {
        return sceneCounter < gameModel.Texts.count-1
    }
    
    func nextText() {
        if hasNext() { sceneCounter += 1 }
        
        if(gameModel.firstSlide == sceneCounter) {
            isInSlide = true
        } else if(gameModel.lastSlide == sceneCounter) {
            isInSlide = false
        } else if (isInSlide) {
            slide += 1
        }
        
        checkIfCanSkip()
                
        if (gameModel.gamePlayOnText.contains(sceneCounter)){
            shouldShowGame.toggle()
        }
        
        updateFromModel()
    }
    
    func checkIfCanSkip() {
        if(gameModel.canSkipOnSlide == sceneCounter){
            canSkip = true
        } else {
            canSkip = false
        }
    }
    
    func skipText() {
        isInSlide = false
        slide += gameModel.lastSlide - sceneCounter - 1
        sceneCounter = gameModel.lastSlide
        checkIfCanSkip()
        updateFromModel()
    }
    
    func previousText() {
        if(gameModel.firstSlide == sceneCounter) {
            isInSlide = false
        } else if(gameModel.lastSlide == sceneCounter) {
            isInSlide = true
        } else if (isInSlide) {
            slide -= 1
        }
        
        if hasPrevious() { sceneCounter -= 1 }
        
        checkIfCanSkip()
        
        updateFromModel()
    }
    
    func updateFromModel() {
        text = gameModel.Texts[sceneCounter]
        joyImage = gameModel.JoyImages[sceneCounter-slide]
        slideImage = gameModel.SlideImages[slide]
    }

    func goToNextPhase() {
        shouldShowGame.toggle()
        let nextLevel = level + 1
        if (nextLevel < gameModel.levelsExitCordinates.count) {
            level = nextLevel
        }
        gameModel.gamePlayOnText.removeFirst()
    }
    
    func setScreenSize(newSize: CGSize) {
        if(newSize.width > newSize.height) {
            gameModel.screenSize = CGSize(width: newSize.height, height: newSize.width)
        }
        else {
            gameModel.screenSize = newSize
        }
    }
    
    func getScreenSize() -> CGSize {
        return gameModel.screenSize
    }
    
    func setupFont() {
        let cfURL = Bundle.main.url(forResource: "VT323-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
    }
}
