# Raku features used in Rakurust

This file is the living catalog of **Raku language features** the compiler uses, and where they appear. Extend it whenever you introduce or substantially rely on a new feature.

## Conventions

- Add or extend a row in the **same change** as the code.
- **Where** uses stable names (subroutine, rule, type) so you can `grep` the tree.

## Catalog

| Raku feature | Module / file | Where | What it demonstrates |
|--------------|---------------|-------|------------------------|
| `grammar` / `rule` / `token` | [lib/Rakurust/Grammar.rakumod](../lib/Rakurust/Grammar.rakumod) | `Rakurust::Grammar`, `TOP`, `expr`, `term`, `factor` | Declarative parsing with whitespace-aware `rule` vs `token` |
| Action class + `make` | [lib/Rakurust/Grammar.rakumod](../lib/Rakurust/Grammar.rakumod) | `Rakurust::Grammar::Actions` | Building AST values from parse tree |
| `given` / `when` | [lib/Rakurust/Grammar.rakumod](../lib/Rakurust/Grammar.rakumod) | `addop-kind`, `mulop-kind` | Readable mapping from lexeme to enum |
| `given` / `when` | [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | `llvm-i32-op` | Mapping `BinOpKind` → LLVM instruction names |
| `role` / `class` composition | [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod) | `Node`, `Expr`, `IntLit`, `BinOp` | Shared behavior on AST roles; concrete node classes |
| `enum` | [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod) | `BinOpKind` | Safe, named operator variants |
| `is required` | [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod) | AST class attributes | Construction fails fast without required slots |
| `proto` / `multi` methods | [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | `Emitter.emit-expr` | Open dispatch on AST shapes (visitor-style codegen) |
| `gather` / `take` | [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | `Emitter.emit-program` | Lazy list of IR lines joined into one string |
| Private method | [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | `!fresh-temp` | Lexical encapsulation of SSA name generation |
| `Str()` coercion | [lib/Rakurust.rakumod](../lib/Rakurust.rakumod) | `compile`, `parse-ast` | Accept `Str` or coercible types for source text |
| `subset` / `where` | [bin/rakurust.raku](../bin/rakurust.raku) | `ExistingFile` | CLI path must exist and be a plain file |
| `multi MAIN` | [bin/rakurust.raku](../bin/rakurust.raku) | `MAIN` candidates | Separate entry points for compile vs help |
| `unit module` | [lib/Rakurust.rakumod](../lib/Rakurust.rakumod), [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod) | top of file | Whole file is one package, less boilerplate |
| `is export` | [lib/Rakurust.rakumod](../lib/Rakurust.rakumod), [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod), [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | selected subs / types | Public API for consumers and tests |
| `Test` + `plan` / `ok` / `is` | [t/01-compile-run.t](../t/01-compile-run.t) | whole file | TAP integration tests with assertions |
| `run` / `Proc` | [t/01-compile-run.t](../t/01-compile-run.t) | `compile-and-run-exit` | Driving `clang` and the emitted binary |
| `IO::Path` (`slurp` / `spurt` / `mkdir`) | [bin/rakurust.raku](../bin/rakurust.raku), [t/01-compile-run.t](../t/01-compile-run.t) | CLI + tests | File I/O without shelling out for reads/writes |

## Planned / not yet used

Ideas for later milestones (grammar growth, `let`, branches, more tests):

- `proto token` / `token` multis in the grammar for extensible lexing
- `state` on the emitter for temp IDs (currently a normal attribute reset per program)
- `hyper` or parallel testing of fixtures
- `Junction` in tests only if it clarifies multi-case expectations
- `macro` (experimental) — only if there is a compelling metaprogramming demo
