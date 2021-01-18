Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F264E2FA2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392591AbhAROPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392731AbhARON5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:13:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAEE322C9E;
        Mon, 18 Jan 2021 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610979163;
        bh=8OfMxgXz16Dn7o5Ie1qNmaJLFHYEanmQ8aF50mGj4X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D52GKEFQ+FgZnirT63GYjMnTq8VDYk84eAZ5IzYXKACSasI9XHUQsGgWDeZEFf6tF
         qvKJwvhNkQZ2MDCToFJdjUGweQbxAoplO538eU5b/Slaa4KGWn69Nk5uQJtrz4Qi6m
         kaSbPDAvc3f891f/wn5drQufylTBwAdWVm9/6FphpHuoL0ddOaZgDKAJ3qIu1EzX76
         WRT5ycbTVve+9pawFZu8T0iJGRyeyJ4FozVYp0yJ/tdOUVRvdeGCVLFiRRwREb8Jc8
         Wnken7XtqEhLsfd5gNi9XRDu/FSKVFPvv7fBv5pBVpdtvSao2uOTgJDM/KAq0lFY5R
         ndGgV3BMT8HFA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 6/8] preempt/dynamic: Provide preempt_schedule[_notrace]() static calls
Date:   Mon, 18 Jan 2021 15:12:21 +0100
Message-Id: <20210118141223.123667-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
References: <20210118141223.123667-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Provide static calls to control preempt_schedule[_notrace]()
(called in CONFIG_PREEMPT) so that we can override their behaviour when
preempt= is overriden.

Since the default behaviour is full preemption, both their calls are
initialized to the arch provided wrapper, if any.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
[only define static calls when PREEMPT_DYNAMIC, make it less dependent
on x86 with __preempt_schedule_func()]
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/preempt.h | 34 ++++++++++++++++++++++++++--------
 kernel/sched/core.c            | 12 ++++++++++++
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 69485ca13665..3db9cb8b1a25 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -5,6 +5,7 @@
 #include <asm/rmwcc.h>
 #include <asm/percpu.h>
 #include <linux/thread_info.h>
+#include <linux/static_call_types.h>
 
 DECLARE_PER_CPU(int, __preempt_count);
 
@@ -103,16 +104,33 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
-  extern asmlinkage void preempt_schedule_thunk(void);
-# define __preempt_schedule() \
-	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT)
 
-  extern asmlinkage void preempt_schedule(void);
-  extern asmlinkage void preempt_schedule_notrace_thunk(void);
-# define __preempt_schedule_notrace() \
-	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT)
+extern asmlinkage void preempt_schedule(void);
+extern asmlinkage void preempt_schedule_thunk(void);
+
+#define __preempt_schedule_func() preempt_schedule_thunk
+
+DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
+
+#define __preempt_schedule() \
+do { \
+	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
+} while (0)
+
+extern asmlinkage void preempt_schedule_notrace(void);
+extern asmlinkage void preempt_schedule_notrace_thunk(void);
+
+#define __preempt_schedule_notrace_func() preempt_schedule_notrace_thunk
+
+DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
+
+#define __preempt_schedule_notrace() \
+do { \
+	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
+} while (0)
 
-  extern asmlinkage void preempt_schedule_notrace(void);
 #endif
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d6de12b4eef2..faff4b546c5f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5251,6 +5251,12 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
+EXPORT_STATIC_CALL(preempt_schedule);
+#endif
+
+
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
  *
@@ -5303,6 +5309,12 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 }
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
+EXPORT_STATIC_CALL(preempt_schedule_notrace);
+#endif
+
+
 #endif /* CONFIG_PREEMPTION */
 
 /*
-- 
2.25.1

