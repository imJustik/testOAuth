import UIKit

var requestCount = 0

class MyURLProtocol: NSURLProtocol {
    override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        print("Request #\(requestCount++): URL = \(request.URL!.absoluteString)")
        if let u = request.URL!.absoluteString.rangeOfString("https://com.treedeo.envatotest/oauth2Callback?code=") {
            let code = request.URL!.absoluteString.substringFromIndex(u.endIndex)
            print("******* \(code) *********")
             UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
            return false
        }
        return false
    }
}