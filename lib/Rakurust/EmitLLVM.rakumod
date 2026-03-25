#| Walk AST and print LLVM IR text (i32, single `main`, one basic block).
use v6.d;

use Rakurust::AST;

class Emitter {
    has Str @!lines;
    has Int $!temp = 0;

    method !fresh-temp(--> Str) {
        '%t' ~ $!temp++
    }

    proto method emit-expr(Expr $e --> Str) {*}

    multi method emit-expr(IntLit $e --> Str) {
        my Str $r = self!fresh-temp;
        @!lines.push: "  $r = add i32 0, {$e.value}";
        $r;
    }

    multi method emit-expr(BinOp $e --> Str) {
        my Str $l = self.emit-expr($e.left);
        my Str $r = self.emit-expr($e.right);
        my Str $out = self!fresh-temp;
        my Str $opc = llvm-i32-op($e.op);
        @!lines.push: "  $out = $opc i32 $l, $r";
        $out;
    }

    method emit-program(Program $p --> Str) {
        @!lines = ();
        $!temp = 0;
        my Str $res = self.emit-expr($p.function.body.expr);
        @!lines.push: "  ret i32 $res";
        gather {
            take '; ModuleID = \'rakurust\'';
            take 'define i32 @main() {';
            take 'entry:';
            take $_ for @!lines;
            take '}';
            take '';
        }.join("\n");
    }
}

sub llvm-i32-op(BinOpKind $k --> Str) is export {
    given $k {
        when BinOpKind::Add { 'add' }
        when BinOpKind::Sub { 'sub' }
        when BinOpKind::Mul { 'mul' }
        when BinOpKind::Div { 'sdiv' }
        default { die "unknown BinOpKind: $_" }
    }
}

sub emit-llvm(Program $ast --> Str) is export {
    Emitter.new.emit-program($ast);
}
