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
                NavigationLink(destination: {
                    ProductPageView()
                }, label: {
                    Text("Product page")
                })
                
                NavigationLink(destination: ProductPageView(), isActive: $playerStatus.isChildViewVisible) {
                    EmptyView()
                }
                
            } //: Navigation View
            
            // Player
            if (playerStatus.isPlayerViewVisible) {
                PlayerView()
            }
            
        } //: Zstack
    }
    
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
