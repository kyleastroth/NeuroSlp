	.text
	.file	"s1_64_sub_2.unroll.c"
	.globl	example1                        # -- Begin function example1
	.p2align	4, 0x90
	.type	example1,@function
example1:                               # @example1
	.cfi_startproc
# %bb.0:                                # %entry
	movl	input1(%rip), %eax
	subl	input2(%rip), %eax
	movl	%eax, output(%rip)
	movl	input1+4(%rip), %eax
	subl	input2+4(%rip), %eax
	movl	input1+8(%rip), %ecx
	subl	input2+8(%rip), %ecx
	movl	%eax, output+4(%rip)
	movl	%ecx, output+8(%rip)
	movl	input1+12(%rip), %eax
	subl	input2+12(%rip), %eax
	movl	%eax, output+12(%rip)
	movl	input1+16(%rip), %eax
	subl	input2+16(%rip), %eax
	movl	input1+20(%rip), %ecx
	subl	input2+20(%rip), %ecx
	movl	%eax, output+16(%rip)
	movl	%ecx, output+20(%rip)
	movl	input1+24(%rip), %eax
	subl	input2+24(%rip), %eax
	movl	%eax, output+24(%rip)
	movl	input1+28(%rip), %eax
	subl	input2+28(%rip), %eax
	movl	input1+32(%rip), %ecx
	subl	input2+32(%rip), %ecx
	movl	%eax, output+28(%rip)
	movl	%ecx, output+32(%rip)
	movl	input1+36(%rip), %eax
	subl	input2+36(%rip), %eax
	movl	%eax, output+36(%rip)
	movl	input1+40(%rip), %eax
	subl	input2+40(%rip), %eax
	movl	input1+44(%rip), %ecx
	subl	input2+44(%rip), %ecx
	movl	%eax, output+40(%rip)
	movl	%ecx, output+44(%rip)
	movl	input1+48(%rip), %eax
	subl	input2+48(%rip), %eax
	movl	%eax, output+48(%rip)
	movl	input1+52(%rip), %eax
	subl	input2+52(%rip), %eax
	movl	input1+56(%rip), %ecx
	subl	input2+56(%rip), %ecx
	movl	%eax, output+52(%rip)
	movl	%ecx, output+56(%rip)
	movl	input1+60(%rip), %eax
	subl	input2+60(%rip), %eax
	movl	%eax, output+60(%rip)
	movl	input1+64(%rip), %eax
	subl	input2+64(%rip), %eax
	movl	input1+68(%rip), %ecx
	subl	input2+68(%rip), %ecx
	movl	%eax, output+64(%rip)
	movl	%ecx, output+68(%rip)
	movl	input1+72(%rip), %eax
	subl	input2+72(%rip), %eax
	movl	%eax, output+72(%rip)
	movl	input1+76(%rip), %eax
	subl	input2+76(%rip), %eax
	movl	input1+80(%rip), %ecx
	subl	input2+80(%rip), %ecx
	movl	%eax, output+76(%rip)
	movl	%ecx, output+80(%rip)
	movl	input1+84(%rip), %eax
	subl	input2+84(%rip), %eax
	movl	%eax, output+84(%rip)
	movl	input1+88(%rip), %eax
	subl	input2+88(%rip), %eax
	movl	input1+92(%rip), %ecx
	subl	input2+92(%rip), %ecx
	movl	%eax, output+88(%rip)
	movl	%ecx, output+92(%rip)
	movl	input1+96(%rip), %eax
	subl	input2+96(%rip), %eax
	movl	%eax, output+96(%rip)
	movl	input1+100(%rip), %eax
	subl	input2+100(%rip), %eax
	movl	input1+104(%rip), %ecx
	subl	input2+104(%rip), %ecx
	movl	%eax, output+100(%rip)
	movl	%ecx, output+104(%rip)
	movl	input1+108(%rip), %eax
	subl	input2+108(%rip), %eax
	movl	%eax, output+108(%rip)
	movl	input1+112(%rip), %eax
	subl	input2+112(%rip), %eax
	movl	input1+116(%rip), %ecx
	subl	input2+116(%rip), %ecx
	movl	%eax, output+112(%rip)
	movl	%ecx, output+116(%rip)
	movl	input1+120(%rip), %eax
	subl	input2+120(%rip), %eax
	movl	%eax, output+120(%rip)
	movl	input1+124(%rip), %eax
	subl	input2+124(%rip), %eax
	movl	input1+128(%rip), %ecx
	subl	input2+128(%rip), %ecx
	movl	%eax, output+124(%rip)
	movl	%ecx, output+128(%rip)
	movl	input1+132(%rip), %eax
	subl	input2+132(%rip), %eax
	movl	%eax, output+132(%rip)
	movl	input1+136(%rip), %eax
	subl	input2+136(%rip), %eax
	movl	input1+140(%rip), %ecx
	subl	input2+140(%rip), %ecx
	movl	%eax, output+136(%rip)
	movl	%ecx, output+140(%rip)
	movl	input1+144(%rip), %eax
	subl	input2+144(%rip), %eax
	movl	%eax, output+144(%rip)
	movl	input1+148(%rip), %eax
	subl	input2+148(%rip), %eax
	movl	input1+152(%rip), %ecx
	subl	input2+152(%rip), %ecx
	movl	%eax, output+148(%rip)
	movl	%ecx, output+152(%rip)
	movl	input1+156(%rip), %eax
	subl	input2+156(%rip), %eax
	movl	%eax, output+156(%rip)
	movl	input1+160(%rip), %eax
	subl	input2+160(%rip), %eax
	movl	input1+164(%rip), %ecx
	subl	input2+164(%rip), %ecx
	movl	%eax, output+160(%rip)
	movl	%ecx, output+164(%rip)
	movl	input1+168(%rip), %eax
	subl	input2+168(%rip), %eax
	movl	%eax, output+168(%rip)
	movl	input1+172(%rip), %eax
	subl	input2+172(%rip), %eax
	movl	input1+176(%rip), %ecx
	subl	input2+176(%rip), %ecx
	movl	%eax, output+172(%rip)
	movl	%ecx, output+176(%rip)
	movl	input1+180(%rip), %eax
	subl	input2+180(%rip), %eax
	movl	%eax, output+180(%rip)
	movl	input1+184(%rip), %eax
	subl	input2+184(%rip), %eax
	movl	input1+188(%rip), %ecx
	subl	input2+188(%rip), %ecx
	movl	%eax, output+184(%rip)
	movl	%ecx, output+188(%rip)
	movl	input1+192(%rip), %eax
	subl	input2+192(%rip), %eax
	movl	%eax, output+192(%rip)
	movl	input1+196(%rip), %eax
	subl	input2+196(%rip), %eax
	movl	input1+200(%rip), %ecx
	subl	input2+200(%rip), %ecx
	movl	%eax, output+196(%rip)
	movl	%ecx, output+200(%rip)
	movl	input1+204(%rip), %eax
	subl	input2+204(%rip), %eax
	movl	%eax, output+204(%rip)
	movl	input1+208(%rip), %eax
	subl	input2+208(%rip), %eax
	movl	input1+212(%rip), %ecx
	subl	input2+212(%rip), %ecx
	movl	%eax, output+208(%rip)
	movl	%ecx, output+212(%rip)
	movl	input1+216(%rip), %eax
	subl	input2+216(%rip), %eax
	movl	%eax, output+216(%rip)
	movl	input1+220(%rip), %eax
	subl	input2+220(%rip), %eax
	movl	input1+224(%rip), %ecx
	subl	input2+224(%rip), %ecx
	movl	%eax, output+220(%rip)
	movl	%ecx, output+224(%rip)
	movl	input1+228(%rip), %eax
	subl	input2+228(%rip), %eax
	movl	%eax, output+228(%rip)
	movl	input1+232(%rip), %eax
	subl	input2+232(%rip), %eax
	movl	input1+236(%rip), %ecx
	subl	input2+236(%rip), %ecx
	movl	%eax, output+232(%rip)
	movl	%ecx, output+236(%rip)
	movl	input1+240(%rip), %eax
	subl	input2+240(%rip), %eax
	movl	%eax, output+240(%rip)
	movl	input1+244(%rip), %eax
	subl	input2+244(%rip), %eax
	movl	input1+248(%rip), %ecx
	subl	input2+248(%rip), %ecx
	movl	%eax, output+244(%rip)
	movl	%ecx, output+248(%rip)
	movl	input1+252(%rip), %eax
	subl	input2+252(%rip), %eax
	movl	%eax, output+252(%rip)
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
	.p2align	4, 0x0
input1:
	.zero	256
	.size	input1, 256

	.type	input2,@object                  # @input2
	.globl	input2
	.p2align	4, 0x0
input2:
	.zero	256
	.size	input2, 256

	.type	output,@object                  # @output
	.globl	output
	.p2align	4, 0x0
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
