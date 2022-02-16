section .text
    global main
main:
    mov [counter], word 1
l1:
;    mov edx, 1
;    mov ecx, n_line
;    mov ebx, 1
;    mov eax, 4
;    int 0x80        ; print '\n'


    mov rbx, [counter]
    add rbx, 1
    mov [counter], rbx
    mov rax, rbx
    

    cmp rbx, [num]
    je exit

    mov r11, 0

;return1:
    mov eax, [counter]
    mov ebx, 100000
    div ebx
    mov eax, [counter]
    cmp edx, 0
    je print_counter

    mov rbx, [counter]
l2:
    xor rdx, rdx
    mov rax, rbx
    mov rcx, 2
    div rcx
    cmp dx, 0
    je even
    jmp calculate_odd
even:
    mov [res], rax

    mov r11, 1
;    call convert_int_to_string ; convert number in aex 
;return2:
;    mov ecx, string_number
;    mov ebx, 1
;    mov eax, 4
;    int 0x80        ; print res

;    mov edx, 1
;    mov ecx, n_line
;    mov ebx, 1
;    mov eax, 4
;    int 0x80        ; print '\n'


    mov rbx, [res]
    cmp rbx, [counter]
    jl l1
    mov [res], rbx
    jmp l2


exit:
    mov eax, 1
    int 0x80

print_counter:
    call convert_int_to_string ; convert number in aex

    mov ecx, string_number
    mov ebx, 1
    mov eax, 4
    int 0x80        ; print res

    mov edx, 1
    mov ecx, n_line
    mov ebx, 1
    mov eax, 4
    int 0x80        ; print '\n'


calculate_odd:
    xor rdx, rdx
    mov rax, 3
    mul rbx
    add rax, 1
    jmp even



convert_int_to_string:
    xor r10, r10
    mov r11b, 0
    mov [string_number], r10
    mov [string_number + 8], r10
int_to_string:               ; convert an unsigned int number to a string
    mov r8, rax             ; save number on r8 register
    mov rbx, 10              ; get 10 to calculate a base10 *
    xor rcx, rcx
    xor rdx, rdx             ; edx != 0 cause unexpected  behavior during div **

int_length:                  ; get string's length [cl] of decimal int (count how many times [cl-1] eax [input] should be divided by 10 so that result >=1 and <10)
    inc cl
    cmp rax, rbx
    jl get_divisor
    xor rdx, rdx
    div rbx
    jmp int_length

get_divisor:                 ; calculate a base10 divisor  10^(cl-1)
    cmp r11b, 0
    je c3
    mov dl, r11b
    sub dl, cl
    jmp add_zero_char
c3: mov r11b, cl 
    mov rax, 1
divisor_loop:
    inc ch
    cmp ch, cl
    jge get_first_digit
    mul rbx                  ; *
    jmp divisor_loop

add_zero_char:
    dec dl
    cmp dl, 0
    je c3
    mov al, 0x30
    xor rbx, rbx
    mov bl, r10b             ; calculate address on string ...
    add rbx, string_number   ; ... to save new ascii character 8810182
    mov [rbx], al
    inc r10w
    mov rbx, 10
    jmp add_zero_char

get_first_digit:             ; divide input by base10 divisor
    xor rdx,rdx
    mov r9, rax
    mov rax, r8
    div r9                  ; **
    
get_bias:
    add al, 0x30             ; convert number to ascii
    xor rbx, rbx
    mov bl, r10b             ; calculate address on string ...
    add rbx, string_number   ; ... to save new ascii character
    mov [rbx], al
    inc r10w
    mov rax, rdx
    cmp cl, 1                ; if string length (cl) isn't 1 ...
    jne int_to_string        ;
    mov rdx, r10
    ret
;    cmp r11, 0
;    je return1
;    jmp return2
    
;convert_number_to_string:
;    mov ecx, 10         ; divisor
;    xor bx, bx          ; count digits

;divide:
;    xor edx, edx        ; high part = 0
;    div ecx             ; eax = edx:eax/ecx, edx = remainder
;    push edx             ; DL is a digit in range [0..9]
;    inc bx              ; count digits
;    test eax, eax       ; EAX is 0?
;    jnz divide          ; no, continue

;    ; POP digits from stack in reverse order
;    mov cx, bx          ; number of digits
;    lea si, strResult   ; DS:SI points to string buffer
;next_digit:
;    pop ax
;    add al, '0'         ; convert to ASCII
;    mov [si], al        ; write it to the buffer
;    inc si
;    loop next_digit
;    ret


section .bss
string_number resb 19  ;string from int_to_string

counter resq 1
res resq 1

section .data
n_line dq 0xa
num dq 0xffffffff

strResult db 16 dup (0) ; string buffer to store results

