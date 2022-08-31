//
//  ContentView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-08-30.
//

import SwiftUI



struct ContentView: View {
    // MARK: - Properties
    @State private var location: CGPoint = CGPoint(x: miniPlayerWidth/2, y: miniPlayerHeight/2)
    @State private var isPlayerMinimised: Bool = false
    
    private let playerUrl: String = "https://demo.bambuser.shop/content/webview-landing-v2.html?mockLiveBambuser=true"
    
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            PlayerWebView(url: playerUrl)
            .frame(width: isPlayerMinimised ? miniPlayerWidth : UIScreen.main.bounds.width, height: isPlayerMinimised ? miniPlayerHeight : UIScreen.main.bounds.height)
            .cornerRadius(isPlayerMinimised ? 10 : 0)
            .position(isPlayerMinimised ? location : CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2))
            .gesture(DragGesture().onChanged({ value in self.location = value.location
            }))
            .onTapGesture {
                if isPlayerMinimised {isPlayerMinimised = false}
            }
            .ignoresSafeArea()
            
            Button(action: {
                isPlayerMinimised.toggle()
            }, label: {
                Text("Toggle the player size")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .background(.pink)
                    .cornerRadius(20)
                // if I use position, somehow all the display area reacts as a button, so it should be comment out.
                //                    .position(x: 200, y: UIScreen.main.bounds.height - 300)
                
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

