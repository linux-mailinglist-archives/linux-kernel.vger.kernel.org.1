Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D628F0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbgJOLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgJOLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:10:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D82C0613DC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=o4opdKENuLgTNdnE27byzUzkmgr/fIhkR2CPuwh+4/g=; b=lTjCJkNQ2QPX33r//NzwgvS4cn
        sohv5BohOY5X4HR0pQJAvozkh6e5VrmYGunNUv5+VLPdPRBY4IdxzaBfvG27G62jLKAvTnpYyGzzk
        a7Smx3XkMl5WSH+d6LKVCbEj1PYB5fTv/uuuV9qAacbTpBJhvzw72FplEzNk5m8d6g2ULfrvCa5l7
        Xz1TNIVV1M1i7CrJ77kKhsgxAY6JunnMsrN+K/xruqiW5K0ekw42ReUJ2KMsmBv4wdPQDL8S/facJ
        ySo03jBSao2pljNOnRTDIiZJEMWJ153EOiVKSax70+NN5jlg32v+wqGAcp8bwOUcuAOyqpN6ySYIA
        93+Q/6Ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT18e-0002Oa-N0; Thu, 15 Oct 2020 11:09:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F764307976;
        Thu, 15 Oct 2020 13:09:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B9D06235F4456; Thu, 15 Oct 2020 13:09:36 +0200 (CEST)
Message-ID: <20201015110924.459860506@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Oct 2020 13:05:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v3 19/19] sched: Comment affine_move_task()
References: <20201015110532.738127234@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>


Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201013140116.26651-2-valentin.schneider@arm.com
---
 kernel/sched/core.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2028,7 +2028,75 @@ struct set_affinity_pending {
 };
 
 /*
- * This function is wildly self concurrent, consider at least 3 times.
+ * This function is wildly self concurrent; here be dragons.
+ *
+ *
+ * When given a valid mask, __set_cpus_allowed_ptr() must block until the
+ * designated task is enqueued on an allowed CPU. If that task is currently
+ * running, we have to kick it out using the CPU stopper.
+ *
+ * Migrate-Disable comes along and tramples all over our nice sandcastle.
+ * Consider:
+ *
+ *     Initial conditions: P0->cpus_mask = [0, 1]
+ *
+ *     P0@CPU0                  P1
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                              set_cpus_allowed_ptr(P0, [1]);
+ *
+ * P1 *cannot* return from this set_cpus_allowed_ptr() call until P0 executes
+ * its outermost migrate_enable() (i.e. it exits its Migrate-Disable region).
+ * This means we need the following scheme:
+ *
+ *     P0@CPU0                  P1
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                              set_cpus_allowed_ptr(P0, [1]);
+ *                                <blocks>
+ *     <resumes>
+ *     migrate_enable();
+ *       __set_cpus_allowed_ptr();
+ *       <wakes local stopper>
+ *                         `--> <woken on migration completion>
+ *
+ * Now the fun stuff: there may be several P1-like tasks, i.e. multiple
+ * concurrent set_cpus_allowed_ptr(P0, [*]) calls. CPU affinity changes of any
+ * task p are serialized by p->pi_lock, which we can leverage: the one that
+ * should come into effect at the end of the Migrate-Disable region is the last
+ * one. This means we only need to track a single cpumask (i.e. p->cpus_mask),
+ * but we still need to properly signal those waiting tasks at the appropriate
+ * moment.
+ *
+ * This is implemented using struct set_affinity_pending. The first
+ * __set_cpus_allowed_ptr() caller within a given Migrate-Disable region will
+ * setup an instance of that struct and install it on the targeted task_struct.
+ * Any and all further callers will reuse that instance. Those then wait for
+ * a completion signaled at the tail of the CPU stopper callback (1), triggered
+ * on the end of the Migrate-Disable region (i.e. outermost migrate_enable()).
+ *
+ *
+ * (1) In the cases covered above. There is one more where the completion is
+ * signaled within affine_move_task() itself: when a subsequent affinity request
+ * cancels the need for an active migration. Consider:
+ *
+ *     Initial conditions: P0->cpus_mask = [0, 1]
+ *
+ *     P0@CPU0            P1                             P2
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                        set_cpus_allowed_ptr(P0, [1]);
+ *                          <blocks>
+ *                                                       set_cpus_allowed_ptr(P0, [0, 1]);
+ *                                                         <signal completion>
+ *                          <awakes>
+ *
+ * Note that the above is safe vs a concurrent migrate_enable(), as any
+ * pending affinity completion is preceded an uninstallion of
+ * p->migration_pending done with p->pi_lock held.
  */
 static int affine_move_task(struct rq *rq, struct rq_flags *rf,
 			    struct task_struct *p, int dest_cpu, unsigned int flags)
@@ -2071,6 +2139,7 @@ static int affine_move_task(struct rq *r
 	if (!(flags & SCA_MIGRATE_ENABLE)) {
 		/* serialized by p->pi_lock */
 		if (!p->migration_pending) {
+			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
 			p->migration_pending = &my_pending;
@@ -2109,7 +2178,11 @@ static int affine_move_task(struct rq *r
 	}
 
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
-
+		/*
+		 * Lessen races (and headaches) by delegating
+		 * is_migration_disabled(p) checks to the stopper, which will
+		 * run on the same CPU as said p.
+		 */
 		task_rq_unlock(rq, p, rf);
 		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
 
@@ -2134,6 +2207,10 @@ static int affine_move_task(struct rq *r
 	if (refcount_dec_and_test(&pending->refs))
 		wake_up_var(&pending->refs);
 
+	/*
+	 * Block the original owner of &pending until all subsequent callers
+	 * have seen the completion and decremented the refcount
+	 */
 	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
 
 	return 0;


