//
//  MessageHandlerDelegate.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-06.
//

import Foundation

protocol MessageHandlerDelegate: AnyObject {
    func playerProductTapped(productData: Product)
}
