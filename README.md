# VParseus
Is marked for major rewrite based on my Parseus Libary but that one has Priority.
Parser Libary/(Generator) in V
- Generator is out of the window for now

Currently just spits out an ast in JSON format and a strict budget version of a lexer whiich uses assosiative arrays.

update:
I got a new regex-to-token based approach for a lexer up and running just needs some cleanup before publishing it here.
In the end this library should contain struct and mainly functions for easier parsing. So the Parser generator is something I won't work on for a while. also I am working on a Compiler in c# for my own language where I use the Lexer mentioned above and started to create library code to support the Parser in its work.
also I do have some ideas to change the generator part and ebnf(sbnf) to v code part.
