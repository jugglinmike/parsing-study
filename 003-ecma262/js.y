%{
#include <cstdio>
#include <iostream>
using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

void yyerror(const char *s);
%}

%union {
  int ival;
  float fval;
  char *sval;
}

%token VOID
%token OCTET
%token <ival> NUMBER
%%

program: VOID NUMBER ';';

%%
int main() {
  do {
    yyparse();
  } while (!feof(yyin));
}

void yyerror(const char *s) {
  cout << "Parse error. Message: " << s << endl;
  exit(-1);
}
