//
//  ContentView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-08-30.
//

import SwiftUI

struct ContentView: View {
    @State private var location: CGPoint = CGPoint(x: 0, y: 0)
    
    var body: some View {
        PlayerWebView(url: "https://demo.bambuser.shop/content/webview-landing-v2.html?mockLiveBambuser=true")
            .frame(width: 200, height: 300)
            .cornerRadius(10)
            .position(location)
            .gesture(DragGesture().onChanged({ value in self.location = value.location
            }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
