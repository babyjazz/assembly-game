        .model  tiny

        .data
        msg     db      '=$',0
        ok      db      '@$'
        x       db      0
        y       db      24
        hole_x  db      0
        hole    db      ' $'

        .code
        org     0100h
main proc   
        mov     ah, 00h         ; Set to 80x25
        mov     al, 03h
        int     10h

        call    floor           ; init floor 
        call    print_character ; init character


        call    slide_hole
        call    delay
        call    slide_hole

        ret
main endp

;======================== function zone =====================


slide_hole proc
        mov     cx, 80
    print_hole:
        push    cx

        mov     ah, 02h         ; set cursor
        mov     bh, 00h
        mov     dh, y           ;y
        mov     dl, hole_x           ;x
        int     10h

        mov     ah, 09h         ; Write a colored char
        mov     al, ' '
        mov     bh, 00h
        mov     bl, 0Fh
        mov     cx, 0001h
        int     10h

        call    delay

        ;print restor = after print hole
        sub     hole_x, 1
        mov     ah, 02h         ; set cursor
        mov     bh, 00h
        mov     dh, y           ;y
        mov     dl, hole_x           ;x
        int     10h
        
        mov     ah, 09h         ; Write a colored char
        mov     al, '='
        mov     bh, 00h
        mov     bl, 0Fh
        mov     cx, 0001h
        int     10h

        add     hole_x, 2

        pop     cx
    loop print_hole

ret
slide_hole endp



delay proc
    mov     cx, 1
    lp_delay:
        push    cx
        mov     ah, 86h
        mov     cx, 01h          ;inc cx,inc delay
        mov     dx, 0fffh
        int     15h
        pop     cx
    loop lp_delay

        ;delay   proc
        ;mov     cx, 100
    ;d_loop1:
        ;push    cx
        ;mov     cx, 1100
    ;d_loop2:
        ;nop
        ;loop    d_loop2
        ;pop     cx
        ;loop    d_loop1
    ret
delay   endp



floor proc
        mov     cx, 80
    print: 
        push    cx
        mov     ah, 02h         ; set cursor
        mov     bh, 00h
        mov     dh, y           ;y
        mov     dl, x           ;x
        int     10h

        mov     ah, 09h
        mov     al, '='
        mov     bh, 00h
        mov     bl, 0Fh
        int     10h

        inc     x
        pop     cx
    loop print
ret
floor endp



print_character proc
        mov     ah, 02h         ; set cursor
        mov     bh, 00h
        mov     dh, 23           ;y
        mov     dl, 60           ;x
        int     10h

	    mov     ah, 09h
        mov     dx, offset ok
        int     21h
        ;mov     ah, 09h
        ;mov     al, '@'
        ;mov     bh, 00h
        ;mov     bl, 43h
        ;int     10h
ret
print_character endp


end main
