//
//  SwiftUIBamMiniPlayerApp.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-08-30.
//

import SwiftUI

@main
struct SwiftUIBamMiniPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environmentObject(ObservablePlayerState())
        }
    }
}
