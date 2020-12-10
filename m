Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB94A2D5469
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 08:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgLJHSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 02:18:43 -0500
Received: from pi3.com.pl ([185.238.74.129]:41404 "EHLO pi3.com.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgLJHSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 02:18:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 5CA604C001D;
        Thu, 10 Dec 2020 08:17:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1607584665; bh=W8DRtMkyfmtnCmmWtbn3ndFhcP0+Ja5Nqbxe/Jc6LV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYyoM0aDEgV9ZIidHybkjEGs76wJlx0P7qhKWsDJ4/vVNECz+Hdd4qkwQOj5nuDoy
         MROYU6T9l9O2Ht3PDrANHPtQlOIrECHW/zcOfuoh9UgWhliX/rd/H3AWQVD4YslD8O
         pq7SpG8hTqJ6LyFszx0rAY09qbatM8zp14M1/OcNURY3qQm7fNAkSb1w8USpTSqsjJ
         N+DlzFPtQfS0XZ6sTcXmsyP36KlrbiLpi08hdDWJZMiBP0Dndq3rVf/azKRqLr/NPn
         Y4XyBqv4dbU0INMoRs+R6CpxDIZsBaaX7VmA+vxM6eVOesG4uDbQntQ7TnZxQUNrCw
         uGefJEXO+zTGw==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a_6tzo-d0Rk8; Thu, 10 Dec 2020 08:17:42 +0100 (CET)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 4F3524C14E9; Thu, 10 Dec 2020 08:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1607584662; bh=W8DRtMkyfmtnCmmWtbn3ndFhcP0+Ja5Nqbxe/Jc6LV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXBQsl7SystRFBWwT4U/AE8Q2xbjBemKZ5J3MC0RWJhI6ifAoXM6qOojh/PSETCc6
         QP8aqoMVkp73h/tESPP2gsFiY3lwSxtVW1vImobwiw5UPX8CLGSSUMqdNKgvsGQkgR
         JqvnmqwXi7pvxsXE5OwTn3t/7WN07LcsuQw8AJ2J6q3Vm6sHEZAO+OV0YoapHq898O
         qiKOQQBwuVPotqY8yssK6SWjr61DnWEr4y6aVIaKsyIpNeN2YZj/jWopVQyOJ4Vl/J
         GF2ZXEgtzjX62sVBJc7OiFCgfitjLNGGSQPyNfgOe9lk1PWwJFzf2lEiwAyvnKVzV3
         rxKMLune0o0BA==
Date:   Thu, 10 Dec 2020 08:17:42 +0100
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>
Subject: Re: KRETPROBES are broken since kernel 5.8
Message-ID: <20201210071742.GA14484@pi3.com.pl>
References: <20201209215001.GA8593@pi3.com.pl>
 <20201210102507.6bd47a08191852b9f8b5e3f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210102507.6bd47a08191852b9f8b5e3f0@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 10, 2020 at 10:25:07AM +0900, Masami Hiramatsu wrote:
> Hi Adam,
> 
> Thank you for reporting and debugging, actually we had investigated this
> issue in Aug. Please read this thread.
> 
> https://lkml.kernel.org/r/8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com
> 

Thanks for the link. I've read the entire history of proposed fix - very 
informative :)

> We finally fixed this issue by commit e03b4a084ea6 ("kprobes: Remove NMI
> context check") and commit 645f224e7ba2 ("kprobes: Tell lockdep about
> kprobe nesting"). Yeah, it will be in the v5.10.
> 
> Could you try to test whether these commits can solve the issue?

I've applied these commits on the top of kernel 5.9.7 and verified that it 
works well. Non-optimized KRETPROBES are back to life.

However, there might be another issue which I wanted to brought / discuss - 
problem with optimizer. Until kernel 5.9 KRETPROBE on e.g. 
'ftrace_enable_sysctl' function was correctly optimized without any problems. 
Since 5.9 it can't be optimized anynmore. I didn't see any changes in the 
sources regarding the optimizer, neither function itself.
When I looked at the generated vmlinux binary, I can see that GCC generated 
padding at the end of this function using INT3 opcode:

...
ffffffff8130528b:       41 bd f0 ff ff ff       mov    $0xfffffff0,%r13d
ffffffff81305291:       e9 fe fe ff ff          jmpq   ffffffff81305194 <ftrace_enable_sysctl+0x114>
ffffffff81305296:       cc                      int3
ffffffff81305297:       cc                      int3
ffffffff81305298:       cc                      int3
ffffffff81305299:       cc                      int3
ffffffff8130529a:       cc                      int3
ffffffff8130529b:       cc                      int3
ffffffff8130529c:       cc                      int3
ffffffff8130529d:       cc                      int3
ffffffff8130529e:       cc                      int3
ffffffff8130529f:       cc                      int3

Such padding didn't exist in this function in generated images for older 
kernels. Nevertheless, such padding is not unusual and it's pretty common.

Optimizer logic fails here:

try_to_optimize_kprobe() -> alloc_aggr_kprobe() -> __prepare_optimized_kprobe()
-> arch_prepare_optimized_kprobe() -> can_optimize():

    /* Decode instructions */
    addr = paddr - offset;
    while (addr < paddr - offset + size) { /* Decode until function end */
        unsigned long recovered_insn;
        if (search_exception_tables(addr))
            /*
             * Since some fixup code will jumps into this function,
             * we can't optimize kprobe in this function.
             */
            return 0;
        recovered_insn = recover_probed_instruction(buf, addr);
        if (!recovered_insn)
            return 0;
        kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
        insn_get_length(&insn);
        /* Another subsystem puts a breakpoint */
        if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
            return 0;
        /* Recover address */
        insn.kaddr = (void *)addr;
        insn.next_byte = (void *)(addr + insn.length);
        /* Check any instructions don't jump into target */
        if (insn_is_indirect_jump(&insn) ||
            insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
                     DISP32_SIZE))
            return 0;
        addr += insn.length;
    }

