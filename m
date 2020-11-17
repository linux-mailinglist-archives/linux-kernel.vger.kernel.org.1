Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6550F2B722A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgKQXUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgKQXUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:41 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:40 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id u4so22737150qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKR66i9OfhGkYfSJJgoQGocXvteuxaUKkU6YrqwaVm0=;
        b=toE1OMKIl7NrszcS1B1TenXmedMQpnL9Vg3GBAYy4tSkAqpYIVLIxVpnR395I6lilg
         uMfHO7RcijF3eiXBtJx0Nqh0Cf3OiiNCu2vhj/RQLth8L/S5FKmc5YopikqxnrMctwlj
         4T0Emu8FoOyevqjfZhyuMgQifdqzxRGA+8dEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKR66i9OfhGkYfSJJgoQGocXvteuxaUKkU6YrqwaVm0=;
        b=HaewbM4s4mSWU0hCF/tZqmhovi6s5KtrSARXJbDr+6wjAxo0iqmVv7QlRomz++Y2Fk
         I5e7C3lRM02QaOfjJeyEPWBXJf5bmC7rIL414aHl6VC9wRUpXW4nhs9g1KmVrgqWAs1n
         WMpiCrrNkWWfP5jVTl78zT7Kd53PXqZ8vMTSGXnpzlwotLD0GyGrIVb97/tM+BD3Sz4l
         Z2276FNlbW/9t8DaeiYcCoRiTo+4waBsqU4k4MP4+ijDEp2AUR1pwnoUgVndQ1Ni69yW
         5iKEIECiQjPcM/WUJ1a9c1764dYyzY8QNOqfQOLKZSn9l3pL8FRw8NrZX9dzdcP07IZA
         RfsQ==
X-Gm-Message-State: AOAM5314CsuZ2yzX+761BDu/iaChMUI3Xw8M8DByPpP52tpnPRJF3zgD
        I+Gx2Xyj7lOxPI+krPiFRa3uZA==
X-Google-Smtp-Source: ABdhPJypwCEfFGf60CftZvWn3cTNQIHYDoFTPRY+ojOemi7mMXY2+HNc2HVnJj+JI7smojMjFSWjNw==
X-Received: by 2002:a05:620a:1655:: with SMTP id c21mr2064329qko.127.1605655238962;
        Tue, 17 Nov 2020 15:20:38 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:38 -0800 (PST)
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
        "Paul E . McKenney" <paulmck@kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 13/32] sched: Trivial forced-newidle balancer
Date:   Tue, 17 Nov 2020 18:19:43 -0500
Message-Id: <20201117232003.3580179-14-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When a sibling is forced-idle to match the core-cookie; search for
matching tasks to fill the core.

rcu_read_unlock() can incur an infrequent deadlock in
sched_core_balance(). Fix this by using the RCU-sched flavor instead.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h |   1 +
 kernel/sched/core.c   | 130 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c   |   1 +
 kernel/sched/sched.h  |   6 ++
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 344499ab29f2..7efce9c9d9cf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -688,6 +688,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned int			core_occupation;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 12e8e6627ab3..3b373b592680 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -202,6 +202,21 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	return match;
 }
 
+static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+{
+	struct rb_node *node = &p->core_node;
+
+	node = rb_next(node);
+	if (!node)
+		return NULL;
+
+	p = container_of(node, struct task_struct, core_node);
+	if (p->core_cookie != cookie)
+		return NULL;
+
+	return p;
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -5134,8 +5149,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
+	int i, j, cpu, occ = 0;
 	bool need_sync;
-	int i, j, cpu;
 
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
@@ -5260,6 +5275,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			if (!p)
 				continue;
 
+			if (!is_task_rq_idle(p))
+				occ++;
+
 			rq_i->core_pick = p;
 
 			/*
@@ -5285,6 +5303,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				}
 			}
@@ -5324,6 +5343,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			rq_i->core->core_forceidle = true;
 		}
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
 			continue;
@@ -5353,6 +5374,113 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return next;
 }
 
+static bool try_steal_cookie(int this, int that)
+{
+	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
+	struct task_struct *p;
+	unsigned long cookie;
+	bool success = false;
+
+	local_irq_disable();
+	double_rq_lock(dst, src);
+
+	cookie = dst->core->core_cookie;
+	if (!cookie)
+		goto unlock;
+
+	if (dst->curr != dst->idle)
+		goto unlock;
+
+	p = sched_core_find(src, cookie);
+	if (p == src->idle)
+		goto unlock;
+
+	do {
+		if (p == src->core_pick || p == src->curr)
+			goto next;
+
+		if (!cpumask_test_cpu(this, &p->cpus_mask))
+			goto next;
+
+		if (p->core_occupation > dst->idle->core_occupation)
+			goto next;
+
+		p->on_rq = TASK_ON_RQ_MIGRATING;
+		deactivate_task(src, p, 0);
+		set_task_cpu(p, this);
+		activate_task(dst, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+
+		resched_curr(dst);
+
+		success = true;
+		break;
+
+next:
+		p = sched_core_next(p, cookie);
+	} while (p);
+
+unlock:
+	double_rq_unlock(dst, src);
+	local_irq_enable();
+
+	return success;
+}
+
+static bool steal_cookie_task(int cpu, struct sched_domain *sd)
+{
+	int i;
+
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+		if (i == cpu)
+			continue;
+
+		if (need_resched())
+			break;
+
+		if (try_steal_cookie(cpu, i))
+			return true;
+	}
+
+	return false;
+}
+
+static void sched_core_balance(struct rq *rq)
+{
+	struct sched_domain *sd;
+	int cpu = cpu_of(rq);
+
+	preempt_disable();
+	rcu_read_lock();
+	raw_spin_unlock_irq(rq_lockp(rq));
+	for_each_domain(cpu, sd) {
+		if (need_resched())
+			break;
+
+		if (steal_cookie_task(cpu, sd))
+			break;
+	}
+	raw_spin_lock_irq(rq_lockp(rq));
+	rcu_read_unlock();
+	preempt_enable();
+}
+
+static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+
+void queue_core_balance(struct rq *rq)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	if (!rq->core->core_cookie)
+		return;
+
+	if (!rq->nr_running) /* not forced idle */
+		return;
+
+	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
+}
+
 static inline void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 33864193a2f9..8bdb214eb78f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -404,6 +404,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	queue_core_balance(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d934cc51acf1..e72942a9ee11 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1135,6 +1135,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
 
+extern void queue_core_balance(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1147,6 +1149,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+static inline void queue_core_balance(struct rq *rq)
+{
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.29.2.299.gdc1121823c-goog

