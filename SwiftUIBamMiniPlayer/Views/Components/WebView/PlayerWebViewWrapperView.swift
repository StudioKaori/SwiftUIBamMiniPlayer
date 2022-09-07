//
//  PlayerWebViewWrapper.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-08-30.
//

import SwiftUI
import WebKit

struct PlayerWebViewWrapperView: UIViewRepresentable {
    
    let url: String
    private let observable = WebViewURLObservable()
    
    // Observe the target's value change
    var observer: NSKeyValueObservation? {
        observable.instance
    }
    
    // MARK: - UIViewRepresentable
    // Create view instance and returns UIKit view
    func makeUIView(context: Context) -> WKWebView {
                
        // load local player.html
        guard let path: String = Bundle.main.path(forResource: "player", ofType: "html") else {
            // to do throw error instead of returning error
            return PlayerWebView.shared.webView
        }
            let localHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
        PlayerWebView.shared.webView.loadFileURL(localHTMLUrl, allowingReadAccessTo: localHTMLUrl)
  
        
//        let theFileName = ("player" as NSString).lastPathComponent
//        let htmlPath = Bundle.main.path(forResource: theFileName, ofType: "html")
//        let folderPath = Bundle.main.bundlePath
//        let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
//
//        do {
//
//            let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
//
//            PlayerWebView.shared.webView.loadHTMLString(htmlString as String, baseURL: baseUrl)
//        } catch {
//            // catch error
//        }
        
        return PlayerWebView.shared.webView
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
