//
//  ProductPageView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-01.
//

import SwiftUI

struct ProductPageView: View {
    // MARK: - Properties
    @EnvironmentObject var observablePlayerState: ObservablePlayerState
    
    @StateObject private var messageHandler: MessageHandler = MessageHandler()
    
    var productId = "default"
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Product ID: " + productId)
                .padding()
            
            Button(action: {
                messageHandler.isPlayerViewVisible.toggle()
            }, label: {
                Text(messageHandler.isPlayerViewVisible ? "Close the player" : "Open the player")
                
            })
        }
        
    }
}

struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView()
            .environmentObject(ObservablePlayerState())
    }
}
