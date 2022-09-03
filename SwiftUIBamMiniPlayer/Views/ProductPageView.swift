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
        }
        
    }
}

struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView()
    }
}
