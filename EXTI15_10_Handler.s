
.include "exti_map.inc"
.section .text
.align	1
.syntax unified
.thumb
.global EXTI15_10_Handler

EXTI15_10_Handler:
        ldr r0, =EXTI_BASE
        ldr r0, [r0, EXTI_PR_OFFSET]
        ldr r1, =0x00000400
        cmp r0, r1 
        beq EXTI10_Handler
        ldr r1, =0x00000800
        cmp r0, r1 
        beq EXTI11_Handler
        bx  lr

EXTI10_Handler:
        adds r8, r8, #1
        ldr r0, =EXTI_BASE
        ldr r2, [r0, EXTI_PR_OFFSET] 
        orr r2, r2, 0x00000400
        str r2, [r0, EXTI_PR_OFFSET]  
        bx lr       

EXTI11_Handler:
        eor r9, r9, 1
        and r9, r9, 0x1
        ldr r0, =EXTI_BASE
        ldr r2, [r0, EXTI_PR_OFFSET] 
        orr r2, r2, 0x00000800
        str r2, [r0, EXTI_PR_OFFSET] 
        bx  lr

.size   EXTI15_10_Handler, .-EXTI15_10_Handler


