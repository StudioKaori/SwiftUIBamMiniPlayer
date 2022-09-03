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
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Product SKU: " + playerStatus.currentProduct.sku)
                .padding()
            Text("Product Title: " + playerStatus.currentProduct.title)
                .padding()
            Text("Product URL: " + playerStatus.currentProduct.url)
                .padding()
        }
        
    }
}

struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView()
    }
}
