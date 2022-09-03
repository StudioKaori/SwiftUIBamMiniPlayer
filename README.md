# SwiftUI + WebView Mini Player

Foobar is a Python library for dealing with word pluralization.

## Installation

Open the project with Xcode


## Update

### 2022/09/03 update
### Issue: Non SwiftUI View class cannot access to Environmental object

Message handler class is dealing with communication between JS on Webview and native app. But it’s non SwiftUI View class and cannot access to Environmental object

#### -> Change Message Handler to a singleton object

Message Handler class will be the owner of the player statuses (isPlayerViewVisible, isPlayerMinimised) instead of the Environmental object.

To hold consistent player statuses, I created singleton instance of Message Handler (name: MessageHandler.shared)

### Issue: To make mini player visible over the other view

The mini player must be over any visible views such as product page, home page etc

#### -> Set playerView over the navigation link

So that the playerView is always top of any views (pages)

For that, declared the following observable variables in Environmental project

```
@Published var isPlayerViewVisible: Bool = false
@Published var isPlayerMinimised: Bool = false
```


## License
[MIT](https://choosealicense.com/licenses/mit/)
