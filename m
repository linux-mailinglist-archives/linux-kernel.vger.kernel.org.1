Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437322701B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIRQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgIRQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:13:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0BEC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:13:58 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c26009774b294abcb5722.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2600:9774:b294:abcb:5722])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0E9E1EC034B;
        Fri, 18 Sep 2020 18:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600445634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E95if4/ZtWaJyuQ8w8SvlyJSplEHDNOPTkbopuOwKfk=;
        b=dlO1gwlsIlZbLr7VwlUljAiTals46JtY6lFFBhYt32G9NxIQ3yD5UHqxMNTI5DjMtiirKX
        tNVjJu5wmVqZHp5/448rbf7JCkPW0YZgNuEwnOyGueJ7xHLWMyvJixkHI3z3UCdGSPxJGa
        f0jV0gJW/FjPynuOqtCDcn0i+J2rsW8=
Date:   Fri, 18 Sep 2020 18:13:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] x86/mce: Recover from poison found while copying
 from user space
Message-ID: <20200918161347.GG6585@zn.tnic>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-8-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908175519.14223-8-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:55:18AM -0700, Tony Luck wrote:
> From: Youquan Song <youquan.song@intel.com>
> 
> Existing kernel code can only recover from a machine check on code that
> tagged in the exception table with a fault handling recovery path.

"is tagged"

> New field in the task structure mce_vaddr is initialized to the
> user virtual address of the fault. This is so that kill_me_maybe()
> can provide that information to the user SIGBUS handler.
> 
> Add code to recover from a machine check while copying data from user
> space to the kernel. Action for this case is the same as if the user
> touched the poison directly; unmap the page and send a SIGBUS to the task.
> 
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 51 ++++++++++++++++++++++++++++++++++
>  include/linux/sched.h          |  1 +
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 5512318a07ae..2a3c42329c3f 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -53,6 +53,8 @@
>  #include <asm/mce.h>
>  #include <asm/msr.h>
>  #include <asm/reboot.h>
> +#include <asm/insn.h>
> +#include <asm/insn-eval.h>
>  
>  #include "internal.h"
>  
> @@ -1197,6 +1199,32 @@ static void kill_me_maybe(struct callback_head *cb)
>  	kill_me_now(cb);
>  }
>  
> +/*
> + * Decode a kernel instruction that faulted while reading from a user
> + * address and return the linear address that was being read.
> + */
> +static void __user *get_virtual_address(struct pt_regs *regs)
> +{
> +	u8 insn_buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +
> +	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
> +		return (void __user *)~0ul;

You're initializing ->mce_vaddr to NULL below but you're returning ~0
here. You should return NULL here too. If it is NULL, this check from
your next patch will pass:

	if (p->mce_vaddr != (void __user *)~0ul) {

which would be the wrong thing to do so you need to think about a single
invalid vaddr value and stick with it.

> +	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
> +	insn_get_length(&insn);
> +	insn_get_modrm(&insn);
> +	insn_get_sib(&insn);

AFAICT, you need the opcode only so why do all those?

I think you simply need to do:

	insn_get_opcode()

and then check opcode->got because otherwise you might be looking at
garbage below.

> +
> +	/*
> +	 * For MOVS[BWLQ] the source address is in %rsi

Pls end your sentences with a fullstop.

> +	 */
> +	if (insn.opcode.value == 0xa4 || insn.opcode.value == 0xa5)
> +		return (void __user *)regs->si;

How do you know just by looking at the opcodes, that the source operand
in rSI is __user memory?

I see is_copy_from_user() in your next patch so I guess I'll verify that
there...

> +	else
> +		return insn_get_addr_ref(&insn, regs);
> +}
> +
>  /*
>   * The actual machine check handler. This only handles real
>   * exceptions when something got corrupted coming in through int 18.
> @@ -1342,6 +1370,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  		/* If this triggers there is no way to recover. Die hard. */
>  		BUG_ON(!on_thread_stack() || !user_mode(regs));
>  
> +		current->mce_vaddr = NULL;
>  		current->mce_addr = m.addr;
>  		current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
>  		current->mce_whole_page = whole_page(&m);
> @@ -1350,6 +1379,13 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  			current->mce_kill_me.func = kill_me_now;
>  		task_work_add(current, &current->mce_kill_me, true);
>  	} else {
> +		/*
> +		 * Before fixing the exception IP, find the user address
> +		 * in the MCE_IN_KERNEL_COPYIN case
						   ^
						   |-- Fullstop

> +		 */
> +		if (m.kflags & MCE_IN_KERNEL_COPYIN)
> +			current->mce_vaddr = get_virtual_address(regs);
> +
>  		/*
>  		 * Handle an MCE which has happened in kernel space but from
>  		 * which the kernel can recover: ex_has_fault_handler() has
> @@ -1363,6 +1399,21 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
>  				mce_panic("Failed kernel mode recovery", &m, msg);
>  		}
> +
> +		/*
> +		 * MCE on user data while copying to kernel. Action here is
> +		 * very similar to the user hitting the poison themself.
> +		 * Poison page will be unmapped and signal sent to process.
> +		 */
> +		if (m.kflags & MCE_IN_KERNEL_COPYIN) {
> +			current->mce_addr = m.addr;
> +			current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
> +			current->mce_whole_page = whole_page(&m);
> +			current->mce_kill_me.func = kill_me_maybe;
> +			if (kill_it)
> +				current->mce_kill_me.func = kill_me_now;
> +			task_work_add(current, &current->mce_kill_me, true);

This hunk is mostly copied from the in-user case above. How about a
"goto recover;" label instead of the duplication?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
