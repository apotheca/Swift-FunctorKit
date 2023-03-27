public protocol Profunctor: Functor where Co == Content {
    
    associatedtype Contra
    associatedtype Co
    
    func dimap<A,B>(
        _ contramap: @escaping (A) throws -> Contra,
        _ comap: @escaping(Co) throws -> B
    ) rethrows -> Self where Self.Contra == A, Self.Co == B
    
    func contramap<A>(
        _ contra: @escaping (A) throws -> Contra
    ) rethrows -> Self where Self.Contra == A
    
    func comap<A>(
        _ co: @escaping(Co) throws -> A
    ) rethrows -> Self where Self.Co == A
    
}
