/// @file parser.y
/// @brief The bison grammar file that describes the LANCE language and
///        the semantic actions used to translate it to assembly code.

%{
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "errors.h"
#include "list.h"
#include "codegen.h"
#include "scanner.h"
#include "parser.h"

/*
 * Global variables
 */

// The program currently being compiled.
static t_program *program;

void yyerror(const char *msg)
{
  emitError(curFileLoc, "%s", msg);
}

%}

/*
 * Axiom declaration
 *
 * The starting non-terminal of the grammar will be `program'.
 */

%start program

/*
 * Union declaration
 *
 * Specifies the set of types available for the semantic values of terminal
 * and non-terminal symbols.
 */

%union {
  int integer;
  char *string;
  t_regID reg;
  t_symbol *var;
  t_listNode *list;
  t_label *label;
  t_ifStmt ifStmt;
  t_whileStmt whileStmt;
}

/*
 * Terminal symbol declaration
 *
 * Here we declare all the token symbols that can be produced by the scanner.
 * Bison will automatically produce a #define that assigns a number (or token
 * identifier) to each one of these tokens.
 *   We also declare the type for the semantic values of some of these tokens.
 */

%token EOF_TOK  // End of file.
%token LPAR RPAR LSQUARE RSQUARE LBRACE RBRACE
%token COMMA SEMI PLUS MINUS MUL_OP DIV_OP MOD_OP
%token AND_OP XOR_OP OR_OP NOT_OP
%token ASSIGN LT GT SHL_OP SHR_OP EQ NOTEQ LTEQ GTEQ
%token ANDAND OROR
%token TYPE
%token RETURN
%token READ WRITE ELSE
%token INBOUNDS

// These are the tokens with a semantic value.
%token <ifStmt> IF
%token <whileStmt> WHILE
%token <label> DO
%token <string> IDENTIFIER
%token <integer> NUMBER

/*
 * Non-terminal symbol semantic value type declarations
 *
 * Here we declare the type of the semantic values of non-terminal symbols.
 *   We only declare the type of non-terminal symbols of which we actually use
 * their semantic value.
 */

%type <var> var_id
%type <reg> exp

/*
 * Operator precedence and associativity
 *
 * Precedence is given by the declaration order. Associativity is given by the
 * specific keyword used (%left, %right).
 */

%left OROR
%left ANDAND
%left OR_OP
%left XOR_OP
%left AND_OP
%left EQ NOTEQ
%left LT GT LTEQ GTEQ
%left SHL_OP SHR_OP
%left PLUS MINUS
%left MUL_OP DIV_OP MOD_OP
%right NOT_OP

/*
 * Grammar and semantic actions
 *
 * The grammar of the language follows. The semantic actions are the pieces of
 * C code enclosed in {} brackets: they are executed when the rule has been
 * parsed and recognized up to the point where the semantic action appears.
 */

%%

/* `program' is the starting non-terminal of the grammar.
 * A program is composed by:
 *   1. Declarations (zero or more),
 *   2. A list of instructions (zero or more). */
program
  : var_declarations statements EOF_TOK
  {
    // Generate the epilog of the program, that is, a call to the
    // `exit' syscall.
    genEpilog(program);
    // Return from yyparse().
    YYACCEPT;
  }
;

/* This non-terminal appears at the beginning of the program and represents
 * all the declarations. */
var_declarations
  : var_declarations var_declaration
  | /* empty */
;

/* Each declaration consists of a type, a list of declarators, and a
 * terminating semicolon. */
var_declaration
  : TYPE declarator_list SEMI
;

declarator_list
  : declarator_list COMMA declarator
  | declarator
;

/* A declarator specifies either a scalar variable name or an array name
 * and size. */
declarator
  : IDENTIFIER
  {
    createSymbol(program, $1, TYPE_INT, 0);
  }
  | IDENTIFIER LSQUARE NUMBER RSQUARE
  {
    createSymbol(program, $1, TYPE_INT_ARRAY, $3);
  }
;

/* A block of code is a list of statements enclosed between braces. */
code_block
  : LBRACE statements RBRACE
;

statements
  : statements statement
  | /* empty */
;

statement
  : assign_statement SEMI
  | if_statement
  | while_statement
  | do_while_statement SEMI
  | return_statement SEMI
  | read_statement SEMI
  | write_statement SEMI
  | SEMI
;

/* An assignment statement stores the value of an expression in the memory
 * location of a given scalar variable or array element. */
