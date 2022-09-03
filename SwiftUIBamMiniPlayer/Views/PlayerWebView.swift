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
        let handler = MessageHandler.shared
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

// MARK: - Javascript message handler
class MessageHandler: NSObject, WKScriptMessageHandler, ObservableObject {
    
    // MARK: - Properties
    @Published var isPlayerViewVisible: Bool = false
    @Published var isPlayerMinimised: Bool = false
    
    // Singleton object
    static let shared: MessageHandler = MessageHandler()
    private override init() {}

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard message.name == "bambuserEventHandler" else {
            print("No handler for this message: \(message)")
            return
        }
        
        guard let body = message.body as? [String: Any] else {
            print("could not convert message body to dictionary: \(message.body)")
            return
        }
        
        // Check all available events on our Player API Reference
        // https://bambuser.com/docs/one-to-many/player-api-reference/
        // Here we only handled the following  'player.EVENT.READY' and 'player.EVENT.CLOSE' events as for example.
        
        guard let eventName = body["eventName"] as? String else { return }
        switch eventName {
            // MARK: - Handle "Close"
        case "player.EVENT.CLOSE":
            // Add your handler methods if needed
            // As an example we invoke the close() method
            //close()
            print(body["eventName"] ?? "Default Event Name")
            
            // MARK: - Handle "Ready"
        case "player.EVENT.READY":
            // Add your handler methods if needed
            // As an example we print a message when the 'player.EVENT.READY' is emitted
            print(body["eventName"] ?? "Default Event Name")
            
//            // MARK: - Handle "Add to calendar"
//        case "player.EVENT.SHOW_ADD_TO_CALENDAR":
//            if let data = body["data"] as? [String: AnyObject] {
//                let dateFormatter = ISO8601DateFormatter()
//                dateFormatter.formatOptions.insert(.withFractionalSeconds)
//
//                guard
//                    let title = data["title"] as? String,
//                    let description = data["description"] as? String,
//                    let startString = data["start"] as? String,
//                    let startDate = dateFormatter.date(from: startString),
//                    let duration = data["duration"] as? TimeInterval,
//                    let urlString = data["url"] as? String,
//                    let url = URL(string: urlString)
//                else { return }
//
//                // Create the end date by adding the durations, dividing by 1000 to convert from milliseconds to seconds
//                let endDate = startDate.addingTimeInterval(duration / 1000)
//
//                // Create the calendar event
//                let showEvent = CalendarEvent(
//                    title: title,
//                    description: description,
//                    startDate: startDate,
//                    endDate: endDate,
//                    url: url
//                )
//
//                // Save to default calendar
//                // NOTE: Don't forget to set the 'NSCalendarsUsageDescription' key in 'Info.plist'. Otherwise, the app
//                // will crash in runtime.
//                showEvent.saveToCalendar { [weak self] result in
//                    guard let self = self else { return }
//                    switch result {
//                    case .success(_):
//                        self.showAlert("Saved to calendar", "The show event was saved in the calendar.")
//                    case .failure(let error):
//                        self.showAlert("Error", error.localizedDescription)
//                    }
//                }
//            }
//
//            // MARK: - Handle share events
//        case "player.EVENT.SHOW_SHARE":
//            guard
//                let data = body["data"] as? [String: AnyObject],
//                let urlString = data["url"] as? String,
//                let url = URL(string: urlString)
//            else { return }
//
//            // Create an activity view controller containing the URL to share
//            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
//            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
//
//            // Present the activity view controller
//            present(activityViewController, animated: true, completion: nil)
//
            // MARK: - Handle product clicks
        case "player.EVENT.SHOW_PRODUCT_VIEW":
            // Get the data needed for presenting the product
            guard
                let data = body["data"] as? [String: AnyObject],
                //                let url = data["url"] as? String,
                //                let id = data["id"] as? String,
                    //                let vendor = data["vendor"] as? String,
                    let title = data["title"] as? String,
                //                let actionOrigin = data["actionOrigin"] as? String,
                //                let actionTarget = data["actionTarget"] as? String,
                    let sku = data["sku"] as? String

            else { return }
            
            print("sku: \(sku)")
            isPlayerMinimised = true
            //self.observablePlayerState.isChildViewVisible = true

            
        default:
            print("eventName", "This event does not have a handler for event \(eventName)!")
        }
    }
}
