// Indexed functors

public protocol IndexedFunctor: Functor {
    associatedtype ContentIx // Formerly 'Index' but this clashes with existing Swift
    func indexmap<A>(_ f: @escaping (ContentIx,Content) throws -> A) rethrows -> Self where Self.Content == A
}

// Indexed recursive and base functor

public protocol IndexedRecursive: Recursive where Base: IndexedBaseFunctor, Path == [Base.Iter] {
    associatedtype Path
}

public protocol IndexedBaseFunctor: BaseFunctor {
    associatedtype Iter
}

// Indexed bifunctors

public protocol IndexedBifunctor: IndexedFunctor, Bifunctor where ContentIx == SecondIx {
    associatedtype FirstIx
    associatedtype SecondIx
    func indexbimap<A,B>(
        _ first: @escaping (FirstIx,First) throws -> A,
        _ second: @escaping (SecondIx,Second) throws -> B
    ) rethrows -> Self where Self.First == A, Self.Second == B
}

// Indexed recursive functor and base bifunctor

public protocol IndexedRecursiveFunctor:
    IndexedFunctor,
    IndexedRecursive,
    RecursiveFunctor
where
    Base: IndexedBaseBifunctor,
    // We can hardcode the index type for composite indices, ignoring many qualities
    ContentIx == (Path,Base.Ix)
    // OR we can admit that Path is FixF IterF () and Index is FixF IterF Ix
    // We do not need trifunctors because recursion dictates that the outer / sinister
    //  layer only knows about the median / middle layer, which in turn only knows
    //  about the inner / dexter layer. Chained bifunctors are enough, and the sinister / dexter
    //  must inform the median for any information to cross to the other.
{
    // OR we can soften the restriction by instead just requiring that we be able to
    // build an index out of iters and ix:
    //static func toIndex(_ path: Path, _ ix: Base.Ix) -> ContentIx
    
}

public protocol IndexedBaseBifunctor: BaseBifunctor, IndexedBaseFunctor, IndexedBifunctor where Ix == FirstIx, Iter == SecondIx {
    associatedtype Ix
//    func indexbimap<A,B>(
//        _ first: @escaping (Ix,First) throws -> A,
//        _ second: @escaping (Iter,Second) throws -> B
//    ) rethrows -> Self where Self.First == A, Self.Second == B
}
