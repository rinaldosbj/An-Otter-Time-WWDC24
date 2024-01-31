//
//  CreditsView.swift
//  An Otter Universe
//
//  Created by rsbj on 29/01/24.
//

import SwiftUI

struct CreditsView: View {
    var colors = Colors()
    @StateObject var gameViewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            Image("Background-Slide")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                
                ZStack {
                    Rectangle()
                        .stroke(colors.DARKBLUE, lineWidth: 10)
                        .background(colors.WHITE)
                    VStack {
                        Text("This experience was made by Rinaldo Júnior especially for apple's WWDC Swift Student Challenge 2024.\n\nRoyalties free music:\nClassical 1 by Jonny S.\nAvailable on mixkit.co\n\nCustom Fonts:\nVT323 by Peter Hull\nAvailable on Google Fonts\n\nIllustrations made by:\nRinaldo Júnior\n\nScript made by:\nRinaldo Júnior")
                            .multilineTextAlignment(.center)
                            .font(Font(.init(.alertHeader, size: 35)))
                            .lineLimit(20)
                            .padding(70)
                            .foregroundStyle(colors.DARKBLUE)
                    }
                }
                .padding(40)
                
                Button {
                    NavigationUtil.popToRootView()
                } label: {
                    ZStack {
                        Rectangle()
                            .stroke(colors.DARKBLUE, lineWidth: 10)
                            .background(colors.WHITE)
                        HStack {
                            Image(systemName: "chevron.left")
                                .bold()
                                .foregroundStyle(colors.DARKBLUE)
                            Text("Back to Home")
                                .font(.title)
                                .bold()
                                .padding(.trailing,5)
                                .foregroundStyle(colors.DARKBLUE)
                        }
                    }
                }.frame(maxWidth: 400,maxHeight: 70)
                    .padding(40)
                    .padding(.bottom,100)
            }
        }
    }
}

struct NavigationUtil {
    static func popToRootView(animated: Bool = false) {
        findNavigationController(viewController: UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController)?.popToRootViewController(animated: true)
    }
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        return nil
    }
}
