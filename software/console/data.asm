;===============================================================================
; Copyright (C) by Blackend.dev
;===============================================================================

align	STATIC_QWORD_SIZE_byte,	db	STATIC_NOTHING

;===============================================================================
console_window			dq	STATIC_EMPTY	; pozycja na osi X
				dq	STATIC_EMPTY	; pozycja na osi Y
				dq	CONSOLE_WINDOW_WIDTH_pixel	; szerokość okna
				dq	CONSOLE_WINDOW_HEIGHT_pixel	; wysokość okna
				dq	STATIC_EMPTY	; wskaźnik do przestrzeni danych okna (uzupełnia Bosu)
.extra:				dq	STATIC_EMPTY	; rozmiar przestrzeni danych okna w Bajtach (uzupełnia Bosu)
				dq	LIBRARY_BOSU_WINDOW_FLAG_header | LIBRARY_BOSU_WINDOW_FLAG_border
				dq	STATIC_EMPTY	; identyfikator okna (uzupełnia Bosu)
				dq	STATIC_EMPTY	; szerokość okna w Bajtach (uzupełnia Bosu)
.elements:			;---------------------------------------
				; element "nagłówek"
				;---------------------------------------
.element_header:		dd	LIBRARY_BOSU_ELEMENT_TYPE_header
				dq	.element_header_end - .element_header	; rozmiar elementu
				dq	0	; pozycja na osi X względem przestrzeni danych okna
				dq	0	; pozycja na osi Y względem przestrzeni danych okna
				dq	STATIC_EMPTY	; wartość ignorowana, nagłówek zawsze jest na całą szerokość okna (-krawędzie)
				dq	LIBRARY_BOSU_ELEMENT_HEADER_HEIGHT_pixel	; wysokość elementu
				dq	STATIC_EMPTY	; wskaźnik do procedury obsługi zdarzenia
				db	.element_header_end - .element_header_string
.element_header_string:		db	"Console"
.element_header_end:		;---------------------------------------
				; element "terminal"
				;---------------------------------------
.element_terminal:		dd	LIBRARY_BOSU_ELEMENT_TYPE_draw
				dq	.element_terminal_end - .element_terminal
				dq	0	; pozycja na osi X względem przestrzeni danych okna
				dq	LIBRARY_BOSU_ELEMENT_HEADER_HEIGHT_pixel
				dq	CONSOLE_WINDOW_WIDTH_pixel
				dq	CONSOLE_WINDOW_HEIGHT_pixel - LIBRARY_BOSU_ELEMENT_HEADER_HEIGHT_pixel
				dq	STATIC_EMPTY	; brak akcji związanej z elementem
.element_terminal_end:		;---------------------------------------
				; koniec elementów okna
				;---------------------------------------
				dd	STATIC_EMPTY
console_window_end:

;===============================================================================
console_terminal_table		dq	CONSOLE_WINDOW_WIDTH_pixel	; szerokość w pikselach
				dq	CONSOLE_WINDOW_HEIGHT_pixel - LIBRARY_BOSU_ELEMENT_HEADER_HEIGHT_pixel	; wysokość w pikselach
				dq	STATIC_EMPTY	; wskaźnik do przestrzeni danych terminala
				dq	(CONSOLE_WINDOW_WIDTH_pixel * (CONSOLE_WINDOW_HEIGHT_pixel - LIBRARY_BOSU_ELEMENT_HEADER_HEIGHT_pixel)) << KERNEL_VIDEO_DEPTH_shift	; rozmiar przestrzeni w Bajtach
				dq	CONSOLE_WINDOW_WIDTH_pixel << KERNEL_VIDEO_DEPTH_shift	; scanline_byte
				dq	STATIC_EMPTY	; wskaźnik pozycji wirtualnego kursora w przestrzeni danych terminala
				dq	STATIC_EMPTY	; szerokość terminala w znakach
				dq	STATIC_EMPTY	; wysokość terminala w znakach
				dq	STATIC_EMPTY	; scanline_char
				dq	STATIC_EMPTY	; pozycja kursora na osi X.Y
				dq	STATIC_EMPTY	; blokada wirtualnego kursora
				dd	0x00F5F5F5	; kolor czcionki
				dd	0x00000000	; kolor tła