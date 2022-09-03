//
//  ProductPageView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-01.
//

import SwiftUI

struct ProductPageView: View {
    // MARK: - Properties
    @StateObject private var playerStatus = PlayerStatus.shared
    
    var productId = "default"
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Product ID: " + productId)
                .padding()
            
            Button(action: {
                playerStatus.isPlayerViewVisible.toggle()
            }, label: {
                Text(playerStatus.isPlayerViewVisible ? "Close the player" : "Open the player")
                
            })
        }
        
    }
}

struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView()
    }
}
