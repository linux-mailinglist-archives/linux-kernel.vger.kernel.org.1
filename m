Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4FA26D9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIQKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgIQKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:48:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DECC061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:48:55 -0700 (PDT)
Message-Id: <20200917101624.708629719@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600339729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mmv89QXjj7U3XRxgS9HSrVCslkQtfKsfeulro/mY7tE=;
        b=IZVKxfNwWdfbBCaZhVfLaWL9NHZy+20RDAXpTMcts2DrQV3xMh4K5oW6Xp3D+zPGWwKtRC
        IXZCjskI/UskmjLIWwfKAskwa1Hsm5PNGxzPNhzHOBdgMX4U0t+6UEXykyyw5j3gYUiH6R
        gDnKzlsFZfLrPq8DeN3/kQlo9ma+PMqCc2cmST5bA997wf/wLh4McYsJvnrLHRrAnHLxb8
        bhKpnjsqv609mbUsdyxMTsXGU7VjSQMc+LuzOxFhM+zMUu6BvldeL1Og7lI+JKi/JFJ/Ew
        i7GBHaIwEIs4rK0utq09+1Wsr6lQ8dX0NNFy1pFGuU41r5S8qUwh1G1C2U6l5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600339729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mmv89QXjj7U3XRxgS9HSrVCslkQtfKsfeulro/mY7tE=;
        b=hoDZxpIhRGTQuSkJAhV+24szpe3y9piOcxuV+GeeRtj/qPMJoO6vwIH2KcTB68cXeObPHB
        px8jd05XXge/lEDQ==
Date:   Thu, 17 Sep 2020 11:42:10 +0200
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
Subject: [patch 08/10] sched: Add update_migratory() callback to scheduler classes
References: <20200917094202.301694311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a mechanism to update the number or migratory tasks in the RT and
deadline scheduler classes.

This will be used by the upcoming migrate_disable/enable() functionality on
RT kernels.

Originally-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/deadline.c |   10 ++++++++++
 kernel/sched/rt.c       |   10 ++++++++++
 kernel/sched/sched.h    |    4 ++++
 3 files changed, 24 insertions(+)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -479,6 +479,13 @@ static void dec_dl_migration(struct sche
 	update_dl_migration(dl_rq);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static void update_migratory_dl(struct task_struct *p, long delta)
+{
+	task_rq(p)->dl.dl_nr_migratory += delta;
+}
+#endif
+
 /*
  * The list of pushable -deadline task is not a plist, like in
  * sched_rt.c, it is an rb-tree with tasks ordered by deadline.
@@ -2499,6 +2506,9 @@ const struct sched_class dl_sched_class
 	.rq_online              = rq_online_dl,
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
+#ifdef CONFIG_PREEMPT_RT
+	.update_migratory	= update_migratory_dl,
+#endif
 #endif
 
 	.task_tick		= task_tick_dl,
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2272,6 +2272,13 @@ static void switched_from_rt(struct rq *
 	rt_queue_pull_task(rq);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static void update_migratory_rt(struct task_struct *p, long delta)
+{
+	task_rq(p)->rt.rt_nr_migratory += delta;
+}
+#endif
+
 void __init init_sched_rt_class(void)
 {
 	unsigned int i;
@@ -2449,6 +2456,9 @@ const struct sched_class rt_sched_class
 	.rq_offline             = rq_offline_rt,
 	.task_woken		= task_woken_rt,
 	.switched_from		= switched_from_rt,
+#ifdef CONFIG_PREEMPT_RT
+	.update_migratory	= update_migratory_rt,
+#endif
 #endif
 
 	.task_tick		= task_tick_rt,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1808,6 +1808,10 @@ struct sched_class {
 	void (*set_cpus_allowed)(struct task_struct *p,
 				 const struct cpumask *newmask);
 
+#ifdef CONFIG_PREEMPT_RT
+	void (*update_migratory)(struct task_struct *p, long delta);
+#endif
+
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
 #endif

