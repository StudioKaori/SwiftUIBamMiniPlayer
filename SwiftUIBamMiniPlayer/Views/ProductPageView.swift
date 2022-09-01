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
    
    var body: some View {
        Button(action: {
            self.observablePlayerState.isPlayerViewVisible.toggle()
        }, label: {
            Text("Toggle")
        })
    }
}

struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView()
    }
}
