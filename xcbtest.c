// build with gcc -lxcb xcbtest.c
#include <xcb/xcb.h>
#include <stdio.h>

xcb_connection_t *connection;
xcb_screen_t *screen;
const xcb_setup_t *setup;
xcb_screen_iterator_t iterator;

int main() {
    connection = xcb_connect(NULL, NULL);
    if (xcb_connection_has_error(connection) > 0) {
        printf("fuk");
        return 1;
    }

    setup = xcb_get_setup(connection);
    iterator = xcb_setup_roots_iterator(setup);
    printf("iterator:\n");
    printf("data: %u\n", iterator.data);
    printf("rem: %d\n", iterator.rem);
    printf("index: %d\n", iterator.index);
    printf("=================\n");

    screen = iterator.data;
    printf("screen:\n");
    printf("root: %d\n", screen->root);
    printf("default_colormap: %d\n", screen->default_colormap);
    printf("white_pixel: %d\n", screen->white_pixel);
    printf("black_pixel: %d\n", screen->black_pixel);
    printf("current_input_masks: %d\n", screen->current_input_masks);
    printf("width_in_pixels: %d\n", screen->width_in_pixels);
    printf("height_in_pixels: %d\n", screen->height_in_pixels);
    printf("width_in_millimeters: %d\n", screen->width_in_millimeters);
    printf("height_in_millimeters: %d\n", screen->height_in_millimeters);
    printf("min_installed_maps: %d\n", screen->min_installed_maps);
    printf("max_installed_maps: %d\n", screen->max_installed_maps);
    printf("root_visual: %d\n", screen->root_visual);
    printf("backing_stores: %d\n", screen->backing_stores);
    printf("save_unders: %d\n", screen->save_unders);
    printf("root_depth: %d\n", screen->root_depth);
    printf("allowed_depths_len: %d\n", screen->allowed_depths_len);

    return 0;
}
