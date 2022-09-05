//
//  HomePageView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-01.
//

import SwiftUI

struct HomePageView: View {
    // MARK: - Properties
    @StateObject private var playerStatus = PlayerStatus.shared
    
    // MARK: - Body
    var body: some View {
        ZStack {
            NavigationView {
                VStack{
                    NavigationLink(destination: {
                        ProductPageView()
                    }, label: {
                        Text("Product page")
                    })
                    .padding()
                    
                    Button(action: {
                        playerStatus.isPlayerViewVisible.toggle()
                    }, label: {
                        Text(playerStatus.isPlayerViewVisible ? "Close the player" : "Open the player")
                        
                    })
                    
                    NavigationLink(destination: ProductPageView(), isActive: $playerStatus.isChildViewVisible, label: {
                        EmptyView()
                    })
                } //: VStack
            } //: Navigation View
            
            // Player
            PlayerView()

            
        } //: Zstack
    }
    
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
