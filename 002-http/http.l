%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "http.tab.h"
%}
%%
end                { return END; }
HTTP\/[0-9]\.[0-9] { return PROTO_VER; }
GET                { return VERB_GET; }
PUT                { return VERB_PUT; }
POST               { return VERB_POST; }
DELETE             { return VERB_DELETE; }
HEAD               { return VERB_HEAD; }
[0-9]+\.[0-9]+     { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+             { yylval.ival = atoi(yytext); return INT; }
[\/:?]             { return yytext[0]; }
.                  { return OCTET; }
%%
