package gt.edu.url.compiler;

import java_cup.runtime.Symbol;

import java.io.FileInputStream;
import java.io.InputStreamReader;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main(String[] args) {
        args = Flags.handleFlags(args);
		for (String string : args) {
			try {

				CoolLexer lexer = new CoolLexer(CharStreams.fromFileName(string));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        CoolParser parser = new CoolParser(tokens);
        ParseTree tree = parser.sintactico();

		CoolVisitor_ cool = new CoolVisitor_();
		cool.visit(tree);

		System.out.println(cool.visit(tree).toString());
/*
            CoolTokenLexer lexer = new CoolTokenLexer(new InputStreamReader(new FileInputStream(string)));
            CoolParser parser = new CoolParser(lexer);
            Symbol result = (Flags.parser_debug
                    ? parser.debug_parse()
                    : parser.parse());
            if (parser.omerrs > 0) {
                System.err.println("Compilation halted due to lex and parse errors");
                System.exit(1);
            }
            ((Program)result.value).dump_with_types(System.out, 0);
			 */
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            Utilities.fatalError("Unexpected exception in parser");
        }
		}
        
    }

}