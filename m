Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91192FA2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392753AbhAROQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392732AbhARON4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:13:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 701E622C9D;
        Mon, 18 Jan 2021 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610979161;
        bh=1cAkqJEmvE+Ld0yQposc40r3ymfj/fgFEzm9JOq8VCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRXjaYuWcY8xlbLNhULUrqDG/j4qaOohRik+7wJVfgeWHeb84r/WHILvOWlqP00E6
         1FbVrc5tFcZ2YFXSQkl1WW90HG0CoTm/D6nEsjG/GwDAsvwsE51YCwZxsC0cNSs4Tu
         TtI6wTJ3ls7YjcQVY3UXuxG6jO5fr6p74o6OcgtK/iZ7B3CZ7pO9BP0mk4UnWhfFbq
         znZ2nnFWoQMBXqCTJkXpGslXbOPPTLIuOR11Tg+ocGOw9LHyqABoHIzk51Tt+pYmkb
         bq+dWDJkHQ6U2a/UntrgXgz3mALa+xVsJb6y/9lqKbUatzBXb6AwdYV3iN1+tGP7as
         LYo3xoon3280Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 5/8] preempt/dynamic: Provide cond_resched() and might_resched() static calls
Date:   Mon, 18 Jan 2021 15:12:20 +0100
Message-Id: <20210118141223.123667-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
References: <20210118141223.123667-1-frederic@kernel.org>
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
 include/linux/kernel.h | 23 +++++++++++++++++++----
 include/linux/sched.h  | 27 ++++++++++++++++++++++++---
 kernel/sched/core.c    | 16 +++++++++++++---
 3 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f7902d8c1048..cfd3d349f905 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -15,7 +15,7 @@
 #include <linux/typecheck.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
-
+#include <linux/static_call_types.h>
 #include <asm/byteorder.h>
 
 #include <uapi/linux/kernel.h>
@@ -81,11 +81,26 @@ struct pt_regs;
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
+DECLARE_STATIC_CALL(might_resched, __cond_resched);
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
index 6e3a5eeec509..86bcb589da09 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1871,11 +1871,32 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
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
+DECLARE_STATIC_CALL(cond_resched, __cond_resched);
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
index 15d2562118d1..d6de12b4eef2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6654,17 +6654,27 @@ SYSCALL_DEFINE0(sched_yield)
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
+DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
+EXPORT_STATIC_CALL(cond_resched);
+
+DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
+EXPORT_STATIC_CALL(might_resched);
 #endif
 
 /*
-- 
2.25.1

