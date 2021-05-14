
import Foundation

public struct System: Decodable, CustomStringConvertible {
    
    private enum SystemCodingKey: String, CodingKey {
        
        case country = "country"
        case sunrise = "sunrise"
        case sunset  = "sunset"
    }
    
    public var country: String
    
    public var sunrise: Int
    public var sunset:  Int
    
    public var description: String {
        return "(country: \(country), sunrise: \(sunrise), sunset: \(sunset))"
    }
    
    internal init() {
        self.country = ""
        self.sunrise = 0
        self.sunset  = 0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SystemCodingKey.self)
        
        self.country = (try? container.decode(String.self, forKey: .country)) ?? ""
        self.sunrise = (try? container.decode(Int.self,    forKey: .sunrise)) ?? 0
        self.sunset  = (try? container.decode(Int.self,    forKey: .sunset))  ?? 0
    }
}
