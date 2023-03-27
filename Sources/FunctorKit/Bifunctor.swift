public protocol Bifunctor: Functor where Second == Content {
    
    associatedtype First
    associatedtype Second
    
    func bimap<A,B>(
        _ first: @escaping (First) throws -> A,
        _ second: @escaping (Second) throws -> B
    ) rethrows -> Self where Self.First == A, Self.Second == B
    
    func first<A>(
        _ f: @escaping (First) throws -> A
    ) rethrows -> Self where Self.First == A
    
    func second<A>(
        _ f: @escaping (Second) throws -> A
    ) rethrows -> Self where Self.Second == A
    
}

/* Default RecursiveFunctor implementation:
extension <#Type#>: Bifunctor {

    public func bimap<A, B>(
        _ first: @escaping (First) throws -> A,
        _ second: @escaping (Second) throws -> B
    ) rethrows -> <#Type#>F<A,B> {
        <#Implementation#>
    }

    public func first<A>(_ f: @escaping (First) throws -> A) rethrows -> <#Type#>F<A, Second> {
        return try bimap(f, identity)
    }

    public func second<A>(_ f: @escaping (Second) throws -> A) rethrows -> <#Type#>F<First, A> {
        return try bimap(identity, f)
    }
 
 }
 */

// TODO: Clown, Joker, et al.
