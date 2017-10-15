%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "js.tab.h"
%}
%%
export               { return EXPORT; }
as                   { return AS; }
from                 { return FROM; }
[a-zA-Z][a-zA-Z0-9]* { yylval.sval = strdup(yytext); return IDENTIFIER; }
'[^']*'              { yylval.sval = strdup(yytext); return STRING; }
[;,}{]               { return yytext[0]; }
.                    ;
%%
