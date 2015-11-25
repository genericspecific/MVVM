import Foundation

struct DetailModelService {
    
    static func get(id: Int, completion: NSDictionary? -> Void) {
        let path = NSBundle.mainBundle().pathForResource("item1", ofType: "json")!
        let url = NSURL(fileURLWithPath: path)
        let data = NSData(contentsOfURL: url)!
        
        let output: NSDictionary?
        do {
            output = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
        } catch {
            output = nil
        }
        completion(output)
    }
}