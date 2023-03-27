extension Dictionary: Functor {

    public typealias Content = Value
    
    public func fmap<A>(_ f: @escaping (Value) throws -> A) rethrows -> Dictionary<Key,A> {
        return try mapValues(f)
    }
    
    public static func <^><A>(fn: @escaping (Value) throws -> A, a: [Key:Value]) rethrows -> [Key:A] {
        return try a.fmap(fn)
    }
    
}

extension Dictionary: AsyncFunctor {
    
    public func asyncFmap<A>(_ transform: @escaping (Content) async throws -> A) async rethrows -> Dictionary<Key,A> {
        return try await asyncMapValues(transform)
    }
    
    public func concurrentFmap<A>(_ transform: @escaping (Content) async throws -> A) async rethrows -> Dictionary<Key,A> {
        return try await concurrentMapValues(transform)
    }
    
    public func asyncMapValues<A>(_ transform: @escaping (Value) async throws -> A) async rethrows -> Dictionary<Key,A> {
        var result: [Key:A] = [:]
        for kvp in self {
            try await result.updateValue(transform(kvp.value), forKey: kvp.key)
        }
        return result
    }
    
    public func concurrentMapValues<A>(_ transform: @escaping (Value) async throws -> A) async rethrows -> Dictionary<Key,A> {
        let tasks = self.mapValues { element in Task { try await transform(element) } }
        return try await tasks.asyncMapValues { try await $0.value }
    }
    
}


//extension Dictionary: IndexedFunctor where Key: Hashable {
//
//    public typealias Index = Key
//
//    // TODO: Ponder whether this should be curried or uncurried.
//    //  For now, leave it uncurried, it's more swifty.
//    public func indexmap<A>(_ f: @escaping (Key, Value) throws -> A) rethrows -> Dictionary<Key,A> {
//        return try Dictionary<Key,A>(uniqueKeysWithValues: map { k, v in try (k,f(k,v)) })
//    }
//
//}

extension Dictionary: IndexedFunctor where Key: Hashable {
    
    public typealias ContentIx = Key
    
    public func indexmap<A>(_ f: @escaping (Key, Value) throws -> A) rethrows -> Dictionary<Key, A> {
        fatalError()
    }
    
    
}
