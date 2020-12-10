Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6392D5054
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 02:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbgLJB0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 20:26:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732545AbgLJBZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 20:25:53 -0500
Date:   Thu, 10 Dec 2020 10:25:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607563512;
        bh=sxnil84+Qy6PwRZRR44eDAMgMsDrHuc8CnlcrIVWWjw=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=p0+SRKYrA0Y8FboHEefVJsM2KBGHiBdoQ8viQEz/IHc2I47dUeMYR3aJKlYgONpbz
         ppYnETHqqSKyHRhDrtrroa++Zd0COL923ETj41vUWCAoBrBHyNxMce6Cw63YLSK6Vt
         cHNAUETeDqxA1OvuRu9Sc497vEESaPT9gfae3wJicdMW+KdKDXk/qVhDLliV6j20me
         LsAUcwAp29GJjvzzn3zCLar+JiUBfrd928EaLTU3h17GV8NN7oCVdp+y7RdQYl43Dr
         c+vjRCcL7DOzrsjyA0qB1eiGbP+CCNZh6t4mA7fNjjPNziFkZPPvP5DBwng5TbtUYy
         yhgohp9Q9dOrg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adam Zabrocki <pi3@pi3.com.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>
Subject: Re: KRETPROBES are broken since kernel 5.8
Message-Id: <20201210102507.6bd47a08191852b9f8b5e3f0@kernel.org>
In-Reply-To: <20201209215001.GA8593@pi3.com.pl>
References: <20201209215001.GA8593@pi3.com.pl>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thank you for reporting and debugging, actually we had investigated this
issue in Aug. Please read this thread.

https://lkml.kernel.org/r/8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com

We finally fixed this issue by commit e03b4a084ea6 ("kprobes: Remove NMI
context check") and commit 645f224e7ba2 ("kprobes: Tell lockdep about
kprobe nesting"). Yeah, it will be in the v5.10.

Could you try to test whether these commits can solve the issue?
If it is OK, we should backport those to stable tree.

Thank you,

On Wed, 9 Dec 2020 22:50:01 +0100
Adam Zabrocki <pi3@pi3.com.pl> wrote:

> Hello,
> 
> Starting from kernel 5.8 all non-optimized kretprobes don't work. Until 5.8,
> when #DB exception was raised, entry to the NMI was not fully performed. Among
> others, the following logic was executed:
> https://elixir.bootlin.com/linux/v5.7.19/source/arch/x86/kernel/traps.c#L589
> 
>     if (!user_mode(regs)) {
>         rcu_nmi_enter();
>         preempt_disable();
>     }
> 
> In some older kernels function ist_enter() was called instead. Inside this
> function we can see the following logic:
> https://elixir.bootlin.com/linux/v5.7.19/source/arch/x86/kernel/traps.c#L91
> 
>     if (user_mode(regs)) {
>         RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>     } else {
>         /*
>          * We might have interrupted pretty much anything.  In
>          * fact, if we're a machine check, we can even interrupt
>          * NMI processing.  We don't want in_nmi() to return true,
>          * but we need to notify RCU.
>          */
>         rcu_nmi_enter();
>     }
> 
>     preempt_disable();
> 
> As the comment says "We don't want in_nmi() to return true, but we need to
> notify RCU.". However, since kernel 5.8 the logic of how interrupts are handled
> was modified and currently we have this (function "exc_int3"):
> https://elixir.bootlin.com/linux/v5.8/source/arch/x86/kernel/traps.c#L630
> 
>     /*
>      * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
>      * can trigger INT3, hence poke_int3_handler() must be done
>      * before. If the entry came from kernel mode, then use nmi_enter()
>      * because the INT3 could have been hit in any context including
>      * NMI.
>      */
>     if (user_mode(regs)) {
>         idtentry_enter_user(regs);
>         instrumentation_begin();
>         do_int3_user(regs);
>         instrumentation_end();
>         idtentry_exit_user(regs);
>     } else {
>         nmi_enter();
>         instrumentation_begin();
>         trace_hardirqs_off_finish();
>         if (!do_int3(regs))
>             die("int3", regs, 0);
>         if (regs->flags & X86_EFLAGS_IF)
>             trace_hardirqs_on_prepare();
>         instrumentation_end();
>         nmi_exit();
>     }
> 
> The root of unlucky change comes from this commit:
> 
> https://github.com/torvalds/linux/commit/0d00449c7a28a1514595630735df383dec606812#diff-51ce909c2f65ed9cc668bc36cc3c18528541d8a10e84287874cd37a5918abae5
> 
> which later was modified by this commit:
> 
> https://github.com/torvalds/linux/commit/8edd7e37aed8b9df938a63f0b0259c70569ce3d2
> 
> and this is what we currently have in all kernels since 5.8. Essentially,
> KRETPROBES are not working since these commits. We have the following logic:
> 
> asm_exc_int3() -> exc_int3():
>                     |
>     ----------------|
>     |
>     v
> ...
> nmi_enter();
> ...
> if (!do_int3(regs))
>        |
>   -----|
>   |
>   v
> do_int3() -> kprobe_int3_handler():
>                     |
>     ----------------|
>     |
>     v
> ...
> if (!p->pre_handler || !p->pre_handler(p, regs))
>                              |
>     -------------------------|
>     |
>     v
> ...
> pre_handler_kretprobe():
> ...
>     if (unlikely(in_nmi())) {
>         rp->nmissed++;
>         return 0;
>     }
> 
> Essentially, exc_int3() calls nmi_enter(), and pre_handler_kretprobe() before
> invoking any registered kprobe verifies if it is not in NMI via in_nmi() call.
> 
> This bug was masked by OPTIMIZER which was turning most of the KPROBES to be
> FTRACE so essentially if someone registered KRETPROBE, buggy code was not
> invoked (FTRACE code was executed instead). However, the optimizer was changed
> and can't optimize as many functions anymore (probably another bug which might
> be worth to investigate) and this bug is more visible.
> 
> Thanks,
> Adam
> 
> -- 
> pi3 (pi3ki31ny) - pi3 (at) itsec pl
> http://pi3.com.pl
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
