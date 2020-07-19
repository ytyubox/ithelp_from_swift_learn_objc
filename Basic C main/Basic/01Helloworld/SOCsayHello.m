//
//  main.m
//  BasicC
//
//  Created by 游宗諭 on 2020/7/15.
//

#include <stdio.h>
#import <Foundation/Foundation.h>
#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

void sayHello(const char* name) {
  // printf(ANSI_COLOR_RED     "This text is RED!"     ANSI_COLOR_RESET "\n");
  // printf(ANSI_COLOR_GREEN   "This text is GREEN!"   ANSI_COLOR_RESET "\n");
  // printf(ANSI_COLOR_YELLOW  "This text is YELLOW!"  ANSI_COLOR_RESET "\n");
  // printf(ANSI_COLOR_BLUE    "This text is BLUE!"    ANSI_COLOR_RESET "\n");
  // printf(ANSI_COLOR_MAGENTA "This text is MAGENTA!" ANSI_COLOR_RESET "\n");
  // printf(ANSI_COLOR_CYAN    "This text is CYAN!"    ANSI_COLOR_RESET "\n");
	printf(ANSI_COLOR_RED     "Hello %s!" ANSI_COLOR_RESET "\n", name);
	printf(ANSI_COLOR_GREEN   "Hello %s!" ANSI_COLOR_RESET "\n", name);
	printf(ANSI_COLOR_YELLOW  "Hello %s!" ANSI_COLOR_RESET "\n", name);
	printf(ANSI_COLOR_BLUE    "Hello %s!" ANSI_COLOR_RESET "\n", name);
	printf(ANSI_COLOR_MAGENTA "Hello %s!" ANSI_COLOR_RESET "\n", name);
	printf(ANSI_COLOR_CYAN    "Hello %s!" ANSI_COLOR_RESET "\n", name);
}
