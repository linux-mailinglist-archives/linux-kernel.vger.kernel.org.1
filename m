Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3726E294D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437435AbgJUNRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394958AbgJUNRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:17:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BFAC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UwnRjfY5BPNMzLgUrGTLpEuYrfE7DEf2HGxX68JRo1o=; b=OcCoIj6ShzR1fGH5JYU3M0kTni
        LjQQ/G+403InTFLUfYrDc7P/GeAb+FCQfaj1eQGwrGEtjC+Vw1QiKEooMCz8znAsRP1jKtzBDzf6v
        +eN9CYiNpTPYl1JDorkStoIqEzakolyAApN9jXbKKKg3oc+e7I7GCoYHwQ3ReGVpNyloEMa32LfkF
        VyvMPEheBkRlUDV0Z9+iyQy0L6CWmbrkiwfbGzi/lZC82gbuzxlG4OK+cfMTp9ThqfgKESGipV9ex
        gZ7qfisxv1Cs1iJqqbbNTi6nbHny9Ilmj/CO4WMobVuXPJDmOXWYpeFNQf+tj1YIxnM9dT0dX3FHX
        5zxvkalQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVDzi-0003ya-V8; Wed, 21 Oct 2020 13:17:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A169A30377D;
        Wed, 21 Oct 2020 15:17:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C0BE203CC4BF; Wed, 21 Oct 2020 15:17:33 +0200 (CEST)
Date:   Wed, 21 Oct 2020 15:17:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 trace_hardirqs_on
Message-ID: <20201021131733.GH2628@hirez.programming.kicks-ass.net>
References: <000000000000e921b305b18ba0a7@google.com>
 <20201013091743.12c371a8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013091743.12c371a8@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 09:17:43AM -0400, Steven Rostedt wrote:
> On Tue, 13 Oct 2020 04:22:21 -0700
> syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    865c50e1 x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15112ef0500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c829313274207568
> > dashboard link: https://syzkaller.appspot.com/bug?extid=53f8ce8bbc07924b6417
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com
> > 
> > BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor.0/8265
> > caller is lockdep_hardirqs_on_prepare+0x56/0x620 kernel/locking/lockdep.c:4060
> > CPU: 0 PID: 8265 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1d6/0x29e lib/dump_stack.c:118
> >  check_preemption_disabled+0x13c/0x140 lib/smp_processor_id.c:48
> >  lockdep_hardirqs_on_prepare+0x56/0x620 kernel/locking/lockdep.c:4060
> >  trace_hardirqs_on+0x6f/0x80 kernel/trace/trace_preemptirq.c:49
> >  __bad_area_nosemaphore+0x89/0x510 arch/x86/mm/fault.c:797
> >  handle_page_fault arch/x86/mm/fault.c:1429 [inline]
> >  exc_page_fault+0x129/0x240 arch/x86/mm/fault.c:1482
> >  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
> > RIP: 0033:0x402d28
> > Code: 00 00 48 89 7c 24 f8 48 89 74 24 f0 48 89 54 24 e8 48 89 4c 24 e0 48 8b 74 24 f8 4c 8b 4c 24 f0 48 8b 4c 24 e8 48 8b 54 24 e0 <8b> 86 0c 01 00 00 44 8b 86 08 01 00 00 c1 e0 04 8d b8 7f 01 00 00
> > RSP: 002b:00007fce5827ec68 EFLAGS: 00010216
> > RAX: 0000000000402d00 RBX: 000000000118bfc8 RCX: 0000000020000200
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 000000000118c010 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfd4
> > R13: 00007ffea2de495f R14: 00007fce5827f9c0 R15: 000000000118bfd4
> > BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor.0/8265
> > caller is lockdep_hardirqs_on+0x36/0x110 kernel/locking/lockdep.c:4129
> > CPU: 0 PID: 8265 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1d6/0x29e lib/dump_stack.c:118
> >  check_preemption_disabled+0x13c/0x140 lib/smp_processor_id.c:48
> >  lockdep_hardirqs_on+0x36/0x110 kernel/locking/lockdep.c:4129
> >  __bad_area_nosemaphore+0x89/0x510 arch/x86/mm/fault.c:797
> 
> Peter,
> 
> I'm guessing the above is:
> 
> static void
> __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
> 		       unsigned long address, u32 pkey, int si_code)
> {
> 	struct task_struct *tsk = current;
> 
> 	/* User mode accesses just cause a SIGSEGV */
> 	if (user_mode(regs) && (error_code & X86_PF_USER)) {
> 		/*
> 		 * It's possible to have interrupts off here:
> 		 */
> 		local_irq_enable();
> 
> 
> And I'm also guessing that we can call this with interrupts enabled (based
> on the comment).
> 
> And we have this:
> 
>    local_irq_enable()
>       trace_hardirqs_on()
>          lockdep_hardirqs_on()
>              __this_cpu_read()

Moo, two threads..

20201019183355.GS2611@hirez.programming.kicks-ass.net

---

On Tue, Oct 20, 2020 at 12:55:46AM +0800, kernel test robot wrote:
> [   92.898145] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c6/526

> [   92.903305] Call Trace:
> [   92.905182]  __this_cpu_preempt_check+0xf/0x11
> [   92.905968]  lockdep_hardirqs_on_prepare+0x2c/0x18f
> [   92.906853]  trace_hardirqs_on+0x49/0x53
> [   92.907578]  __bad_area_nosemaphore+0x3a/0x134

Hurph, that's a spurious local_irq_enable(). I suppose this'll fix it.

---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..9f818145ef7d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4057,9 +4057,6 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(in_nmi()))
 		return;
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
-		return;
-
 	if (unlikely(lockdep_hardirqs_enabled())) {
 		/*
 		 * Neither irq nor preemption are disabled here
@@ -4070,6 +4067,9 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 		return;
 	}
 
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
+		return;
+
 	/*
 	 * We're enabling irqs and according to our state above irqs weren't
 	 * already enabled, yet we find the hardware thinks they are in fact
@@ -4126,9 +4126,6 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		goto skip_checks;
 	}
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
-		return;
-
 	if (lockdep_hardirqs_enabled()) {
 		/*
 		 * Neither irq nor preemption are disabled here
@@ -4139,6 +4136,9 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		return;
 	}
 
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
+		return;
+
 	/*
 	 * We're enabling irqs and according to our state above irqs weren't
 	 * already enabled, yet we find the hardware thinks they are in fact

