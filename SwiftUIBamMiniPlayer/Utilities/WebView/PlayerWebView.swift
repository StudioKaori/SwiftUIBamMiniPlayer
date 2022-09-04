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
    
    // Close the player and webview
    public func playerOpen() {
        PlayerStatus.shared.isPlayerViewVisible = true
    }
    
    // Close the player and webview
    public func playerClose() {
        PlayerStatus.shared.isPlayerViewVisible = false
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
        configuration.userContentController.add(handler, name: "bambuserEventHandler")
        
        return configuration
    }
}
