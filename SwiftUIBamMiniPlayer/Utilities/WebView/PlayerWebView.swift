//
//  PlayerWebView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-04.
//

import WebKit

class PlayerWebView {
    let webView: WKWebView = WKWebView(frame: .zero, configuration: WebViewConfig.getConfig())
    
    // MARK: - Singleton instance
    static let shared = PlayerWebView()
    private init() {}
    
    // This function is used to communicate message to the JS
    public func evaluateJavascript(_ javascript: String, sourceURL: String? = nil, completion: ((_ result: Any? , _ error: String?) -> Void)? = nil) {
        webView.evaluateJavaScript(javascript) { (result, error) in
            guard error == nil else {
                print("EvaluateJavascript error \(String(describing: error))")
                completion?(nil, error?.localizedDescription)
                return
            }
            completion?(result, nil)
            print("EvaluateJavascript Success: \(String(describing: result))")
        }
    }
    
    /// Close the player and webview
    public func playerOpen(showID: String) {
        PlayerStatus.shared.showID = showID
        PlayerStatus.shared.isPlayerViewVisible = true
    }
    
    /// Close the player and webview
    public func playerClose() {
        PlayerStatus.shared.isPlayerViewVisible = false
        PlayerStatus.shared.isPlayerMinimised = false
    }
    
    /// Minimise the player
    public func playerMinimise() {
        PlayerStatus.shared.isPlayerMinimised = true
    }
    
    /// Make the player full size. To open the player, you need to call playerOpen first.
    public func playerMakeFullSize() {
        PlayerStatus.shared.isPlayerMinimised = false
    }
    
}

// MARK: - Create WebView config
private class WebViewConfig {
    static func getConfig() -> WKWebViewConfiguration {
        // For playing video inline
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        
        // To enable Javascript
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        configuration.preferences = preferences
        
        // Javascript post message handler
        let handler = WebViewMessageHandler()
        
        // MessangeHandler delegate, to delegate the product tapped method to the other class
        handler.messageHandlerDelegate = PlayerMessageHandler.shared
        
        configuration.userContentController.add(handler, name: "bambuserEventHandler")
        
        return configuration
    }
}

