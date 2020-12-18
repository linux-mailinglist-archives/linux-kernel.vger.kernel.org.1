Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342FD2DE378
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgLRNs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgLRNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:48:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1053DC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:48:16 -0800 (PST)
Received: from [IPv6:2a00:5f00:102:0:944a:5cff:fe54:340e] (unknown [IPv6:2a00:5f00:102:0:944a:5cff:fe54:340e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8326C1F463DC;
        Fri, 18 Dec 2020 13:48:13 +0000 (GMT)
Subject: Re: next/master bisection: baseline.login on
 ox820-cloudengines-pogoplug-series-3
To:     kernelci-results@groups.io,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
References: <5fdc89c3.1c69fb81.c9707.68bb@mx.google.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Abbott Liu <liuwenliang@huawei.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "kernelci@groups.io" <kernelci@groups.io>
Message-ID: <3e1680ed-94b8-74c9-ffe6-c2bd71f2a705@collabora.com>
Date:   Fri, 18 Dec 2020 13:48:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <5fdc89c3.1c69fb81.c9707.68bb@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

Please see the bisection report below about a boot failure on
ox820-cloudengines-pogoplug-series-3.  There was also a bisection
yesterday with next-20201216 which landed on the same commit, on
the same platform and also with oxnas_v6_defconfig.  I'm not
aware of any other platform on kernelci.org showing the same
regression.

Hope this helps!

Best wishes,
Guillaume

On 18/12/2020 10:51, KernelCI bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.login on ox820-cloudengines-pogoplug-series-3
> 
> Summary:
>   Start:      90cc8cf2d1ab Add linux-next specific files for 20201217
>   Plain log:  https://storage.kernelci.org/next/master/next-20201217/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/baseline-ox820-cloudengines-pogoplug-series-3.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20201217/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/baseline-ox820-cloudengines-pogoplug-series-3.html
>   Result:     f77ac2e378be ARM: 9030/1: entry: omit FP emulation for UND exceptions taken in kernel mode
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     ox820-cloudengines-pogoplug-series-3
>   CPU arch:   arm
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     oxnas_v6_defconfig
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit f77ac2e378be9dd61eb88728f0840642f045d9d1
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Thu Nov 19 18:09:16 2020 +0100
> 
>     ARM: 9030/1: entry: omit FP emulation for UND exceptions taken in kernel mode
>     
>     There are a couple of problems with the exception entry code that deals
>     with FP exceptions (which are reported as UND exceptions) when building
>     the kernel in Thumb2 mode:
>     - the conditional branch to vfp_kmode_exception in vfp_support_entry()
>       may be out of range for its target, depending on how the linker decides
>       to arrange the sections;
>     - when the UND exception is taken in kernel mode, the emulation handling
>       logic is entered via the 'call_fpe' label, which means we end up using
>       the wrong value/mask pairs to match and detect the NEON opcodes.
>     
>     Since UND exceptions in kernel mode are unlikely to occur on a hot path
>     (as opposed to the user mode version which is invoked for VFP support
>     code and lazy restore), we can use the existing undef hook machinery for
>     any kernel mode instruction emulation that is needed, including calling
>     the existing vfp_kmode_exception() routine for unexpected cases. So drop
>     the call to call_fpe, and instead, install an undef hook that will get
>     called for NEON and VFP instructions that trigger an UND exception in
>     kernel mode.
>     
>     While at it, make sure that the PC correction is accurate for the
>     execution mode where the exception was taken, by checking the PSR
>     Thumb bit.
>     
>     Cc: Dmitry Osipenko <digetx@gmail.com>
>     Cc: Kees Cook <keescook@chromium.org>
>     Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
>     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>     Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index c4220f51fcf3..0ea8529a4872 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -252,31 +252,10 @@ __und_svc:
>  #else
>  	svc_entry
>  #endif
> -	@
> -	@ call emulation code, which returns using r9 if it has emulated
> -	@ the instruction, or the more conventional lr if we are to treat
> -	@ this as a real undefined instruction
> -	@
> -	@  r0 - instruction
> -	@
> -#ifndef CONFIG_THUMB2_KERNEL
> -	ldr	r0, [r4, #-4]
> -#else
> -	mov	r1, #2
> -	ldrh	r0, [r4, #-2]			@ Thumb instruction at LR - 2
> -	cmp	r0, #0xe800			@ 32-bit instruction if xx >= 0
> -	blo	__und_svc_fault
> -	ldrh	r9, [r4]			@ bottom 16 bits
> -	add	r4, r4, #2
> -	str	r4, [sp, #S_PC]
> -	orr	r0, r9, r0, lsl #16
> -#endif
> -	badr	r9, __und_svc_finish
> -	mov	r2, r4
> -	bl	call_fpe
>  
>  	mov	r1, #4				@ PC correction to apply
> -__und_svc_fault:
> + THUMB(	tst	r5, #PSR_T_BIT		)	@ exception taken in Thumb mode?
> + THUMB(	movne	r1, #2			)	@ if so, fix up PC correction
>  	mov	r0, sp				@ struct pt_regs *regs
>  	bl	__und_fault
>  
> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> index 4fcff9f59947..d5837bf05a9a 100644
> --- a/arch/arm/vfp/vfphw.S
> +++ b/arch/arm/vfp/vfphw.S
> @@ -79,11 +79,6 @@ ENTRY(vfp_support_entry)
>  	DBGSTR3	"instr %08x pc %08x state %p", r0, r2, r10
>  
>  	.fpu	vfpv2
> -	ldr	r3, [sp, #S_PSR]	@ Neither lazy restore nor FP exceptions
> -	and	r3, r3, #MODE_MASK	@ are supported in kernel mode
> -	teq	r3, #USR_MODE
> -	bne	vfp_kmode_exception	@ Returns through lr
> -
>  	VFPFMRX	r1, FPEXC		@ Is the VFP enabled?
>  	DBGSTR1	"fpexc %08x", r1
>  	tst	r1, #FPEXC_EN
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 8c9e7f9f0277..c3b6451c18bd 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -23,6 +23,7 @@
>  #include <asm/cputype.h>
>  #include <asm/system_info.h>
>  #include <asm/thread_notify.h>
> +#include <asm/traps.h>
>  #include <asm/vfp.h>
>  
>  #include "vfpinstr.h"
> @@ -642,7 +643,9 @@ static int vfp_starting_cpu(unsigned int unused)
>  	return 0;
>  }
>  
> -void vfp_kmode_exception(void)
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +
> +static int vfp_kmode_exception(struct pt_regs *regs, unsigned int instr)
>  {
>  	/*
>  	 * If we reach this point, a floating point exception has been raised
> @@ -660,9 +663,51 @@ void vfp_kmode_exception(void)
>  		pr_crit("BUG: unsupported FP instruction in kernel mode\n");
>  	else
>  		pr_crit("BUG: FP instruction issued in kernel mode with FP unit disabled\n");
> +	pr_crit("FPEXC == 0x%08x\n", fmrx(FPEXC));
> +	return 1;
>  }
>  
> -#ifdef CONFIG_KERNEL_MODE_NEON
> +static struct undef_hook vfp_kmode_exception_hook[] = {{
> +	.instr_mask	= 0xfe000000,
> +	.instr_val	= 0xf2000000,
> +	.cpsr_mask	= MODE_MASK | PSR_T_BIT,
> +	.cpsr_val	= SVC_MODE,
> +	.fn		= vfp_kmode_exception,
> +}, {
> +	.instr_mask	= 0xff100000,
> +	.instr_val	= 0xf4000000,
> +	.cpsr_mask	= MODE_MASK | PSR_T_BIT,
> +	.cpsr_val	= SVC_MODE,
> +	.fn		= vfp_kmode_exception,
> +}, {
> +	.instr_mask	= 0xef000000,
> +	.instr_val	= 0xef000000,
> +	.cpsr_mask	= MODE_MASK | PSR_T_BIT,
> +	.cpsr_val	= SVC_MODE | PSR_T_BIT,
> +	.fn		= vfp_kmode_exception,
> +}, {
> +	.instr_mask	= 0xff100000,
> +	.instr_val	= 0xf9000000,
> +	.cpsr_mask	= MODE_MASK | PSR_T_BIT,
> +	.cpsr_val	= SVC_MODE | PSR_T_BIT,
> +	.fn		= vfp_kmode_exception,
> +}, {
> +	.instr_mask	= 0x0c000e00,
> +	.instr_val	= 0x0c000a00,
> +	.cpsr_mask	= MODE_MASK,
> +	.cpsr_val	= SVC_MODE,
> +	.fn		= vfp_kmode_exception,
> +}};
> +
> +static int __init vfp_kmode_exception_hook_init(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vfp_kmode_exception_hook); i++)
> +		register_undef_hook(&vfp_kmode_exception_hook[i]);
> +	return 0;
> +}
> +core_initcall(vfp_kmode_exception_hook_init);
>  
>  /*
>   * Kernel-side NEON support functions
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [31f6551ad75608d9c71fd4d3548c33f1abc52093] cifs: handle "guest" mount parameter
> git bisect good 31f6551ad75608d9c71fd4d3548c33f1abc52093
> # bad: [90cc8cf2d1ab87d708ebc311ac104ccbbefad9fc] Add linux-next specific files for 20201217
> git bisect bad 90cc8cf2d1ab87d708ebc311ac104ccbbefad9fc
> # good: [3db1a3fa98808aa90f95ec3e0fa2fc7abf28f5c9] Merge tag 'staging-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect good 3db1a3fa98808aa90f95ec3e0fa2fc7abf28f5c9
> # bad: [4538b80cd2885c885e3bf06e5103bc0f214c11ee] Merge remote-tracking branch 'arm-soc/for-next'
> git bisect bad 4538b80cd2885c885e3bf06e5103bc0f214c11ee
> # good: [5ee863bec794f30bdf7fdf57ce0d9f579b0d1aa3] Merge branch 'parisc-5.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> git bisect good 5ee863bec794f30bdf7fdf57ce0d9f579b0d1aa3
> # good: [fb10b701887b9fce88aacc06ca4b6c9160ca7a66] Merge branch 'arm/dt' into for-next
> git bisect good fb10b701887b9fce88aacc06ca4b6c9160ca7a66
> # good: [821a8a63a6b55ee5325e07bf5ab7d7a1752009d1] Merge remote-tracking branch 'asm-generic/master'
> git bisect good 821a8a63a6b55ee5325e07bf5ab7d7a1752009d1
> # good: [7debceff46eef5350bf2b62494c7772f78b22257] Merge branch 'arm/dt' into for-next
> git bisect good 7debceff46eef5350bf2b62494c7772f78b22257
> # bad: [b383a1412e0df59c556abb93c1fa2399e91b6102] Merge remote-tracking branch 'arm64/for-next/core'
> git bisect bad b383a1412e0df59c556abb93c1fa2399e91b6102
> # good: [113eb4ce4fc33ef3deda1431497811d43342c0cc] Merge branch 'for-next/iommu/vt-d' into for-next/iommu/core
> git bisect good 113eb4ce4fc33ef3deda1431497811d43342c0cc
> # skip: [eb86b15a2c53e2263b7cbad00a0100c8451989dc] Merge branches 'fixes' and 'misc' into for-next
> git bisect skip eb86b15a2c53e2263b7cbad00a0100c8451989dc
> # skip: [2a50d6b9cfe96ef5d39b9c3497dcc83a907d00cd] ARM: 9033/1: arm/smp: Drop the macro S(x,s)
> git bisect skip 2a50d6b9cfe96ef5d39b9c3497dcc83a907d00cd
> # good: [421015713b306e47af95d4d61cdfbd96d462e4cb] ARM: 9017/2: Enable KASan for ARM
> git bisect good 421015713b306e47af95d4d61cdfbd96d462e4cb
> # good: [2c736bb4087f2cb949cbbaf4148733131b8466dc] Merge tag 'arm-adrl-replacement-for-v5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux into devel-stable
> git bisect good 2c736bb4087f2cb949cbbaf4148733131b8466dc
> # skip: [3597a10e4c444f3d4d6a64bdc98e4585a99301b9] ARM: 9036/1: uncompress: Fix dbgadtb size parameter name
> git bisect skip 3597a10e4c444f3d4d6a64bdc98e4585a99301b9
> # skip: [1205285c7a71c3b7a879e31ec477639f2dac22b1] ARM: 9027/1: head.S: explicitly map DT even if it lives in the first physical section
> git bisect skip 1205285c7a71c3b7a879e31ec477639f2dac22b1
> # good: [71fe89ceb55bc0a85121b757cc8d3fb6ff457263] dma-iommu: remove __iommu_dma_mmap
> git bisect good 71fe89ceb55bc0a85121b757cc8d3fb6ff457263
> # skip: [17fb1a208129e3472ec45be08cbe39601a407e2c] ARM: 9031/1: hyp-stub: remove unused .L__boot_cpu_mode_offset symbol
> git bisect skip 17fb1a208129e3472ec45be08cbe39601a407e2c
> # good: [95d1718c961e49cfa02995ce1587a22cd7e2fbf5] Merge remote-tracking branch 'arm64/for-next/iommu/core' into for-next/core
> git bisect good 95d1718c961e49cfa02995ce1587a22cd7e2fbf5
> # skip: [0fe88ade3f937d6efc276901a56be6575a5a2171] ARM: 9032/1: arm/mm: Convert PUD level pgtable helper macros into functions
> git bisect skip 0fe88ade3f937d6efc276901a56be6575a5a2171
> # good: [730b5764ea8526e48bdb85a24ed96d62de435940] ARM: 9024/1: Drop useless cast of "u64" to "long long"
> git bisect good 730b5764ea8526e48bdb85a24ed96d62de435940
> # good: [4d576cab16f57e1f87978f6997a725179398341e] ARM: 9028/1: disable KASAN in call stack capturing routines
> git bisect good 4d576cab16f57e1f87978f6997a725179398341e
> # skip: [3bdf1a7503d61d2241f93f36e9c0d8a0d444bc5c] ARM: 9037/1: uncompress: Add OF_DT_MAGIC macro
> git bisect skip 3bdf1a7503d61d2241f93f36e9c0d8a0d444bc5c
> # bad: [f77ac2e378be9dd61eb88728f0840642f045d9d1] ARM: 9030/1: entry: omit FP emulation for UND exceptions taken in kernel mode
> git bisect bad f77ac2e378be9dd61eb88728f0840642f045d9d1
> # good: [3c9f5708b7aed6a963e2aefccbd1854802de163e] ARM: 9029/1: Make iwmmxt.S support Clang's integrated assembler
> git bisect good 3c9f5708b7aed6a963e2aefccbd1854802de163e
> # first bad commit: [f77ac2e378be9dd61eb88728f0840642f045d9d1] ARM: 9030/1: entry: omit FP emulation for UND exceptions taken in kernel mode
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#4773): https://groups.io/g/kernelci-results/message/4773
> Mute This Topic: https://groups.io/mt/79040317/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

