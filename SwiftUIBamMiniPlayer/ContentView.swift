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
                .frame(width: isPlayerMinimised ? 200 : 400, height: isPlayerMinimised ? 300 : 600)
                .cornerRadius(isPlayerMinimised ? 10 : 0)
                .position(isPlayerMinimised ? location : CGPoint(x: 0, y: 0))
                .gesture(DragGesture().onChanged({ value in self.location = value.location
                }))
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

