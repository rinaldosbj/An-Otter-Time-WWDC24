//
//  GameView.swift
//  An Otter Universe
//
//  Created by rsbj on 08/01/24.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var gameViewModel = GameViewModel()
    @State var won: Bool = false
    var colors = Colors()
    
    var body: some View {
        ZStack{
            backgroundImage
            VStack {
                otter
                textBox
            }
            bottomButtons
            game
        }
    }
    
    var game: some View {
        // MARK: Needs more work
        GameSceneView(level: gameViewModel.level, gameModel: GameModel.shared, won: $won)
            .isPresented(condition: gameViewModel.shouldShowGame)
            .onChange(of: won) { newValue in
                gameViewModel.goToNextPhase()
            }
    }
    
    var backgroundImage: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Image("Background-Slide")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .isPresented(condition: gameViewModel.isInSlide)
            Rectangle()
                .foregroundStyle(colors.GRAY)
                .ignoresSafeArea()
                .isPresented(condition: gameViewModel.shouldShowGame)
            Rectangle()
                .foregroundStyle(colors.DARKBLUE)
                .opacity(0.3)
                .ignoresSafeArea()
        }
    }
    
    var textBox: some View {
        VStack {
            ZStack {
                Rectangle()
                    .stroke(colors.DARKBLUE, lineWidth: 10)
                    .background(colors.WHITE)
                VStack {
                    Text(gameViewModel.text)
                        .font(Font(.init(.alertHeader, size: 35)))
                        .lineLimit(20)
                        .padding(45)
                        .foregroundStyle(colors.DARKBLUE)
                    Image(gameViewModel.slideImage)
                        .resizable()
                        .scaledToFit()
                        .padding(55)
                        .isPresented(condition: gameViewModel.isInSlide)
                }
            }
            .padding(40)
            .setMaxHeightOnCondition(!gameViewModel.isInSlide, maxHeight: 310)
            Spacer()
                .frame(maxHeight: 100)
        }.isPresented(condition: !gameViewModel.shouldShowGame)
    }
    
    var otter: some View {
        VStack {
            Spacer()
                .frame(height: gameViewModel.getScreenSize().height/7)
            Image(gameViewModel.joyImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
        }
        .isPresented(condition: !gameViewModel.isInSlide)
        .padding(.bottom,-gameViewModel.getScreenSize().height/30)
        .frame(maxWidth: gameViewModel.getScreenSize().width)
        .isPresented(condition: !gameViewModel.shouldShowGame)
    }
    
    var backButton: some View {
        Button {
            gameViewModel.previousText()
        } label: {
            ZStack {
                Rectangle()
                    .stroke(colors.DARKBLUE, lineWidth: 10)
                    .background(colors.WHITE)
                HStack {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundStyle(colors.DARKBLUE)
                    Text("Previous")
                        .font(.title)
                        .bold()
                        .padding(.trailing,5)
                        .foregroundStyle(colors.DARKBLUE)
                }
            }
        }.frame(maxWidth: 200,maxHeight: 70)
    }
    
    var nextButton: some View {
        Button {
            gameViewModel.nextText()
        } label: {
            ZStack {
                Rectangle()
                    .stroke(colors.DARKBLUE, lineWidth: 10)
                    .background(colors.WHITE)
                HStack {
                    Text("Next")
                        .font(.title)
                        .bold()
                        .padding(.leading,5)
                        .foregroundStyle(colors.DARKBLUE)
                    Image(systemName: "chevron.right")
                        .bold()
                        .foregroundStyle(colors.DARKBLUE)
                }
            }
        }
        .frame(maxWidth: 200,maxHeight: 70)
        .isPresented(condition: !gameViewModel.canSkip)
    }
    
    var bottomButtons: some View {
        VStack {
            Spacer()
            HStack {
                backButton
                    .padding(40)
                    .isPresented(condition: gameViewModel.hasPrevious())
                Spacer()
                nextButton
                    .padding(40)
                    .isPresented(condition: gameViewModel.hasNext())
                skipButtons
                    .padding(40)
                    .isPresented(condition: gameViewModel.canSkip)
                goToCreditsButton
                    .padding(40)
                    .isPresented(condition: !gameViewModel.hasNext())
            }
        }
        .isPresented(condition: !gameViewModel.shouldShowGame)
    }
    
    var goToCreditsButton: some View {
        NavigationLink {
            CreditsView().navigationBarBackButtonHidden()
        } label: {
            ZStack {
                Rectangle()
                    .stroke(colors.DARKBLUE, lineWidth: 10)
                    .background(colors.WHITE)
                HStack {
                    Text("Credits")
                        .font(.title)
                        .bold()
                        .foregroundStyle(colors.DARKBLUE)
                }
            }
        }.frame(maxWidth: 200,maxHeight: 70)
    }
    
    var skipButtons: some View {
        HStack {
            Button {
                gameViewModel.nextText()
            } label: {
                ZStack {
                    Rectangle()
                        .stroke(colors.DARKBLUE, lineWidth: 10)
                        .background(colors.BLUERWHITE)
                    Text("Another Example")
                        .font(.title)
                        .bold()
                        .foregroundStyle(colors.DARKBLUE)
                }
            }
            .frame(maxWidth: 400,maxHeight: 70)
            .padding(.horizontal,20)
            
            Button {
                gameViewModel.skipText()
            } label: {
                ZStack {
                    Rectangle()
                        .stroke(colors.DARKBLUE, lineWidth: 10)
                        .background(colors.WHITE)
                    HStack {
                        Text("Go to Simulation")
                            .font(.title)
                            .bold()
                            .foregroundStyle(colors.DARKBLUE)
                        Image(systemName: "chevron.right")
                            .bold()
                            .foregroundStyle(colors.DARKBLUE)
                    }
                }
            }
            .frame(maxWidth: 400,maxHeight: 70)
        }
    }
}

extension View {
    @ViewBuilder
    func isPresented(condition: Bool) -> some View  {
        if(condition){ self }
    }
    
    @ViewBuilder
    func setMaxHeightOnCondition(_ condition: Bool,maxHeight: CGFloat) -> some View {
        if(condition) { self.frame(maxHeight: maxHeight) }
        else { self }
    }
}
