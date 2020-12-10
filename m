Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF632D616F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgLJQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbgLJQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:15:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+n2txMGzirWDbYFlCh+HdMVVPIygYMcnaAzAxQDlW4A=; b=lt2ohKhbGs/2GXsAMGUTEhGD2b
        EBEmjmP1UryZoTOg/AplnCb4L2NIxR9PIojCX9f3SAgIStqhga7w9YFsd4fKTNfVBOguCJRkiXZ+P
        t6nuUcDjGgonSE5vVBN8Egtcwh+bUmRhh3O4muhEYM5XNDIfEPuFXMXaeVXa0c4eVsBgy5ruFjw+Z
        GwAShlvhg7scyAnDmjyXwzMJV0nIZVGxWWpP4EbQb+cmG8d8w0MbUybOTGfUW1omsEd04gzbRIi6p
        zL4LmVxLtwS8kv6Gfp1GsYmv5B1x1ZyOWs+FjvLXac03FZcSJJ5l+yrqFpl8F03NxfKPxY9cbA+s0
        Sxm+9SyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knOa2-0002KH-9r; Thu, 10 Dec 2020 16:14:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D2E83007CD;
        Thu, 10 Dec 2020 17:14:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5664D20697DEC; Thu, 10 Dec 2020 17:14:08 +0100 (CET)
Date:   Thu, 10 Dec 2020 17:14:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [sched/hotplug]  2558aacff8:  will-it-scale.per_thread_ops -1.6%
 regression
Message-ID: <20201210161408.GX3021@hirez.programming.kicks-ass.net>
References: <20201210081859.GA19784@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210081859.GA19784@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 04:18:59PM +0800, kernel test robot wrote:
> FYI, we noticed a -1.6% regression of will-it-scale.per_thread_ops due to commit:
> commit: 2558aacff8586699bcd248b406febb28b0a25de2 ("sched/hotplug: Ensure only per-cpu kthreads run during hotplug")

Mooo, weird but whatever. Does the below help at all?

---
 kernel/sched/core.c  | 40 +++++++++++++++-------------------------
 kernel/sched/sched.h | 13 +++++--------
 2 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7af80c3fce12..f80245c7f903 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3985,15 +3985,20 @@ static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
 	}
 }
 
+static void balance_push(struct rq *rq);
+
+struct callback_head balance_push_callback = {
+	.next = NULL,
+	.func = (void (*)(struct callback_head *))balance_push,
+};
+
 static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
 {
 	struct callback_head *head = rq->balance_callback;
 
 	lockdep_assert_held(&rq->lock);
-	if (head) {
+	if (head)
 		rq->balance_callback = NULL;
-		rq->balance_flags &= ~BALANCE_WORK;
-	}
 
 	return head;
 }
@@ -4014,21 +4019,6 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 	}
 }
 
-static void balance_push(struct rq *rq);
-
-static inline void balance_switch(struct rq *rq)
-{
-	if (likely(!rq->balance_flags))
-		return;
-
-	if (rq->balance_flags & BALANCE_PUSH) {
-		balance_push(rq);
-		return;
-	}
-
-	__balance_callbacks(rq);
-}
-
 #else
 
 static inline void __balance_callbacks(struct rq *rq)
@@ -4044,10 +4034,6 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 {
 }
 
-static inline void balance_switch(struct rq *rq)
-{
-}
-
 #endif
 
 static inline void
@@ -4075,7 +4061,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	balance_switch(rq);
+	__balance_callbacks(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -7256,6 +7242,10 @@ static void balance_push(struct rq *rq)
 
 	lockdep_assert_held(&rq->lock);
 	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+	/*
+	 * Ensure the thing is persistent until balance_push_set(, on = false);
+	 */
+	rq->balance_callback = &balance_push_callback;
 
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
@@ -7305,9 +7295,9 @@ static void balance_push_set(int cpu, bool on)
 
 	rq_lock_irqsave(rq, &rf);
 	if (on)
-		rq->balance_flags |= BALANCE_PUSH;
+		rq->balance_callback = &balance_push_callback;
 	else
-		rq->balance_flags &= ~BALANCE_PUSH;
+		rq->balance_callback = NULL;
 	rq_unlock_irqrestore(rq, &rf);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f5acb6c5ce49..12ada79d40f3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -975,7 +975,6 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
-	unsigned char		balance_flags;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1226,6 +1225,8 @@ struct rq_flags {
 #endif
 };
 
+extern struct callback_head balance_push_callback;
+
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
  * sticky/continuous lockdep_assert_held().
@@ -1243,9 +1244,9 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
-#endif
 #ifdef CONFIG_SMP
-	SCHED_WARN_ON(rq->balance_callback);
+	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
+#endif
 #endif
 }
 
@@ -1408,9 +1409,6 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
-#define BALANCE_WORK	0x01
-#define BALANCE_PUSH	0x02
-
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1418,13 +1416,12 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
-	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
+	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
-	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \
