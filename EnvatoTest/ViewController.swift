//
//  ViewController.swift
//  EnvatoTest
//
//  Created by Илья on 22.01.16.
//  Copyright © 2016 treedeo. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {
    let defaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var request: UIButton!
    @IBOutlet weak var label: UILabel!
    var token = ""
    let oauthswift = OAuth2Swift(
        consumerKey:"stocks-project-0nqclhez",         // 2 Enter google app settings
        consumerSecret: "xdBXmJ4VqrQVFixSwvUwslHVsLkm86mD",
        authorizeUrl:   "https://api.envato.com/authorization",
        accessTokenUrl: "https://api.envato.com/token",
        responseType:   "code"
    )
    @IBOutlet weak var auth: UIButton!
    @IBAction func auth(sender: AnyObject) {
          oauthswift.authorize_url_handler = WebViewController()
            oauthswift.authorizeWithCallbackURL(
            NSURL(string:"com.treedeo.EnvatoTest:/oauth2Callback")!,
            scope: "",        // 4 Scope
            state: "",
            success: { credential, response, parameters in
               // print(credential.oauth_token)
                if credential.oauth_token != "" {
                self.defaults.setValue(credential.oauth_token, forKey:"token")
                self.authSuccess()
                }
//                print(credential.oauth_token_secret)
//                print(parameters["username"])
            },
            failure: { error in
                print(error.localizedDescription)
        } )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.valueForKey("token") == nil {
            label.text = "Требует авторизация"
            auth.enabled = true
            request.enabled = false
        } else {
            authSuccess()
        }
    }
    func authSuccess() {
        label.text = "Мы внутри"
        auth.enabled = false
        request.enabled = true
        token = defaults.valueForKey("token")! as! String
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func request(sender: AnyObject) {
        oauthswift.client.request("https://api.envato.com/v1/market/private/user/account.json", method: .POST, parameters: [:], headers: ["Authorization":"Bearer \(token)"], success: { data, response in
            let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
            self.label.text = (jsonDict["account"] as! NSDictionary)["balance"] as? String
            }, failure: { error in
           print(error.localizedDescription)
            
                
        })
//        oauthswift.client.request("https://api.linkedin.com/v1/people/~", .GET,
//            parameters: [:], headers: [:],
//            success: { }
    }
}

