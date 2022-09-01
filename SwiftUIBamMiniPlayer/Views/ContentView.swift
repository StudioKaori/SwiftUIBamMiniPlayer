//
//  ContentView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-08-30.
//

import SwiftUI



struct ContentView: View {
    // MARK: - Properties
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            NavigationView {
                NavigationLink(destination: {
                    ProductPageView()
                }, label: {
                    Text("Product page")
                })
            }
        } //: Zstack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

