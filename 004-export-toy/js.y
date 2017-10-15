%{
#include <cstdio>
#include <iostream>
using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

void yyerror(const char *s);
%}

// "lalr" is the default value
// https://www.gnu.org/software/bison/manual/html_node/LR-Table-Construction.html
//%define lr.type canonical-lr

%union {
  float nval;
  char *sval;
}

%token EXPORT
%token AS
%token FROM
%token <sval> IDENTIFIER
%token <sval> STRING

%%

program: statement_list;

statement_list: statement_list statement
 | statement
 ;

statement: export_decl;

export_decl: EXPORT export_clause from_clause ';'
 | EXPORT export_clause_local ';'
 ;

from_clause: FROM STRING;

export_clause: '{' exports_list '}'
 | '{' exports_list ',' '}'
 ;
export_clause_local: '{' exports_list_local '}'
 | '{' exports_list_local ',' '}'
 ;

exports_list: exports_list ',' export_specifier
 | export_specifier
 ;
exports_list_local: exports_list_local ',' export_specifier_local
 | export_specifier_local
 ;

export_specifier: identifier_name
 | identifier_name AS identifier_name
 ;

export_specifier_local: identifier_reference
 | identifier_reference AS identifier_name
 ;

identifier_reference: IDENTIFIER;
identifier_name: IDENTIFIER;
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
