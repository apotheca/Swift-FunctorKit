import Foundation

// In Haskell:
//  infixl 4 <$>, <$, $>
//  infixl 4 <*>, <*, *>
// NOTE: Use of $ is not allowed, replaced with ^
infix operator <^>  : FmapPrecedence
infix operator <^   : FmapPrecedence
infix operator ^>   : FmapPrecedence
infix operator <*>  : FmapPrecedence
infix operator <*   : FmapPrecedence
infix operator *>   : FmapPrecedence

precedencegroup FmapPrecedence {
    associativity: left
    higherThan: ChoicePrecedence
}

// In Haskell:
// infixl 3 <|>
infix operator <|> : ChoicePrecedence

precedencegroup ChoicePrecedence {
    associativity: left
    higherThan: BindPrecedence
}

// In Haskell:
//  infixl 1  >>=, >>
// NOTE: Use of = is not allowed, replaced with -
// NOTE: Use of >> is taken, replaced with >>|
infix operator >>-  : BindPrecedence
infix operator >>|  : BindPrecedence

precedencegroup BindPrecedence {
    associativity: left
    higherThan: RightBindPrecedence
}

// In Haskell:
//  infixr 1  =<<, <<<, >>>
infix operator -<<  : RightBindPrecedence
infix operator <<<  : RightBindPrecedence
infix operator >>>  : RightBindPrecedence

precedencegroup RightBindPrecedence {
    associativity: right
    higherThan: LabelPrecedence
}

// In Haskell:
//  infix 0 <?>
infix operator <?> : LabelPrecedence

precedencegroup LabelPrecedence {
    associativity: left
    higherThan: TernaryPrecedence
}

public func <<<<A,B,C> (bc: @escaping (B) -> C, ab: @escaping (A) -> B) -> (A) -> C {
    compose(bc, ab)
}

public func >>><A,B,C> (ab: @escaping (A) -> B, bc: @escaping (B) -> C) -> (A) -> C {
    compose(bc, ab)
}
