Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5679B283914
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgJEPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJEPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:09:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F19DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Islad3Fb7ezLfWZo0We1gmwlRXZvsAvxygXzRD8A0sc=; b=gMcUiiqhR1ebhkCdPr6ERHmewv
        FmhZurA/eZqjwpKcgb2yxFB/SGQyNMFiO53f0L2jgBWqVlZ2N4YTjXBPhUP8RVKbkh5dhVpgictCe
        qCmxcn/b3tQMWwkBfZIN10xGoch4ceH0gYP5ZwHfu+fZdml3fbgx11FXYXuVS3q4+7D9/H51fSRDo
        3xfgzIKDAUiht6vLzfbm1XifAGwMIQ9J2lSxQbgtKgAqKewNNqEipfS8vUW0w9T2jha64GG0P4DFX
        mTmqoA8wf/aG0wwTwCm0r5n//csLJ9zWckJtAmsGA7evpSsEDacNpRjNQ28rTtfNEg7eH3VIzzNLn
        A7Xzun7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPS7V-0008P8-G6; Mon, 05 Oct 2020 15:09:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 607F7306102;
        Mon,  5 Oct 2020 17:09:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D5DB229A897B8; Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Message-ID: <20201005150921.661842442@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Oct 2020 16:57:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH -v2 07/17] sched: Fix hotplug vs CPU bandwidth control
References: <20201005145717.346020688@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now migrate tasks away before DYING, we should also move
bandwidth unthrottle, otherwise we can gain tasks from unthrottle
after we expect all tasks to be gone already.

Also; it looks like the RT balancers don't respect cpu_active() and
instead rely on rq->online in part, complete this. This too requires
we do set_rq_offline() earlier to match the cpu_active() semantics.
(The bigger patch is to convert RT to cpu_active() entirely)

Since set_rq_online() is called from sched_cpu_activate(), place
set_rq_offline() in sched_cpu_deactivate().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |   14 ++++++++++----
 kernel/sched/deadline.c |    5 +----
 kernel/sched/rt.c       |    5 +----
 3 files changed, 12 insertions(+), 12 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6979,6 +6979,8 @@ int sched_cpu_activate(unsigned int cpu)
 
 int sched_cpu_deactivate(unsigned int cpu)
 {
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
 	int ret;
 
 	set_cpu_active(cpu, false);
@@ -6993,6 +6995,14 @@ int sched_cpu_deactivate(unsigned int cp
 
 	balance_push_set(cpu, true);
 
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		update_rq_clock();
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_offline(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -7074,10 +7084,6 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
-	}
 	BUG_ON(rq->nr_running != 1);
 	rq_unlock_irqrestore(rq, &rf);
 
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -543,7 +543,7 @@ static int push_dl_task(struct rq *rq);
 
 static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
 {
-	return dl_task(prev);
+	return rq->online && dl_task(prev);
 }
 
 static DEFINE_PER_CPU(struct callback_head, dl_push_head);
@@ -2326,9 +2326,6 @@ static void rq_online_dl(struct rq *rq)
 /* Assumes rq->lock is held */
 static void rq_offline_dl(struct rq *rq)
 {
-	if (rq->dl.overloaded)
-		dl_clear_overload(rq);
-
 	cpudl_clear(&rq->rd->cpudl, rq->cpu);
 	cpudl_clear_freecpu(&rq->rd->cpudl, rq->cpu);
 }
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -265,7 +265,7 @@ static void pull_rt_task(struct rq *this
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
-	return rq->rt.highest_prio.curr > prev->prio;
+	return rq->online && rq->rt.highest_prio.curr > prev->prio;
 }
 
 static inline int rt_overloaded(struct rq *rq)
@@ -2245,9 +2245,6 @@ static void rq_online_rt(struct rq *rq)
 /* Assumes rq->lock is held */
 static void rq_offline_rt(struct rq *rq)
 {
-	if (rq->rt.overloaded)
-		rt_clear_overload(rq);
-
 	__disable_runtime(rq);
 
 	cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_INVALID);


