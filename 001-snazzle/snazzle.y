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

%token SNAZZLE TYPE
%token END

%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING
%%

snazzle:
	   header template body_section footer { cout << "Done!" << endl; }
	   ;

header:
	  SNAZZLE FLOAT { cout << "reading a snazzle file version: " << $2 << endl; }
	  ;

template:
		typelines
		;
typelines:
		 typelines typeline
		 | typeline
		 ;
typeline:
		TYPE STRING { cout << "new defined snazzle type: " << $2 << endl; }
        ;

body_section:
			body_lines
			;
body_lines:
		  body_lines body_line
		  | body_line
		  ;
body_line:
		 INT INT INT INT STRING { cout << "new snazzle: " << $1 << $2 << $3 << $4 << $5 << endl; }
		 ;

footer:
	  END
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
