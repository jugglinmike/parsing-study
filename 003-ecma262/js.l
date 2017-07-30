%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "js.tab.h"
%}
%%
void               { return VOID; }
[0-9]+\.[0-9]+     { yylval.fval = atof(yytext); return NUMBER; }
[0-9]+             { yylval.ival = atof(yytext); return NUMBER; }
;                  { return ';'; }
.                  ;
%%
