Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CAF2AC9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgKJA4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731095AbgKJA41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:56:27 -0500
Received: from localhost.localdomain (i15-lef02-th2-89-83-252-17.ft.lns.abo.bbox.fr [89.83.252.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7678E20679;
        Tue, 10 Nov 2020 00:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604969786;
        bh=1dHOAnluzc3DUZgTXwlA5THZJyKHNcgVZxfXg5zyNXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAdvSxsB7P0JyGzSC6g52Bzh/mdlJLbMVn+F6ktHvaYdqKsgHbifsuGMsPG0iEC4g
         vge7qa/9uzPJ0IxmsRGIMKK2sYVw7IW5y7Fo31OCxJ4Z28bcS7QzO2Cet0WSlUwYwF
         49Af2I5LaJbJ9K+3pReMPU3hoDf2thiUDcT02dcE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 4/7] preempt/dynamic: Provide cond_resched() and might_resched() static calls
Date:   Tue, 10 Nov 2020 01:56:06 +0100
Message-Id: <20201110005609.40989-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110005609.40989-1-frederic@kernel.org>
References: <20201110005609.40989-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Provide static calls to control cond_resched() (called in !CONFIG_PREEMPT)
and might_resched() (called in CONFIG_PREEMPT_VOLUNTARY) to that we
can override their behaviour when preempt= is overriden.

Since the default behaviour is full preemption, both their calls are
ignored when preempt= isn't passed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
[branch might_resched() directly to __cond_resched(), only define static
calls when PREEMPT_DYNAMIC]
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kernel.h | 22 +++++++++++++++++++---
 include/linux/sched.h  | 27 ++++++++++++++++++++++++---
 kernel/sched/core.c    | 16 +++++++++++++---
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f05e9128201..ecd820174455 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -15,6 +15,7 @@
 #include <linux/typecheck.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
+#include <linux/static_call_types.h>
 #include <asm/byteorder.h>
 #include <asm/div64.h>
 #include <uapi/linux/kernel.h>
@@ -194,11 +195,26 @@ struct pt_regs;
 struct user;
 
 #ifdef CONFIG_PREEMPT_VOLUNTARY
-extern int _cond_resched(void);
-# define might_resched() _cond_resched()
+
+extern int __cond_resched(void);
+# define might_resched() __cond_resched()
+
+#elif defined(CONFIG_PREEMPT_DYNAMIC)
+
+extern int __cond_resched(void);
+
+DECLARE_STATIC_CALL(might_resched, __static_call_return0);
+
+static __always_inline void might_resched(void)
+{
+	static_call(might_resched)();
+}
+
 #else
+
 # define might_resched() do { } while (0)
-#endif
+
+#endif /* CONFIG_PREEMPT_* */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void ___might_sleep(const char *file, int line, int preempt_offset);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..f1d6f274e0dc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1829,11 +1829,32 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * value indicates whether a reschedule was done in fact.
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
-#ifndef CONFIG_PREEMPTION
-extern int _cond_resched(void);
+#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
+extern int __cond_resched(void);
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+DECLARE_STATIC_CALL(cond_resched, __static_call_return0);
+
+static __always_inline int _cond_resched(void)
+{
+	return static_call(cond_resched)();
+}
+
 #else
+
+static inline int _cond_resched(void)
+{
+	return __cond_resched();
+}
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
+#else
+
 static inline int _cond_resched(void) { return 0; }
-#endif
+
+#endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
 
 #define cond_resched() ({			\
 	___might_sleep(__FILE__, __LINE__, 0);	\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..6432d0079510 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6111,17 +6111,27 @@ SYSCALL_DEFINE0(sched_yield)
 	return 0;
 }
 
-#ifndef CONFIG_PREEMPTION
-int __sched _cond_resched(void)
+#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
+int __sched __cond_resched(void)
 {
 	if (should_resched(0)) {
 		preempt_schedule_common();
 		return 1;
 	}
+#ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
+#endif
 	return 0;
 }
-EXPORT_SYMBOL(_cond_resched);
+EXPORT_SYMBOL(__cond_resched);
+#endif
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(cond_resched, __static_call_return0);
+EXPORT_STATIC_CALL(cond_resched);
+
+DEFINE_STATIC_CALL(might_resched, __static_call_return0);
+EXPORT_STATIC_CALL(might_resched);
 #endif
 
 /*
-- 
2.25.1

