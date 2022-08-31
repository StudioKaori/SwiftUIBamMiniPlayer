//
//  ContentView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-08-30.
//

import SwiftUI



struct ContentView: View {
    // MARK: - Properties
    @State private var location: CGPoint = CGPoint(x: 0, y: 0)
    @State private var isPlayerMinimised: Bool = false
    
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            PlayerWebView(url: "https://demo.bambuser.shop/content/webview-landing-v2.html?mockLiveBambuser=true")
                .frame(width: isPlayerMinimised ? 200 : UIScreen.main.bounds.width, height: isPlayerMinimised ? 300 : UIScreen.main.bounds.height)
                .cornerRadius(isPlayerMinimised ? 10 : 0)
                .position(isPlayerMinimised ? location : CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2))
                .gesture(DragGesture().onChanged({ value in self.location = value.location
                }))
                .ignoresSafeArea()
            
            Button(action: {
                isPlayerMinimised.toggle()
            }, label: {
                Text("Minimise the player")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

