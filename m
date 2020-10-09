Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439E42888B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbgJIMaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:30:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38803 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733135AbgJIMaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:30:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id i5so9157027edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHteoUCMUy9dURwIJhXmkUjIKQju9wQs+T3JT8G0LOU=;
        b=j4Z4JHlqTM+EBaegYNPrtwACidKc8YC8NIa7wzlAK4dp4eZDjLQz1sVmAWYtGyLzw0
         NGYJMY4S40D++gV/vepAS+3BbiPeQShGW2+EmAT9Ghs08sn2Y++tt9J0/dcwIRqhrKRi
         ksUxMQ3Bez2G95R4VxkFbUNr+UbMMECYc9qxO2akMGksNBtARaPHEhoyrWwZ6uOhhGym
         hGU4qbFjwcpcEJI5kFmbTipXgewczT/ix2vIyBisdIBe6UGUdBro8aK02NEfJrJ/0gt8
         5JLbooi+XXAgZJ11t9NbDv33OJk+zb8EebGNSRuUmixoCRp6OuARfi9C1sjWdmTBurfd
         vxBg==
X-Gm-Message-State: AOAM533WxKZLQ+lm50ObZohAWWefXvcoCcK7CGMbkm/7IDxqB5fsC+wd
        LwmpeFOD+h4T944iwfw7/uI=
X-Google-Smtp-Source: ABdhPJyZTxRDOzzf2ISTtIwgkE59p11ntKaE2EtWV4Bs8b/R/lArHUiNQwxhHe3nNnjaci0/ze21ig==
X-Received: by 2002:a05:6402:31bc:: with SMTP id dj28mr14482397edb.10.1602246600494;
        Fri, 09 Oct 2020 05:30:00 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-85-160-42-169.eurotel.cz. [85.160.42.169])
        by smtp.gmail.com with ESMTPSA id q27sm6412701ejd.74.2020.10.09.05.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:30:00 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH v2 4/5] kernel: introduce CONFIG_PREEMPT_DYNAMIC
Date:   Fri,  9 Oct 2020 14:29:25 +0200
Message-Id: <20201009122926.29962-5-mhocko@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009122926.29962-1-mhocko@kernel.org>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009122926.29962-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Boot time preemption mode selection is currently hardcoded for
!CONFIG_PREEMPTION. Peter has suggested to introduce a dedicated
option for the functionality because not each archiveture implements
implements static branches (jump labels) effectively and therefore
an additional overhead might be prohibitive or undesirable.

Introduce CONFIG_PREEMPT_DYNAMIC that allows boot time preemption mode
override. The functionality is currently implemented for PREEMPT_NONE
and PREEMPT_VOLUNTARY preemption modes.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/kernel.h | 20 ++++++++++++++++++--
 include/linux/sched.h  | 12 ------------
 kernel/Kconfig.preempt | 19 +++++++++++++++++++
 kernel/sched/core.c    |  6 +++++-
 4 files changed, 42 insertions(+), 15 deletions(-)

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
index c460a9a2373b..e142f36dd429 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -73,6 +73,25 @@ config PREEMPT_RT
 
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
2.28.0

