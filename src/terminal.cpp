struct TerminalContext {
    uint32_t buffer;
    uint32_t width;
    uint32_t height;
    uint32_t x;
    uint32_t y;
    uint8_t foreground;
    uint8_t background;
};

TerminalContext term_ctx;

void newline() {
    term_ctx.x = 0;
    term_ctx.y++;
}

void print_char(char c) {
    if (c == '\n') {
        newline();
        return;
    }
    uint32_t position = term_ctx.buffer + term_ctx.x * 2 + term_ctx.y * 2 * term_ctx.width;
    *(char*)(position) = c;
    *(char*)(position + 1) = term_ctx.background << 4 | term_ctx.foreground;
    term_ctx.x++;
}

void print_string(char* string) {
    while (*string) {
        print_char(*string++);
    }
}

void set_foreground(uint8_t color) {
    term_ctx.foreground = color;
}

void set_background(uint8_t color) {
    term_ctx.background = color;
}
