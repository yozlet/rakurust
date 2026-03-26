#!/usr/bin/env raku
#| Compile Rakurust source to LLVM IR (.ll). Usage: rakurust.raku [-o out.ll] <file.rs>
use v6.d;

use lib $?FILE.IO.parent.parent.child('lib');
use Rakurust;

subset ExistingFile of Str where *.IO.f;

multi sub MAIN() {
    note 'Usage: raku bin/rakurust.raku [-o out.ll] <file.rs>  or  -h';
    exit 2;
}

multi sub MAIN(ExistingFile $path, Str :o(:$output) = Str) {
    my Str $src = $path.IO.slurp;
    my Str $ll = compile($src);
    if $output {
        $output.IO.spurt($ll);
    }
    else {
        print $ll;
    }
}

multi sub MAIN(Bool :h(:$help)!) {
    say q:to/USAGE/;
    rakurust.raku <file.rs>              Print LLVM IR to stdout
    rakurust.raku -o out.ll <file.rs>    Write LLVM IR to file
    USAGE
}
