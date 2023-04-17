#SysY2022：基于antlr4的词法分析(C++语言实现)

目录结构：

```
.
├── README.md    # 本说明文档
├── Sysy.g4      # SysY2022 antlr4 grammar规则文件
├── SysyLex.g4   # SysY2022 antlr4 Lexical规则文件
├── g4tocpp.sh   # 根据antlr4的规则(.g4)生成cpp词法分析程序
├── generated    # 生成程序及主控程序目录
│   ├── Makefile # Makefile
│   ├── main.cpp # 主控程序
│   └── main.h   # 头文件
└── test_cases   # 测试用例
    ├── case_1.c
    ├── case_2.c
    ├── case_3.c
    ├── case_4.c
    └── case_5.c
```

# 实验任务
        
在文件SysyLex.g4中补充适当的词法规则，并在main.cpp,main.h中适当修改或添加代码，设计识别`SysY2022`语言单词符号的词法分析器。

你需要补充的内容有：
### (一)在SysyLex.g4文件中，补充以下词法规则

(1) 标识符ID;

(2) int型字面量INT_LIT;

(3) float型字面量FLOAT_LIT;

(4) 词法错误LEX_ERR

### (二)确认main.h中定义的token种别名称与其种别编号一致

对于下面的词法规则：

`````cpp
lexer grammar SysyLex;

// keyword
INT : 'int';
FLOAT : 'float';
VOID : 'void';
CONST : 'const';
RETURN : 'return';
IF : 'if';
ELSE : 'else';
WHILE : 'while'; 
`````
antlr4会生成如下的C++代码（头文件):
```cpp
   enum {
    INT = 1, FLOAT = 2, VOID = 3, CONST = 4, RETURN = 5, IF = 6, ELSE = 7, 
    WHILE = 8
  };

```
为正确输出token种别名称(如INT)而非其编号(1)，在main.h文件中定义了string类型的数组：
```cpp
 std::string tokenTypeName[] = {"", "INT", "FLOAT", "VOID", "CONST", "RETURN", "IF", "ELSE",   "WHILE", "BREAK", "CONTINUE", "LP", "RP", 
    "LB", "RB", "LC", "RC", "COMMA", "SEMICOLON", "QUESTION", 
    "COLON", "MINUS", "NOT", "ASSIGN", "ADD", "MUL", "DIV", 
    "MOD", "AND", "OR", "EQ", "NEQ", "LT", "LE", "GT", 
    "GE", "INT_LIT", "FLOAT_LIT", "ID", "STRING", "", 
    "", "", "LEX_ERR"};

```
请确保token的名称与其定义的顺序一致。由于token从1开始编号，故token名称数组的0号元素置为"",对于不需要输出的种别名称亦可用""略过。

### (三)在main.cpp中，正确显示token及token的种别信息.
1. 对于识别出的合法的单词(token)，直接输出：

<p><font color=blue>识别出的单词 : 种别名称</font></p> (“:”号前后各留一空格，一个单词占一行）

2. 对于所有的词法错误，应该报告词法错误，例如: '9ab'，'2f'等，应该报告错误，报告格式为：

<p><font color=blue>Lexical error - 行号 : 识别出来的串(如'9ab')</font></p> (“-”和“:”号前后各留一空格，报告之后换行)

3. 对于whitespace和注释，直接忽略；


# 要求

1. 对于识别出的合法的单词，直接输出：

识别出的单词 : 种别名称  (“:”号前后各留一空格，一个单词占一行）

2. 对于所有的词法错误，应该报告词法错误，例如: '9ab'，'2f'等，应该报告错误，报告格式为：

Lexical error - 行号 : 识别出来的串  (如'9ab', “-”和“:”号前后各留一空格，每报告一个词法错误之后换行)

3. 对于whitespace和注释，直接忽略；

对于以下程序
```
int main(){
    float a, b;
    int c = 085;
    a = 020e-04f;
    b = getfloat();
    putfloat(a + b);
    putch(10);
    return 0;
}
```
词法分析的输出为
```
nt : INT
main : ID
( : LP
) : RP
{ : LC
float : FLOAT
a : ID
, : COMMA
b : ID
; : SEMICOLON
int : INT
c : ID
= : ASSIGN
Lexical error - line 3 : 085
; : SEMICOLON
a : ID
= : ASSIGN
020e-04f : FLOAT_LIT
; : SEMICOLON
b : ID
= : ASSIGN
getfloat : ID
( : LP
) : RP
; : SEMICOLON
putfloat : ID
( : LP
a : ID
+ : ADD
b : ID
) : RP
; : SEMICOLON
putch : ID
( : LP
10 : INT_LIT
) : RP
; : SEMICOLON
return : RETURN
0 : INT_LIT
; : SEMICOLON
} : RC
```
# main.cpp


# SysY语言定义(2022)
(https://gitlab.eduxiji.net/nscscc/compiler2022/-/blob/master/SysY2022%E8%AF%AD%E8%A8%80%E5%AE%9A%E4%B9%89-V1.pdf)

# antlr4官网及开源项目
https://www.antlr.org/

https://github.com/antlr/antlr4

# antlr4 C++ runtime
wget https://www.antlr.org/download/antlr4-cpp-runtime-4.9.3-source.zip

antlr4-cpp-runtime的编译及安装请自行查阅手册。



