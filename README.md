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
# 实验环境
Ubuntu 18.04 LTS及以上

GNU build-essential (gcc,g++,...) 7.5及以上

make 

antlr4 4.9.3 JAR包

antlr4 4.9.3 C++ runtime

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
int : INT
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
````cpp
#include <iostream>

#include "antlr4-runtime.h"
#include "SysyLexer.h"
#include "SysyParser.h"
#include "main.h"

using namespace antlr4;

int main(int argc, const char* argv[]) {
    std::ifstream stream;
    stream.open(argv[1]);
    ANTLRInputStream input(stream);
    //ANTLRInputStream input(std::cin);
    SysyLexer lexer(&input);
    CommonTokenStream tokens(&lexer);

    tokens.fill();
   
    for (auto token : tokens.getTokens()) {
  
        //简单粗暴的输出token信息并不符合题目要求
        //std::cout << token->toString() << std::endl;
    }

    /* 语法分析
    SysyParser parser(&tokens);
    tree::ParseTree* tree = parser.compUnit();

    std::cout << tree->toStringTree(&parser) << std::endl << std::endl;
    */

    return 0;
}    
````
main.cpp中，token的输出(该输出句语已被注释掉)直接调用了token->toString()，其直接输出token及token的种别编号，这并不符合实验要求，请查阅antlr4的API手册，调用合适的方法，获得所需信息，提示：

token->getText() - 取得token对应的文本符号串

token->getLine() - 取得token所在的行号

token->getType() - 取得token的种别编号,如果token及其词法规则的定义顺序与main.h中tokenTypeName[]数组元素的顺序一致，则tokenTypeName[token->getType()]可获得token名。
注意，当token的Type值为lexer.LEX_ERR应报词法错误；当Type值为lexer.EOF时，应忽略，不输出。

# SysY语言定义(2022)
(https://gitlab.eduxiji.net/nscscc/compiler2022/-/blob/master/SysY2022%E8%AF%AD%E8%A8%80%E5%AE%9A%E4%B9%89-V1.pdf)

# antlr4官网及开源项目
https://www.antlr.org/

https://github.com/antlr/antlr4

# antlr4 C++ runtime
wget https://www.antlr.org/download/antlr4-cpp-runtime-4.9.3-source.zip

antlr4-cpp-runtime的编译及安装请自行查阅手册。

# 评测方法
正确补充词法规则，并补充能输出实验要求的C++代码后，可以按以下方法测试程序：

```
(1) 根据antlr4词法规则，生成c++词法分析程序
./g4tocpp.sh

如果报没有执行权的错误，可执行chmod +x g4tocpp.sh后再执行
该脚本实际执行的是：
antlr4 Sysy.g4 -Dlanguage=Cpp -listener -visitor -o generated/
其中antlr4是java -cp "/usr/local/lib/antlr-4.9.3-complete.jar:$CLASSPATH" org.antlr.v4.Tool的别称
执行上述脚本后，generated/文件夹将增加一批.cpp,.h文件。
(2) 编译c++词法分析程序 
cd generated
make 
正常情况下将生成词法分析程序scanner. 
注：这个Makefile没有做清理工作，你可以完善它，在必要时make clean清理所有生成的文件。
(3) 执行词法分析程序，分析测试用例 
./scanner ../test_cases/case_1.c
./scanner ../test_cases/case_2.c
./scanner ../test_cases/case_3.c
./scanner ../test_cases/case_4.c
./scanner ../test_cases/case_5.c

```


