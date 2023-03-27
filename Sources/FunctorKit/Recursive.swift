public protocol Recursive where Base.Content == Self {
    
    associatedtype Base: BaseFunctor // Functor
    
    func project() -> Base
    
}

/* Default Recursive implementation:
extension <#Type#>: Recursive {
    
    public typealias Base = <#Type#>F<Self>
    
    public func project() -> Base {
        <#Implementation#>
    }
    
    public func fold<A>(cata alg:  @escaping (<#Type#>F<A>) throws -> A) rethrows -> A {
        return try Self.fold(self, cata: alg)
    }
    
    public static func fold<A>(
       _ a: <#Type#>,
       cata alg:  @escaping (<#Type#>F<A>) throws -> A
    ) rethrows -> A {
       return try refold(a, ana: { $0.project() }, cata: alg)
    }

    public static func unfold<A>(
       _ a: A,
       ana coalg: @escaping (A) throws -> <#Type#>F<A>
    ) rethrows -> <#Type#> {
       return try refold(a, ana: coalg, cata: { $0.embed() })
    }

    public static func refold<A,B>(
       _ a: A,
       ana coalg:  @escaping(A) throws -> <#Type#>F<A>,
       cata alg:  @escaping(<#Type#>F<B>) throws -> B
    ) rethrows -> B {
       return try alg(coalg(a).fmap { try refold($0, ana: coalg, cata: alg) })
    }
    
}
*/

public protocol BaseFunctor: Functor where Fix.Base == Self {
    
    associatedtype Fix: Recursive
    
    func embed() -> Fix
    
}

/* Default BaseFunctor implementation
extension <#Type#>F: BaseFunctor where Content == <#Type#> {
    
    public typealias Fix = <#Type#>
    
    public func embed() -> Fix {
        <#Implementation#>
    }
    
}
*/
