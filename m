Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481D328391F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgJEPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgJEPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:10:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC40C0613AA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4hgDup+uLDAA6BxhPVYzQptfW5E+W82Xqngvc9Dnkyk=; b=bWtv1Fxb9a6l8BO7N5N+YW8Mit
        oZwzwmvkGufyWBNQE6mUGadyaPKPnv+YYI/lRnmNUIltLDdO9B+KiAKKYr0t6oA8j+An+1K8FRkHZ
        uTyLfRVSJZXYa/EKFOThg5bm8fazYSTF2rx67MVBSzijr4riHkWWaOotpqoZoG0/ar7JT9Mi3Eoes
        HipFpifzzDbPSXS4snxa31+G1ECP632iZGxh9oZh2+93bD160xfmk0OOAxkq6Mflj1r0oY8RdHuBJ
        HJgN95KpLTUJTbKvb7AydGR1LhD/281VXjfuMKnoWlNicV/cDS1z2vfP8eKTc0ujIUsjKbxB9PiE2
        EdYY6VHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPS7V-0000LR-L9; Mon, 05 Oct 2020 15:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 729903077E1;
        Mon,  5 Oct 2020 17:09:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EE92129A897BE; Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Message-ID: <20201005150922.254742096@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Oct 2020 16:57:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH -v2 13/17] sched,rt: Use the full cpumask for balancing
References: <20201005145717.346020688@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want migrate_disable() tasks to get PULLs in order for them to PUSH
away the higher priority task.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/cpudeadline.c |    4 ++--
 kernel/sched/cpupri.c      |    4 ++--
 kernel/sched/deadline.c    |    4 ++--
 kernel/sched/rt.c          |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -120,7 +120,7 @@ int cpudl_find(struct cpudl *cp, struct
 	const struct sched_dl_entity *dl_se = &p->dl;
 
 	if (later_mask &&
-	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
+	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_mask)) {
 		unsigned long cap, max_cap = 0;
 		int cpu, max_cpu = -1;
 
@@ -151,7 +151,7 @@ int cpudl_find(struct cpudl *cp, struct
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
-		if (cpumask_test_cpu(best_cpu, p->cpus_ptr) &&
+		if (cpumask_test_cpu(best_cpu, &p->cpus_mask) &&
 		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
 			if (later_mask)
 				cpumask_set_cpu(best_cpu, later_mask);
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -73,11 +73,11 @@ static inline int __cpupri_find(struct c
 	if (skip)
 		return 0;
 
-	if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
+	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
 		return 0;
 
 	if (lowest_mask) {
-		cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
+		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1888,7 +1888,7 @@ static void task_fork_dl(struct task_str
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 	return 0;
 }
@@ -2038,7 +2038,7 @@ static struct rq *find_lock_later_rq(str
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1658,7 +1658,7 @@ static void put_prev_task_rt(struct rq *
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 
 	return 0;
@@ -1811,7 +1811,7 @@ static struct rq *find_lock_lowest_rq(st
 			 * Also make sure that it wasn't scheduled on its rq.
 			 */
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {


