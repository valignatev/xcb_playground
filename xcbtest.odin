// odin run xcbtest.odin

package main

import "core:c"
import "core:fmt"

foreign import xcb "system:xcb"

xcb_connection_t :: struct {}
xcb_window_t :: u32
xcb_colormap_t :: u32
xcb_visualid_t :: u32
xcb_keycode_t :: u8

xcb_screen_t :: struct {
    root: xcb_window_t,
    default_colormap: xcb_colormap_t,
    white_pixel: u32,
    black_pixel: u32,
    current_input_masks: u32,
    width_in_pixels: u16,
    height_in_pixels: u16,
    width_in_millimeters: u16,
    height_in_millimeters: u16,
    min_installed_maps: u16,
    max_installed_maps: u16,
    root_visual: xcb_visualid_t,
    backing_stores: u8,
    save_unders: u8,
    root_depth: u8,
    allowed_depths_len: u8,
}

xcb_screen_iterator_t :: struct {
  data: ^xcb_screen_t,
  rem: int,
  index: int,
}

xcb_setup_t :: struct {
    status: u8,
    pad0: u8,
    protocol_major_version: u16,
    protocol_minor_version: u16,
    length: u16,
    release_number: u32,
    resource_id_base: u32,
    resource_id_mask: u32,
    motion_buffer_size: u32,
    vendor_len: u16,
    maximum_request_length: u16,
    roots_len: u8,
    pixmap_formats_len: u8,
    image_byte_order: u8,
    bitmap_format_bit_order: u8,
    bitmap_format_scanline_unit: u8,
    bitmap_format_scanline_pad: u8,
    min_keycode: xcb_keycode_t,
    max_keycode: xcb_keycode_t,
    pad1: [4]u8,
}

foreign xcb {
    xcb_connect :: proc(displayname: cstring, screepnp: ^int) -> ^xcb_connection_t ---
    xcb_connection_has_error :: proc(c: ^xcb_connection_t) -> int ---
    xcb_setup_roots_iterator :: proc(R: ^xcb_setup_t) -> xcb_screen_iterator_t ---
    xcb_get_setup :: proc(c: ^xcb_connection_t) -> ^xcb_setup_t ---
}

connection: ^xcb_connection_t
screen: ^xcb_screen_t

main :: proc() {
    connection = xcb_connect(nil, nil)
    if xcb_connection_has_error(connection) > 0 {
	fmt.eprintln("fuk")
	return;
    }
    setup := xcb_get_setup(connection)
    fmt.printf("%#v\n", setup)
    iterator := xcb_setup_roots_iterator(setup)
    fmt.printf("%#v\n", iterator)
    screen = iterator.data
    // ==================================
    // screen is nil here for some reason
    // ==================================
    fmt.printf("%#v\n", screen)
}
