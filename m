Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4403F2887B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgJILRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:17:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731313AbgJILRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:17:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602242224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DqksQAnJCB3g13Puq9zwiSNMONneY496/lTwvC/s7s0=;
        b=LkAyfQyvP9GnSMkhhHXkZ6AaBoPW32VP3loUNm2TrtfkVQKbDBLDxy1Le5m1LwS6tkxVBK
        ttY7ndJHG4tQkuc+9AFEArz/5skkZEPUYexxLc+tm7Vqk5vk0nvkRTF8mzlBbHZxLUWMIG
        UsTOZJJhY4AbooATlkoZyXqg7fbq6hY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86CF9AC84;
        Fri,  9 Oct 2020 11:17:04 +0000 (UTC)
Date:   Fri, 9 Oct 2020 13:17:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009111703.GL4967@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007122144.GF2628@hirez.programming.kicks-ass.net>
 <20201007123553.GK29020@dhcp22.suse.cz>
 <20201009094741.GH2628@hirez.programming.kicks-ass.net>
 <20201009101405.GI4967@dhcp22.suse.cz>
 <20201009102009.GK2628@hirez.programming.kicks-ass.net>
 <20201009104808.GK4967@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009104808.GK4967@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-10-20 12:48:09, Michal Hocko wrote:
[...]
> I will add the CONFIG_PREEMPT_DYNAMIC in the next version. I just have
> to think whether flipping the direction is really safe and easier in the
> end. For our particular usecase we are more interested in
> NONE<->VOLUNTARY at this moment and having full preemption in the mix
> later is just fine. If you insist on the other direction then we can
> work on that.

This is a quick implementation of PREEMPT_DYNAMIC (still with the
original approach to start from non preemptive kernels). It is a bit
hairy but I suspect that starting with CONFIG_PREEMPTION wouldn't make
it very much easier but I haven't tried that yet. Advantage of this
approach is that it is clear that it is safe as NONE/VOLUNTARY are
trivial to examine.

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d2d37bd5ecd5..b61ab02dba84 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -193,20 +193,36 @@ struct completion;
 struct pt_regs;
 struct user;
 
+/*
+ * cond_resched() and cond_resched_lock(): latency reduction via
+ * explicit rescheduling in places that are safe. The return
+ * value indicates whether a reschedule was done in fact.
+ * cond_resched_lock() will drop the spinlock before scheduling,
+ */
 #ifndef CONFIG_PREEMPTION
+extern int _cond_resched(void);
+#else
+static inline int _cond_resched(void) { return 0; }
+#endif
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 DECLARE_STATIC_KEY_TRUE(preempt_voluntary_key);
 #else
 DECLARE_STATIC_KEY_FALSE(preempt_voluntary_key);
 #endif
 
-extern int _cond_resched(void);
 # define might_resched() \
 	do { if (static_branch_likely(&preempt_voluntary_key)) _cond_resched(); } while (0)
 #else
+
+#ifdef CONFIG_PREEMPT_VOLUNTARY
 # define might_resched() \
-	do { } while (0)
+	do { _cond_resched(); } while (0)
+#else
+# define might_resched() do { } while (0)
 #endif
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void ___might_sleep(const char *file, int line, int preempt_offset);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..184b5e162184 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1812,18 +1812,6 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
 
-/*
- * cond_resched() and cond_resched_lock(): latency reduction via
- * explicit rescheduling in places that are safe. The return
- * value indicates whether a reschedule was done in fact.
- * cond_resched_lock() will drop the spinlock before scheduling,
- */
-#ifndef CONFIG_PREEMPTION
-extern int _cond_resched(void);
-#else
-static inline int _cond_resched(void) { return 0; }
-#endif
-
 #define cond_resched() ({			\
 	___might_sleep(__FILE__, __LINE__, 0);	\
 	_cond_resched();			\
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..a73b5564cc51 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -74,6 +74,25 @@ config PREEMPT_RT
 
 endchoice
 
+config PREEMPT_DYNAMIC
+	bool "Allow boot time preemption model selection"
+	depends on PREEMPT_NONE || PREEMPT_VOLUNTARY
+	help
+	  This option allows to define the preemption model on the kernel
+	  command line parameter and thus override the default preemption
+	  model defined during compile time.
+
+	  The feature is primarily interesting for Linux distributions which
+	  provide a pre-built kernel binary to reduce the number of kernel
+	  flavors they offer while still offering different usecases.
+
+	  The runtime overhead is negligible with JUMP_LABELS enabled but if
+	  runtime patching is not available for the specific architecture then
+	  the potential overhead should be considered.
+
+	  Select if you the same pre-built kernel should be used for both Server
+	  and Desktop workloads.
+
 config PREEMPT_COUNT
        bool
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 07d37d862637..fe22b2fca864 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -43,6 +43,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 DEFINE_STATIC_KEY_TRUE(preempt_voluntary_key);
 #else
@@ -51,6 +53,8 @@ DEFINE_STATIC_KEY_FALSE(preempt_voluntary_key);
 #endif
 EXPORT_SYMBOL(preempt_voluntary_key);
 
+#endif
+
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 /*
  * Debugging: various feature bits
@@ -8491,7 +8495,7 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
         trace_sched_update_nr_running_tp(rq, count);
 }
 
-#ifndef CONFIG_PREEMPTION
+#ifdef CONFIG_PREEMPT_DYNAMIC
 static int __init setup_non_preempt_mode(char *str)
 {
 	if (!strcmp(str, "none")) {
-- 
Michal Hocko
SUSE Labs
