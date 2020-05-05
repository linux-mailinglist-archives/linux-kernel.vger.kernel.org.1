Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0231C594B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgEEONv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729216AbgEEONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065AC0610D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:47 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyJz-0000KY-6k; Tue, 05 May 2020 16:13:19 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A3A0DFFC8D;
        Tue,  5 May 2020 16:13:18 +0200 (CEST)
Message-Id: <20200505134058.453581595@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:06 +0200
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
Subject: [patch V4 part 1 04/36] sched: Make scheduler_ipi inline
References: <20200505131602.633487962@linutronix.de>
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

Now that the scheduler IPI is trivial and simple again there is no point to
have the little function out of line. This simplifies the effort of
constraining the instrumentation nicely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |   10 +++++++++-
 kernel/sched/core.c   |   10 ----------
 2 files changed, 9 insertions(+), 11 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1719,7 +1719,15 @@ extern char *__get_task_comm(char *to, s
 })
 
 #ifdef CONFIG_SMP
-void scheduler_ipi(void);
+static __always_inline void scheduler_ipi(void)
+{
+	/*
+	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
+	 * TIF_NEED_RESCHED remotely (for the first time) will also send
+	 * this IPI.
+	 */
+	preempt_fold_need_resched();
+}
 extern unsigned long wait_task_inactive(struct task_struct *, long match_state);
 #else
 static inline void scheduler_ipi(void) { }
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2312,16 +2312,6 @@ static void wake_csd_func(void *info)
 	sched_ttwu_pending();
 }
 
-void scheduler_ipi(void)
-{
-	/*
-	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
-	 * TIF_NEED_RESCHED remotely (for the first time) will also send
-	 * this IPI.
-	 */
-	preempt_fold_need_resched();
-}
-
 static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);

