# FunctorKit

A prelude for programming with functors. Still under major construction.

# Importing

Importing requires a little care.

In package platforms, to support concurrency and async / await:

```swift
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
```

Note that the repository is `Swift-FunctorKit`, but the package / library are just `FunctorKit`.

In package dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/apotheca/Swift-FunctorKit", from: "0.1.0")
],
```

In target dependencies:

```swift
dependencies: [
    .product(name: "FunctorKit", package: "Swift-FunctorKit"),
]),
```

# Contents

Anything with a checkmark ☑ is mostly stable, though it may experience nomenclature changes.

Anything missing a checkmark ☐ is unstable, and its implementation is unfinished or subject to change.

## Features

- ☑ Operators
- ☐ Clean code
- ☐ Nomenclature
- ☐ Implementations
- ☐ Documentation
- ☐ Example
- ☐ Unit tests

## Functor and recursive protocols

- ☑ Monoid
- ☑ Functor
- ☑ Foldable
- ☑ Bifunctor
- ☐ Bifoldable
- ☑ Profunctor
- ☑ Recursive and BaseFunctor
- ☐ RecursiveFunctor and BaseBifunctor
- ☐ Indexed, Itered, Pathed
- ☐ Recursion Schemes
- ☐ Annotation Schemes
- ☐ AsyncFunctor

## Functor types

- ☐ Both
- ☐ Either
- ☐ Func
- ☐ Identity
- ☐ Pair

## Recursive number types

- ☐ Nat
- ☐ Bin

## Recursive functor types

- ☐ BinTree
- ☐ List
- ☐ Tree
- ☐ Map

## Recursion / annotation schemes

- ☐ And
- ☐ Or
- ☐ Xor
- ☐ Onto
- ☐ Unto

# Gotchas

Many functions are not expressible due to lack of higher-order types. Instead, there are default implementations of functions in the source files.
