# adapted from something here -> https://github.com/kovidgoyal/kitty/discussions/4447
# (for future debugging reference)

from kitty.tab_bar import draw_title


def draw_tab(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data):
    screen.draw("[")

    draw_title(draw_data, screen, tab, index)

    extra = screen.cursor.x - before - max_title_length
    print(f"extra:{extra}")
    if extra >= 0:
        screen.cursor.x -= extra + 3
        screen.draw('…')
    elif extra == -1:
        screen.cursor.x -= 2
        screen.draw('…')

    screen.draw("] ")

    return screen.cursor.x
