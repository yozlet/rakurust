# Rakurust

A **tiny Rust-shaped language** implemented in **[Raku](https://www.raku.org/)**, compiled to **LLVM IR** (`.ll` text) and exercised with **`clang`** in tests. The main goal is to **showcase Raku** (grammars, roles, multi-dispatch, and friends) while keeping the pipeline small and correct.

## Requirements

- [Rakudo](https://rakudo.org/) (`raku`)
- **`clang`** on your `PATH` (for tests and for turning `.ll` into a runnable binary)

## Clone and submodule

This repo vendors a shallow copy of the official [Raku documentation](https://github.com/Raku/doc) for local reference:

```bash
git clone https://github.com/yozlet/rakurust.git
cd rakurust
git submodule update --init --depth 1
```

(Replace the URL with your fork or remote if different.)

## Usage

Emit LLVM IR to **stdout**:

```bash
raku bin/rakurust.raku t/fixtures/precedence.rs
```

Write IR to a file (options must precede the source file):

```bash
raku bin/rakurust.raku -o out.ll t/fixtures/literal.rs
clang -Wno-override-module out.ll -o a.out && ./a.out; echo $?
```

Use as a library:

```bash
raku -Ilib -e 'use Rakurust; say compile("fn main() -> i32 { return 40 + 2; }")'
```

## Tests

```bash
prove -v -e raku t/*.t
```

Tests compile emitted IR with `clang` and check process exit codes against expected `i32` results.

## Documentation

| Document | Purpose |
|----------|---------|
| [docs/PLAN.md](docs/PLAN.md) | Goals, architecture, language subset, roadmap |
| [docs/raku-features-used.md](docs/raku-features-used.md) | Raku features used in the code + doc links |
| [AGENTS.md](AGENTS.md) | Short pointers for tooling / agents |

## Language (v0)

Single entrypoint, integer arithmetic:

```rust
fn main() -> i32 {
    return (1 + 2) * 3;
}
```

See **docs/PLAN.md** for exact scope and planned extensions.

## License

Artistic License 2.0 — see [META6.json](META6.json).
