Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25CE1DC1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 00:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgETWPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 18:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgETWPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:15:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F60A20823;
        Wed, 20 May 2020 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590012932;
        bh=aHIwMpLNIUwrAoCIhPWxIan4ODVV6e70BRdbQbLMFcg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wdRPJ8wvm3t3ksbcnLju8ASGrtoxZqDq9pQNi/VxTOGZ3T8kYVnOfXNaO2FAJAE35
         wh6bNdVllBeVdLTH2O0Mh5AZ8E+CQDNQSHHeESZR9hbsEhrdk6oknsybFhgsUcbr9z
         kAwUeIxk4+hKPA5wAt32L2V5FoaK7DgvoNN9vkIY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 88B863522A2B; Wed, 20 May 2020 15:15:31 -0700 (PDT)
Date:   Wed, 20 May 2020 15:15:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V6 12/37] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
Message-ID: <20200520221531.GW2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87ftbv7nsd.fsf@nanos.tec.linutronix.de>
 <87a7237k3x.fsf@nanos.tec.linutronix.de>
 <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
 <874ksb7hbg.fsf@nanos.tec.linutronix.de>
 <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
 <20200520022353.GN2869@paulmck-ThinkPad-P72>
 <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
 <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
 <20200520180546.GQ2869@paulmck-ThinkPad-P72>
 <87o8qiv135.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8qiv135.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:49:18PM +0200, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Wed, May 20, 2020 at 09:51:17AM -0700, Andy Lutomirski wrote:
> >> Paul, the major change here is that if an IRQ hits normal kernel code
> >> (i.e. code where RCU is watching and we're not in an EQS), the IRQ
> >> won't call rcu_irq_enter() and rcu_irq_exit().  Instead it will call
> >> rcu_tickle() on entry and nothing on exit.  Does that cover all the
> >> bases?
> >
> > From an RCU viewpoint, yes, give or take my concerns about someone
> > putting rcu_tickle() on entry and rcu_irq_exit() on exit.  Perhaps
> > I can bring some lockdep trickery to bear.
> 
> An surplus rcu_irq_exit() should already trigger alarms today.

Fair point!

> > But I must defer to Thomas and Peter on the non-RCU/non-NO_HZ_FULL
> > portions of this.
> 
> I don't see a problem. Let me write that into actual testable patch
> form.

Here is the RCU part, with my current best guess for the commit log.

Please note that this is on top of my -rcu stack, so some adjustment
will likely be needed to pull it underneath Joel's series that removes
the special-purpose bits at the bottom of the ->dynticks counter.

But a starting point, anyway.

							Thanx, Paul

------------------------------------------------------------------------

commit ca05838a9a1809fafee63f488a7be8b30e1c2a6a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed May 20 15:03:07 2020 -0700

    rcu: Abstract out tickle_nohz_for_rcu() from rcu_nmi_enter()
    
    This commit splits out the nohz_full scheduler-tick enabling from the
    rest of the rcu_nmi_enter() logic.  This allows short exception handlers
    that interrupt kernel code regions that RCU is already watching to just
    invoke tickle_nohz_for_rcu() at exception entry instead of having to
    invoke rcu_nmi_enter() on entry and also rcu_nmi_exit() on all exit paths.
    
    Suggested-by: Andy Lutomirski <luto@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 621556e..d4be42a 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -14,6 +14,10 @@ extern bool synchronize_hardirq(unsigned int irq);
 
 #if defined(CONFIG_TINY_RCU)
 
+static inline void tickle_nohz_for_rcu(void)
+{
+}
+
 static inline void rcu_nmi_enter(void)
 {
 }
@@ -23,6 +27,7 @@ static inline void rcu_nmi_exit(void)
 }
 
 #else
+extern void tickle_nohz_for_rcu(void);
 extern void rcu_nmi_enter(void);
 extern void rcu_nmi_exit(void);
 #endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7812574..0a3cad4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -806,6 +806,67 @@ void noinstr rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
+ * tickle_nohz_for_rcu - Enable scheduler tick on CPU if RCU needs it.
+ *
+ * The scheduler tick is not normally enabled when CPUs enter the kernel
+ * from nohz_full userspace execution.  After all, nohz_full userspace
+ * execution is an RCU quiescent state and the time executing in the kernel
+ * is quite short.  Except of course when it isn't.  And it is not hard to
+ * cause a large system to spend tens of seconds or even minutes looping
+ * in the kernel, which can cause a number of problems, include RCU CPU
+ * stall warnings.
+ *
+ * Therefore, if a nohz_full CPU fails to report a quiescent state
+ * in a timely manner, the RCU grace-period kthread sets that CPU's
+ * ->rcu_urgent_qs flag with the expectation that the next interrupt or
+ * exception will invoke this function, which will turn on the scheduler
+ * tick, which will enable RCU to detect that CPU's quiescent states,
+ * for example, due to cond_resched() calls in CONFIG_PREEMPT=n kernels.
+ * The tick will be disabled once a quiescent state is reported for
+ * this CPU.
+ *
+ * Of course, in carefully tuned systems, there might never be an
+ * interrupt or exception.  In that case, the RCU grace-period kthread
+ * will eventually cause one to happen.  However, in less carefully
+ * controlled environments, this function allows RCU to get what it
+ * needs without creating otherwise useless interruptions.
+ */
+noinstr void tickle_nohz_for_rcu(void)
+{
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
+	if (in_nmi())
+		return; // Enabling tick is unsafe in NMI handlers.
+	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+			 "Illegal tickle_nohz_for_rcu from extended quiescent state");
+	instrumentation_begin();
+	if (!tick_nohz_full_cpu(rdp->cpu) ||
+	    !READ_ONCE(rdp->rcu_urgent_qs) ||
+	    READ_ONCE(rdp->rcu_forced_tick)) {
+		// RCU doesn't need nohz_full help from this CPU, or it is
+		// already getting that help.
+		instrumentation_end();
+		return;
+	}
+
+	// We get here only when not in an extended quiescent state and
+	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
+	// already watching and (2) The fact that we are in an interrupt
+	// handler and that the rcu_node lock is an irq-disabled lock
+	// prevents self-deadlock.  So we can safely recheck under the lock.
+	// Note that the nohz_full state currently cannot change.
+	raw_spin_lock_rcu_node(rdp->mynode);
+	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		// A nohz_full CPU is in the kernel and RCU needs a
+		// quiescent state.  Turn on the tick!
+		WRITE_ONCE(rdp->rcu_forced_tick, true);
+		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+	}
+	raw_spin_unlock_rcu_node(rdp->mynode);
+	instrumentation_end();
+}
+
+/**
  * rcu_nmi_enter - inform RCU of entry to NMI context
  * @irq: Is this call from rcu_irq_enter?
  *
@@ -835,7 +896,9 @@ noinstr void rcu_nmi_enter(void)
 	 * is if the interrupt arrived in kernel mode; in this case we would
 	 * be the outermost interrupt but still increment by 2 which is Ok.
 	 */
-	if (rcu_dynticks_curr_cpu_in_eqs()) {
+	if (!rcu_dynticks_curr_cpu_in_eqs()) {
+		tickle_nohz_for_rcu();
+	} else {
 
 		if (!in_nmi())
 			rcu_dynticks_task_exit();
@@ -851,28 +914,6 @@ noinstr void rcu_nmi_enter(void)
 		}
 
 		incby = 1;
-	} else if (!in_nmi()) {
-		instrumentation_begin();
-		if (tick_nohz_full_cpu(rdp->cpu) &&
-		    READ_ONCE(rdp->rcu_urgent_qs) &&
-		    !READ_ONCE(rdp->rcu_forced_tick)) {
-			// We get here only if we had already exited the
-			// extended quiescent state and this was an
-			// interrupt (not an NMI).  Therefore, (1) RCU is
-			// already watching and (2) The fact that we are in
-			// an interrupt handler and that the rcu_node lock
-			// is an irq-disabled lock prevents self-deadlock.
-			// So we can safely recheck under the lock.
-			raw_spin_lock_rcu_node(rdp->mynode);
-			if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-				// A nohz_full CPU is in the kernel and RCU
-				// needs a quiescent state.  Turn on the tick!
-				WRITE_ONCE(rdp->rcu_forced_tick, true);
-				tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
-			}
-			raw_spin_unlock_rcu_node(rdp->mynode);
-		}
-		instrumentation_end();
 	}
 	instrumentation_begin();
 	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
