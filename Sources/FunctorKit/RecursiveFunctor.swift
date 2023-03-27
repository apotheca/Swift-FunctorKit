// We could do this:
/*
public protocol RecursiveFunctor: Recursive, Functor where BaseF.First == Content, BaseF.Second == Self {
    associatedtype BaseF: BaseBifunctor
    func project() -> BaseF
}

public protocol BaseBifunctor: Bifunctor, BaseFunctor where FixF.BaseF == Self {
    associatedtype FixF: RecursiveFunctor
    func embed() -> FixF
}
*/
// Or we could just unify it all.

public protocol RecursiveFunctor: Recursive, Functor where Base: BaseBifunctor, Base.First == Content, Base.Second == Self {
    
}

/* Default RecursiveFunctor implementation:
extension <#Type#>: RecursiveFunctor {
    
    public func fold<A,B>(
        map   fn:  @escaping (Content) throws -> A,
        cata alg:  @escaping (<#Type#>F<A,B>) throws -> B
    ) rethrows -> B {
        return try Self.fold(self, map: fn, cata: alg)
    }
    
    public static func fold<A,B>(
        _ a: <#Type#>,
        map   fn:  @escaping (Content) throws -> A,
        cata alg:  @escaping (<#Type#>F<A,B>) throws -> B
    ) rethrows -> B {
        return try refold(a, ana: { $0.project() }, map: fn, cata: alg)
    }
    
    public static func unfold<A,B>(
        _ a: A,
        ana coalg: @escaping (A) throws -> <#Type#>F<Content,A>,
        map    fn:    @escaping (Content) throws -> B
    ) rethrows -> <#Type#><B> {
        return try refold(a, ana: coalg, map: fn, cata: { $0.embed() })
    }
    
    // NOTE: fmap(fn) == Self.refold(self, ana: { $0.project() }, map: fn, cata: { $0.embed() })
    public static func refold<A,B,C>(
        _ a: A,
        ana coalg: @escaping (A) throws -> <#Type#>F<Content,A>,
        map    fn: @escaping (Content) throws -> B,
        cata  alg: @escaping (<#Type#>F<B,C>) throws -> C
    ) rethrows -> C {
        return try alg(coalg(a).bimap(
            { try fn($0) },
            { try refold($0, ana: coalg, map: fn, cata: alg) }
        ))
    }
    
}
*/

public protocol BaseBifunctor: Bifunctor, BaseFunctor where Fix: RecursiveFunctor, Fix.Content == First, Fix == Second {
    
}

/* Default BaseBifunctor implementation:
extension <#Type#>F: BaseBifunctor where First == Fix.Content, Second == Fix {
 
}
*/




