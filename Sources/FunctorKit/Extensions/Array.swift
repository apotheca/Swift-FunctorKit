extension Array: Functor {

    public typealias Content = Element
    
    public func fmap<A>(_ f: @escaping (Content) throws -> A) rethrows -> Array<A> {
        return try map(f)
    }
    
    public static func <^><A>(fn: @escaping (Element) throws -> A, a: [Element]) rethrows -> [A] {
        return try a.fmap(fn)
    }
    
}

extension Array: AsyncFunctor {
    
    public func asyncFmap<A>(_ transform: (Element) async throws -> A) async rethrows -> Array<A> {
        var result: [A] = []
        for element in self {
            try await result.append(transform(element))
        }
        return result
    }
    
    public func concurrentFmap<A>(_ transform: @escaping (Element) async throws -> A) async rethrows -> Array<A> {
        let tasks = self.fmap { element in Task { try await transform(element) } }
        return try await tasks.asyncFmap { try await $0.value }
    }
    
}

extension Array: IndexedFunctor {
    
    public typealias Index = Int
    
    public func indexmap<A>(_ f: @escaping (Int, Element) throws -> A) rethrows -> Array<A> {
        return try enumerated().map(f)
    }
    
}

extension Array where Element == String {
    public var unwords: String {
        return joined(separator: " ")
    }
}

extension String {
    public var words: [String] {
        return split(separator: " ").map { String($0) }
    }
}

