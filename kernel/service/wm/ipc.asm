;===============================================================================
; Copyright (C) by blackdev.org
;===============================================================================

;===============================================================================
; wejście:
;	cl - identyfikator komunikatu
;	rsi - wskaźnik obiektu zależnego
kernel_wm_ipc_mouse:
	; zachowaj oryginalne rejestry
	push	rax
	push	rbx
	push	rcx
	push	rsi

	; pobierz ID okna i PID
	mov	rax,	qword [rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.id]
	mov	rbx,	qword [rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.pid]

	; zamień pozycję wskaźnika kursora na pośrednią (względem okna)
	sub	r8,	qword [rsi + KERNEL_WM_STRUCTURE_OBJECT.field + KERNEL_WM_STRUCTURE_FIELD.x]
	sub	r9,	qword [rsi + KERNEL_WM_STRUCTURE_OBJECT.field + KERNEL_WM_STRUCTURE_FIELD.y]

	; skomponuj komunikat dla procesu
	mov	rsi,	kernel_wm_ipc_data

	; wyślij informacje o typie akcji
	mov	byte [rsi + KERNEL_WM_STRUCTURE_IPC.type],	cl

	; wyślij informacje o ID okna biorącego udział
	mov	qword [rsi + KERNEL_WM_STRUCTURE_IPC.id],	rax

	; wyślij informacje o pozycji wskaźnika kursora
	mov	qword [rsi + KERNEL_WM_STRUCTURE_IPC.value0],	r8	; x
	mov	qword [rsi + KERNEL_WM_STRUCTURE_IPC.value1],	r9	; y

	; wyślij komunikat
	xor	ecx,	ecx	; standardowy rozmiar komunikatu pod adresem w rejestrze RSI
	call	kernel_ipc_insert

	; przywróć oryginalne rejestry
	pop	rsi
	pop	rcx
	pop	rbx
	pop	rax

	; powrót z procedury
	ret

	macro_debug	"kernel_wm_ipc_mouse"

;===============================================================================
; wejście:
;	ax - kod klawisza
;	cl - identyfikator komunikatu
;	rsi - wskaźnik obiektu zależnego
kernel_wm_ipc_keyboard:
	; zachowaj oryginalne rejestry
	push	rbx
	push	rcx
	push	rdx
	push	rsi

	; pobierz ID okna i PID
	mov	rdx,	qword [rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.id]
	mov	rbx,	qword [rsi + KERNEL_WM_STRUCTURE_OBJECT.SIZE + KERNEL_WM_STRUCTURE_OBJECT_EXTRA.pid]

	; skomponuj komunikat dla procesu
	mov	rsi,	kernel_wm_ipc_data

	; wyślij informacje o typie akcji
	mov	byte [rsi + KERNEL_WM_STRUCTURE_IPC.type],	cl

	; wyślij informacje o ID okna biorącego udział
	mov	qword [rsi + KERNEL_WM_STRUCTURE_IPC.id],	rdx

	; wyślij informacje o kodzie klawisza
	mov	qword [rsi + KERNEL_WM_STRUCTURE_IPC.value0],	rax

	; wyślij komunikat
	xor	ecx,	ecx	; standardowy rozmiar komunikatu pod adresem w rejestrze RSI
	call	kernel_ipc_insert

	; przywróć oryginalne rejestry
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx

	; powrót z procedury
	ret

	macro_debug	"kernel_wm_ipc_keyboard"