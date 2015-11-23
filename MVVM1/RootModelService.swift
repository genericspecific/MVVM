import Foundation

struct RootModelService {
    
    static func getAll() throws -> [NSDictionary] {
        let path = NSBundle.mainBundle().pathForResource("root", ofType: "json")!
        let url = NSURL(fileURLWithPath: path)
        let data = NSData(contentsOfURL: url)!
        
        return try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [NSDictionary]
    }
}