assign_statement
  : var_id ASSIGN exp
  {
    genStoreRegisterToVariable(program, $1, $3);
  }
  | var_id LSQUARE exp RSQUARE ASSIGN exp
  {
    genStoreRegisterToArrayElement(program, $1, $3, $6);
  }
;

/* An if statements first computes the expression, then jumps to the `else' part
 * if the expression is equal to zero. Otherwise the `then' part is executed.
 * After the `then' part the `else' part needs to be jumped over. */
if_statement
  : IF LPAR exp RPAR
  {
    // Generate a jump to the else part if the expression is equal to zero.
    $1.lElse = createLabel(program);
    genBEQ(program, $3, REG_0, $1.lElse);
  }
  code_block
  {
    // After the `then' part, generate a jump to the end of the statement.
    $1.lExit = createLabel(program);
    genJ(program, $1.lExit);
    // Assign the label which points to the first instruction of the else part.
    assignLabel(program, $1.lElse);
  }
  else_part
  {
    // Assign the label to the end of the statement.
    assignLabel(program, $1.lExit);
  }
;

/* The `else' part may be missing. */
else_part
  : ELSE code_block
  | /* empty */
;

/* A while statement repeats the execution of its code block as long as the
 * expression is different than zero. The expression is computed at the
 * beginning of each loop iteration. */
while_statement
  : WHILE
  {
    // Assign a label at the beginning of the loop for the back-edge.
    $1.lLoop = createLabel(program);
    assignLabel(program, $1.lLoop);
  }
  LPAR exp RPAR
  {
    // Generate a jump out of the loop if the condition is equal to zero.
    $1.lExit = createLabel(program);
    genBEQ(program, $4, REG_0, $1.lExit);
  }
  code_block
  {
    // Generate a jump back to the beginning of the loop after its body.
    genJ(program, $1.lLoop);
    // Assign the label to the end of the loop.
    assignLabel(program, $1.lExit);
  }
;

/* A do-while statement repeats the execution of its code block as long as the
 * expression is different than zero. The expression is computed at the
 * end of each loop iteration. */
do_while_statement
  : DO
  {
    // Assign a label at the beginning of the loop for the back-edge.
    $1 = createLabel(program);
    assignLabel(program, $1);
  }
  code_block WHILE LPAR exp RPAR
  {
    // Generate a jump to the beginning of the loop to repeat the code block
    // if the condition is not equal to zero.
    genBNE(program, $6, REG_0, $1);
  }
;

/* A return statement simply exits from the program, and hence translates to a
 * call to the `exit' syscall. */
return_statement
  : RETURN
  {
    genExit0Syscall(program);
  }
;

/* A read statement translates to a ReadInt syscall. The value it returns is
 * then stored in the appropriate variable. */
read_statement
  : READ LPAR var_id RPAR
  {
    t_regID rTmp = getNewRegister(program);
    genReadIntSyscall(program, rTmp);
    genStoreRegisterToVariable(program, $3, rTmp);
  }
;

/* A write statement translates to a PrintInt syscall, followed by a PrintChar
 * syscall which prints a newline. */
write_statement
  : WRITE LPAR exp RPAR
  {
    // Generate a call to the PrintInt syscall.
    genPrintIntSyscall(program, $3);
    // Also generate code to print a newline after the integer.
    t_regID rTmp = getNewRegister(program);
    genLI(program, rTmp, '\n');
    genPrintCharSyscall(program, rTmp);
  }
;


/* The exp rule represents the syntax of expressions. The semantic value of
 * the rule is the register ID that will contain the value of the expression
 * at runtime. */
