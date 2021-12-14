#include <stdint.h>
#include "terminal.cpp"
#include "colors.h"

extern "C" void main() {
    term_ctx.buffer = 0xb8000;
    term_ctx.width = 80;
    term_ctx.height = 25;
    term_ctx.x = 0;
    term_ctx.y = 0;
    term_ctx.foreground = WHITE;
    term_ctx.background = BLACK;

    set_foreground(BLACK);
    set_background(CYAN);
    //                   #=-                              654321--123456                              -=#
    char banner_top[] = "[                              Welcome to OmegaOS                              ]\n\n";
    print_string(banner_top);

    set_foreground(WHITE);
    set_background(BLACK);
    for (char x = 1; x < 8; x++) {
        for (char y = 0; y < 32; y++) {
            print_char(' ');
            print_char(x * 32 + y);
        }
        newline();
    }

    set_foreground(GREEN);
    set_background(BLACK);
    char hello[] = "\nHello, world!";
    print_string(hello);

    return;
}
