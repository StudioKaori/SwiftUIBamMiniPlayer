//
//  PlayerWebView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-08-30.
//

import SwiftUI
import WebKit

struct PlayerWebView: UIViewRepresentable {
    
    let url: String
    private let observable = WebViewURLObservable()
    
    // Observe the target's value change
    var observer: NSKeyValueObservation? {
        observable.instance
    }
    
    // MARK: - UIViewRepresentable
    // Create view instance and returns UIKit view
    func makeUIView(context: Context) -> WKWebView {
        
        // For playing video inline
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        
        // To enable Javascript
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        // Javascript post message handler
        let handler = MessageHandler()
        configuration.userContentController.add(handler, name: "jsMessage")
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }
    
    // MARK: - UIViewRepresentable
    // When UIView is updated, the method is called
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        // Log the WKWebView's URL
        observable.instance = uiView.observe(\WKWebView.url, options: .new) { view, change in
            if let url = view.url {
                print("Page URL: \(url)")
            }
        }
        
        // if url remains the same, meaning the component updated by drag gesture. that case, not re-load the url
        //print("Updated, url", uiView.url ?? "")
        if uiView.url != URL(string: url)! {
            uiView.load(URLRequest(url: URL(string: url)!))
        }
        
        
        
    }
}

// MARK:  WKWebViewのURLが変わったこと（WebView内画面遷移）を検知するための `ObservableObject`
private class WebViewURLObservable: ObservableObject {
    @Published var instance: NSKeyValueObservation?
}

// MARK: - Javascript message handler
class MessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}
