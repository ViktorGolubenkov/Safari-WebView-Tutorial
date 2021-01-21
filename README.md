# Safari-WebView-Tutorial

Hey guys!
    
In short, I like to learn something new and I decided to write something like this to fix the material in my head. :) 
Moreover, it may be interesting or useful to someone.
Problem: I noticed that some developers use Safari in their applications to present web pages (even when it's only 1 page). This seems strange...
Goal: to learn more and compare two similar, but completely different frameworks.

We'll talk about: SafariServices and WebKit and try to figure out where to use which one is best! OK, It's a good time to remember (or learn) a bit! (I will try to describe here most basic things as much as possible. But i'm sorry if i forget something!)

SafariServices - https://developer.apple.com/documentation/safariservices

WebKit - https://developer.apple.com/documentation/webkit

Level - Beginner/Beginner+

#If you find a bug or want to add something - I will be very happy!

At first, let's take a look at SFSafariViewController
(https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) and how to implement it!

- SAFARI VIEW (SFSafariViewController)
1. Create a Single View App

<img width="363" alt="Снимок экрана 2021-01-20 в 14 29 06" src="https://user-images.githubusercontent.com/65627244/105189600-30d47380-5b46-11eb-9bdb-3d63239a04d8.png"> <img width="363" alt="Снимок экрана 2021-01-20 в 14 30 01" src="https://user-images.githubusercontent.com/65627244/105189594-2fa34680-5b46-11eb-8a99-72fad0e264af.png">


2. Rename your ViewController to SafariViewController (Ctrl+click on the class name -> Refactor -> Rename). Drag the button from the Object Library to the view and create an @IBAction (name your action whatever you want :)

    `@IBAction func showMeGoogleButtonPressed(_ sender: UIButton) { 
    }`
    
![ezgif com-resize](https://user-images.githubusercontent.com/65627244/105191319-fbc92080-5b47-11eb-976c-f2158ef84f79.gif)

3. Add the framework `"import SafariServices"` to the top of your SafariViewController. Add the following lines inside your action:

<img width="403" alt="Снимок экрана 2021-01-20 в 14 47 15" src="https://user-images.githubusercontent.com/65627244/105191484-2f0baf80-5b48-11eb-93e7-031a80857e18.png">

        if let url = URL(string: "https://www.google.com") {
            let safariViewController = SFSafariViewController(url: url)
            
            present(safariViewController, animated: true, completion: nil)
        }



Build and run your app.

![ezgif com-resize-2](https://user-images.githubusercontent.com/65627244/105193704-d50be980-5b49-11eb-84bb-46e02987625e.gif)


Yep, that's it! A few lines of code give us a huge bunch of possibilities! Just take a look at this:
We can go back, go forward, dismiss the view, even open page in the main Safari browser and all this by default! Additionally, we even have auto-detecting of data such as phone numbers (if you're testing on a physical device). And of course, we can customize our "SafariView" (for example `"dismissButtonStyle"` or even create your own custom `"Content Blocker"`). Great!


OK, it's simple and cool at the same time! But what if our web page should initially only show one page or several pages, but strictly related to the home page and forbidding unlimited surfing!? :) Yes, we have one thing!


_____



- WEB VIEW (WKWebView)

1. Let's place a new button on our SafariViewController (something like "Show WebView"). Drag the new button from the Object Library to the view and then create an @IBAction.

    
    `@IBAction func showMeWebViewButtonPressed(_ sender: UIButton) { }`


2. Create another ViewController (let's call it "WebViewController") and related Cocoa Touch Class file (don't forget to connect your new view to the new file in Identity Inspector), add `"import WebKit"` at the top of new file.





3. Create an Present Modally segue by Ctrl + drag from new button "Show WebView" to our WebViewController

<img width="247" alt="ezgif com-resize" src="https://user-images.githubusercontent.com/65627244/105194660-df7ab300-5b4a-11eb-8571-9d3eca6703b4.png">



Build and run your app. When "Show WebView" pressed, you should to see a clear white sheet. Ok, so far so good...



4. Drag the WKWebView from the Object Library to our WebViewController, Ctrl + drag from WKWebView to WebViewController and create Outlet (let's call it "webView").
    
    `@IBOutlet weak var webView: WKWebView!`


5. Add the following lines to your WebViewController:

In `viewDidLoad()`:
        
        let request = URLRequest(url: URL(string: "https://docs.github.com/en/github/site-policy/github-privacy-statement")!)

        webView.load(request)


Build and run your app, push "Show me WebView" button. Let's take a look what we have: something works/something doesn't, we can't go back or forward to previous page, we can't even dismiss this view (honestly, in this case we can swipe down and dismiss the view, but only in this case!). 
`So, "Thank you Apple!" - for being able to customize everything we need! That's cool!` Ok, let's go ahead:


6. Add conformation of our WebViewController with the protocol WKNavigationDelegate like

`"class WebViewController: UIViewController, WKNavigationDelegate {}"`

or use the extension (as I like it) 

`"extension WebViewController: WKNavigationDelegate {}"`

6.1 A small note - Be sure to read the Developer Documentation. "DD" describes everything we need to know about 

`WKUIDelegate` (https://developer.apple.com/documentation/webkit/wkuidelegate) 

and 

`WKNavigationDelegate` (https://developer.apple.com/documentation/webkit/wknavigationdelegate) 

protocols and much more!

6.2 Add the following line to our `"viewDidLoad()"`:

        webView.navigationDelegate = self
        
This line said "WebView, i want to know about every navigation"


7. In this case, we use a simple/fast/familiar to users of the approach of a button. Open the Storyboard, update the size of your WebView. Then drag the three buttons from the Object Library to the free space.

<img width="165" alt="ezgif com-resize-3" src="https://user-images.githubusercontent.com/65627244/105196385-9fb4cb00-5b4c-11eb-950b-818eaff0f62a.png">
    
Add three Actions:

    @IBAction func dismissWebView(_ sender: UIButton) {}
    @IBAction func goBackPressed(_ sender: UIButton) {}
    @IBAction func goForwardPressed(_ sender: UIButton) {}
    
 
    
8. To our `"dismissWebView(_ : )"` action add the following line:

    `dismiss(animated: true, completion: nil)`

Build and run your app. Now we can dismiss the WebView! Great!

But we still need to move back and forward. Ok, let's go!

9. Update actions with the following lines:

    `@IBAction func goBackPressed(_ sender: UIButton) {
    
        self.webView.stopLoading()
        self.webView.goBack()
    }`
    
    and
    
    `@IBAction func goForwardPressed(_ sender: UIButton) {
    
        self.webView.stopLoading()
        self.webView.goForward()
    }`

In order: first we stopped loading the page, then we just ran a method that returns us to the page back or forward from the list.

<img width="496" alt="Снимок экрана 2021-01-20 в 16 26 48" src="https://user-images.githubusercontent.com/65627244/105196752-ffab7180-5b4c-11eb-95d5-37b1d7c27780.png">

Build and run your app again. Now you can move the pages back and forward.



So we don't really need to implement additional methods for WKNavigationDelegate because they are optional, but there is one interesting method...




10. Start typing `"decidePolicy..."` and add the following method to your WebViewController class (or extension):


    `func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    // some code
    }`


To be short, this method checks the condition that you can provide internally before the next page is loaded. In other words, this method says, "I need to check if I can go ahead because you specified some restrictions." 

Yep, let's play with it :) Add some code for this method:


    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if host.contains("docs.github.com") {
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }


Build and run your app. Try to dismiss the WebView, go back and forward through the pages. But, try loading a GitHub page not related to the "docs" section - you can't:)
Right, because in the method below we just said: "decisionHandler, please check if the URL contains docs.github.com".

![ezgif com-resize-3](https://user-images.githubusercontent.com/65627244/105197799-0dadc200-5b4e-11eb-819f-6e0d896381e5.gif)

At this point, I suggest we stop for now! The WebView provides a lot of customization options (for example, `"webView.allowsBackForwardNavigationGestures = true"` will allow you to swipe right and left while navigating through the pages, or we can add a custom toolbar for the navigation buttons at the top or bottom of the screen).

In conclusion, I want to add that by allowing users to navigate to web pages, we must use the right approaches. Especially when our application claims to be high-level. 
I am sure that using Webkit and building a custom webview will be the right solution in 9 out of 10 cases. 
Moreover, the user being in "Safari" can easily open another page, get distracted by advertising and completely forget about our app!

#If you find a bug or want to add something - I will be very happy!



