	.file	"C_task1.c"
	.text
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$10, %edi
	call	malloc@PLT
	movq	%rax, %rdi
	movq	.LC0(%rip), %rax
	movq	%rax, (%rdi)
	movzwl	.LC1(%rip), %eax
	movw	%ax, 8(%rdi)
	call	puts@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.byte	89
	.byte	89
	.byte	89
	.byte	89
	.byte	89
	.byte	89
	.byte	89
	.byte	89
	.set	.LC1,.LC0
	.ident	"GCC: (GNU) 12.2.1 20230201"
	.section	.note.GNU-stack,"",@progbits
