cd "C:\Users\fried\OneDrive\Dokumente\Code\FreeCode\V\VParseus\src"
v.exe -g run . ..\test.ebnf -gen test
v.exe fmt .\test\test_lex.v -w .\test\test_lex.v
