public protocol AsyncFunctor: Functor {
    
    func asyncFmap<A>(
        _ transform: @escaping (Content) async throws -> A
    ) async rethrows -> Self where Self.Content == A
    
    func concurrentFmap<A>(
        _ transform: @escaping (Content) async throws -> A
    ) async rethrows  -> Self where Self.Content == A
    
}

/* Default implementation
extension <#Type#>: AsyncFunctor {
    
    public func asyncFmap<A>(
        _ transform: @escaping (Content) async throws -> A
    ) async rethrows -> <#Type#><A> {
        <#Implementation#>
    }
    
    public func concurrentFmap<A>(
        _ transform: @escaping (Content) async throws -> A
    ) async rethrows -> <#Type#><A> {
        let tasks = fmap { a in Task { try await transform(a) } }
        return try await tasks.asyncFmap { task in try await task.value }
    }
}
*/

/*
extension <#Type#>: AsyncRecursive {
    
}
    public static func asyncRefold<A,B>(
       _ a: A,
       ana coalg: @escaping (A) async throws -> <#Type#>F<A>,
       cata alg: @escaping (<#Type#>F<B>) async throws -> B
    ) async rethrows -> B {
       return try await alg(coalg(a).asyncFmap { try await asyncRefold($0, ana: coalg, cata: alg) })
    }

    public static func concurrentRefold<A,B>(
       _ a: A,
       ana coalg: @escaping (A) async throws -> <#Type#>F<A>,
       cata alg: @escaping (<#Type#>F<B>) async throws -> B
    ) async rethrows -> B {
       return try await alg(coalg(a).concurrentFmap { try await concurrentRefold($0, ana: coalg, cata: alg) })
    }

}
*/

// TODO: asyncRefoldMap
