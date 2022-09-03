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
        print("makeUIView")
        
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
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        // load local player.html
        let theFileName = ("player" as NSString).lastPathComponent
        let htmlPath = Bundle.main.path(forResource: theFileName, ofType: "html")
        let folderPath = Bundle.main.bundlePath
        let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
        
        // inject JS to capture console.log output and send to iOS
        //        let source = "function captureLog(msg) { window.webkit.messageHandlers.logHandler.postMessage(msg); } window.console.log = captureLog;"
        //        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        //        webView.configuration.userContentController.addUserScript(script)
        //        // register the bridge script that listens for the output
        //        webView.configuration.userContentController.add(handler, name: "logHandler")
        
        do {
            let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
            webView.loadHTMLString(htmlString as String, baseURL: baseUrl)
        } catch {
            // catch error
        }
        
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
        //        if uiView.url != URL(string: url)! {
        //            uiView.load(URLRequest(url: URL(string: url)!))
        //        }
        
        
        
    }
}

// MARK:  WKWebViewのURLが変わったこと（WebView内画面遷移）を検知するための `ObservableObject`
private class WebViewURLObservable: ObservableObject {
    @Published var instance: NSKeyValueObservation?
}
