%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// #include <ctype.h> // TODO: Type Checking
extern int yylex(void);
extern void yyerror(char *);
extern FILE * yyin;

%}

%union {
    char *str;
    int ival, bval;
    
}
%token print_num mod print_bool and or not _if _define fun
%token <ival> number
%token <bval> bool_val
%token <str> id
%type <np> PORGRAM STMT STMTS PRINT_STMT EXPS EXP NUM_OP LOG_OP
%type <np> IF_EXP TEST_EXP THEN_EXP ELSE_EXP
%type <np> DEF_STMT VARIABLE
%type <np> FUN_EXP FUN_IDs FUN_BODY FUN_CALL PARAMS PARAM FUN_NAME VARIABLES
%%
PORGRAM         :   STMTS                                   {  }
                ;
STMTS           :   STMT STMTS                              {  }
                |   STMT                                    {  }
                ;

STMT            :   EXP                                     {  }
                |   PRINT_STMT                              {  }
                |   DEF_STMT                                {  }
                ;

PRINT_STMT      :   '(' print_num EXP ')'                   { }
                |   '(' print_bool EXP ')'                  {  }
                ;

EXPS            :   EXP EXPS                                {  }
                |   EXP                                     {  }
                ;
EXP             :   number                                  { }
                |   bool_val                                {  }
                |   NUM_OP                                  {  }
                |   LOG_OP                                  {  }
                |   IF_EXP                                  {  }
                |   VARIABLE                                {  }
                |   FUN_EXP                                 {  }
                |   FUN_CALL                                {  }
                ;

NUM_OP          :   '(' '+' EXPS ')'                        {  }
                |   '(' '-' EXP EXP  ')'                    {  }
                |   '(' '*' EXPS ')'                        {  }
                |   '(' '/' EXP EXP  ')'                    {  }
                |   '(' mod EXP EXP  ')'                    {  }
                |   '(' '>' EXP EXP  ')'                    {  }
                |   '(' '<' EXP EXP  ')'                    {  }
                |   '(' '=' EXPS ')'                        {  }
                ;

LOG_OP          :   '(' and EXP EXPS ')'                    {  }
                |   '(' or EXP EXPS ')'                     {  }
                |   '(' not EXP ')'                         {  }
                ;

DEF_STMT        :   '(' _define VARIABLE EXP ')'            {  }
                ;
VARIABLE        :   id                                      {  }
                ;

IF_EXP          :   '(' _if TEST_EXP THEN_EXP ELSE_EXP ')'  {  }
                ;
TEST_EXP        :   EXP                                     {  }
                ;
THEN_EXP        :   EXP                                     {  }
                ;
ELSE_EXP        :   EXP                                     {  }
                ;

FUN_EXP         :   '(' fun FUN_IDs FUN_BODY ')'            {  }
                ;
FUN_IDs         :   '(' VARIABLES ')'                       {  }
                ;
VARIABLES       :   VARIABLES VARIABLE                      {  }
                |   /* empty */                             {  }
                ;

FUN_BODY        :   EXP                                     {  }
                ;

FUN_CALL        :   '(' FUN_EXP PARAMS ')'                  {  }
                |   '(' FUN_NAME PARAMS ')'                 {  }
                ;
PARAMS          :   PARAM PARAMS                            {  }
                |   /* empty */                             {  }
                ;
PARAM           :   EXP                                     {  }
                ;
FUN_NAME        :   id                                      {  }
                ;
%%
int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    int a = yyparse();
    fclose(yyin);
    if(a == 0) {
     
        printf("Parsed successfuly!\n");
    } else {
        /* yyerror() */
    }
  
    return 0;
}