%{
#include <stdio.h>
#include <math.h>
#include <string.h>
int yylex (void);
void yyerror (char const *);
extern char val[100];
%}
%define api.value.type {char *}

%token DEF		1
%token INTEGER		2
%token REAL		3
%token STRING		4
%token IF		5
%token THEN		6
%token WHILE		7
%token REAL_CONST	8
%token ID		9
%token INT_CONST	10
%token STRING_CONST	11
%token SEMI		12
%token COLON		13
%token LEFT_PAREN	14
%token RIGHT_PAREN	15
%token PLUS		16
%token MINUS		17
%token MULT		18
%token DIVIDE		19
%token CARAT		20
%token MOD		21
%token EQUAL		22
%token NOT_EQUAL	23
%token LESS_THAN	24
%token GREATER_THAN	25
%token LESS_EQUAL	26
%token GREATER_EQUAL	27
%token ASSIGN		28
%token LEFT_SQUARE	29
%token RIGHT_SQUARE	30
%token LEFT_BRACE	31
%token RIGHT_BRACE	32
%token COMMA		33

%% /* Grammar rules and actions follow. */

input	:	statement_list
	;

statement_list
	:	
	|	statement statement_list
	;

statement
	:	variable_definition
	|	assignment_statement
	|	conditional_statement
	|	loop_statement
	|	block_statement
	|	expression SEMI
	;

variable_definition
	:	DEF identifier COLON type SEMI
		{ printf("Variable %s defined as a %s\n", $2, $4); }
	;

identifier
	:	ID
		{ $$ = strdup(val); }
	;

type	
	:	INTEGER
		{ $$ = "integer"; }
	|	REAL
		{ $$ = "real"; }
	|	STRING
		{ $$ = "string"; }
	;

assignment_statement
	:	identifier ASSIGN expression SEMI
		{ printf("Assigning %s to an expression\n", $1); }
	;

constant
	:	REAL_CONST	
		{ $$ = strdup(val); }
	|	INT_CONST
		{ $$ = strdup(val); }
	|	STRING_CONST
		{ $$ = strdup(val); }
	;

operator
	: 	PLUS		
		{ $$ = "addition"; }
	| 	MINUS
		{ $$ = "subtraction"; }
	|	MULT
		{ $$ = "multiplication"; }
	|	DIVIDE
		{ $$ = "division"; }
	|	CARAT
		{ $$ = "exponentiation"; }
	| 	MOD
		{ $$ = "remainder"; }
	;
	
conditional_statement
	: 	IF LEFT_SQUARE bool_expression RIGHT_SQUARE THEN statement SEMI
		{ printf("Found a conditional statement\n"); }
	;
	
loop_statement
	: 	WHILE LEFT_SQUARE bool_expression RIGHT_SQUARE statement SEMI
		{ printf("Found a loop statement\n"); }
	;
	
bool_expression
	: 	expression relop expression
		{ printf("Found a %s expression\n", $2); }
	;
	
relop
	:	EQUAL
		{ $$ = "is equal to"; }
	|	NOT_EQUAL
		{ $$ = "is not equal to"; }
	|	LESS_THAN
		{ $$ = "is less than"; }
	| 	GREATER_THAN
		{ $$ = "is greater than"; }
	|	LESS_EQUAL
		{ $$ = "is less than or equal to"; }
	|	GREATER_EQUAL
		{ $$ = "is greater than or equal to"; }
	;
		
block_statement
	: 	LEFT_BRACE statement_list RIGHT_BRACE
		{ printf("Found a block statement\n"); }
	|	LEFT_BRACE RIGHT_BRACE
		{ printf("Found a block statement\n"); }
	;
	
expression
	:	constant
		{ printf("Found a constant  %s\n", $1); } 
	| 	identifier
		{ printf("Found a identifier %s as an expression\n", $1); }
	|	expression operator expression
		{ printf("Found a %s expression\n", $2); }
	|	identifier LEFT_PAREN expression_list RIGHT_PAREN
		{ printf("Calling function %s with args\n", $1); }
	|	identifier LEFT_PAREN RIGHT_PAREN
		{ printf("Calling function %s with no args\n", $1); }
	|	LEFT_PAREN expression RIGHT_PAREN
		{ printf("Found a parenthesis expression\n"); }
	;
	
expression_list
	:	expression
	|	expression_list COMMA expression
	;
	
	
