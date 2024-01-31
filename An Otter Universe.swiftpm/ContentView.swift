import SwiftUI

struct ContentView: View {
    
    @StateObject var gameViewModel = GameViewModel()
    var soundManager = SoundManager.shared
    var colors = Colors()
    @State var isSoundOn = true
    @State var showedOnboarding = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    StrokeText(text: "An Otter Time", width: 1.5, color: colors.GRAY)
                        .font(Font(.init(.alertHeader, size: 100)))
                        .foregroundStyle(colors.DARKBLUE)
                    StrokeText(text: "(and again)", width: 0.5, color: colors.GRAY)
                        .font(Font(.init(.application, size: 80)))
                        .foregroundStyle(colors.DARKBLUE)
                    Spacer()
                        .frame(maxHeight: 100)
                    NavigationLink {
                        GameView().navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            Rectangle()
                                .stroke(colors.DARKBLUE, lineWidth: 10)
                                .background(colors.WHITE)
                            HStack {
                                Text("PLAY")
                                    .font(Font(.init(.alertHeader, size: 50)))
                                    .foregroundStyle(colors.DARKBLUE)
                            }
                        }
                    }.frame(maxWidth: 400,maxHeight: 100)
                        .padding(.bottom,40)
                    
                    HStack(spacing: 40) {
                        NavigationLink {
                            CreditsView().navigationBarBackButtonHidden()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .stroke(colors.DARKBLUE, lineWidth: 10)
                                    .background(colors.WHITE)
                                HStack {
                                    Text("CREDITS")
                                        .font(Font(.init(.alertHeader, size: 40)))
                                        .foregroundStyle(colors.DARKBLUE)
                                }
                            }
                        }.frame(maxWidth: 260,maxHeight: 100)
                        
                        
                        Button {
                            soundManager.pauseMusic()
                            isSoundOn.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .stroke(colors.DARKBLUE, lineWidth: 10)
                                    .background(colors.WHITE)
                                HStack {
                                    Image(systemName: "speaker.slash.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(colors.DARKBLUE)
                                        .isPresented(condition: isSoundOn)
                                    Image(systemName: "speaker.wave.2.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(colors.DARKBLUE)
                                        .isPresented(condition: !isSoundOn)
                                }.padding(25)
                            }
                        }.frame(maxWidth: 100,maxHeight: 100)
                    }
                    Spacer()
                    
                }
            }
            .onAppear {
                gameViewModel.setScreenSize(newSize: geo.size)
                gameViewModel.gameModel.updateGamePlayOnText()
                showedOnboarding.toggle()
            }
        }.ignoresSafeArea()
            .navigationDestination(isPresented: $showedOnboarding) {
            PositionView().navigationBarBackButtonHidden()
        }
    }
    
    init() {
        GameViewModel().setupFont()
    }
}

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}
