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

%token PROTO_VER
%token END
%token VERB_GET
%token VERB_PUT
%token VERB_POST
%token VERB_DELETE
%token VERB_HEAD
%token CR
%token LF

%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING
%token <sval> VERB;
%%

message:
	   request { cout << "HTTP request" << endl; }
	   | response { cout << "HTTP response" << endl; }
	   ;

CRLF:
	CR LF {}
	;

request:
	   request_verb uri PROTO_VER CRLF
			headers CRLF { cout << "HTTP request 2" << endl; }
	   ;

request_verb:
			VERB_GET {}
			| VERB_PUT {}
			| VERB_POST {}
			| VERB_DELETE {}
			| VERB_HEAD {}
			;

uri:
    uri_path {}
	| uri_path '?' uri_query_string {}
    ;

uri_path:
	'/'
	| '/' uri_path_relative
	;

uri_query_string:
				STRING
				;

uri_path_relative:
				 uri_path_relative '/' STRING
				 | STRING
				 ;

headers:
	   headers CRLF header {}
	   | header {}
	   ;

header: STRING ':' STRING {};

response:
	   PROTO_VER INT STRING {}
	   ;

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
