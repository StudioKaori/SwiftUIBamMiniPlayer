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
    
    var productId = "default"
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Product ID: " + productId)
                .padding()
            
            Button(action: {
                self.observablePlayerState.isPlayerViewVisible.toggle()
            }, label: {
                Text(self.observablePlayerState.isPlayerViewVisible ? "Close the player" : "Open the player")
                
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
