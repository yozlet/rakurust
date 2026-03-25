#| Parse Rakurust source and return LLVM IR text.
use v6.d;

unit module Rakurust;

use Rakurust::AST;
use Rakurust::EmitLLVM;
use Rakurust::Grammar;

sub compile(Str() $source --> Str) is export {
    my $actions = Rakurust::Grammar::Actions.new;
    my $match = Rakurust::Grammar.parse($source, :actions($actions))
        // die 'Parse failed';
    emit-llvm($match.made);
}

sub parse-ast(Str() $source --> Program) is export {
    my $actions = Rakurust::Grammar::Actions.new;
    my $match = Rakurust::Grammar.parse($source, :actions($actions))
        // die 'Parse failed';
    $match.made;
}
