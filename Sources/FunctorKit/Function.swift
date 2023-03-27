//
//  File.swift
//  
//
//  Created by Leo on 2/21/23.
//

import Foundation

public func identity<A>(_ a: A) -> A {
    return a
}

public func const<A,B>(_ a: A) -> (B) -> A {
    return { _ in a }
}

public func skip<A,B>(_ a: A) -> (B) -> B {
    return { b in b }
}

public func compose<A,B,C>(
    _ f: @escaping (B) -> C,
    _ g: @escaping (A) -> B
) -> (A) -> C {
    return { a in f(g(a)) }
}

public func flip<A,B,C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { y in { x in f(x)(y) } }
}

public func apply<A,B>(_ f: (A) -> B, _ a: A) -> B {
    return f(a)
}

// NOTE: This extremely outdated question / answer,
//  https://stackoverflow.com/a/34566264
//  suggests defining fix as:
//      func fix<T,U>(_ f: @escaping Fn<Fn<T,U>,Fn<T,U>>) -> Fn<T,U>
//  However, this is not strictly necessary, and we can go with:
//      func fix<A>(_ f: @escaping Fn<Fn<A,A>,Fn<A,A>>) -> Fn<A,A> {
public func fix<A>(
    _ f: @escaping (@escaping (A) -> A) -> (A) -> A
) -> (A) -> A {
    // We want this, but it causes infinite recursion due to eager evaluation.
    //  return f(fix(f))
    // We simply add an eta-expansion to solve this, and make it lazy.
    //  return { x in ...(x) }
    // It makes the type a little more confusing, but
    //  ((A) -> A) -> (A) -> A
    // Is still just
    //  A -> A
    // in disguise.
    // Note that we cannot define fix as ``((A) -> A) -> A`  because while
    //  `() -> A` and `A` /are the same thing/ in a lazy language, they are
    //  entirely separate types in a strict one like Swift.
    return { x in
        return f(fix(f))(x)
    }
}
// NOTE: We deal with the double escaping rather than the tuple-desugaring issues
//public typealias Fn<Arg,Result> = (Arg) -> Result
//public func fix<A>(
//    _ f: @escaping (Fn<Fn<A,A>,Fn<A,A>>)
//) -> Fn<A,A> {
//    return { x in
//        return f(fix(f))(x)
//    }
//}


// Currying
// Allows us to replace:
//  let plusFn = { x in { y in x + y }}
// With:
//  let plusFn = curry(+)
// This makes it easier to write code like:
//  let plus = curry(+) <^> integer <*> integer
public func curry<A,B,C>(_ f: @escaping (A,B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a,b) } }
}

// Uncurrying
public func uncurry<A,B,C>(_ f: @escaping (A) -> (B) -> C) -> (A,B) -> C {
    return { (a,b) in f(a)(b) }
}

public func curry3<A,B,C,D>(_ f: @escaping (A,B,C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in { b in { c in f(a,b,c) } } }
}
public func uncurry3<A,B,C,D>(_ f: @escaping (A) -> (B) -> (C) -> D) -> (A,B,C) -> D {
    return { (a,b,c) in f(a)(b)(c) }
}
