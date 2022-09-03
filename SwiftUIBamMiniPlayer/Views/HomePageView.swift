//
//  HomePageView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-01.
//

import SwiftUI

struct HomePageView: View {
    // MARK: - Properties
    @EnvironmentObject var observablePlayerState: ObservablePlayerState
    @StateObject private var messageHandler: MessageHandler = MessageHandler.shared
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            NavigationView {
                NavigationLink(destination: {
                    ProductPageView()
                }, label: {
                    Text("Product page")
                })
            } //: Navigation View
            
//            NavigationLink(destination: ProductPageView(), isActive: $observablePlayerState.isChildViewVisible) {
//                EmptyView()
//            }
            
            // Player
            if (messageHandler.isPlayerViewVisible) {
                PlayerView()
            }
            
        } //: Zstack
    }
    
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(ObservablePlayerState())
    }
}
