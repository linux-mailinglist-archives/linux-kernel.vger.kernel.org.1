Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A26926D98F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIQKvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgIQKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:48:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:48:55 -0700 (PDT)
Message-Id: <20200917101624.615730057@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600339728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ix4b6DiojnK/zMBGTDqqJhtZZ2M5rZkiIeQjBFPLv24=;
        b=Syvj8SKxj16HQrMA9aJwfcY5l18Ktr+XfCR9HNVAoJr8g8suPWyBexceahkOcB4Ahh8axs
        GWwnEMYBr/6mXBb9b4cmQhWK2HuTtMEwJWDVAil5cesndToNJ0A0f06PxWIJmz2LkfWwzf
        PiFVli7LkEdUsu1MFCWRGbZodXmCkvjpERwXG4bvtnJNCQEAylBGMwhE4IIYxqsZZlA+8a
        hBkvprZZKvuJOj53UClY+mb3HqUMdRU2WSE4U14FmJTFB1tbcA7/d3JuB/KlkibgMb7H1u
        +mW4KIXznZSuLF/Hf8p01AEtrI+8fM5HC7B51jSF7BwkZ/1g3VsTPHII3sVSdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600339728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ix4b6DiojnK/zMBGTDqqJhtZZ2M5rZkiIeQjBFPLv24=;
        b=IIzcpGSp77btxGNAYRAuIwqZrYV9/s/T5Z0E6uEJEl+v/Z7JSTfllRGnZpYv9Ttsu6Vh5e
        wdIlOX1/aJ7W5nDQ==
Date:   Thu, 17 Sep 2020 11:42:09 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [patch 07/10] sched/core: Add mechanism to wait for affinity setting
 to complete
References: <20200917094202.301694311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT kernels allow to disable migration while being preemptible. Tasks which
have migration disabled cannot be moved to a different CPU when the
affinity mask is changed until they leave the migrate disabled section.

Add a mechanism to queue the migration request in the task and wait for it
to complete. The task will handle it when it leaves the migrate disabled
section.

This ensures that __set_cpus_allowed_ptr() is guaranteed to return only after
the new affinity mask has taken effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |   19 ++++++++++++
 kernel/sched/core.c   |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -629,8 +629,16 @@ struct wake_q_node {
 };
 
 #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
+struct task_migrate_data {
+	const cpumask_t		*mask;
+	struct completion	*done;
+	bool			check;
+	int			res;
+};
+
 struct task_migration_ctrl {
 	struct mutex			mutex;
+	struct task_migrate_data	*pending;
 	int				disable_cnt;
 };
 
@@ -638,8 +646,19 @@ struct task_migration_ctrl {
 {									\
 	.mutex = __MUTEX_INITIALIZER(init_task.migration_ctrl.mutex),	\
 }
+
+static inline int task_self_migrate_result(struct task_migrate_data *data)
+{
+	return data->res;
+}
+
 #else /* CONFIG_PREEMPT_RT && CONFIG_SMP */
+struct task_migrate_data { };
 struct task_migration_ctrl { };
+static inline int task_self_migrate_result(struct task_migrate_data *data)
+{
+	return -ENOSYS;
+}
 #endif /* !(CONFIG_PREEMPT_RT && CONFIG_SMP) */
 
 struct task_struct {
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -442,6 +442,70 @@ static inline void hrtick_rq_init(struct
 }
 #endif	/* CONFIG_SCHED_HRTICK */
 
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+static inline void task_lock_migration_ctrl(struct task_struct *p)
+{
+	mutex_lock(&p->migration_ctrl.mutex);
+}
+
+static inline void task_unlock_migration_ctrl(struct task_struct *p)
+{
+	mutex_unlock(&p->migration_ctrl.mutex);
+}
+
+/*
+ * If the affinity of a task should be set and the task is in a migrate
+ * disabled region then the operation has to wait until the task leaves the
+ * migrate disabled region and takes care of setting it's affinity on its
+ * own.
+ */
+static bool task_self_migration(struct task_struct *p,
+				const struct cpumask *new_mask, bool check,
+				struct rq *rq, struct rq_flags *rf,
+				struct task_migrate_data *data)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+
+	lockdep_assert_held(&p->migration_ctrl.mutex);
+	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(&p->pi_lock);
+
+	if (!p->migration_ctrl.disable_cnt)
+		return false;
+
+	BUG_ON(p == current);
+
+	/*
+	 * Store a pointer to migration data in the migration control
+	 * struct, which will be used by the task to set its own affinity
+	 * when it leaves the migrate disabled section. The result is
+	 * returned in @data::res.
+	 */
+	data->mask = new_mask;
+	data->check = check;
+	data->done = &done;
+	p->migration_ctrl.pending = data;
+
+	/* Get a reference on @p, drop the locks and wait for it to complete */
+	get_task_struct(p);
+	task_rq_unlock(rq, p, rf);
+	wait_for_completion(&done);
+	put_task_struct(p);
+	return true;
+}
+
+#else /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT) */
+static inline void task_lock_migration_ctrl(struct task_struct *p) { }
+static inline void task_unlock_migration_ctrl(struct task_struct *p) { }
+static bool task_self_migration(struct task_struct *p,
+				const struct cpumask *new_mask, bool check,
+				struct rq *rq, struct rq_flags *rf,
+				struct task_migrate_data *data)
+{
+	return false;
+}
+#endif /* !(defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)) */
+
 /*
  * cmpxchg based fetch_or, macro so it works for different integer types
  */
@@ -1947,17 +2011,29 @@ static int set_cpus_allowed_ptr_locked(s
 static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  const struct cpumask *new_mask, bool check)
 {
+	struct task_migrate_data sync_data;
 	struct rq_flags rf;
 	struct rq *rq;
 	int ret = 0;
 
+	/*
+	 * On RT kernels the affinity setting might be delayed if the task
+	 * is in a migrate disabled region. The request for changing the
+	 * affinity is queued in the target task which acts upon it when
+	 * leaving the migrate disabled sections. This requires
+	 * serialization to protect the relevant data structures.
+	 */
+	task_lock_migration_ctrl(p);
 	rq = task_rq_lock(p, &rf);
 
 	if (cpumask_equal(&p->cpus_mask, new_mask))
 		task_rq_unlock(rq, p, &rf);
+	else if (task_self_migration(p, new_mask, check, rq, &rf, &sync_data))
+		ret = task_self_migrate_result(&sync_data);
 	else
 		ret = set_cpus_allowed_ptr_locked(p, new_mask, check, rq, &rf);
 
+	task_unlock_migration_ctrl(p);
 	return ret;
 }
 

