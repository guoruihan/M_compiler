default rel

global __print
global __println
global __getString
global __getInt
global __toString
global __string_length
global __string_substring
global __string_parseInt
global __string_ord
global __stringConcat
global __stringComp
global main

extern strcmp
extern __sprintf_chk
extern __stack_chk_fail
extern memcpy
extern malloc
extern __isoc99_scanf
extern puts
extern __printf_chk
extern _GLOBAL_OFFSET_TABLE_


SECTION .text

__print:
        lea     rdx, [rdi+8H]
        mov     rsi, L_011
        mov     edi, 1
        xor     eax, eax
        jmp     __printf_chk

ALIGN   16

__println:
        add     rdi, 8
        jmp     puts

ALIGN   8

__getString:
        push    rbp
        push    rbx
        mov     rsi, __buffer.3340
        mov     rdi, L_011
        xor     eax, eax
        sub     rsp, 8
        call    __isoc99_scanf
        mov     rcx, __buffer.3340
        mov     rbx, rcx

L_001:  mov     edx, dword [rbx]
        add     rbx, 4
        lea     eax, [rdx-1010101H]
        not     edx
        and     eax, edx
        and     eax, 80808080H
        jz      L_001
        mov     edx, eax
        shr     edx, 16
        test    eax, 8080H
        cmove   eax, edx
        lea     rdx, [rbx+2H]
        mov     esi, eax
        cmove   rbx, rdx
        add     sil, al
        sbb     rbx, 3
        sub     rbx, rcx
        lea     edi, [rbx+8H]
        movsxd  rdi, edi
        call    malloc
        mov     rbp, rax
        lea     rdx, [rbx+1H]
        movsxd  rax, ebx
        lea     rdi, [rbp+8H]
        mov     rsi, __buffer.3340
        mov     qword [rbp], rax
        call    memcpy
        add     rsp, 8
        mov     rax, rbp
        pop     rbx
        pop     rbp
        ret

__getInt:
        sub     rsp, 24
        mov     rdi, L_012
        mov     rax, qword [fs:abs 28H]
        mov     qword [rsp+8H], rax
        xor     eax, eax
        mov     rsi, rsp
        call    __isoc99_scanf
        mov     rdx, qword [rsp+8H]
        xor     rdx, qword [fs:abs 28H]
        mov     rax, qword [rsp]
        jnz     L_002
        add     rsp, 24
        ret

L_002:  call    __stack_chk_fail

ALIGN   16

__toString:
        push    rbp
        push    rbx
        mov     rbp, rdi
        mov     edi, 32
        sub     rsp, 8
        call    malloc
        mov     rcx, L_012
        lea     rdi, [rax+8H]
        mov     rbx, rax
        mov     r8, rbp
        mov     edx, 24
        mov     esi, 1
        xor     eax, eax
        call    __sprintf_chk
        cdqe
        mov     qword [rbx], rax
        add     rsp, 8
        mov     rax, rbx
        pop     rbx
        pop     rbp
        ret

ALIGN   16

__string_length:
        mov     rax, qword [rdi]
        ret

ALIGN   16

__string_substring:
        push    r14
        push    r13
        mov     r14, rsi
        push    r12
        push    rbp
        mov     r12, rdi
        push    rbx
        mov     ebx, edx
        sub     ebx, esi
        lea     edi, [rbx+0AH]
        lea     ebp, [rbx+1H]
        movsxd  rdi, edi
        call    malloc
        test    ebp, ebp
        mov     r13, rax
        movsxd  rax, ebp
        mov     qword [r13], rax
        jle     L_003
        mov     edx, ebx
        lea     rdi, [r13+8H]
        lea     rsi, [r12+r14+8H]
        add     rdx, 1
        call    memcpy

L_003:  add     ebp, 8
        mov     rax, r13
        movsxd  rbp, ebp
        pop     rbx
        mov     byte [r13+rbp], 0
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        ret

ALIGN   8

__string_parseInt:
        movsx   eax, byte [rdi+8H]
        cmp     al, 45
        jz      L_006
        lea     edx, [rax-30H]
        cmp     dl, 9
        ja      L_007
        lea     rcx, [rdi+8H]
        xor     edi, edi

L_004:  xor     edx, edx

ALIGN   16

