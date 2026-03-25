#| AST for Rakurust v0: single `fn main() -> i32 { return <expr>; }`.
use v6.d;

unit module Rakurust::AST;

role Node {
}

enum BinOpKind is export <Add Sub Mul Div>;

role Expr does Node is export {
}

class IntLit does Expr is export {
    has Int $.value is required;
}

class BinOp does Expr is export {
    has BinOpKind $.op is required;
    has Expr $.left is required;
    has Expr $.right is required;
}

class Return is export {
    has Expr $.expr is required;
}

class Function is export {
    has Str $.name is required;
    has Return $.body is required;
}

class Program is export {
    has Function $.function is required;
}
