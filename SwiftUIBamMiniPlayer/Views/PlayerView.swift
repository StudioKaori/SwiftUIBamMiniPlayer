//
//  PlayerView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-01.
//

import SwiftUI

struct PlayerView: View {
    // MARK: - Properties
    @State private var location: CGPoint = CGPoint(
        x: miniPlayerMarginFromEdge + miniPlayerWidth/2,
        y: miniPlayerMarginFromEdge + miniPlayerHeight/2
    )
    @State private var isPlayerMinimised: Bool = false
    
    private let playerUrl: String = "https://demo.bambuser.shop/content/webview-landing-v2.html?mockLiveBambuser=true"
    
    private let miniPlayerPositionLeadingX: CGFloat = miniPlayerMarginFromEdge + miniPlayerWidth/2
    private let miniPlayerPositionLeadingY: CGFloat = miniPlayerMarginFromEdge + miniPlayerHeight/2
    private let miniPlayerPositionTrailingX: CGFloat = UIScreen.main.bounds.width - miniPlayerWidth/2 - miniPlayerMarginFromEdge
    private let miniPlayerPositionTrailingY: CGFloat = UIScreen.main.bounds.height - miniPlayerHeight/2 - miniPlayerMarginFromEdge
    
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            PlayerWebView(url: playerUrl)
                .frame(width: isPlayerMinimised ? miniPlayerWidth : UIScreen.main.bounds.width, height: isPlayerMinimised ? miniPlayerHeight : UIScreen.main.bounds.height)
                .cornerRadius(isPlayerMinimised ? 10 : 0)
                .position(isPlayerMinimised ? location : CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2))
                .gesture(
                    DragGesture().onChanged({ value in
                        //print(value.location)
                        let _ = print(value)
                        var newLocation: CGPoint = value.location
                        
                        if value.location.x < miniPlayerPositionLeadingX {
                            newLocation.x = miniPlayerPositionLeadingX
                        }
                        if value.location.y < miniPlayerPositionLeadingY {
                            newLocation.y = miniPlayerPositionLeadingY
                        }
                        if value.location.x > miniPlayerPositionTrailingX  {
                            newLocation.x = miniPlayerPositionTrailingX
                        }
                        if value.location.y > miniPlayerPositionTrailingY  {
                            newLocation.y = miniPlayerPositionTrailingY
                        }
                        
                        self.location = newLocation
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
            })
            .foregroundColor(.white)
            .padding()
            .background(.pink)
            .cornerRadius(20)
            // offset should be applied to the button, not the Text to make the button react
            .offset(x: 0, y: UIScreen.main.bounds.height - 350)
            // if I use position, somehow all the display area reacts as a button, so it should be comment out.
            // it seems like position fill all the available area.
            // .position(x: 200, y: UIScreen.main.bounds.height - 300)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}