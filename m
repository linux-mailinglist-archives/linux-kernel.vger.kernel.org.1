Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E92F3340
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbhALOwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhALOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:52:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD6EC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yTCwTC1bCMbOusv231NnACqn29dKdvj5DWvPJoA/jVE=; b=obWb/l/ORT6h0rigXc3c7dklUR
        1FA8iIVIsvgWqNpkj2HEEotdn5ZaBsUvES3cyq6TNsH1Hmdg5JlIKHrLdm86IW8hgAHQMkTu46u8w
        neS1SnIHEGmkL208ohQ93mTo4pPWD+f7yuNebDH0HKOibYggF4CSvCE0gA8LrypArUHF/5YG+yrQG
        8eXPemeGsVSrEr1rGL5UBq5Wg9MV1ucNyZ/BPSPTALf3tFqj+7ln4G1DTqbJQKsfBBZnyf/YpV0iu
        h8nQkIIcO65atxHuJgrJjM0RFTfMth46iURkDKe9hXt+syhG5UI33ZA5m0ilm52ozmdLmwRx1g2G0
        Q1aqX8aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzL1I-0000cc-Gq; Tue, 12 Jan 2021 14:51:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDC4D306099;
        Tue, 12 Jan 2021 15:51:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B7A0E20C228DA; Tue, 12 Jan 2021 15:51:38 +0100 (CET)
Message-ID: <20210112144843.910110658@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jan 2021 15:43:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 4/4] sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
References: <20210112144344.850850975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 1cf12e08bc4d ("sched/hotplug: Consolidate task
migration on CPU unplug") we'd leave any task on the dying CPU and
break affinity and force them off at the very end.

This scheme had to change in order to enable migrate_disable(). One
cannot wait for migrate_disable() to complete while stuck in
stop_machine(). Furthermore, since we need at the very least: idle,
hotplug and stop threads at any point before stop_machine, we can't
break affinity and/or push those away.

Under the assumption that all per-cpu kthreads are sanely handled by
CPU hotplug, the new code no long breaks affinity or migrates any of
them (which then includes the critical ones above).

However, there's an important difference between per-cpu kthreads and
kthreads that happen to have a single CPU affinity which is lost. The
latter class very much relies on the forced affinity breaking and
migration semantics previously provided.

Use the new kthread_is_per_cpu() infrastructure to tighten
is_per_cpu_kthread() and fix the hot-unplug problems stemming from the
change.

Fixes: 1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c  |    8 +++++++-
 kernel/sched/sched.h |   12 ++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7276,8 +7276,14 @@ static void balance_push(struct rq *rq)
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
+	 *
+	 * XXX: the idle task does not match is_per_cpu_kthread() due to
+	 * histerical raisins.
 	 */
-	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
+	if (rq->idle == push_task ||
+	    is_per_cpu_kthread(push_task) ||
+	    is_migration_disabled(push_task)) {
+
 		/*
 		 * If this is the idle task on the outgoing CPU try to wake
 		 * up the hotplug control thread which might wait for the
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2692,15 +2692,23 @@ static inline void membarrier_switch_mm(
 #endif
 
 #ifdef CONFIG_SMP
+/*
+ * Match geniune per-cpu kthreads; threads that are bound to a single CPU for
+ * correctness, not kernel threads that happen to have a single CPU affinity.
+ *
+ * Such threads will have PF_NO_SETAFFINITY to ensure userspace cannot
+ * accidentally place them elsewhere -- this also filters out 'early' kthreads
+ * that have PF_KTHREAD set but do not have a struct kthread.
+ */
 static inline bool is_per_cpu_kthread(struct task_struct *p)
 {
 	if (!(p->flags & PF_KTHREAD))
 		return false;
 
-	if (p->nr_cpus_allowed != 1)
+	if (!(p->flags & PF_NO_SETAFFINITY))
 		return false;
 
-	return true;
+	return kthread_is_per_cpu(p);
 }
 #endif
 


