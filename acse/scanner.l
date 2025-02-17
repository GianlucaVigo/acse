/** @file scanner.l
 ** @brief The Flex file describing the tokens used by the LANCE language. */

%{
#include <string.h>
#include "list.h"
#include "scanner.h"
#include "parser.h"
#include "parser.tab.h"

t_fileLocation curFileLoc = {NULL, -1};

%}

/* Disable multi-file support. */
%option noyywrap
/* Define a new comment state. */
%x comment

/*
 * Name definitions
 */

DIGIT                     [0-9]
ID                        [a-zA-Z_][a-zA-Z0-9_]*

/*
 * Rules
 */

%%

"\r\n"                    { curFileLoc.row++; }
"\n"                      { curFileLoc.row++; }

[ \t\f\v]+                { /* Ignore whitespace. */ }

"//"[^\n]*                { /* Ignore comment lines. */ }
"/*"                      BEGIN(comment);

<comment>[^*\n]*
<comment>[^*\n]*\n        { curFileLoc.row++; }
<comment>"*"+[^*/\n]*
<comment>"*"+[^*/\n]*\n   { curFileLoc.row++; }
<comment>"*"+"/"          BEGIN(INITIAL);

"{"                       { return LBRACE; }
"}"                       { return RBRACE; }
"["                       { return LSQUARE; }
"]"                       { return RSQUARE; }
"("                       { return LPAR; }
")"                       { return RPAR; }
";"                       { return SEMI; }
"+"                       { return PLUS; }
"-"                       { return MINUS; }
"*"                       { return MUL_OP; }
"/"                       { return DIV_OP; }
"%"                       { return MOD_OP; }
"&"                       { return AND_OP; }
"^"                       { return XOR_OP; }
"|"                       { return OR_OP; }
"!"                       { return NOT_OP; }
"="                       { return ASSIGN; }
"<"                       { return LT; }
">"                       { return GT; }
"<<"                      { return SHL_OP; }
">>"                      { return SHR_OP; }
"=="                      { return EQ; }
"!="                      { return NOTEQ; }
"<="                      { return LTEQ; }
">="                      { return GTEQ; }
"&&"                      { return ANDAND; }
"||"                      { return OROR; }
","                       { return COMMA; }

"do"                      { return DO; }
"else"                    { return ELSE; }
"if"                      { return IF; }
"int"                     { return TYPE; }
"while"                   { return WHILE; }
"return"                  { return RETURN; }
"read"                    { return READ; }
"write"                   { return WRITE; }
"if_repeat"               { return IF_REPEAT; }
"until"                   { return UNTIL; }

{ID}                      {
                            yylval.string = strdup(yytext);
                            return IDENTIFIER;
                          }
{DIGIT}+                  {
                            yylval.integer = atoi(yytext);
                            return NUMBER;
                          }

.                         {
                            yyerror("unexpected token");
                            return -1;
                          }
<INITIAL><<EOF>>          {
                            curFileLoc.row = -1;
                            return EOF_TOK;
                          }
