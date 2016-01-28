import UIKit
import OAuthSwift

class WebViewController: OAuthWebViewController{
    var targetURL : NSURL?
    var webView : UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.bounds
        webView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        webView.scalesPageToFit = true
        view.addSubview(webView)
        targetURL = NSURL(string: "https://api.envato.com/authorization?response_type=code&client_id=stocks-project-0nqclhez&redirect_uri=https://com.treedeo.EnvatoTest:/oauth2Callback")
        loadAddressURL()
    }
    func loadAddressURL() {
        if let targetURL = targetURL {
            let req = NSURLRequest(URL: targetURL)
            webView.loadRequest(req)
        }
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
       return true
    }
}