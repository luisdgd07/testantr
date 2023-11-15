package gt.edu.url.compiler;


import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStreamReader;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;

import java_cup.runtime.Symbol;
/**
 * Hello world!
 *
 */
public class App 
{
	public static void main(String[] args) {

		FileReader file = null;
	try {
		String inputFile = args[0];
		FileInputStream inputStream = new FileInputStream(inputFile);
		ANTLRInputStream input = new ANTLRInputStream(inputStream);
	    CoolLexer lexer = new CoolLexer(input);
		CommonToken token;
		while ((token= (CommonToken) lexer.nextToken()).getType()!= TokenConstants.EOF) {
			Utilities.dumpToken(System.out, lexer.getLine(), token);
		}
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		CoolParser parser = new CoolParser(tokens);
		ParseTree arbol = parser.sintactico();
		CoolVisitor_ cool = new CoolVisitor_();
		cool.visit(arbol);

		System.out.println(cool.visit(arbol).toString());
	} catch (Exception ex) {
	    ex.printStackTrace(System.err);
	}
    }

}
