//
//  WebViewMessageHandler.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-03.
//

import SwiftUI
import WebKit

class WebViewMessageHandler: NSObject, WKScriptMessageHandler {
    // MARK: - Properties

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
            PlayerStatus.shared.isPlayerMinimised = true
            //self.observablePlayerState.isChildViewVisible = true

            
        default:
            print("eventName", "This event does not have a handler for event \(eventName)!")
        }
    }
}
