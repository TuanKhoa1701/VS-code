    .syntax unified
    .cpu cortex-m3
    .thumb

    .section .isr_vector, "a",%progbits
    .type   g_pfnVectors, %object
    .size   g_pfnVectors, . -g_pfnVectors
g_pfnVectors:
    .word   _estack
    .word   Reset_Handler
    .word   NMI_Handler
    .word   HardFault_Handler
    .word   MemManage_Handler
    .word   BusFault_Handler
    .word   UsageFault_Handler
    .word   0
    .word   0
    .word   0
    .word   0
    .word   SVC_Handler
    .word   DebugMon_Handler
    .word   0
    .word   PendSV_Handler
    .word   SysTick_Handler

                @  External Interrupts
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   ADC1_2_IRQHandler
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0                
    .word   TIM2_IRQHandler         @TIM2                
/*================Default Handler - Stuck here */
    .section .text.Reset_Handler
    .weak Reset_Handler
    .type Reset_Handler, %function
    Default_Handler:
    b .
Reset_Handler:
    ldr     r0, = _sdata
    ldr     r1, = _edata
    ldr     r2, = _sidata
1:
    cmp     r0, r1
    ittt      lt
    ldrlt   r3, [r2], #4
    strlt   r2, [r0], #4
    blt     1b

    ldr     r0, = _sbss
    ldr     r1, = _ebss
    movs    r2, #0
2:
    cmp     r0, r1
    itt      lt
    strlt   r2, [r0], #4
    blt     2b

    bl     SystemInit
    bl     hala
    b       .
// Default exception handlers
    .weak NMI_Handler
    .thumb_set NMI_Handler, Default_Handler

    .weak HardFault_Handler
    .thumb_set HardFault_Handler, Default_Handler

    .weak MemManage_Handler
    .thumb_set MemManage_Handler, Default_Handler

    .weak BusFault_Handler
    .thumb_set BusFault_Handler, Default_Handler

    .weak UsageFault_Handler
    .thumb_set UsageFault_Handler, Default_Handler

    .weak SysTick_Handler
    .thumb_set SysTick_Handler, Default_Handler

    .weak SVC_Handler
    .thumb_set SVC_Handler, Default_Handler

    .weak DebugMon_Handler
    .thumb_set DebugMon_Handler, Default_Handler
    
    .weak PendSV_Handler
    .thumb_set PendSV_Handler, Default_Handler

    .weak   TIM2_IRQHandler
    .thumb_set TIM2_IRQHandler, Default_Handler

    .weak ADC1_2_IRQHandler
    .thumb_set ADC1_2_IRQHandler, Default_Handler

    .section .stack, "a", %progbits
    .word 0x20005000  @ Initial stack pointer value
