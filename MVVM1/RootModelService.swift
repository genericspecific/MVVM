import Foundation

struct RootModelService {
    
    static func getAll(completion: NSDictionary -> Void) {
        let path = NSBundle.mainBundle().pathForResource("root", ofType: "json")!
        let url = NSURL(fileURLWithPath: path)
        let data = NSData(contentsOfURL: url)!
        
        // add a delay to fake network latency
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            do {
                try completion(NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary)
            } catch {
                completion(NSDictionary())
            }
        }
    }
}