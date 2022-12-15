Dump of assembler code for function example:
   0x0000000000001270 <+0>:	vmovd  %edi,%xmm0
   0x0000000000001274 <+4>:	vpbroadcastd %xmm0,%ymm0
   0x0000000000001279 <+9>:	lea    0x35b0(%rip),%rax        # 0x4830 <assign+2016>
   0x0000000000001280 <+16>:	xor    %ecx,%ecx
   0x0000000000001282 <+18>:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   0x0000000000001290 <+32>:	xor    %edx,%edx
   0x0000000000001292 <+34>:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   0x00000000000012a0 <+48>:	vmovdqu %ymm0,-0x7e0(%rax,%rdx,4)
   0x00000000000012a9 <+57>:	vmovdqu %ymm0,-0x7c0(%rax,%rdx,4)
   0x00000000000012b2 <+66>:	vmovdqu %ymm0,-0x7a0(%rax,%rdx,4)
   0x00000000000012bb <+75>:	vmovdqu %ymm0,-0x780(%rax,%rdx,4)
   0x00000000000012c4 <+84>:	vmovdqu %ymm0,-0x760(%rax,%rdx,4)
   0x00000000000012cd <+93>:	vmovdqu %ymm0,-0x740(%rax,%rdx,4)
   0x00000000000012d6 <+102>:	vmovdqu %ymm0,-0x720(%rax,%rdx,4)
   0x00000000000012df <+111>:	vmovdqu %ymm0,-0x700(%rax,%rdx,4)
   0x00000000000012e8 <+120>:	vmovdqu %ymm0,-0x6e0(%rax,%rdx,4)
   0x00000000000012f1 <+129>:	vmovdqu %ymm0,-0x6c0(%rax,%rdx,4)
   0x00000000000012fa <+138>:	vmovdqu %ymm0,-0x6a0(%rax,%rdx,4)
   0x0000000000001303 <+147>:	vmovdqu %ymm0,-0x680(%rax,%rdx,4)
   0x000000000000130c <+156>:	vmovdqu %ymm0,-0x660(%rax,%rdx,4)
   0x0000000000001315 <+165>:	vmovdqu %ymm0,-0x640(%rax,%rdx,4)
   0x000000000000131e <+174>:	vmovdqu %ymm0,-0x620(%rax,%rdx,4)
   0x0000000000001327 <+183>:	vmovdqu %ymm0,-0x600(%rax,%rdx,4)
   0x0000000000001330 <+192>:	vmovdqu %ymm0,-0x5e0(%rax,%rdx,4)
   0x0000000000001339 <+201>:	vmovdqu %ymm0,-0x5c0(%rax,%rdx,4)
   0x0000000000001342 <+210>:	vmovdqu %ymm0,-0x5a0(%rax,%rdx,4)
   0x000000000000134b <+219>:	vmovdqu %ymm0,-0x580(%rax,%rdx,4)
   0x0000000000001354 <+228>:	vmovdqu %ymm0,-0x560(%rax,%rdx,4)
   0x000000000000135d <+237>:	vmovdqu %ymm0,-0x540(%rax,%rdx,4)
   0x0000000000001366 <+246>:	vmovdqu %ymm0,-0x520(%rax,%rdx,4)
   0x000000000000136f <+255>:	vmovdqu %ymm0,-0x500(%rax,%rdx,4)
   0x0000000000001378 <+264>:	vmovdqu %ymm0,-0x4e0(%rax,%rdx,4)
   0x0000000000001381 <+273>:	vmovdqu %ymm0,-0x4c0(%rax,%rdx,4)
   0x000000000000138a <+282>:	vmovdqu %ymm0,-0x4a0(%rax,%rdx,4)
   0x0000000000001393 <+291>:	vmovdqu %ymm0,-0x480(%rax,%rdx,4)
   0x000000000000139c <+300>:	vmovdqu %ymm0,-0x460(%rax,%rdx,4)
   0x00000000000013a5 <+309>:	vmovdqu %ymm0,-0x440(%rax,%rdx,4)
   0x00000000000013ae <+318>:	vmovdqu %ymm0,-0x420(%rax,%rdx,4)
   0x00000000000013b7 <+327>:	vmovdqu %ymm0,-0x400(%rax,%rdx,4)
   0x00000000000013c0 <+336>:	vmovdqu %ymm0,-0x3e0(%rax,%rdx,4)
   0x00000000000013c9 <+345>:	vmovdqu %ymm0,-0x3c0(%rax,%rdx,4)
   0x00000000000013d2 <+354>:	vmovdqu %ymm0,-0x3a0(%rax,%rdx,4)
   0x00000000000013db <+363>:	vmovdqu %ymm0,-0x380(%rax,%rdx,4)
   0x00000000000013e4 <+372>:	vmovdqu %ymm0,-0x360(%rax,%rdx,4)
   0x00000000000013ed <+381>:	vmovdqu %ymm0,-0x340(%rax,%rdx,4)
   0x00000000000013f6 <+390>:	vmovdqu %ymm0,-0x320(%rax,%rdx,4)
   0x00000000000013ff <+399>:	vmovdqu %ymm0,-0x300(%rax,%rdx,4)
   0x0000000000001408 <+408>:	vmovdqu %ymm0,-0x2e0(%rax,%rdx,4)
   0x0000000000001411 <+417>:	vmovdqu %ymm0,-0x2c0(%rax,%rdx,4)
   0x000000000000141a <+426>:	vmovdqu %ymm0,-0x2a0(%rax,%rdx,4)
   0x0000000000001423 <+435>:	vmovdqu %ymm0,-0x280(%rax,%rdx,4)
   0x000000000000142c <+444>:	vmovdqu %ymm0,-0x260(%rax,%rdx,4)
   0x0000000000001435 <+453>:	vmovdqu %ymm0,-0x240(%rax,%rdx,4)
   0x000000000000143e <+462>:	vmovdqu %ymm0,-0x220(%rax,%rdx,4)
   0x0000000000001447 <+471>:	vmovdqu %ymm0,-0x200(%rax,%rdx,4)
   0x0000000000001450 <+480>:	vmovdqu %ymm0,-0x1e0(%rax,%rdx,4)
   0x0000000000001459 <+489>:	vmovdqu %ymm0,-0x1c0(%rax,%rdx,4)
   0x0000000000001462 <+498>:	vmovdqu %ymm0,-0x1a0(%rax,%rdx,4)
   0x000000000000146b <+507>:	vmovdqu %ymm0,-0x180(%rax,%rdx,4)
   0x0000000000001474 <+516>:	vmovdqu %ymm0,-0x160(%rax,%rdx,4)
   0x000000000000147d <+525>:	vmovdqu %ymm0,-0x140(%rax,%rdx,4)
   0x0000000000001486 <+534>:	vmovdqu %ymm0,-0x120(%rax,%rdx,4)
   0x000000000000148f <+543>:	vmovdqu %ymm0,-0x100(%rax,%rdx,4)
   0x0000000000001498 <+552>:	vmovdqu %ymm0,-0xe0(%rax,%rdx,4)
   0x00000000000014a1 <+561>:	vmovdqu %ymm0,-0xc0(%rax,%rdx,4)
   0x00000000000014aa <+570>:	vmovdqu %ymm0,-0xa0(%rax,%rdx,4)
   0x00000000000014b3 <+579>:	vmovdqu %ymm0,-0x80(%rax,%rdx,4)
   0x00000000000014b9 <+585>:	vmovdqu %ymm0,-0x60(%rax,%rdx,4)
   0x00000000000014bf <+591>:	vmovdqu %ymm0,-0x40(%rax,%rdx,4)
   0x00000000000014c5 <+597>:	vmovdqu %ymm0,-0x20(%rax,%rdx,4)
   0x00000000000014cb <+603>:	vmovdqu %ymm0,(%rax,%rdx,4)
   0x00000000000014d0 <+608>:	add    $0x200,%rdx
   0x00000000000014d7 <+615>:	cmp    $0x400,%rdx
   0x00000000000014de <+622>:	jne    0x12a0 <example+48>
   0x00000000000014e4 <+628>:	inc    %rcx
   0x00000000000014e7 <+631>:	add    $0x1000,%rax
   0x00000000000014ed <+637>:	cmp    $0x800,%rcx
   0x00000000000014f4 <+644>:	jne    0x1290 <example+32>
   0x00000000000014fa <+650>:	vzeroupper 
   0x00000000000014fd <+653>:	ret    
End of assembler dump.
