public protocol Functor {
    
    associatedtype Content
    
    func fmap<A>(
        _ f: @escaping (Content) throws -> A
    ) rethrows -> Self where Self.Content == A
    
}

/* Default implementation:
extension <#Type#>: Functor {
 
    typealias Content = <#Content#>
    
    public func fmap<A>(_ f: @escaping (<#Content#>) throws -> A) rethrows -> <#Type#><A> {
        <#Implementation#>
    }
 
     public static func <^><A>(fn: @escaping (<#Content#>) throws -> A, a: <#Type#><<#Content#>>) rethrows -> <#Type#><A> {
         return try a.fmap(fn)
     }
 
 }
 */
