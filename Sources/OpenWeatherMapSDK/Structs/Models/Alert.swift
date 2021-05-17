
import Foundation

public struct Alert: Decodable, CustomStringConvertible {
    
    private enum AlertCodingKey: String, CodingKey {
        
        case senderName = "sender_name"
        case event      = "event"
        case start      = "start"
        case end        = "end"
        case text       = "description"
    }
    
    public var senderName: String
    public var event:      String
    public var start:      Int
    public var end:        Int
    public var text:       String
    
    public init() {
        self.senderName = ""
        self.event      = ""
        self.start      = 0
        self.end        = 0
        self.text       = ""
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlertCodingKey.self)
        
        self.senderName = (try? container.decode(String.self, forKey: .senderName)) ?? ""
        self.event      = (try? container.decode(String.self, forKey: .event))      ?? ""
        self.start      = (try? container.decode(Int.self,    forKey: .start))      ?? 0
        self.end        = (try? container.decode(Int.self,    forKey: .end))        ?? 0
        self.text       = (try? container.decode(String.self, forKey: .text))       ?? ""
    }
    
    public var description: String {
        return "(sender name: \(senderName), event: \(event), start: \(start), end: \(end), text: \(text))"
    }
}