L_005:  lea     edx, [rdx+rdx*4]
        add     rcx, 1
        lea     edx, [rax+rdx*2-30H]
        movsx   eax, byte [rcx]
        lea     esi, [rax-30H]
        cmp     sil, 9
        jbe     L_005
        movsxd  rcx, edx
        neg     edx
        test    edi, edi
        movsxd  rax, edx
        cmove   rax, rcx
        ret

ALIGN   16

L_006:  movsx   eax, byte [rdi+9H]
        lea     rcx, [rdi+9H]
        lea     edx, [rax-30H]
        cmp     dl, 9
        ja      L_007
        mov     edi, 1
        jmp     L_004

ALIGN   16

L_007:  xor     eax, eax
        ret

ALIGN   16

__string_ord:
        movsx   rax, byte [rdi+rsi+8H]
        ret

ALIGN   16

__stringConcat:
        push    r14
        push    r13
        mov     r14, rdi
        push    r12
        push    rbp
        mov     r13, rsi
        push    rbx
        mov     rbx, qword [rdi]
        mov     r12, qword [rsi]
        lea     rdi, [rbx+r12+9H]
        call    malloc
        mov     rbp, rax
        lea     rax, [rbx+r12]
        test    rbx, rbx
        mov     qword [rbp], rax
        jle     L_010
        lea     rdi, [rbp+8H]
        lea     rsi, [r14+8H]
        mov     rdx, rbx
        add     ebx, 8
        call    memcpy
        movsxd  rax, ebx
L_008:  test    r12, r12
        jle     L_009
        movsxd  rdi, ebx
        lea     rsi, [r13+8H]
        mov     rdx, r12
        add     rdi, rbp
        call    memcpy
        lea     eax, [rbx+r12]
        cdqe
L_009:  mov     byte [rbp+rax], 0
        mov     rax, rbp
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        ret

L_010:  mov     eax, 8
        mov     ebx, 8
        jmp     L_008

ALIGN   8

__stringComp:
        sub     rsp, 8
        add     rsi, 8
        add     rdi, 8
        call    strcmp
        add     rsp, 8
        cdqe
        ret

SECTION .data

SECTION .bss    align=32

__buffer.3340:
        resb    1048576

SECTION .text.startup

main:
        xor     eax, eax
        jmp     __init

SECTION .rodata.str1.1

L_011:
        db 25H, 73H, 00H

L_012:
        db 25H, 6CH, 64H, 00H


;====================================================
	 section .text
_merge_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r13
	mov r13, rdi
	mov rcx, rsi
	cmp r13, 0
	je l_1
	l_2:
	cmp rcx, 0
	je l_3
	l_4:
	mov rax, qword [g_0]
	mov rdx, qword [rax + r13 * 8 + 8]
	mov rax, qword [g_0]
	cmp rdx, qword [rax + rcx * 8 + 8]
	jge l_5
	l_6:
	mov rax, r13
	mov r13, rcx
	mov rcx, rax
	l_5:
	mov rsi, rcx
	mov rax, qword [g_1]
	mov rdi, qword [rax + r13 * 8 + 8]
	call _merge_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, qword [g_1]
	mov qword [rax + r13 * 8 + 8], rcx
	mov rax, qword [g_2]
	mov rcx, qword [rax + r13 * 8 + 8]
	mov rax, qword [g_1]
	mov rax, qword [rax + r13 * 8 + 8]
	mov rdx, qword [g_2]
	mov qword [rdx + r13 * 8 + 8], rax
	mov rax, qword [g_1]
	mov qword [rax + r13 * 8 + 8], rcx
	mov rax, r13
	jmp l_7
	l_3:
	mov rax, r13
	jmp l_7
	l_1:
	mov rax, rcx
	l_7:
	pop r13
	leave 
	ret
