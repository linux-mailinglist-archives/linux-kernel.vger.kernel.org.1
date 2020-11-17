Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01372B721B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgKQXUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgKQXUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:19 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FCCC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:19 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id b11so92983qvr.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdaoBnEfruRypGn9rkAtKhg3GZYtOZ2C1xPd0kz4UjA=;
        b=VdqNolZPsD4/hdlxOcxcE0KQ+WRxr7Mw2yQnJ5D6zslkZsLNc3H0501Bq3ZlYM/CMf
         Rm7J3scFh7LnNYvrIooQkKjZxuMNEQn0uPdKzewvHFcP3wC2py3xfF60Gir8teplAZnY
         OlvOHjiuOl6Z7yWbokqXEEqy018oeCxEv7M2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdaoBnEfruRypGn9rkAtKhg3GZYtOZ2C1xPd0kz4UjA=;
        b=ob0OEyccWpAbW2URfDdYIM5Ukn4Ry4tu8jN4nzdYWUgj12MID9NAGHgaCBtqcbKzTS
         LM9TUBrf17bLpOQ7tcEb2UlAjg72Y/o5Z0w1BV7y/jtZNgCyjZZ4dh2ulB1j/jlDJMCO
         Vm54UVzSk3eCWy5h+8xRzYsXDfcuRkJTbmfBAFYVwu8H7OMMURehdED6JCYzjf/mcMt/
         V0AC1aBmpJaiaslQ8e7jm2LP3Kxv/IwrFb+LYFam8I+AZb4Cek7VVmP2Fmm+sxjO17z4
         WIpK0q9ka+tCfD+MAHsRfzYHrMRzTPEOyVM6thZo0jmCOS8CIcqvZ5zGBln0yRWewn25
         qxVg==
X-Gm-Message-State: AOAM5335Fhll54SkVdf4JW2+tdAey1CkgwmOol2xNPqwp3ZXNKI7ScDr
        S5eKhaHoc1aooSpae/BlFK3iZg==
X-Google-Smtp-Source: ABdhPJx0IGkUMOlKZoYxYidRHDWVL3JhTn9A+rCfjsin5eqvVhK9GPdyh14mOY8VxX9mooTOlnNPyA==
X-Received: by 2002:ad4:4e13:: with SMTP id dl19mr2163193qvb.24.1605655218417;
        Tue, 17 Nov 2020 15:20:18 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:17 -0800 (PST)
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
Subject: [PATCH -tip 02/32] sched: Introduce sched_class::pick_task()
Date:   Tue, 17 Nov 2020 18:19:32 -0500
Message-Id: <20201117232003.3580179-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Because sched_class::pick_next_task() also implies
sched_class::set_next_task() (and possibly put_prev_task() and
newidle_balance) it is not state invariant. This makes it unsuitable
for remote task selection.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/deadline.c  | 16 ++++++++++++++--
 kernel/sched/fair.c      | 32 +++++++++++++++++++++++++++++++-
 kernel/sched/idle.c      |  8 ++++++++
 kernel/sched/rt.c        | 15 +++++++++++++--
 kernel/sched/sched.h     |  3 +++
 kernel/sched/stop_task.c | 14 ++++++++++++--
 6 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0f2ea0a3664c..abfc8b505d0d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1867,7 +1867,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *pick_next_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -1879,7 +1879,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 	p = dl_task_of(dl_se);
-	set_next_task_dl(rq, p, true);
+
+	return p;
+}
+
+static struct task_struct *pick_next_task_dl(struct rq *rq)
+{
+	struct task_struct *p;
+
+	p = pick_task_dl(rq);
+	if (p)
+		set_next_task_dl(rq, p, true);
+
 	return p;
 }
 
@@ -2551,6 +2562,7 @@ DEFINE_SCHED_CLASS(dl) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
+	.pick_task		= pick_task_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52ddfec7cea6..12cf068eeec8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4459,7 +4459,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
 	 */
-	if (cfs_rq->skip == se) {
+	if (cfs_rq->skip && cfs_rq->skip == se) {
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -7017,6 +7017,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		set_last_buddy(se);
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_fair(struct rq *rq)
+{
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	struct sched_entity *se;
+
+	if (!cfs_rq->nr_running)
+		return NULL;
+
+	do {
+		struct sched_entity *curr = cfs_rq->curr;
+
+		se = pick_next_entity(cfs_rq, NULL);
+
+		if (curr) {
+			if (se && curr->on_rq)
+				update_curr(cfs_rq);
+
+			if (!se || entity_before(curr, se))
+				se = curr;
+		}
+
+		cfs_rq = group_cfs_rq(se);
+	} while (cfs_rq);
+
+	return task_of(se);
+}
+#endif
+
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -11219,6 +11248,7 @@ DEFINE_SCHED_CLASS(fair) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
+	.pick_task		= pick_task_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 50e128b899c4..33864193a2f9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -406,6 +406,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	schedstat_inc(rq->sched_goidle);
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_idle(struct rq *rq)
+{
+	return rq->idle;
+}
+#endif
+
 struct task_struct *pick_next_task_idle(struct rq *rq)
 {
 	struct task_struct *next = rq->idle;
@@ -473,6 +480,7 @@ DEFINE_SCHED_CLASS(idle) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a6f9d132c24f..a0e245b0c4bd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1626,7 +1626,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_next_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 
@@ -1634,7 +1634,17 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
-	set_next_task_rt(rq, p, true);
+
+	return p;
+}
+
+static struct task_struct *pick_next_task_rt(struct rq *rq)
+{
+	struct task_struct *p = pick_task_rt(rq);
+
+	if (p)
+		set_next_task_rt(rq, p, true);
+
 	return p;
 }
 
@@ -2483,6 +2493,7 @@ DEFINE_SCHED_CLASS(rt) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
+	.pick_task		= pick_task_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f794c9337047..5a0dd2b312aa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1839,6 +1839,9 @@ struct sched_class {
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
+
+	struct task_struct * (*pick_task)(struct rq *rq);
+
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 55f39125c0e1..f988ebe3febb 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -34,15 +34,24 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_next_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;
 
-	set_next_task_stop(rq, rq->stop, true);
 	return rq->stop;
 }
 
+static struct task_struct *pick_next_task_stop(struct rq *rq)
+{
+	struct task_struct *p = pick_task_stop(rq);
+
+	if (p)
+		set_next_task_stop(rq, p, true);
+
+	return p;
+}
+
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -123,6 +132,7 @@ DEFINE_SCHED_CLASS(stop) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_stop,
+	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
-- 
2.29.2.299.gdc1121823c-goog

