	.text
	.file	"header.c"
	.globl	init_memory                     # -- Begin function init_memory
	.p2align	4, 0x90
	.type	init_memory,@function
init_memory:                            # @init_memory
	.cfi_startproc
# %bb.0:                                # %entry
	cmpq	%rsi, %rdi
	je	.LBB0_3
# %bb.1:                                # %while.body.preheader
	movb	$1, %al
	.p2align	4, 0x90
.LBB0_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	%al, %ecx
	leal	(,%rcx,8), %eax
	subl	%ecx, %eax
	xorb	$39, %al
	incb	%al
	movb	%al, (%rdi)
	incq	%rdi
	cmpq	%rsi, %rdi
	jne	.LBB0_2
.LBB0_3:                                # %while.end
	retq
.Lfunc_end0:
	.size	init_memory, .Lfunc_end0-init_memory
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function init_memory_float
.LCPI1_0:
	.long	0x3f800000                      # float 1
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI1_1:
	.quad	0x3ff199999999999a              # double 1.1000000000000001
	.text
	.globl	init_memory_float
	.p2align	4, 0x90
	.type	init_memory_float,@function
init_memory_float:                      # @init_memory_float
	.cfi_startproc
# %bb.0:                                # %entry
	cmpq	%rsi, %rdi
	je	.LBB1_3
# %bb.1:                                # %while.body.preheader
	vmovss	.LCPI1_0(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
	vmovsd	.LCPI1_1(%rip), %xmm0           # xmm0 = mem[0],zero
	.p2align	4, 0x90
.LBB1_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	vmulsd	%xmm0, %xmm1, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmovss	%xmm1, (%rdi)
	addq	$4, %rdi
	cmpq	%rsi, %rdi
	jne	.LBB1_2
.LBB1_3:                                # %while.end
	retq
.Lfunc_end1:
	.size	init_memory_float, .Lfunc_end1-init_memory_float
	.cfi_endproc
                                        # -- End function
	.globl	digest_memory                   # -- Begin function digest_memory
	.p2align	4, 0x90
	.type	digest_memory,@function
digest_memory:                          # @digest_memory
	.cfi_startproc
# %bb.0:                                # %entry
	movl	$1, %eax
	cmpq	%rsi, %rdi
	je	.LBB2_3
	.p2align	4, 0x90
.LBB2_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	leal	(%rax,%rax,2), %ecx
	movzbl	(%rdi), %eax
	xorl	%ecx, %eax
	shrl	$8, %ecx
	shll	$8, %eax
	xorl	%ecx, %eax
	incq	%rdi
	cmpq	%rsi, %rdi
	jne	.LBB2_1
.LBB2_3:                                # %while.end
                                        # kill: def $eax killed $eax killed $rax
	retq
.Lfunc_end2:
	.size	digest_memory, .Lfunc_end2-digest_memory
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function atimer
.LCPI3_0:
	.quad	0x408f400000000000              # double 1000
.LCPI3_1:
	.quad	0x3fe0000000000000              # double 0.5
	.text
	.globl	atimer
	.p2align	4, 0x90
	.type	atimer,@function
atimer:                                 # @atimer
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -16
	movl	%esi, %ebx
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	callq	gettimeofday@PLT
	movq	%rsp, %rdi
	xorl	%esi, %esi
	callq	gettimeofday@PLT
	testl	%ebx, %ebx
	je	.LBB3_1
# %bb.2:                                # %if.then
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	subq	24(%rsp), %rcx
	vcvtsi2sd	%rcx, %xmm0, %xmm0
	vdivsd	.LCPI3_0(%rip), %xmm0, %xmm0
	subq	16(%rsp), %rax
	imulq	$1000, %rax, %rax               # imm = 0x3E8
	vcvtsi2sd	%rax, %xmm1, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
	vaddsd	.LCPI3_1(%rip), %xmm0, %xmm0
	vcvttsd2si	%xmm0, %rsi
	leaq	.L.str(%rip), %rdi
	xorl	%eax, %eax
	addq	$32, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	printf@PLT                      # TAILCALL
.LBB3_1:                                # %if.end
	.cfi_def_cfa_offset 48
	addq	$32, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	atimer, .Lfunc_end3-atimer
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%ld"
	.size	.L.str, 4

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git edca72f5bcb039840fda28e324af4614d4e46fde)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
