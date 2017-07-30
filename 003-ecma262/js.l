%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "js.tab.h"
%}
%%
\/\/[^\n]*\n         ;
void                 { return VOID; }
typeof               { return TYPEOF; }
var                  { return VAR; }
true                 { return BOOLEAN; }
false                { return BOOLEAN; }
null                 { return NULL_; }
function             { return FUNCTION; }
return               { return RETURN; }
if                   { return IF; }
else                 { return ELSE; }
[0-9]+\.[0-9]+       { yylval.nval = atof(yytext); return NUMBER; }
[0-9]+               { yylval.nval = atof(yytext); return NUMBER; }
'[^']*'              { yylval.sval = strdup(yytext); return STRING; }
\"[^\"]*\"           { yylval.sval = strdup(yytext); return STRING; }
[a-zA-Z][a-zA-Z0-9]* { yylval.sval = strdup(yytext); return IDENTIFIER; }
[;,='\")(}{]         { return yytext[0]; }
.                    ;
%%
