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

# SysY语言定义(2022)

# antlr4官网及开源项目
https://www.antlr.org/
https://github.com/antlr/antlr4

# antlr4 C++ runtime
wget https://www.antlr.org/download/antlr4-cpp-runtime-4.9.3-source.zip
antlr4-cpp-runtime的编译及安装请处行查阅手册

# antlr4开源项目

