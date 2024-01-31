//
//  GameModel.swift
//  An Otter Universe
//
//  Created by rsbj on 08/01/24.
//

import SwiftUI

struct Colors {
    let DARKBLUE = Color(hex: 0x222034)
    let DARKERWHITE = Color(hex: 0x9badb7)
    let BLUERWHITE = Color(hex: 0xcbdbfc)
    let GRAY = Color(hex: 0x847e87)
    let WHITE = Color(hex: 0xffffff)
}

class GameModel {
    
    static var shared = GameModel()
    
    var screenSize: CGSize = CGSize(width: 0, height: 0)
    
    var JoyImages = [
        "Joy-excited-waving",
        "Joy-happy",
        "Joy-confident",
        "Joy-happy-hand",
        "Joy-sus",
        "Joy-angy-arm",
        "Joy-excited",
        "SLIDE",
        "Joy-confident",
        "Joy-excited",
        "Joy-happy-hand",
        "Joy-confident",
        "Joy-excited",
        "Joy-excited",
        "Joy-confident",
        "Joy-excited-waving",
    ]
    
    var SlideImages = [
        "Slide1",
        "Cooker1",
        "Cobra",
        "Cooker5",
        "Cooker2",
        "Ball_transform",
        "wind",
        "Ball_wind2",
        "Ball_wind3",
        "Ball_Done",
        "Ball_different"
    ]

    
    var gamePlayOnText = [19,21,22,23]
    private let backupGamePlayOnText = [19,21,22,23]
    
    func updateGamePlayOnText() {
        gamePlayOnText = backupGamePlayOnText
    }
    
    var firstSlide = 7
    var canSkipOnSlide = 11
    var lastSlide = 18
    
    var Texts = [
        "Hello explorer! My name is Joy, I'll be your Captain on your space exploration journey",
        "Recapping, we are in the experimental navigation program at NASA in 2050...",
        "...After the discovery of the secret language of otters, which brought me here, lol...",
        "...We are studying the possibility of intergalactic travel through recursive functions...",
        "What do you mean you don't know what recursive functions are???",
        "I'll have to have a serious talk with Karen from HR, she always gets me into trouble",
        "Well, luckily we have a Key Note ready for situations like these.",
        "The recursive function is a powerful concept widely used in subjects like mathematics, system development, and programming, which greatly helps in algorithm implementations and makes code reading easier.",
        "In a more practical sense, a function is nothing more than one or more actions performed by someone.\n\nA real-life example could be a cook who has the function of putting a topping on a cake, every time she is called, she puts frosting on the cake.",
        "The recursive function works the same way as others, the difference is that every time it's called, it performs its actions and then calls itself, creating a loop where it is called multiple times.\n\nIt's like a snake chasing its own tail.",
        "But if the function calls itself, and within it, it calls itself again and again (infinitely), this can lead to disastrous results!\n\nSo before thinking about implementing a recursive function, we need to think about the rules that govern it.",
        "Every recursive function needs to have:\n1. A base case\n2. A call to itself\n3. It also needs that with each interaction, it gets closer to the final result\n\nThis way, you can create a recursive function successfully!",
        "Let's now see another example that illustrates the execution of each rule of a recursive function:\n\nWe will use a recursive function that winds up this unwound ball of yarn.",
        "The name of the function will be Wind Thread, and every time it's called, it winds the thread around the ball a little more, so that in the end, it is completely wound up.",
        "Notice that at each step, we are closer to our final goal, thus respecting the third rule.",
        "The function repeats itself because every time it finishes winding, it is called again by itself, thus respecting the second rule.",
        "And when it is completely wound up, it reaches its base case or stopping condition, finally respecting the first rule.",
        "This way, we can wind any ball of yarn of any size, as our function is designed for that!",
        "I'm glad you're now up to speed on the subject, now let's start the simulation!",
        "Congratulations! You're learning fast!",
        "As seen in the slides, recursive functions are very useful for simplifying complex problems into small instructions",
        "Wow! This level was harder than it seemed!",
        "Congratulations, you've reached the last level of the simulation! Just be careful with the rocks, maybe they're sending you a message!",
        "Congratulations! You were excellent, I'm very proud!",
        "Karen was right, you will definitely be a great space navigator!",
        "See you later, navigator. I'll see you again in space! Duty calls."
    ]
    
    var levelsRocketCordinates: [[CGFloat]] = [
        [1,1], // level 1
        [1,1], // level 2
        [1,1], // level 3
        [1,1]] // level 4
        
    var levelsExitCordinates: [[CGFloat]] = [
        [6,6], // level 1
        [4,6], // level 2
        [6,3], // level 3
        [13,9]] // level 4
    
    var levelsRocksQuantityAndCordinates = [
        [0], // level 1
        [1,2,2], // level 2
        [3,2,2,4,4,4,2], // level 3
        [51,
         2,2,2,3,2,4,2,5,2,6,2,9,2,10,2,11,2,12,
         3,2,3,6,3,8,
         4,2,4,6,4,9,4,10,4,11,
         5,2,5,6,5,8,
         6,3,6,4,6,5,6,9,6,10,6,11,6,12,
         8,3,8,4,8,5,8,9,8,10,8,11,8,12,
         9,2,9,6,9,8,
         10,2,10,6,10,9,10,10,10,11,
         11,2,11,6,11,8,
         12,2,12,6,12,9,12,10,12,11,12,12]] // level 4 THE ULTIMATE
    
    var levelsGridCellSize = [
        30,
        30,
        30,
        16]
    
    var infoText = "Insert instructions and click the 'SIMULATE' button to start, the rocket will move in the direction of the instructions repeatedly until you win or lose, get to the Star location to proceed to the next level\n\n\n\n\n\n\n\n\nThe rocket has loads of sensors so if you try to move into a rock it won't go in that direction"
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
