import Foundation

struct RootModelService {
    
    static func getAll(completion: [NSDictionary] -> Void) {
        let path = NSBundle.mainBundle().pathForResource("root", ofType: "json")!
        let url = NSURL(fileURLWithPath: path)
        let data = NSData(contentsOfURL: url)!
        
        do {
            try completion(NSJSONSerialization.JSONObjectWithData(data, options: []) as! [NSDictionary])
        } catch {
            completion([])
        }
    }
}