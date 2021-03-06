%{
  #include <stdio.h>
  #include <assert.h>

  static int Pop();
  static int Top();
  static void Push(int val);
%}

%token T_Int
%left '+'
%left '-'
%left '*'
%left '/'

%%

S  : S E '\n' { printf("= %d\n", Top()); }
   |
   ;

E  : E '+' E { Push(Pop() + Pop()); }
   | E '-' E { int op2 = Pop(); Push(Pop() - op2); }
   | E '*' E { Push(Pop() * Pop()); }
   | E '/' E { int op2 = Pop(); Push(Pop() / op2); }
   | T_Int   { Push(yylval); }
   ;

%%

static int stack[100], count = 0;

static int Pop() {
  assert(count > 0);
  return stack[--count];
}

static int Top() {
  assert(count > 0);
  return stack[count - 1];
}

static void Push(int val) {
  assert(count < sizeof(stack) / sizeof(*stack));
  stack[count] = val;
  count += 1;
}

int main() {
  return yyparse();
}
