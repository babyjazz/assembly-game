        .model  tiny
        .data

        column  db  0
        printfloor_count    db 0

        .code
        org     0100h
main proc   
        mov     ah, 00h         ; Set to 80x25
        mov     al, 03h
        int     10h

    call init_floor

        ret
main endp

;======================== function zone =====================



init_floor proc
        printfloor: 

        mov dh, 24  ;row
        mov dl, column  ;column
        mov ah,02h ;cursor Menu scr
        int 10h

        mov ah, 0ah
        mov al, '='
        mov bh, 0
        mov cx, 1
        int 10h

        inc column
        inc printfloor_count

        cmp printfloor_count, 80
        jl printfloor
init_floor endp


end main
