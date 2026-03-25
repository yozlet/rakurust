#| Parser: `fn main() -> i32 { return <expr>; }` with + - * / and parentheses.
use v6.d;

use Rakurust::AST;

grammar Rakurust::Grammar {
    rule TOP {
        'fn' 'main' '(' ')'
        '->' 'i32'
        '{'
        'return' <expr> ';'
        '}'
    }

    rule expr {
        <term> [ <addop> <term> ]*
    }

    token addop { '+' | '-' }

    rule term {
        <factor> [ <mulop> <factor> ]*
    }

    token mulop { '*' | '/' }

    rule factor {
        | <integer>
        | '(' <expr> ')'
    }

    token integer { \d+ }
}

class Rakurust::Grammar::Actions {
    method TOP($/) {
        make Program.new:
            function => Function.new(
                name => 'main',
                body => Return.new(expr => $/<expr>.made),
            );
    }

    method expr($/) {
        my @terms = $/<term>.map(*.made);
        my $acc = @terms[0];
        for $/<addop>.kv -> $i, $op-match {
            $acc = BinOp.new:
                op => addop-kind($op-match.Str),
                left => $acc,
                right => @terms[$i + 1];
        }
        make $acc;
    }

    method term($/) {
        my @facts = $/<factor>.map(*.made);
        my $acc = @facts[0];
        for $/<mulop>.kv -> $i, $op-match {
            $acc = BinOp.new:
                op => mulop-kind($op-match.Str),
                left => $acc,
                right => @facts[$i + 1];
        }
        make $acc;
    }

    method factor($/) {
        if $/<integer> {
            make IntLit.new(value => $/<integer>.Str.Int);
        }
        else {
            make $/<expr>.made;
        }
    }
}

sub addop-kind(Str $s --> BinOpKind) {
    given $s {
        when '+' { BinOpKind::Add }
        when '-' { BinOpKind::Sub }
        default { die "unknown addop: $s" }
    }
}

sub mulop-kind(Str $s --> BinOpKind) {
    given $s {
        when '*' { BinOpKind::Mul }
        when '/' { BinOpKind::Div }
        default { die "unknown mulop: $s" }
    }
}
