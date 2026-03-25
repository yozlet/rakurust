# Raku features used in Rakurust

This file is the living catalog of **Raku language features** the compiler uses, and where they appear. Extend it whenever you introduce or substantially rely on a new feature.

For project goals and roadmap, see **[PLAN.md](PLAN.md)**.

## Raku documentation sources

- **Rendered site:** [docs.raku.org](https://docs.raku.org/) (updated from the upstream repo; anchors can move between releases).
- **Vendor copy:** the official [Raku/doc](https://github.com/Raku/doc) repository is included as a **shallow** Git submodule at [`vendor/raku-doc/`](../vendor/raku-doc/). After cloning Rakurust, fetch it with:
  ```bash
  git submodule update --init --depth 1
  ```
  The **Source** links in the table below point at `.rakudoc` files in that tree (they match the commit the submodule is pinned to, not necessarily the live website).

## Conventions

- Add or extend a row in the **same change** as the code.
- **Where** uses stable names (subroutine, rule, type) so you can `grep` the tree.
- **Documentation** pairs **HTML** (docs.raku.org, for reading) with **Source** (paths under `vendor/raku-doc/doc/`, for grep and diffs against upstream).

## Catalog

| Raku feature | Module / file | Where | What it demonstrates | Documentation |
|--------------|---------------|-------|----------------------|---------------|
| `grammar` / `rule` / `token` | [lib/Rakurust/Grammar.rakumod](../lib/Rakurust/Grammar.rakumod) | `Rakurust::Grammar`, `TOP`, `expr`, `term`, `factor` | Declarative parsing with whitespace-aware `rule` vs `token` | HTML: [Grammars](https://docs.raku.org/language/grammars), [Rules](https://docs.raku.org/language/grammars#Rules) · Source: [`doc/Language/grammars.rakudoc`](../vendor/raku-doc/doc/Language/grammars.rakudoc) |
| Action class + `make` | [lib/Rakurust/Grammar.rakumod](../lib/Rakurust/Grammar.rakumod) | `Rakurust::Grammar::Actions` | Building AST values from parse tree | HTML: [Action objects](https://docs.raku.org/language/grammars#Action_objects), [`make`](https://docs.raku.org/routine/make) · Source: [`grammars.rakudoc`](../vendor/raku-doc/doc/Language/grammars.rakudoc) (actions), [`Match.rakudoc`](../vendor/raku-doc/doc/Type/Match.rakudoc) (`routine make`) |
| `given` / `when` | [lib/Rakurust/Grammar.rakumod](../lib/Rakurust/Grammar.rakumod) | `addop-kind`, `mulop-kind` | Readable mapping from lexeme to enum | HTML: [`given`](https://docs.raku.org/language/control#given), [`when`](https://docs.raku.org/language/control#when) · Source: [`doc/Language/control.rakudoc`](../vendor/raku-doc/doc/Language/control.rakudoc) |
| `given` / `when` | [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | `llvm-i32-op` | Mapping `BinOpKind` → LLVM instruction names | HTML: [`given`](https://docs.raku.org/language/control#given), [`when`](https://docs.raku.org/language/control#when) · Source: [`doc/Language/control.rakudoc`](../vendor/raku-doc/doc/Language/control.rakudoc) |
| `role` / `class` composition | [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod) | `Node`, `Expr`, `IntLit`, `BinOp` | Shared behavior on AST roles; concrete node classes | HTML: [Classes](https://docs.raku.org/language/objects#Classes), [Roles](https://docs.raku.org/language/objects#Roles) · Source: [`doc/Language/objects.rakudoc`](../vendor/raku-doc/doc/Language/objects.rakudoc) |
| `enum` | [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod) | `BinOpKind` | Safe, named operator variants | HTML: [Enumerations](https://docs.raku.org/language/typesystem#Enumerations) · Source: [`doc/Language/typesystem.rakudoc`](../vendor/raku-doc/doc/Language/typesystem.rakudoc), [`enumeration.rakudoc`](../vendor/raku-doc/doc/Language/enumeration.rakudoc) |
| `is required` | [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod) | AST class attributes | Construction fails fast without required slots | HTML: [Attributes](https://docs.raku.org/language/objects#Attributes) · Source: [`doc/Language/objects.rakudoc`](../vendor/raku-doc/doc/Language/objects.rakudoc) |
| `proto` / `multi` methods | [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | `Emitter.emit-expr` | Open dispatch on AST shapes (visitor-style codegen) | HTML: [Multi-dispatch](https://docs.raku.org/language/functions#Multi-dispatch), [`proto` syntax](https://docs.raku.org/syntax/proto) · Source: [`doc/Language/functions.rakudoc`](../vendor/raku-doc/doc/Language/functions.rakudoc) |
| `gather` / `take` | [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | `Emitter.emit-program` | Lazy list of IR lines joined into one string | HTML: [`gather` / `take`](https://docs.raku.org/language/control#gather/take) · Source: [`doc/Language/control.rakudoc`](../vendor/raku-doc/doc/Language/control.rakudoc) |
| Private method | [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | `!fresh-temp` | Lexical encapsulation of SSA name generation | HTML: [Private methods](https://docs.raku.org/language/objects#Private_methods) · Source: [`doc/Language/objects.rakudoc`](../vendor/raku-doc/doc/Language/objects.rakudoc) |
| `Str()` coercion | [lib/Rakurust.rakumod](../lib/Rakurust.rakumod) | `compile`, `parse-ast` | Accept `Str` or coercible types for source text | HTML: [Coercion](https://docs.raku.org/language/typesystem#Coercion) · Source: [`doc/Language/typesystem.rakudoc`](../vendor/raku-doc/doc/Language/typesystem.rakudoc) |
| `subset` / `where` | [bin/rakurust.raku](../bin/rakurust.raku) | `ExistingFile` | CLI path must exist and be a plain file | HTML: [Subset types](https://docs.raku.org/language/typesystem#Subset_types) · Source: [`doc/Language/typesystem.rakudoc`](../vendor/raku-doc/doc/Language/typesystem.rakudoc) |
| `multi MAIN` | [bin/rakurust.raku](../bin/rakurust.raku) | `MAIN` candidates | Separate entry points for compile vs help | HTML: [Creating a CLI](https://docs.raku.org/language/create-cli), [`sub MAIN`](https://docs.raku.org/language/create-cli#sub_MAIN) · Source: [`doc/Language/create-cli.rakudoc`](../vendor/raku-doc/doc/Language/create-cli.rakudoc) |
| `unit module` | [lib/Rakurust.rakumod](../lib/Rakurust.rakumod), [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod) | top of file | Whole file is one package, less boilerplate | HTML: [Modules](https://docs.raku.org/language/modules), [`unit`](https://docs.raku.org/syntax/unit) · Source: [`modules.rakudoc`](../vendor/raku-doc/doc/Language/modules.rakudoc), [`syntax.rakudoc`](../vendor/raku-doc/doc/Language/syntax.rakudoc) (`unit` declarations) |
| `is export` | [lib/Rakurust.rakumod](../lib/Rakurust.rakumod), [lib/Rakurust/AST.rakumod](../lib/Rakurust/AST.rakumod), [lib/Rakurust/EmitLLVM.rakumod](../lib/Rakurust/EmitLLVM.rakumod) | selected subs / types | Public API for consumers and tests | HTML: [Exporting](https://docs.raku.org/language/modules#Exporting_and_importing_public_routines) · Source: [`doc/Language/modules.rakudoc`](../vendor/raku-doc/doc/Language/modules.rakudoc) |
| `Test` + `plan` / `ok` / `is` | [t/01-compile-run.t](../t/01-compile-run.t) | whole file | TAP integration tests with assertions | HTML: [Testing](https://docs.raku.org/language/testing), [`Test`](https://docs.raku.org/type/Test) · Source: [`testing.rakudoc`](../vendor/raku-doc/doc/Language/testing.rakudoc), [`Test.rakudoc`](../vendor/raku-doc/doc/Type/Test.rakudoc) |
| `run` / `Proc` | [t/01-compile-run.t](../t/01-compile-run.t) | `compile-and-run-exit` | Driving `clang` and the emitted binary | HTML: [`run`](https://docs.raku.org/routine/run), [`Proc`](https://docs.raku.org/type/Proc) · Source: [`independent-routines.rakudoc`](../vendor/raku-doc/doc/Type/independent-routines.rakudoc) (`sub run`), [`Proc.rakudoc`](../vendor/raku-doc/doc/Type/Proc.rakudoc) |
| `IO::Path` (`slurp` / `spurt` / `mkdir`) | [bin/rakurust.raku](../bin/rakurust.raku), [t/01-compile-run.t](../t/01-compile-run.t) | CLI + tests | File I/O without shelling out for reads/writes | HTML: [`IO::Path`](https://docs.raku.org/type/IO::Path), [`slurp`](https://docs.raku.org/routine/slurp), [`spurt`](https://docs.raku.org/routine/spurt), [`mkdir`](https://docs.raku.org/routine/mkdir) · Source: [`IO/Path.rakudoc`](../vendor/raku-doc/doc/Type/IO/Path.rakudoc) |

## Planned / not yet used

Ideas for later milestones (grammar growth, `let`, branches, more tests):

- `proto token` / `token` multis in the grammar for extensible lexing
- `state` on the emitter for temp IDs (currently a normal attribute reset per program)
- `hyper` or parallel testing of fixtures
- `Junction` in tests only if it clarifies multi-case expectations
- `macro` (experimental) — only if there is a compelling metaprogramming demo
