//
//  Product.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-03.
//

import Foundation

struct Product: Identifiable {
    let id: UUID = UUID()
    let sku: String
    let title: String
    let url: String
}
