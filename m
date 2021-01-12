Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C72F2C68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404511AbhALKPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:15:25 -0500
Received: from foss.arm.com ([217.140.110.172]:43394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388713AbhALKPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:15:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9083831B;
        Tue, 12 Jan 2021 02:14:38 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6733F719;
        Tue, 12 Jan 2021 02:14:35 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:14:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        keescook@chromium.org, vincenzo.frascino@arm.com,
        kristina.martsenko@arm.com, dbrazdil@google.com,
        samitolvanen@google.com, broonie@kernel.org,
        hayashi.kunihiko@socionext.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: rename S_FRAME_SIZE to PT_REGS_SIZE
Message-ID: <20210112101432.GB34326@C02TD0UTHF1T.local>
References: <20210112015813.2340969-1-Jianlin.Lv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112015813.2340969-1-Jianlin.Lv@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:58:13AM +0800, Jianlin Lv wrote:
> S_FRAME_SIZE is the size of the pt_regs structure, no longer the size of
> the kernel stack frame, the name is misleading. In keeping with arm32,
> rename S_FRAME_SIZE to PT_REGS_SIZE.
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>

I think PT_REGS_SIZE is certainly clearer than S_FRAME_SIZE, and the
patch looks sound to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/asm-offsets.c               |  2 +-
>  arch/arm64/kernel/entry-ftrace.S              | 12 ++++++------
>  arch/arm64/kernel/entry.S                     | 14 +++++++-------
>  arch/arm64/kernel/probes/kprobes_trampoline.S |  6 +++---
>  4 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index f42fd9e33981..301784463587 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -75,7 +75,7 @@ int main(void)
>    DEFINE(S_SDEI_TTBR1,		offsetof(struct pt_regs, sdei_ttbr1));
>    DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
>    DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
> -  DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
> +  DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
>    BLANK();
>  #ifdef CONFIG_COMPAT
>    DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		offsetof(struct compat_sigframe, uc.uc_mcontext.arm_r0));
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index a338f40e64d3..b3e4f9a088b1 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -35,7 +35,7 @@
>   */
>  	.macro  ftrace_regs_entry, allregs=0
>  	/* Make room for pt_regs, plus a callee frame */
> -	sub	sp, sp, #(S_FRAME_SIZE + 16)
> +	sub	sp, sp, #(PT_REGS_SIZE + 16)
>  
>  	/* Save function arguments (and x9 for simplicity) */
>  	stp	x0, x1, [sp, #S_X0]
> @@ -61,15 +61,15 @@
>  	.endif
>  
>  	/* Save the callsite's SP and LR */
> -	add	x10, sp, #(S_FRAME_SIZE + 16)
> +	add	x10, sp, #(PT_REGS_SIZE + 16)
>  	stp	x9, x10, [sp, #S_LR]
>  
>  	/* Save the PC after the ftrace callsite */
>  	str	x30, [sp, #S_PC]
>  
>  	/* Create a frame record for the callsite above pt_regs */
> -	stp	x29, x9, [sp, #S_FRAME_SIZE]
> -	add	x29, sp, #S_FRAME_SIZE
> +	stp	x29, x9, [sp, #PT_REGS_SIZE]
> +	add	x29, sp, #PT_REGS_SIZE
>  
>  	/* Create our frame record within pt_regs. */
>  	stp	x29, x30, [sp, #S_STACKFRAME]
> @@ -120,7 +120,7 @@ ftrace_common_return:
>  	ldr	x9, [sp, #S_PC]
>  
>  	/* Restore the callsite's SP */
> -	add	sp, sp, #S_FRAME_SIZE + 16
> +	add	sp, sp, #PT_REGS_SIZE + 16
>  
>  	ret	x9
>  SYM_CODE_END(ftrace_common)
> @@ -130,7 +130,7 @@ SYM_CODE_START(ftrace_graph_caller)
>  	ldr	x0, [sp, #S_PC]
>  	sub	x0, x0, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
>  	add	x1, sp, #S_LR			// parent_ip (callsite's LR)
> -	ldr	x2, [sp, #S_FRAME_SIZE]	   	// parent fp (callsite's FP)
> +	ldr	x2, [sp, #PT_REGS_SIZE]	   	// parent fp (callsite's FP)
>  	bl	prepare_ftrace_return
>  	b	ftrace_common_return
>  SYM_CODE_END(ftrace_graph_caller)
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index a8c3e7aaca74..c9bae73f2621 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -75,7 +75,7 @@ alternative_else_nop_endif
>  	.endif
>  #endif
>  
> -	sub	sp, sp, #S_FRAME_SIZE
> +	sub	sp, sp, #PT_REGS_SIZE
>  #ifdef CONFIG_VMAP_STACK
>  	/*
>  	 * Test whether the SP has overflowed, without corrupting a GPR.
> @@ -96,7 +96,7 @@ alternative_else_nop_endif
>  	 * userspace, and can clobber EL0 registers to free up GPRs.
>  	 */
>  
> -	/* Stash the original SP (minus S_FRAME_SIZE) in tpidr_el0. */
> +	/* Stash the original SP (minus PT_REGS_SIZE) in tpidr_el0. */
>  	msr	tpidr_el0, x0
>  
>  	/* Recover the original x0 value and stash it in tpidrro_el0 */
> @@ -253,7 +253,7 @@ alternative_else_nop_endif
>  
>  	scs_load tsk, x20
>  	.else
> -	add	x21, sp, #S_FRAME_SIZE
> +	add	x21, sp, #PT_REGS_SIZE
>  	get_current_task tsk
>  	.endif /* \el == 0 */
>  	mrs	x22, elr_el1
> @@ -377,7 +377,7 @@ alternative_else_nop_endif
>  	ldp	x26, x27, [sp, #16 * 13]
>  	ldp	x28, x29, [sp, #16 * 14]
>  	ldr	lr, [sp, #S_LR]
> -	add	sp, sp, #S_FRAME_SIZE		// restore sp
> +	add	sp, sp, #PT_REGS_SIZE		// restore sp
>  
>  	.if	\el == 0
>  alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
> @@ -580,12 +580,12 @@ __bad_stack:
>  
>  	/*
>  	 * Store the original GPRs to the new stack. The orginal SP (minus
> -	 * S_FRAME_SIZE) was stashed in tpidr_el0 by kernel_ventry.
> +	 * PT_REGS_SIZE) was stashed in tpidr_el0 by kernel_ventry.
>  	 */
> -	sub	sp, sp, #S_FRAME_SIZE
> +	sub	sp, sp, #PT_REGS_SIZE
>  	kernel_entry 1
>  	mrs	x0, tpidr_el0
> -	add	x0, x0, #S_FRAME_SIZE
> +	add	x0, x0, #PT_REGS_SIZE
>  	str	x0, [sp, #S_SP]
>  
>  	/* Stash the regs for handle_bad_stack */
> diff --git a/arch/arm64/kernel/probes/kprobes_trampoline.S b/arch/arm64/kernel/probes/kprobes_trampoline.S
> index 890ca72c5a51..288a84e253cc 100644
> --- a/arch/arm64/kernel/probes/kprobes_trampoline.S
> +++ b/arch/arm64/kernel/probes/kprobes_trampoline.S
> @@ -25,7 +25,7 @@
>  	stp x24, x25, [sp, #S_X24]
>  	stp x26, x27, [sp, #S_X26]
>  	stp x28, x29, [sp, #S_X28]
> -	add x0, sp, #S_FRAME_SIZE
> +	add x0, sp, #PT_REGS_SIZE
>  	stp lr, x0, [sp, #S_LR]
>  	/*
>  	 * Construct a useful saved PSTATE
> @@ -62,7 +62,7 @@
>  	.endm
>  
>  SYM_CODE_START(kretprobe_trampoline)
> -	sub sp, sp, #S_FRAME_SIZE
> +	sub sp, sp, #PT_REGS_SIZE
>  
>  	save_all_base_regs
>  
> @@ -76,7 +76,7 @@ SYM_CODE_START(kretprobe_trampoline)
>  
>  	restore_all_base_regs
>  
> -	add sp, sp, #S_FRAME_SIZE
> +	add sp, sp, #PT_REGS_SIZE
>  	ret
>  
>  SYM_CODE_END(kretprobe_trampoline)
> -- 
> 2.25.1
> 
