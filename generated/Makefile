target=scanner
objs=SysyBaseListener.o SysyBaseVisitor.o SysyLexer.o SysyListener.o SysyParser.o SysyVisitor.o main.o
CC=g++
CXXFLAGS += -std=c++17
LIBS += -lantlr4-runtime

main:$(objs)
	$(CC) -o $(target)  $(objs) $(LIBS)
%.o:%.cpp
	$(CC) -c $<
    
