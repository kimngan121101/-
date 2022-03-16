%option noyywrap

D     [0-9]
A     [a-zA-Z]

%{
#include "tokens.h"
char val[100];
%}

%%
def		return (DEF);
integer		return (INTEGER);
real		return (REAL);
string		return (STRING);
if		return (IF);
then		return (THEN);
while		return (WHILE);

{D}+"."{D}+	{ sprintf(val, "Real:%s", yytext); return (REAL_CONST); }
{A}+		{ strcpy(val, yytext); return (ID); }
{D}+		{ sprintf(val, "Integer:%s", yytext); return (INT_CONST); }
\"[^"]*\"	{ sprintf(val, "String:%s", yytext); return (STRING_CONST); }

";"		return (SEMI);
":"		return (COLON);
"("		return (LEFT_PAREN);
")"		return (RIGHT_PAREN);
"+"		return (PLUS);
"-"		return (MINUS);
"*"		return (MULT);
"/"		return (DIVIDE);
"^"		return (CARAT);
"%"		return (MOD);
"="		return (EQUAL);
"!="		return (NOT_EQUAL);
"<"		return (LESS_THAN);
">"		return (GREATER_THAN);
"<="		return (LESS_EQUAL);
">="		return (GREATER_EQUAL);
":="		return (ASSIGN);
"["		return (LEFT_SQUARE);
"]"		return (RIGHT_SQUARE);
"{"		return (LEFT_BRACE);
"}"		return (RIGHT_BRACE);
","		return (COMMA);

^#.*		;	/* Ignore comments */

.		;				/* ignore any unmatched chars */
"\n"		;


%%
void yyerror () 	/* default action in case of error in yylex() */
{
	printf (" error\n");
	exit(0);
}
