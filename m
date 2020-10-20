Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723E72932C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbgJTBn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390101AbgJTBnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:43:55 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBDC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:43:55 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j13so312149ilc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUW17JVqqm+GWrCumnYQ4KN5g+w4KdtULS2fvfyde9U=;
        b=DzA1l3Ni+oEQC5u5OwABsQXngtq0TOgDbah3xoijFnx3XuteXAS2a2xWwA0iqLY+k1
         5ltOfCufZ6P78+WGRxOsKwQqMVtW0vgtGrs/slPf9W4UeX77bZesHrNWdJrr18ycSKqF
         JEFGcvepIuGe567dol5uqicbssnbMvbACoHrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUW17JVqqm+GWrCumnYQ4KN5g+w4KdtULS2fvfyde9U=;
        b=nd43d7henoVc4Bq90Y9IG+BbDtD8lf9z/Rh9ld86Y2A0fw7yBOmXF4hkhujpfcWLwW
         89glDirXORbqQn/1oYgXCqqsL3LURVu5Qv71N1KzLpcNDrd6e70WlSfkGa2a8FePANnT
         u57zFUg4ehGTlrRfdVW/19w0i8IfXZe/AtELFbShK8RQj/BgBA/GpDO2WcjAo5kT/2NB
         krKn+KOUEdpMmb4T6/WLvtc1IhdKcwdGRrGrNU878jPQtSt3V22PUEarasPNtbZhPQE2
         eZE5eXe6lB4mtW7A+nkXzAXcQ8y3Tjfrt1a3LTrwXoH8fPmD3XgO9EJVjXAbplRfnD66
         E0wQ==
X-Gm-Message-State: AOAM531xkaZYkVOVlxb4JRrqVRY1lcuRx0WStbAtPWGBuu/aJwziOTjg
        ni+FgSe3fAg4nlwLq0KfMBH/1Q==
X-Google-Smtp-Source: ABdhPJw/gWRkQ8HYCw4WaXbP55i5uuAFuBUVjk24t26Q/FXnJnPkZY9hDFYFD30MgiYDT4tirHfrqA==
X-Received: by 2002:a92:c88e:: with SMTP id w14mr214154ilo.185.1603158234659;
        Mon, 19 Oct 2020 18:43:54 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:43:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 03/26] sched: Core-wide rq->lock
Date:   Mon, 19 Oct 2020 21:43:13 -0400
Message-Id: <20201020014336.2076526-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Introduce the basic infrastructure to have a core wide rq->lock.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---
 kernel/Kconfig.preempt |   6 +++
 kernel/sched/core.c    | 109 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |  31 ++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..4488fbf4d3a8 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -80,3 +80,9 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+
+config SCHED_CORE
+	bool "Core Scheduling for SMT"
+	default y
+	depends on SCHED_SMT
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 97181b3d12eb..cecbf91cb477 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -74,6 +74,70 @@ unsigned int sysctl_sched_rt_period = 1000000;
 
 __read_mostly int scheduler_running;
 
+#ifdef CONFIG_SCHED_CORE
+
+DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+/*
+ * The static-key + stop-machine variable are needed such that:
+ *
+ *	spin_lock(rq_lockp(rq));
+ *	...
+ *	spin_unlock(rq_lockp(rq));
+ *
+ * ends up locking and unlocking the _same_ lock, and all CPUs
+ * always agree on what rq has what lock.
+ *
+ * XXX entirely possible to selectively enable cores, don't bother for now.
+ */
+static int __sched_core_stopper(void *data)
+{
+	bool enabled = !!(unsigned long)data;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpu_rq(cpu)->core_enabled = enabled;
+
+	return 0;
+}
+
+static DEFINE_MUTEX(sched_core_mutex);
+static int sched_core_count;
+
+static void __sched_core_enable(void)
+{
+	// XXX verify there are no cookie tasks (yet)
+
+	static_branch_enable(&__sched_core_enabled);
+	stop_machine(__sched_core_stopper, (void *)true, NULL);
+}
+
+static void __sched_core_disable(void)
+{
+	// XXX verify there are no cookie tasks (left)
+
+	stop_machine(__sched_core_stopper, (void *)false, NULL);
+	static_branch_disable(&__sched_core_enabled);
+}
+
+void sched_core_get(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!sched_core_count++)
+		__sched_core_enable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+void sched_core_put(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!--sched_core_count)
+		__sched_core_disable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * part of the period that we allow rt tasks to run in us.
  * default: 0.95s
@@ -4363,6 +4427,43 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG();
 }
 
+#ifdef CONFIG_SCHED_CORE
+
+static inline void sched_core_cpu_starting(unsigned int cpu)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	struct rq *rq, *core_rq = NULL;
+	int i;
+
+	core_rq = cpu_rq(cpu)->core;
+
+	if (!core_rq) {
+		for_each_cpu(i, smt_mask) {
+			rq = cpu_rq(i);
+			if (rq->core && rq->core == rq)
+				core_rq = rq;
+			init_sched_core_irq_work(rq);
+		}
+
+		if (!core_rq)
+			core_rq = cpu_rq(cpu);
+
+		for_each_cpu(i, smt_mask) {
+			rq = cpu_rq(i);
+
+			WARN_ON_ONCE(rq->core && rq->core != core_rq);
+			rq->core = core_rq;
+		}
+	}
+
+	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
+}
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_cpu_starting(unsigned int cpu) {}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6963,6 +7064,9 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
+
+	sched_core_cpu_starting(cpu);
+
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -7193,6 +7297,11 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+
+#ifdef CONFIG_SCHED_CORE
+		rq->core = NULL;
+		rq->core_enabled = 0;
+#endif
 	}
 
 	set_load_weight(&init_task, false);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 54bfac702805..85c8472b5d00 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1048,6 +1048,12 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#ifdef CONFIG_SCHED_CORE
+	/* per rq */
+	struct rq		*core;
+	unsigned int		core_enabled;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1075,11 +1081,36 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#ifdef CONFIG_SCHED_CORE
+DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
+}
+
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	if (sched_core_enabled(rq))
+		return &rq->core->__lock;
+
+	return &rq->__lock;
+}
+
+#else /* !CONFIG_SCHED_CORE */
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return false;
+}
+
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
 }
 
+#endif /* CONFIG_SCHED_CORE */
+
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

