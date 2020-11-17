Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACCD2B721D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKQXUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgKQXUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:23 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4148C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:22 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d9so22763026qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GY50eE+jIWpyZRNu0SodzqvctD+qAM2lQaMY0AdZd8E=;
        b=VSt5hplsCmgExOP7Mt2V5khmmkVbR4ks/nMddI7eICkQ5lr5EMrDjUcQmeJXIamxrS
         0qTmgh2myhXFcykoShv8TV8N7dr8tOKKN7Y1zoeenI+T2RzrxMeWIoN49BEXRgMDhdBm
         +OwQWP8lzoUy4j23MhaKz13omFlkixiZ4Kuh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GY50eE+jIWpyZRNu0SodzqvctD+qAM2lQaMY0AdZd8E=;
        b=WmmvrEiT3xgdW0v3cEVySWOhOWuAy1aXAi1FAA8pEXxOcXaSvQWMwB6WZ3Z2EYK2g7
         Ry7bnDRKUCsEcBopmlWYywm3cnqrAWcpGx70d4KF53xD96hNZrQOcFwNpUQr5F4Q9c5d
         89Jz34SCGFTzMkOh3w3+av8CCGB9jqwWl2+41PrGKed91iRIZSKrGZ2DjAlL+QICi8/d
         7FTTiWS1YJRhukWq5W/Wc9i/airg7F8wURa1FHb4ofaoLFvsER9r4q7jQbRzU2j4qn5C
         4xVQJItjMSvmu1gMNd0JYR1yYu8pmlXjX1QiEHz+qfWXXhJ/kL8aIiyAR5ioYOniGN+y
         0tRg==
X-Gm-Message-State: AOAM533W+YVF4JiHrb0qdbLuuivRQt4vt16tJTGqpR+nrePzt/lbmlCF
        xerF7in8cglApM3L8sYu3ADnxA==
X-Google-Smtp-Source: ABdhPJztHpJ5jsdrk+VNTTh7ryi6DjCVo0ZhwBQL7Sxakszy0vI6ANqPONdfNxtmmuZIWIkfPQW7BA==
X-Received: by 2002:ae9:ebd3:: with SMTP id b202mr2149743qkg.26.1605655222118;
        Tue, 17 Nov 2020 15:20:22 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:21 -0800 (PST)
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 04/32] sched: Core-wide rq->lock
Date:   Tue, 17 Nov 2020 18:19:34 -0500
Message-Id: <20201117232003.3580179-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
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
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/Kconfig.preempt |   5 ++
 kernel/sched/core.c    | 108 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |  31 ++++++++++++
 3 files changed, 144 insertions(+)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..6d8be4630bd6 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -80,3 +80,8 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+
+config SCHED_CORE
+	bool "Core Scheduling for SMT"
+	default y
+	depends on SCHED_SMT
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db5cc05a68bc..6d88bc9a6818 100644
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
@@ -4859,6 +4923,42 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -7484,6 +7584,9 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
+
+	sched_core_cpu_starting(cpu);
+
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -7747,6 +7850,11 @@ void __init sched_init(void)
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
index 5a0dd2b312aa..0dfccf988998 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1061,6 +1061,12 @@ struct rq {
 #endif
 	unsigned int		push_busy;
 	struct cpu_stop_work	push_work;
+
+#ifdef CONFIG_SCHED_CORE
+	/* per rq */
+	struct rq		*core;
+	unsigned int		core_enabled;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1099,11 +1105,36 @@ static inline bool is_migration_disabled(struct task_struct *p)
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
2.29.2.299.gdc1121823c-goog

