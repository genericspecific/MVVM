import Foundation

struct DetailModelService {
    
    static func get(id: Int) throws -> NSDictionary {
        let path = NSBundle.mainBundle().pathForResource("item1", ofType: "json")!
        let url = NSURL(fileURLWithPath: path)
        let data = NSData(contentsOfURL: url)!
        
        return try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
    }
}