.include "ivt.s"
.include "gpio_map.inc"
.include "rcc_map.inc"
.include "scb_map.inc"
.include "systick_map.inc"
.section .text
.align	1
.syntax unified
.thumb
.global SysTick_Initialize

SysTick_Initialize:
        # Set SysTick_CTRL to disabLe SysTick IRQ and SysTick timer
        ldr     r0, =SYSTICK_BASE
        # DisabLe SysTick IRQ and SysTick counter, select external clock
        mov     r1, #0 
        str     r1, [r0, STK_CTRL_OFFSET]
        # Clear SysTick current value register (SysTick_VAL)
        ldr     r2, =1000 @ Change it based on interrupt interval possible 7999
        str     r2, [r0, STK_LOAD_OFFSET] 
        # Clear SysTick current value register (SysTick_VAL) 
        mov     r1, #0 
        str     r1, [r0, STK_VAL_OFFSET]
        # Set interrupt priority for SysTick  
        ldr     r2, =SCB_BASE
        add     r2, r2, SCB_SHPR3_OFFSET
        mov     r3, 0x20
        strb    r3, [r2, #11] 
        # Set SysTick_CTRL to enable SysTick timer and SysTick interrupt
        ldr     r1, [r0, STK_CTRL_OFFSET]
        orr     r1, r1, #3  @ Enable SysTick counter & interrupt
        str     r1, [r0, STK_CTRL_OFFSET] 
        bx      lr        

.size   SysTick_Initialize, .-SysTick_Initialize

