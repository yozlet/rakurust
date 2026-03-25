#!/usr/bin/env raku
#| Compile Rakurust source to LLVM IR (.ll). Usage: rakurust.raku <file.rs> [-o out.ll]
use v6.d;

use lib $?FILE.IO.parent.parent.child('lib');
use Rakurust;

subset ExistingFile of Str where *.IO.f;

multi sub MAIN() {
    note 'Usage: raku bin/rakurust.raku <file.rs> [-o out.ll]  or  -h';
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
    rakurust.raku <file.rs>   Print LLVM IR to stdout
    rakurust.raku <file.rs> -o out.ll   Write LLVM IR to file
    USAGE
}
