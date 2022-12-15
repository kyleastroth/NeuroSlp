	.text
	.file	"s1_64_sub_2.unroll.c"
	.globl	example1                        # -- Begin function example1
	.p2align	4, 0x90
	.type	example1,@function
example1:                               # @example1
	.cfi_startproc
# %bb.0:                                # %entry
	vmovdqa	input1+32(%rip), %ymm0
	vmovdqa	input1(%rip), %ymm1
	vpsubd	input2(%rip), %ymm1, %ymm1
	vpsubd	input2+32(%rip), %ymm0, %ymm0
	vmovdqa	%ymm0, output+32(%rip)
	vmovdqa	%ymm1, output(%rip)
	vmovdqa	input1+96(%rip), %ymm0
	vmovdqa	input1+64(%rip), %ymm1
	vpsubd	input2+64(%rip), %ymm1, %ymm1
	vpsubd	input2+96(%rip), %ymm0, %ymm0
	vmovdqa	%ymm0, output+96(%rip)
	vmovdqa	%ymm1, output+64(%rip)
	vmovdqa	input1+160(%rip), %ymm0
	vmovdqa	input1+128(%rip), %ymm1
	vpsubd	input2+128(%rip), %ymm1, %ymm1
	vpsubd	input2+160(%rip), %ymm0, %ymm0
	vmovdqa	%ymm0, output+160(%rip)
	vmovdqa	%ymm1, output+128(%rip)
	vmovdqa	input1+224(%rip), %ymm0
	vmovdqa	input1+192(%rip), %ymm1
	vpsubd	input2+192(%rip), %ymm1, %ymm1
	vpsubd	input2+224(%rip), %ymm0, %ymm0
	vmovdqa	%ymm0, output+224(%rip)
	vmovdqa	%ymm1, output+192(%rip)
	vzeroupper
	retq
.Lfunc_end0:
	.size	example1, .Lfunc_end0-example1
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI1_0:
	.quad	0x408f400000000000              # double 1000
.LCPI1_1:
	.quad	0x3fe0000000000000              # double 0.5
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -16
	leaq	output(%rip), %rdi
	leaq	output+256(%rip), %rsi
	callq	init_memory@PLT
	leaq	input1(%rip), %rdi
	leaq	input1+256(%rip), %rsi
	callq	init_memory@PLT
	leaq	input2(%rip), %rdi
	leaq	input2+256(%rip), %rsi
	callq	init_memory@PLT
	callq	example1
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	callq	gettimeofday@PLT
	movl	$16777216, %ebx                 # imm = 0x1000000
	.p2align	4, 0x90
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	callq	example1
	decl	%ebx
	jne	.LBB1_1
# %bb.2:                                # %for.cond.cleanup
	movq	%rsp, %rdi
	xorl	%esi, %esi
	callq	gettimeofday@PLT
	leaq	output(%rip), %rdi
	leaq	output+256(%rip), %rsi
	callq	digest_memory@PLT
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	subq	16(%rsp), %rax
	subq	24(%rsp), %rcx
	imulq	$1000, %rax, %rax               # imm = 0x3E8
	vcvtsi2sd	%rax, %xmm0, %xmm0
	vcvtsi2sd	%rcx, %xmm1, %xmm1
	vdivsd	.LCPI1_0(%rip), %xmm1, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vaddsd	.LCPI1_1(%rip), %xmm0, %xmm0
	vcvttsd2si	%xmm0, %rsi
	leaq	.L.str(%rip), %rdi
	xorl	%eax, %eax
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$32, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	input1,@object                  # @input1
	.bss
	.globl	input1
	.p2align	6, 0x0
input1:
	.zero	256
	.size	input1, 256

	.type	input2,@object                  # @input2
	.globl	input2
	.p2align	6, 0x0
input2:
	.zero	256
	.size	input2, 256

	.type	output,@object                  # @output
	.globl	output
	.p2align	6, 0x0
output:
	.zero	256
	.size	output, 256

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%ld"
	.size	.L.str, 4

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git edca72f5bcb039840fda28e324af4614d4e46fde)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym input1
	.addrsig_sym input2
	.addrsig_sym output
