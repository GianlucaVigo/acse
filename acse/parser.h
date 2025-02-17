/// @file parser.h
/// @brief Header file associated to parser.y

#ifndef PARSER_H
#define PARSER_H

#include <stdio.h>
#include "program.h"
#include "codegen.h"

/**
 * @defgroup semdef Semantic Definitions
 * @brief Structure definitions used for semantic analysis
 * @{
 */

/** Utility structure used to store information about an if statement. */
typedef struct {
  t_label *lElse; ///< Label to the else part.
  t_label *lExit; ///< Label to the first instruction after the statement.
} t_ifStmt;

/** Utility structure used to store information about a while statement. */
typedef struct {
  t_label *lLoop; ///< Label to the beginning of the loop.
  t_label *lExit; ///< Label to the first instruction after the loop.
} t_whileStmt;

typedef struct {
  t_label *exit;
  t_label *loop;
} t_ifRepeatStmt;

/**
 * @}
 */

/**
 * @defgroup parser Syntatic and Lexical Analysis
 * @brief Functions used for syntactic and lexical analysis
 * @{
 */

/** Performs the initial syntactic-driven translation of the source code.
 *  This function is mostly a wrapper around yyparse().
 *  @param fn The path to the source code file to be compiled.
 *  @returns The program object produced. */
t_program *parseProgram(char *fn);

/**
 * @}
 */

/**
 * @addtogroup errors
 * @{
 */

/** Report a syntax error.
 *  @note This function is also used by Bison-generated code.
 *  @param msg The error message. */
void yyerror(const char *msg);

/**
 * @}
 */

#endif
