# variables
## 編譯程式
CC = clang
## 針對 Objective-C 指定標準 ISO/IEC 9899:1999
STD = -std=c99
## 指定要編譯的程式語言是 Objective-C
OBJC = -lobjc
## 編譯程式額外設定，建議讀者一一查詢
FLAGS = -pedantic -Wall -Wextra -Wno-import
## 指定引入 Objective-C runtime 的 Foundation
FRAMEWORK = -framework Foundation
## 指定使用 #import "header" 查找路徑，要注意不支援子資料夾
HEADERS = -I \
Basic/02HeaderUsage
## 透過 Makefile 的語法，便利的加入子資料夾的所有 .m 檔案
MFILES = \
		$(wildcard Basic/01Helloworld/*.m) \
		$(wildcard Basic/02HeaderUsage/*.m)
## 指定交給編譯程式的程式檔案
OBJCFILES =  $(MFILES) main.m
## 暫時用不到，請先忽略
## OBJ = main.o
## 作為編譯完成後，執行檔指定的名字
TARGET = main
## run phase 使用：主要提供主程式 argv 參數，使用方法 ARGS="ARG1,ARG2"
ARGS = $(arguments)

# make 指令，make 將執行第一個，也就是 all
all: build run

## 使用 make build 呼叫
build:
		$(CC) \
		$(STD) \
		$(FLAGS) \
		$(OBJC) \
		$(FRAMEWORK) \
		$(HEADERS) \
		$(OBJCFILES) \
		-o $(TARGET)
## 使用 make run 呼叫
run:
		./$(TARGET) $(ARGS)

# 指定指令
# 使用 make clean 呼叫
clean:
		rm $(TARGET)
