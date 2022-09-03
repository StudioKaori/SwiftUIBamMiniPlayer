//
//  PlayerStatus.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-03.
//

import SwiftUI

final class PlayerStatus: ObservableObject {
    // MARK: - Properties
    @Published var isPlayerViewVisible: Bool = false
    @Published var isPlayerMinimised: Bool = false
    @Published var isChildViewVisible: Bool = false
    
    // MARK: - Singleton instance
    static let shared = PlayerStatus()
    private init() {}
}
