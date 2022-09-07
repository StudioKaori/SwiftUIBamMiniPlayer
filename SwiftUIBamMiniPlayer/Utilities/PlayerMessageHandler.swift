//
//  WebViewMessageHandler.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-06.
//

import SwiftUI

final class PlayerMessageHandler: ObservableObject {
    // MARK: - Properties
    @Published var isChildViewVisible: Bool = false
    @Published var currentProduct: Product = Product(sku: "", title: "", url: "")
    
    // MARK: - Singleton instance
    static let shared = PlayerMessageHandler()
    private init() {}
}

extension PlayerMessageHandler: MessageHandlerDelegate { 
    func playerProductTapped(productData: Product) {
        PlayerMessageHandler.shared.currentProduct = productData
        PlayerMessageHandler.shared.isChildViewVisible = true
    }
}
