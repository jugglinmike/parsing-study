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
  float nval;
  char *sval;
}

%token VOID
%token TYPEOF
%token VAR
%token STRING
%token BOOLEAN
%token NULL_
%token FUNCTION
%token RETURN
%token IF
%token ELSE
%token <nval> NUMBER
%token <svalu> IDENTIFIER

%%

program: statement_list;

statement_list: statement | statement_list statement;

// TODO: Only allow `return` in function contexts
statement: decl | if_statement | return_statement | expr ';';

expr: void_expr | typeof_expr | primary_expr;

decl: var_decl | function_decl;

var_decl: VAR binding_list ';';

block: '{' statement_list '}';

return_statement: RETURN expr ';';

if_statement: IF '(' expr ')' statement_or_block
			| IF '(' expr ')' statement_or_block ELSE statement_or_block;
statement_or_block: statement | block;

function_decl: FUNCTION IDENTIFIER '(' parameter_list ')'
  '{' statement_list '}';
parameter_list: %empty | IDENTIFIER | parameter_list ',' IDENTIFIER;

binding_list: binding_element | binding_list ',' binding_element;
binding_element: IDENTIFIER | IDENTIFIER '=' expr;

function_expr: FUNCTION '(' parameter_list ')' '{' statement_list '}'
			 | function_decl;

void_expr: VOID expr;

typeof_expr: TYPEOF expr;

primary_expr: literal_expr | identifier_ref_expr | function_expr;

literal_expr: NUMBER | STRING | BOOLEAN | NULL_;

identifier_ref_expr: IDENTIFIER;

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
