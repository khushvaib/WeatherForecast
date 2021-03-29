//
//  HelpViewController.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 28/03/21.
//

import UIKit
import WebKit

class HelpViewController: RootViewController {

    @IBOutlet weak var webView: WKWebView!
    var htmlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.setTitle("Help")
        webView.loadHTMLString(loadHtmlString(), baseURL: nil)
        // Do any additional setup after loading the view.
    }

}

func loadHtmlString() -> String{
    
    let html2 = """
    <html>
    <head>
        <title>Weather Forecast</title>
    </head>
    <body style='font-family:Arial'>
                <font size='6' color= 'white'>
        <p>
    <h1>Home Screen:</h4>
    1. List of previously bookmarked locations will be shown on this screen.
            <br/>
    2. User can delete the location on home screen by left swipe.
            <br/>
    3. To add new location just tap on "tap to add" button and you will be redirected to the map screen.
            <br/>
            <br/>
            <h1>Additional buttons on home screen:</h4>
    1. "tap to add" this tap can redirect you to map screen where you will be able to add your city to see weather forecast.
            <br/>
    2. Help button on top right side takes you to help section where all the app uses instruction are written.
            <br/>
            <br/>
            <h1>Map Screen:</h4>
    1. On this screen you will be redirected to current location, now you can add your desired city to get the weather forecast.
            <br/>
    2. Once you enter a city cannot be added twice.
            <br/>
            <br/>
            <h1>City Screen:</h4>
    1. This screen will be open once you tap on any of the bookmarked location.
            <br/>
    2. Weather related information will be shown here.
            <br/>
    3. <b>You can see the temprature in Farhenite and Celsius on tap of temprature.</b>
            <br/>
        </p>
    </font>
    </body>
    </html>
    """
    return html2
}
