public protocol Semigroup {
    
    static func append(_ a: Self, _ b: Self) -> Self
    
}

extension Array: Semigroup {
    
    public static func append(_ a: Self, _ b: Self) -> Self {
        
        return a + b
        
    }
    
}

public protocol Monoid: Semigroup {
    
    static var empty: Self { get }
    
}

extension Array: Monoid {
    
    public static var empty: Self { return [] }
    
}

//extension /* Foldable */ Array where Element: Monoid {
//    
//    public var concat: Element {
//        return reduce(Element.empty, Element.append)
//    }
//    
//}

