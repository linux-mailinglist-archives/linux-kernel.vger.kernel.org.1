Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6C1F9821
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgFONSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 09:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgFONSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:18:52 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9iHmgEBqMNUJQQp3z9urv2a5oeZZE/kebSknBav0S50=; b=D73M4wgGpzKjddp7Tcwzw79w7D
        JbEuujocMx5wcHpLtmF3xss8/a63XQBIqUx653SfrgLBoelmizlLnkQXrWvnCoJQ8p5RD1KURXHAx
        vP9OvYxsQ70sz6Ug3KPTE99JVYQiCGkZS0YIBDNQFLA4RqDlY5LUzs2HQspl4pJcyOcnq5KS5Nr5b
        KjGaPOFvbWG7ZL+X7FxZX3CN5lrW+8QUq7zQxgjQrbAxwftp++x15m0Z3Bj+OWxRgDoLmNrzGQ5r/
        LBWt3odog6v+JqB6hk39y3GJNTUyFvxzMvsev1NWPExg0BV45yOgONVKeTo+niQrDHvkuLng+b6wZ
        CDIff6hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkp0F-0004P6-Nk; Mon, 15 Jun 2020 13:18:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB3233060FD;
        Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A81542392E708; Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Message-ID: <20200615131143.313301448@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Jun 2020 14:56:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, peterz@infradead.org
Subject: [PATCH 4/6] smp, irq_work: Continue smp_call_function*() and irq_work*() integration
References: <20200615125654.678940605@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on BUG_ON() to ensure the various data structures
line up, use a bunch of horrible unions.

Much of the union magic is to ensure irq_work and smp_call_function do
not (yet) see the members of their respective data structures change
name.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/irq_work.h  |   26 +++++-------------
 include/linux/sched.h     |    5 ---
 include/linux/smp.h       |   23 +++++-----------
 include/linux/smp_types.h |   66 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c       |    6 ++--
 kernel/smp.c              |   18 ------------
 6 files changed, 86 insertions(+), 58 deletions(-)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_IRQ_WORK_H
 #define _LINUX_IRQ_WORK_H
 
-#include <linux/llist.h>
+#include <linux/smp_types.h>
 
 /*
  * An entry can be in one of four states:
@@ -13,24 +13,14 @@
  * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
  */
 
-/* flags share CSD_FLAG_ space */
-
-#define IRQ_WORK_PENDING	BIT(0)
-#define IRQ_WORK_BUSY		BIT(1)
-
-/* Doesn't want IPI, wait for tick: */
-#define IRQ_WORK_LAZY		BIT(2)
-/* Run hard IRQ context, even on RT */
-#define IRQ_WORK_HARD_IRQ	BIT(3)
-
-#define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
-
-/*
- * structure shares layout with single_call_data_t.
- */
 struct irq_work {
-	struct llist_node llnode;
-	atomic_t flags;
+	union {
+		struct __call_single_node node;
+		struct {
+			struct llist_node llnode;
+			atomic_t flags;
+		};
+	};
 	void (*func)(struct irq_work *);
 };
 
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -653,11 +653,8 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct {
-		struct llist_node		wake_entry;
-		unsigned int			wake_entry_type;
-	};
 	int				on_cpu;
+	struct __call_single_node	wake_entry;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
 	unsigned int			cpu;
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -12,29 +12,22 @@
 #include <linux/list.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
-#include <linux/llist.h>
+#include <linux/smp_types.h>
 
 typedef void (*smp_call_func_t)(void *info);
 typedef bool (*smp_cond_func_t)(int cpu, void *info);
 
-enum {
-	CSD_FLAG_LOCK		= 0x01,
-
-	/* IRQ_WORK_flags */
-
-	CSD_TYPE_ASYNC		= 0x00,
-	CSD_TYPE_SYNC		= 0x10,
-	CSD_TYPE_IRQ_WORK	= 0x20,
-	CSD_TYPE_TTWU		= 0x30,
-	CSD_FLAG_TYPE_MASK	= 0xF0,
-};
-
 /*
  * structure shares (partial) layout with struct irq_work
  */
 struct __call_single_data {
-	struct llist_node llist;
-	unsigned int flags;
+	union {
+		struct __call_single_node node;
+		struct {
+			struct llist_node llist;
+			unsigned int flags;
+		};
+	};
 	smp_call_func_t func;
 	void *info;
 };
