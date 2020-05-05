Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76D31C5904
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgEEOVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729813AbgEEOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0C5C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:23 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLh-0001NI-0g; Tue, 05 May 2020 16:15:05 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 75102FFC8D;
        Tue,  5 May 2020 16:15:04 +0200 (CEST)
Message-Id: <20200505134904.364456424@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 3 11/29] rcu: Provide rcu_irq_exit_preempt()
References: <20200505134354.774943181@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts and exceptions invoke rcu_irq_enter() on entry and need to
invoke rcu_irq_exit() before they either return to the interrupted code or
invoke the scheduler due to preemption.

The general assumption is that RCU idle code has to have preemption
disabled so that a return from interrupt cannot schedule. So the return
from interrupt code invokes rcu_irq_exit() and preempt_schedule_irq().

If there is any imbalance in the rcu_irq/nmi* invocations or RCU idle code
had preemption enabled then this goes unnoticed until the CPU goes idle or
some other RCU check is executed.

Provide rcu_irq_exit_preempt() which can be invoked from the
interrupt/exception return code in case that preemption is enabled. It
invokes rcu_irq_exit() and contains a few sanity checks in case that
CONFIG_PROVE_RCU is enabled to catch such issues directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/rcutiny.h |    1 +
 include/linux/rcutree.h |    1 +
 kernel/rcu/tree.c       |   21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)

--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -71,6 +71,7 @@ static inline void rcu_irq_enter(void) {
 static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
+static inline void rcu_irq_exit_preempt(void) { }
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -46,6 +46,7 @@ void rcu_idle_enter(void);
 void rcu_idle_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
+void rcu_irq_exit_preempt(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
 
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -706,6 +706,27 @@ void noinstr rcu_irq_exit(void)
 	rcu_nmi_exit();
 }
 
+/**
+ * rcu_irq_exit_preempt - Inform RCU that current CPU is exiting irq
+ *			  towards in kernel preemption
+ *
+ * Same as rcu_irq_exit() but has a sanity check that scheduling is safe
+ * from RCU point of view. Invoked from return from interrupt before kernel
+ * preemption.
+ */
+void rcu_irq_exit_preempt(void)
+{
+	lockdep_assert_irqs_disabled();
+	rcu_nmi_exit();
+
+	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
+			 "RCU dynticks_nesting counter underflow/zero!");
+	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
+			 "RCU dynticks_nmi_nesting counter underflow/zero!");
+	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+			 "RCU in extended quiescent state!");
+}
+
 /*
  * Wrapper for rcu_irq_exit() where interrupts are enabled.
  *