exp
  : INBOUNDS LPAR var_id ASSIGN var_id LSQUARE exp RSQUARE RPAR
  { 
    // 1^ check: first variable_id must be a scalar variable
    if (isArray($3)){
      yyerror("First param must be a scalar variable");
      YYERROR;
    }

    // 2^ check: second variable_must be an array
    if (!isArray($5)){
      yyerror("Second param must be an array");
      YYERROR;
    }

    // label creation -> end of the operator program
    t_label *end = createLabel(program);

    // result initialization to zero (FALSE by default)
    $$ = getNewRegister(program);
    genLI(program, $$, 0);

    // array size
    t_regID size = getNewRegister(program);
    genADDI(program, size, REG_0, $5->arraySize);

    // checks onn the array index
    genBGE(program, $7, size, end); // above the upper threshold -> end
    genBLT(program, $7, REG_0, end); // below zero -> end
    
    // valid assignment
    t_regID value = genLoadArrayElement(program, $5, $7);
    genStoreRegisterToVariable(program, $3, value);
    
    // return TRUE
    genLI(program, $$, 1);

    // end of the operator program
    assignLabel(program, end);
  }
  | NUMBER
  {
    $$ = getNewRegister(program);
    genLI(program, $$, $1);
  }
  | var_id
  {
    $$ = genLoadVariable(program, $1);
  }
  | var_id LSQUARE exp RSQUARE
  {
    $$ = genLoadArrayElement(program, $1, $3);
  }
  | LPAR exp RPAR
  {
    $$ = $2;
  }
  | MINUS exp
  {
    $$ = getNewRegister(program);
    genSUB(program, $$, REG_0, $2);
  }
  | exp PLUS exp
  {
    $$ = getNewRegister(program);
    genADD(program, $$, $1, $3);
  }
  | exp MINUS exp
  {
    $$ = getNewRegister(program);
    genSUB(program, $$, $1, $3);
  }
  | exp MUL_OP exp
  {
    $$ = getNewRegister(program);
    genMUL(program, $$, $1, $3);
  }
  | exp DIV_OP exp
  {
    $$ = getNewRegister(program);
    genDIV(program, $$, $1, $3);
  }
  | exp MOD_OP exp
  {
    $$ = getNewRegister(program);
    genREM(program, $$, $1, $3);
  }
  | exp AND_OP exp
  {
    $$ = getNewRegister(program);
    genAND(program, $$, $1, $3);
  }
  | exp XOR_OP exp
  {
    $$ = getNewRegister(program);
    genXOR(program, $$, $1, $3);
  }
  | exp OR_OP exp
  {
    $$ = getNewRegister(program);
    genOR(program, $$, $1, $3);
  }
  | exp SHL_OP exp
  {
    $$ = getNewRegister(program);
    genSLL(program, $$, $1, $3);
  }
  | exp SHR_OP exp
  {
    $$ = getNewRegister(program);
    genSRA(program, $$, $1, $3);
  }
  | exp LT exp
  {
    $$ = getNewRegister(program);
    genSLT(program, $$, $1, $3);
  }
  | exp GT exp
  {
    $$ = getNewRegister(program);
    genSGT(program, $$, $1, $3);
  }
  | exp EQ exp
  {
    $$ = getNewRegister(program);
    genSEQ(program, $$, $1, $3);
  }
  | exp NOTEQ exp
  {
    $$ = getNewRegister(program);
    genSNE(program, $$, $1, $3);
  }
  | exp LTEQ exp
  {
    $$ = getNewRegister(program);
    genSLE(program, $$, $1, $3);
  }
  | exp GTEQ exp
  {
    $$ = getNewRegister(program);
    genSGE(program, $$, $1, $3);
  }
  | NOT_OP exp
  {
    $$ = getNewRegister(program);
    genSEQ(program, $$, $2, REG_0);
  }
  | exp ANDAND exp
  {
    t_regID rNormalizedOp1 = getNewRegister(program);
    genSNE(program, rNormalizedOp1, $1, REG_0);
    t_regID rNormalizedOp2 = getNewRegister(program);
    genSNE(program, rNormalizedOp2, $3, REG_0);
    $$ = getNewRegister(program);
    genAND(program, $$, rNormalizedOp1, rNormalizedOp2);
  }
  | exp OROR exp
  {
    t_regID rNormalizedOp1 = getNewRegister(program);
    genSNE(program, rNormalizedOp1, $1, REG_0);
    t_regID rNormalizedOp2 = getNewRegister(program);
    genSNE(program, rNormalizedOp2, $3, REG_0);
    $$ = getNewRegister(program);
    genOR(program, $$, rNormalizedOp1, rNormalizedOp2);
  }
;

var_id
  : IDENTIFIER
  {
    t_symbol *var = getSymbol(program, $1);
    if (var == NULL) {
      yyerror("variable not declared");
      YYERROR;
    }
    $$ = var;
    free($1);
  }
;

%%

t_program *parseProgram(char *fn)
{
  FILE *fp = fopen(fn, "r");
  if (!fp) {
    emitError(nullFileLocation, "could not open input file");
    return NULL;
  }

  program = newProgram();
  curFileLoc.file = fn;
  curFileLoc.row = 0;
  numErrors = 0;
  yyin = fp;
  yyparse();

  if (numErrors > 0) {
    fprintf(stderr, "%d error(s) generated.\n", numErrors);
    fclose(fp);
    deleteProgram(program);
    return NULL;
  }

  fclose(fp);
  return program;
}