One of the check tries to protect from the situation when another subsystem 
puts a breakpoint there as well:

        /* Another subsystem puts a breakpoint */
        if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
            return 0;

However, that's not the case here. INT3_INSN_OPCODE is placed at the end of 
the function as padding (and protect from NOP-padding problems).

I wonder, if optimizer should take this special case into account? Is it worth 
to still optimize such functions when they are padded with INT3?

> If it is OK, we should backport those to stable tree.

Agreed.

Thanks,
Adam

> Thank you,
> 
> On Wed, 9 Dec 2020 22:50:01 +0100
> Adam Zabrocki <pi3@pi3.com.pl> wrote:
> 
> > Hello,
> > 
> > Starting from kernel 5.8 all non-optimized kretprobes don't work. Until 5.8,
> > when #DB exception was raised, entry to the NMI was not fully performed. Among
> > others, the following logic was executed:
> > https://elixir.bootlin.com/linux/v5.7.19/source/arch/x86/kernel/traps.c#L589
> > 
> >     if (!user_mode(regs)) {
> >         rcu_nmi_enter();
> >         preempt_disable();
> >     }
> > 
> > In some older kernels function ist_enter() was called instead. Inside this
> > function we can see the following logic:
> > https://elixir.bootlin.com/linux/v5.7.19/source/arch/x86/kernel/traps.c#L91
> > 
> >     if (user_mode(regs)) {
> >         RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> >     } else {
> >         /*
> >          * We might have interrupted pretty much anything.  In
> >          * fact, if we're a machine check, we can even interrupt
> >          * NMI processing.  We don't want in_nmi() to return true,
> >          * but we need to notify RCU.
> >          */
> >         rcu_nmi_enter();
> >     }
> > 
> >     preempt_disable();
> > 
> > As the comment says "We don't want in_nmi() to return true, but we need to
> > notify RCU.". However, since kernel 5.8 the logic of how interrupts are handled
> > was modified and currently we have this (function "exc_int3"):
> > https://elixir.bootlin.com/linux/v5.8/source/arch/x86/kernel/traps.c#L630
> > 
> >     /*
> >      * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
> >      * can trigger INT3, hence poke_int3_handler() must be done
> >      * before. If the entry came from kernel mode, then use nmi_enter()
> >      * because the INT3 could have been hit in any context including
> >      * NMI.
> >      */
> >     if (user_mode(regs)) {
> >         idtentry_enter_user(regs);
> >         instrumentation_begin();
> >         do_int3_user(regs);
> >         instrumentation_end();
> >         idtentry_exit_user(regs);
> >     } else {
> >         nmi_enter();
> >         instrumentation_begin();
> >         trace_hardirqs_off_finish();
> >         if (!do_int3(regs))
> >             die("int3", regs, 0);
> >         if (regs->flags & X86_EFLAGS_IF)
> >             trace_hardirqs_on_prepare();
> >         instrumentation_end();
> >         nmi_exit();
> >     }
> > 
> > The root of unlucky change comes from this commit:
> > 
> > https://github.com/torvalds/linux/commit/0d00449c7a28a1514595630735df383dec606812#diff-51ce909c2f65ed9cc668bc36cc3c18528541d8a10e84287874cd37a5918abae5
> > 
> > which later was modified by this commit:
> > 
> > https://github.com/torvalds/linux/commit/8edd7e37aed8b9df938a63f0b0259c70569ce3d2
> > 
> > and this is what we currently have in all kernels since 5.8. Essentially,
> > KRETPROBES are not working since these commits. We have the following logic:
> > 
> > asm_exc_int3() -> exc_int3():
> >                     |
> >     ----------------|
> >     |
> >     v
> > ...
> > nmi_enter();
> > ...
> > if (!do_int3(regs))
> >        |
> >   -----|
> >   |
> >   v
> > do_int3() -> kprobe_int3_handler():
> >                     |
> >     ----------------|
> >     |
> >     v
> > ...
> > if (!p->pre_handler || !p->pre_handler(p, regs))
> >                              |
> >     -------------------------|
> >     |
> >     v
> > ...
> > pre_handler_kretprobe():
> > ...
> >     if (unlikely(in_nmi())) {
> >         rp->nmissed++;
> >         return 0;
> >     }
> > 
> > Essentially, exc_int3() calls nmi_enter(), and pre_handler_kretprobe() before
> > invoking any registered kprobe verifies if it is not in NMI via in_nmi() call.
> > 
> > This bug was masked by OPTIMIZER which was turning most of the KPROBES to be
> > FTRACE so essentially if someone registered KRETPROBE, buggy code was not
> > invoked (FTRACE code was executed instead). However, the optimizer was changed
> > and can't optimize as many functions anymore (probably another bug which might
> > be worth to investigate) and this bug is more visible.
> > 
> > Thanks,
> > Adam
> > 
> > -- 
> > pi3 (pi3ki31ny) - pi3 (at) itsec pl
> > http://pi3.com.pl
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl

