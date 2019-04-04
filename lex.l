%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

char arr[100][100];
int i = 0;
int flag = 0;
%}

%option noyywrap
%option yylineno
separator   [ \t\n\r]
letter      [a-z]
digit       [0-9]
number      0|[1-9]{digit}*|-[1-9]{digit}*
id          {letter}[{letter}{digit}-]*
bool_val    #[t|f]
%%
<<EOF>>         { return 0; }
{separator}*    { /* do nothing */ }
"print-num"     { return print_num; }
"print-bool"    { return print_bool; }
[()\+\-*/><=]   { flag = 0;
                    for(int j=0; j<i; j++){
                        if(strcmp(yytext, arr[j])==0)
                            {flag = 1; break;}
                    }
                    if(flag==0){
                        strcpy(arr[i++], yytext); 
                        strcpy(arr[i++], "Lisp Operator"); 
                    }
                    return yytext[0]; }
"mod"           { flag = 0;
                    for(int j=0; j<i; j++){
                        if(strcmp(yytext, arr[j])==0)
                            {flag = 1; break;}
                    }
                    if(flag==0){
                        strcpy(arr[i++], yytext); 
                        strcpy(arr[i++], "Lisp Operator"); 
                    }
                    return mod; }
"and"           { flag = 0;
                    for(int j=0; j<i; j++){
                        if(strcmp(yytext, arr[j])==0)
                            {flag = 1; break;}
                    }
                    if(flag==0){
                        strcpy(arr[i++], yytext); 
                        strcpy(arr[i++], "Logical Operator"); 
                    }
                    return and; }
"or"            { flag = 0;
                    for(int j=0; j<i; j++){
                        if(strcmp(yytext, arr[j])==0)
                            {flag = 1; break;}
                    }
                    if(flag==0){
                        strcpy(arr[i++], yytext); 
                        strcpy(arr[i++], "Logical Operator"); 
                    }
                    return or; }
"not"           { flag = 0;
                    for(int j=0; j<i; j++){
                        if(strcmp(yytext, arr[j])==0)
                            {flag = 1; break;}
                    }
                    if(flag==0){
                        strcpy(arr[i++], yytext); 
                        strcpy(arr[i++], "Logical Operator"); 
                    }
                    return not; }
"if"            { return _if; }
"define"        { return _define; }
"fun"           { return fun; }
{number}        { yylval.ival = atoi(yytext); return number; }
{bool_val}      { yylval.bval = (yytext[1] == 't') ? 1 : 0 ; return bool_val; }
{id}*           {   yylval.str = strdup(yytext); 
                    flag = 0;
                    for(int j=0; j<i; j++){
                        if(strcmp(yylval.str, arr[j])==0)
                            {flag = 1; break;}
                    }
                    if(flag==0){
                        strcpy(arr[i++], yylval.str); 
                        strcpy(arr[i++], "Function"); 
                    }
                    return id; }
.               { printf("unexpected char: %s\n", yytext); }
%%

void yyerror(char *msg) {
    printf("error\n");
    // printf("%s\n", msg);
    
    printf("line number: %d, msg: %s, char: %s\n", yylineno, msg, yytext );
}