_main_User_Defined_fihriaifhiahidsafans:
	l_8:
	push rbp
	mov rbp, rsp
	push r14
	push r15
	push r12
	push r13
	call __getInt 
	mov qword [g_3], rax
	call __getInt 
	mov qword [g_4], rax
	call __getString 
	mov qword [g_5], rax
	mov rax, qword [g_3]
	mov rcx, rax
	mov rax, qword [g_4]
	add rcx, rax
	mov rax, rcx
	add rax, 5
	mov r14, rax
	lea r15, [r14 * 8 + 8]
	mov rdi, r15
	call malloc 
	mov qword [rax], r14
	l_9:
	cmp r14, 0
	jg l_10
	l_11:
	mov qword [g_2], rax
	mov rax, qword [g_3]
	mov rcx, rax
	mov rax, qword [g_4]
	add rcx, rax
	mov rax, rcx
	add rax, 5
	mov r15, rax
	lea r12, [r15 * 8 + 8]
	mov rdi, r12
	call malloc 
	mov qword [rax], r15
	l_12:
	cmp r15, 0
	jg l_13
	l_14:
	mov qword [g_1], rax
	mov rax, qword [g_3]
	mov rcx, qword [g_4]
	add rax, rcx
	add rax, 5
	mov r12, rax
	lea r13, [r12 * 8 + 8]
	mov rdi, r13
	call malloc 
	mov qword [rax], r12
	l_15:
	cmp r12, 0
	jg l_16
	l_17:
	mov qword [g_0], rax
	mov r13, 1
	l_18:
	mov rax, qword [g_3]
	cmp r13, rax
	jle l_19
	l_20:
	mov r13, 1
	l_21:
	mov rax, qword [g_4]
	cmp r13, rax
	jle l_22
	l_23:
	mov r12, 1
	mov rax, qword [g_3]
	add rax, 1
	mov r15, rax
	mov r13, 2
	l_24:
	mov rax, qword [g_3]
	cmp r13, rax
	jle l_25
	l_26:
	mov rax, qword [g_3]
	add rax, 2
	mov r13, rax
	l_27:
	mov rax, qword [g_3]
	mov rcx, rax
	mov rax, qword [g_4]
	add rcx, rax
	cmp r13, rcx
	jle l_28
	l_29:
	mov rax, qword [g_0]
	mov rdi, qword [rax + r12 * 8 + 8]
	call __toString 
	mov rdi, rax
	call __print 
	mov rdi, g_6
	call __print 
	mov rax, qword [g_5]
	mov rcx, rax
	mov rax, r15
	mov rdx, qword [g_3]
	sub rax, rdx
	mov rsi, rax
	sub rsi, 1
	mov rdx, rax
	mov rdi, rcx
	call __string_substring 
	mov rdi, rax
	call __print 
	mov rdi, g_7
	call __print 
	mov rsi, r15
	mov rdi, r12
	call _merge_User_Defined_fihriaifhiahidsafans 
	mov rdi, rax
	call __toString 
	mov rdi, rax
	call __println 
	mov rax, 0
	l_30:
	pop r13
	pop r12
	pop r15
	pop r14
	leave 
	ret
	l_28:
	mov rsi, r13
	mov rdi, r15
	call _merge_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	l_31:
	inc r13
	jmp l_27
	l_25:
	mov rsi, r13
	mov rdi, r12
	call _merge_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	l_32:
	inc r13
	jmp l_24
	l_22:
	mov r12, r13
	mov rax, qword [g_3]
	add r12, rax
	mov rax, qword [g_5]
	mov rcx, rax
	mov rax, r13
	sub rax, 1
	mov rsi, rax
	mov rdi, rcx
	call __string_ord 
	mov rcx, qword [g_0]
	mov qword [rcx + r12 * 8 + 8], rax
	mov rcx, r12
	mov rax, qword [g_2]
	mov qword [rax + rcx * 8 + 8], 0
	mov rax, rcx
	mov rcx, qword [g_1]
	mov qword [rcx + rax * 8 + 8], 0
	l_33:
	inc r13
	jmp l_21
	l_19:
	call __getInt 
	mov rcx, qword [g_0]
	mov qword [rcx + r13 * 8 + 8], rax
	mov rax, qword [g_2]
	mov qword [rax + r13 * 8 + 8], 0
	mov rax, qword [g_1]
	mov qword [rax + r13 * 8 + 8], 0
	l_34:
	inc r13
	jmp l_18
	l_16:
	mov qword [rax + r12 * 8], 0
	dec r12
	jmp l_15
	l_13:
	mov qword [rax + r15 * 8], 0
	dec r15
	jmp l_12
	l_10:
	mov qword [rax + r14 * 8], 0
	dec r14
	jmp l_9
__init:
	l_35:
	push rbp
	mov rbp, rsp
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	 section .data
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_5:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_6:
	dq 1
	db 20H, 00H
g_7:
	dq 1
	db 0AH, 00H

