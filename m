Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889082CAA96
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404222AbgLASPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgLASPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:15:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6BCC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XgMEgGoFfl4yztESyoS12tcQTUQkM31JMYd6l5FT3RI=; b=R0VeOYQ/tZhk0B6Q47IS49Jcl/
        0G+xhvf7BqL5oMk11YIq+d8+y/g4zg7/XDjAn5Y+wB9MA5C+qo6ozSDmGYFEydrKazpsYrRDq3ny0
        CGXhTyFRF3sURNGmjFdurLLAsNgso86tLVuai6B7lsR7Ueys/9aNzS2h0dxZ0DnYh5O/WIy3woobF
        ZYrl7I7jQsvn74kzK1mneWPASqrEDZMu6E+lq18gSMt2rrgxOMtEx+pp9/nTr6CYfEJ7RqDzvcw0t
        qgcjhWqAM/K8G27Fej4GEG9NQriysptE8+VvR0dsStp4RbsbxZZo82mfFH7nd4n2CmmnWmS3Sr1+Z
        iz+Hce3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkABA-0005I9-2e; Tue, 01 Dec 2020 18:15:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDA573003E1;
        Tue,  1 Dec 2020 19:15:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABC052C23DB31; Tue,  1 Dec 2020 19:15:06 +0100 (CET)
Date:   Tue, 1 Dec 2020 19:15:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201181506.GM3092@hirez.programming.kicks-ass.net>
References: <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201145519.GY2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 03:55:19PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 06:46:44AM -0800, Paul E. McKenney wrote:
> 
> > > So after having talked to Sven a bit, the thing that is happening, is
> > > that this is the one place where we take interrupts with RCU being
> > > disabled. Normally RCU is watching and all is well, except during idle.
> > 
> > Isn't interrupt entry supposed to invoke rcu_irq_enter() at some point?
> > Or did this fall victim to recent optimizations?
> 
> It does, but the problem is that s390 is still using

I might've been too quick there, I can't actually seem to find where
s390 does rcu_irq_enter()/exit().

Also, I'm thinking the below might just about solve the current problem.
The next problem would then be it calling TRACE_IRQS_ON after it did
rcu_irq_exit()... :/


---
diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
index 9f75d67b8c20..24d3dd482df7 100644
--- a/arch/s390/include/asm/irq.h
+++ b/arch/s390/include/asm/irq.h
@@ -113,6 +113,8 @@ void irq_subclass_unregister(enum irq_subclass subclass);
 
 #define irq_canonicalize(irq)  (irq)
 
+extern __visible void ext_do_IRQ(struct pt_regs *regs, unsigned long vector);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_IRQ_H */
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 26bb0603c5a1..b8e89b685038 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -976,16 +976,10 @@ ENTRY(ext_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tmhh	%r8,0x300
-	jz	1f
-	TRACE_IRQS_OFF
-1:
-#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	lghi	%r3,EXT_INTERRUPT
-	brasl	%r14,do_IRQ
+	brasl	%r14,ext_do_IRQ
 	j	.Lio_return
 ENDPROC(ext_int_handler)
 
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 3514420f0259..f4a29114e9fd 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -329,3 +329,23 @@ void irq_subclass_unregister(enum irq_subclass subclass)
 	spin_unlock(&irq_subclass_lock);
 }
 EXPORT_SYMBOL(irq_subclass_unregister);
+
+noinstr void ext_do_IRQ(struct pt_regs *regs, unsigned long vector)
+{
+	bool rcu = false;
+
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
+		rcu_irq_enter();
+		rcu = true;
+	}
+	/* instrumentation_begin(); */
+
+	trace_hardirqs_off_finish();
+
+	do_IRQ(regs, vector);
+
+	/* instrumentation_end(); */
+	if (rcu)
+		rcu_irq_exit();
+}
