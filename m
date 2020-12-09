Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED972D4D2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgLIWAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:00:15 -0500
Received: from pi3.com.pl ([185.238.74.129]:39718 "EHLO pi3.com.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388349AbgLIWAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:00:08 -0500
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 17:00:07 EST
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 287BB4C0300;
        Wed,  9 Dec 2020 22:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1607550604; bh=e5FGc3+7YSrmfXultg5VHgIjqiIa4SU34YJceUw8+vU=;
        h=Date:From:To:Subject:From;
        b=qv08MWlDyicXpVmTCFAtruEQ2eToFK0bo7OA9vHx/KygbVk5MUzVbKvu2A14/LF4/
         KyJaLpVNVGNy/h4CQ+IKF4SWV6RSo+BrEQkwHeN9RchlcbTbYSYQ+R0HpxdaKUeQ+v
         eYgCPFQuYST2dO/o9VQH0Aim4mADGfFwR7e1pR1P9EJ10tWLIR9SxqLI+yMvSEkU2O
         p3BUJFbGN+6LFtOuwN+nKGuClVxj7LiYOPI5+hVh4V0UmZvS3Ltx4ndKCg5li/3qGb
         2EeocTVgpBimVddldQJU6fc6PyHJ9iS/YT4G6xjRxywf5zwRqhqPqG/RtVBMphOSK2
         PFOZ9/bbv3q0A==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KdST3LSMRF-M; Wed,  9 Dec 2020 22:50:01 +0100 (CET)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 19B3C4C05AB; Wed,  9 Dec 2020 22:50:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1607550601; bh=e5FGc3+7YSrmfXultg5VHgIjqiIa4SU34YJceUw8+vU=;
        h=Date:From:To:Subject:From;
        b=KDLtQ65vruOIHVOvHqxYvKiMQdwYYn/+3RWdFoiCr97aUODrGj9D1o3LR08lWbkPU
         JOk/PtjaSW0yIMfnWyu70E2RDkR9yJn9Zb+blZqRP9NL3yshRiUaa5bMaasnVorbOb
         f7wy3I0EOmUs/1k08rEHti1P8HInvC+6i0vHcoIvVE+z+VGmjck/qocJI7IQ4VcIB1
         mzm+rfYrYLIMswDDBk9OZJhPW/XjPwd9q434ySPz7qPguaoR15IDnI58bHYxGJBZpf
         h86m6+FDPAi1S9ITJfidR8B5qYc4tabWu+Efpv6HbRsYKRJ36GNYNrExXiI6uNhMnm
         KUwqdBtk6HbLA==
Date:   Wed, 9 Dec 2020 22:50:01 +0100
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Solar Designer <solar@openwall.com>
Subject: KRETPROBES are broken since kernel 5.8
Message-ID: <20201209215001.GA8593@pi3.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Starting from kernel 5.8 all non-optimized kretprobes don't work. Until 5.8,
when #DB exception was raised, entry to the NMI was not fully performed. Among
others, the following logic was executed:
https://elixir.bootlin.com/linux/v5.7.19/source/arch/x86/kernel/traps.c#L589

    if (!user_mode(regs)) {
        rcu_nmi_enter();
        preempt_disable();
    }

In some older kernels function ist_enter() was called instead. Inside this
function we can see the following logic:
https://elixir.bootlin.com/linux/v5.7.19/source/arch/x86/kernel/traps.c#L91

    if (user_mode(regs)) {
        RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
    } else {
        /*
         * We might have interrupted pretty much anything.  In
         * fact, if we're a machine check, we can even interrupt
         * NMI processing.  We don't want in_nmi() to return true,
         * but we need to notify RCU.
         */
        rcu_nmi_enter();
    }

    preempt_disable();

As the comment says "We don't want in_nmi() to return true, but we need to
notify RCU.". However, since kernel 5.8 the logic of how interrupts are handled
was modified and currently we have this (function "exc_int3"):
https://elixir.bootlin.com/linux/v5.8/source/arch/x86/kernel/traps.c#L630

    /*
     * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
     * can trigger INT3, hence poke_int3_handler() must be done
     * before. If the entry came from kernel mode, then use nmi_enter()
     * because the INT3 could have been hit in any context including
     * NMI.
     */
    if (user_mode(regs)) {
        idtentry_enter_user(regs);
        instrumentation_begin();
        do_int3_user(regs);
        instrumentation_end();
        idtentry_exit_user(regs);
    } else {
        nmi_enter();
        instrumentation_begin();
        trace_hardirqs_off_finish();
        if (!do_int3(regs))
            die("int3", regs, 0);
        if (regs->flags & X86_EFLAGS_IF)
            trace_hardirqs_on_prepare();
        instrumentation_end();
        nmi_exit();
    }

The root of unlucky change comes from this commit:

https://github.com/torvalds/linux/commit/0d00449c7a28a1514595630735df383dec606812#diff-51ce909c2f65ed9cc668bc36cc3c18528541d8a10e84287874cd37a5918abae5

which later was modified by this commit:

https://github.com/torvalds/linux/commit/8edd7e37aed8b9df938a63f0b0259c70569ce3d2

and this is what we currently have in all kernels since 5.8. Essentially,
KRETPROBES are not working since these commits. We have the following logic:

asm_exc_int3() -> exc_int3():
                    |
    ----------------|
    |
    v
...
nmi_enter();
...
if (!do_int3(regs))
       |
  -----|
  |
  v
do_int3() -> kprobe_int3_handler():
                    |
    ----------------|
    |
    v
...
if (!p->pre_handler || !p->pre_handler(p, regs))
                             |
    -------------------------|
    |
    v
...
pre_handler_kretprobe():
...
    if (unlikely(in_nmi())) {
        rp->nmissed++;
        return 0;
    }

Essentially, exc_int3() calls nmi_enter(), and pre_handler_kretprobe() before
invoking any registered kprobe verifies if it is not in NMI via in_nmi() call.

This bug was masked by OPTIMIZER which was turning most of the KPROBES to be
FTRACE so essentially if someone registered KRETPROBE, buggy code was not
invoked (FTRACE code was executed instead). However, the optimizer was changed
and can't optimize as many functions anymore (probably another bug which might
be worth to investigate) and this bug is more visible.

Thanks,
Adam

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl

