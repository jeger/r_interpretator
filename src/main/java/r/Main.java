package r;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import r.RLexer;
import r.RParser;

import java.io.File;
import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        RLexer lexer = new RLexer(CharStreams.fromString("a <- 5\n" +
                "b <- 7\n" +
                "print(a + b)\n"));

        RParser parser = new RParser(new CommonTokenStream(lexer));
        ParseTree tree = parser.prog();
        EvalVisitor visitor = new EvalVisitor();
        visitor.visit(tree);
    }
}
