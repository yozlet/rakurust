# Agent notes (Rakurust)

This repository is a **small compiler in Raku**: a Rust-shaped source subset, parsed with Raku grammars, lowered to **LLVM IR text**, then validated with **`clang`** in tests.

## Plan and documentation

- **[docs/PLAN.md](docs/PLAN.md)** — Project goals, architecture, v0 language definition, test strategy, and **roadmap** for future features. Read this before large design or scope changes.
- **[docs/raku-features-used.md](docs/raku-features-used.md)** — Catalog of **Raku language features** used in the codebase (with links to [docs.raku.org](https://docs.raku.org/) and to local sources under `vendor/raku-doc/`). **Update this file when you introduce or substantially rely on a new Raku feature** (same commit as the code).

## Submodule

Official Raku documentation sources live in a **shallow submodule** at `vendor/raku-doc/` ([Raku/doc](https://github.com/Raku/doc)). After clone:

```bash
git submodule update --init --depth 1
```

## Verification

- **Tests:** from repo root, `prove -v -e raku t/*.t` (needs `clang` on `PATH` and a normal `$HOME` for Rakudo precompilation).
- **Manual:** `raku bin/rakurust.raku t/fixtures/literal.rs` or `raku -Ilib -e 'use Rakurust; say compile("fn main() -> i32 { return 42; }")'`.

## Conventions

- Prefer **idiomatic Raku** where it stays readable; avoid using exotic features only for show (see PLAN).
- Keep the **language subset** and **LLVM story** aligned with **docs/PLAN.md** unless the user explicitly changes direction.
- Do not commit generated `*.ll` or `t/tmp/` artifacts (see `.gitignore`).
