#Move into dic
cd "C:\Users\fried\OneDrive\Dokumente\Code\FreeCode\V\VParseus\src"
#Build the project
v.exe -g .\VParseus.v
#Run
.\VParseus.exe ..\test4.ebnf -gen test
#Format Generated Source code
#v.exe fmt .\test\test_lex.v -w .\test\test_lex.v
#Open in code
#code .\test\test_lex.v