--- /dev/null
+++ b/include/linux/smp_types.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SMP_TYPES_H
+#define __LINUX_SMP_TYPES_H
+
+#include <linux/llist.h>
+
+enum {
+	CSD_FLAG_LOCK		= 0x01,
+
+	IRQ_WORK_PENDING	= 0x01,
+	IRQ_WORK_BUSY		= 0x02,
+	IRQ_WORK_LAZY		= 0x04, /* No IPI, wait for tick */
+	IRQ_WORK_HARD_IRQ	= 0x08, /* IRQ context on PREEMPT_RT */
+
+	IRQ_WORK_CLAIMED	= (IRQ_WORK_PENDING | IRQ_WORK_BUSY),
+
+	CSD_TYPE_ASYNC		= 0x00,
+	CSD_TYPE_SYNC		= 0x10,
+	CSD_TYPE_IRQ_WORK	= 0x20,
+	CSD_TYPE_TTWU		= 0x30,
+
+	CSD_FLAG_TYPE_MASK	= 0xF0,
+};
+
+/*
+ * struct __call_single_node is the primary type on
+ * smp.c:call_single_queue.
+ *
+ * flush_smp_call_function_queue() only reads the type from
+ * __call_single_node::u_flags as a regular load, the above
+ * (anonymous) enum defines all the bits of this word.
+ *
+ * Other bits are not modified until the type is known.
+ *
+ * CSD_TYPE_SYNC/ASYNC:
+ *	struct {
+ *		struct llist_node node;
+ *		unsigned int flags;
+ *		smp_call_func_t func;
+ *		void *info;
+ *	};
+ *
+ * CSD_TYPE_IRQ_WORK:
+ *	struct {
+ *		struct llist_node node;
+ *		atomic_t flags;
+ *		void (*func)(struct irq_work *);
+ *	};
+ *
+ * CSD_TYPE_TTWU:
+ *	struct {
+ *		struct llist_node node;
+ *		unsigned int flags;
+ *	};
+ *
+ */
+
+struct __call_single_node {
+	struct llist_node	llist;
+	union {
+		unsigned int	u_flags;
+		atomic_t	a_flags;
+	};
+};
+
+#endif /* __LINUX_SMP_TYPES_H */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2293,7 +2293,7 @@ void sched_ttwu_pending(void *arg)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	llist_for_each_entry_safe(p, t, llist, wake_entry)
+	llist_for_each_entry_safe(p, t, llist, wake_entry.llist)
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
 
 	rq_unlock_irqrestore(rq, &rf);
@@ -2322,7 +2322,7 @@ static void __ttwu_queue_wakelist(struct
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	__smp_call_single_queue(cpu, &p->wake_entry);
+	__smp_call_single_queue(cpu, &p->wake_entry.llist);
 }
 
 void wake_up_if_idle(int cpu)
@@ -2774,7 +2774,7 @@ static void __sched_fork(unsigned long c
 #endif
 	init_numa_balancing(clone_flags, p);
 #ifdef CONFIG_SMP
-	p->wake_entry_type = CSD_TYPE_TTWU;
+	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 #endif
 }
 
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -671,24 +671,6 @@ void __init smp_init(void)
 {
 	int num_nodes, num_cpus;
 
-	/*
-	 * Ensure struct irq_work layout matches so that
-	 * flush_smp_call_function_queue() can do horrible things.
-	 */
-	BUILD_BUG_ON(offsetof(struct irq_work, llnode) !=
-		     offsetof(struct __call_single_data, llist));
-	BUILD_BUG_ON(offsetof(struct irq_work, func) !=
-		     offsetof(struct __call_single_data, func));
-	BUILD_BUG_ON(offsetof(struct irq_work, flags) !=
-		     offsetof(struct __call_single_data, flags));
-
-	/*
-	 * Assert the CSD_TYPE_TTWU layout is similar enough
-	 * for task_struct to be on the @call_single_queue.
-	 */
-	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
-		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
-
 	idle_threads_init();
 	cpuhp_threads_init();
 


