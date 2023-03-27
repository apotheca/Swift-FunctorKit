// NOTE: Foldable
//  Reduce comes from Sequence, but it should be Sequence: Foldable / Reducible
//  because Sequence implies other things too.
public protocol Foldable {
    
    associatedtype Content
    
    // foldl :: (b -> a -> b) -> b -> t a -> b
    func foldl<Result>(
        _ empty: Result,
        _ append: (Result, Content) throws -> Result
    ) rethrows -> Result
    
    func foldr<Result>(
        _ empty: Result,
        _ append: (Content, Result) throws -> Result
    ) rethrows -> Result
    
    func foldMap<Result>(
        _ map: (Content) throws -> Result
    ) rethrows -> Result where Result: Monoid
    
}

extension Foldable where Content: Monoid {
    
    public func foldMonoid() -> Content {
        return foldMap(identity)
    }
    
}

extension Array: Foldable {
    
    public func foldl<Result>(
        _ empty: Result,
        _ append: (Result, Element) throws -> Result
    ) rethrows -> Result {
        return try reduce(empty, append)
    }
    
    public func foldr<Result>(
        _ empty: Result,
        _ append: (Element, Result) throws -> Result
    ) rethrows -> Result {
        return try reversed().reduce(empty) { try append($1,$0) }
    }
    
    public func foldMap<Result>(
        _ map: (Element) throws -> Result
    ) rethrows -> Result where Result : Monoid {
        return try foldr(Result.empty) {try Result.append(map($0),$1) }
    }
}


extension Dictionary: Foldable {
    
    public func foldl<Result>(
        _ empty: Result,
        _ append: (Result, Value) throws -> Result
    ) rethrows -> Result {
        return try Array(values).foldl(empty, append)
    }
    
    public func foldr<Result>(
        _ empty: Result,
        _ append: (Value, Result) throws -> Result
    ) rethrows -> Result {
        //return try Array(values).reversed().reduce(empty, flip(append))
        return try Array(values).reversed().reduce(empty) { try append($1,$0) }
    }
    
    public func foldMap<Result>(
        _ map: (Value) throws -> Result
    ) rethrows -> Result where Result : Monoid {
        return try Array(values).foldr(Result.empty) {try Result.append(map($0),$1) }
    }
}
