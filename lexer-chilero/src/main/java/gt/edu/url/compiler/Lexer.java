package gt.edu.url.compiler;/*
Copyright (c) 2000 The Regents of the University of California.
All rights reserved.

Permission to use, copy, modify, and distribute this software for any
purpose, without fee, and without written agreement is hereby granted,
provided that the above copyright notice and the following two
paragraphs appear in all copies of this software.

IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
*/

import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java_cup.runtime.Symbol;
import java.util.Scanner;
import java.util.concurrent.Callable;
import java.io.BufferedReader;
import java.io.File;
import java.io.StringReader;
import java.nio.file.Files;
import java.nio.file.Path;
import picocli.CommandLine;


class Lexer implements Callable<Integer>
{
	private File file;
	public Integer call() throws Exception {
		if (file!=null){
			BufferedReader buffer = Files.newBufferedReader(file.toPath());
			CoolLexer coolLexer = new CoolLexer(buffer);
			Symbol token;
do {
    token = coolLexer.next_token();
    Utilities.dumpToken(System.out, coolLexer.get_curr_lineno(), token);
} while (token.sym != TokenConstants.EOF);

		}else{
			Scanner scanner = new Scanner(System.in);
			String input = "";
			do {
				input = scanner.nextLine();
				
				while (input.equals("salir")) {
					break;
				}
				CoolLexer coolLexer = new CoolLexer(new StringReader(input));
				Symbol token = coolLexer.next_token();
				Utilities.dumpToken(System.out, coolLexer.get_curr_lineno(), token);
			} while (!input.equals("salir"));
		}
		return 0;
	}
	public static void main(String[] args) {
	args = Flags.handleFlags(args);
			for (int i = 0; i < args.length; i++) {
				FileReader file = null;
				try {
					file = new FileReader(args[i]);
					System.out.println("#name \"" + args[i] + "\"");
					CoolLexer lexer = new CoolLexer(file);
					lexer.set_filename(args[i]);
					Symbol s;
					while ((s = lexer.next_token()).sym != TokenConstants.EOF) {
						Utilities.dumpToken(System.out, lexer.get_curr_lineno(), s);
					}
				} catch (FileNotFoundException ex) {
					Utilities.fatalError("Could not open input file " + args[i]);
				} catch (IOException ex) {
					Utilities.fatalError("Unexpected exception in lexer");
				}
			}
		}}
