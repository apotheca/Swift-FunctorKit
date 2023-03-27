import FunctorKit

// In Haskell:
// fact n = if n == 0 then 1 else n * fact (n-1) in fact 5
// 120

func fact(_ n: Int) -> Int {
    if n == 0 {
        return 1
    } else {
        return n * fact(n - 1)
    }
}
let a = fact(20)
print(a)

// In Haskell
// fix (\rec n -> if n == 0 then 1 else n * rec (n-1)) 5
// 120

let fixFact = fix { rec in { n in
    if n == 0 {
        return 1
    } else {
        return n * rec(n - 1)
    }
} }
let b = fixFact(20)
print(b)
// Prints:
// 2432902008176640000
