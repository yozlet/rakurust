use v6.d;
# Run: prove -v -e raku t/*.t   (from repo root; requires clang on PATH)

use lib $?FILE.IO.parent.parent.child('lib');
use Test;
use Rakurust;

plan 6;

my IO::Path $tmp = $?FILE.IO.parent.child('tmp');
$tmp.mkdir;

sub compile-and-run-exit(Str $source --> Int) {
    my Str $ir = compile($source);
    my IO::Path $ll = $tmp.child('scratch.ll');
    my IO::Path $exe = $tmp.child('scratch-bin');
    $ll.spurt($ir);
    my Proc $clang = run 'clang', '-Wno-override-module', ~$ll, '-o', ~$exe;
    unless $clang.exitcode == 0 {
        diag "clang failed (exit {$clang.exitcode})";
        return -1;
    }
    my Proc $p = run ~$exe;
    $p.exitcode;
}

ok compile(q{fn main() -> i32 { return 0; }}).contains('define i32 @main'),
    'emitted IR defines i32 @main';

is compile-and-run-exit($?FILE.IO.parent.child('fixtures/literal.rs').slurp), 42,
    'fixture literal.rs exits 42';

is compile-and-run-exit($?FILE.IO.parent.child('fixtures/precedence.rs').slurp), 7,
    'fixture precedence.rs: 1+2*3 => 7';

is compile-and-run-exit($?FILE.IO.parent.child('fixtures/parens.rs').slurp), 9,
    'fixture parens.rs: (1+2)*3 => 9';

is compile-and-run-exit(q{fn main() -> i32 { return 10 / 3; }}), 3,
    'integer division truncates toward zero (10/3 => 3)';

is compile-and-run-exit(q{fn main() -> i32 { return 20 / 4; }}), 5,
    'division: 20/4 => 5';
