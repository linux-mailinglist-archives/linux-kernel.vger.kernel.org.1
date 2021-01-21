Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D02FE7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbhAUKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbhAUKh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:37:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F466C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=E5rYwyH9S5cfjdzfPwp0XjIbStHt6vYMSRi8RgFNeA0=; b=ddmgPWXXizX9+bs6/OMCsHBHFa
        eN+iV4xYXwfs2ue9gUu0TUefgPxI4wGIFkaQUUx/OFhNsgsWqui4lmnyIPx3Z0zMnT+HNsWtHRcq/
        zKYteKvESwdcVH6kGhXOB4/a0seshtyHDEtRPJKC+/kWyZSgJp7Gce0ariHX1SCBAZnvX43S3FsAz
        wequeHM+59aAbAeZl+w0bLdcV0K6AVSzpK5CzCNpANYWYY0ncHhI83YuN+b7TzRM33965zabhNP29
        WMWizj6KoKK5w1bKlpXVWmbCCNYn3U8PwJ6GFRRKWT07VYJ5qk22hyPlvOY8TQt0DBY59XWN0aWrV
        VgQHS3xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2XKM-0007O9-3H; Thu, 21 Jan 2021 10:36:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E2DE3070F9;
        Thu, 21 Jan 2021 11:36:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7EE0220C86817; Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Message-ID: <20210121103507.240724591@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Jan 2021 11:17:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH -v3 9/9] sched: Relax the set_cpus_allowed_ptr() semantics
References: <20210121101702.402798862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have KTHREAD_IS_PER_CPU to denote the critical per-cpu
tasks to retain during CPU offline, we can relax the warning in
set_cpus_allowed_ptr(). Any spurious kthread that wants to get on at
the last minute will get pushed off before it can run.

While during CPU online there is no harm, and actual benefit, to
allowing kthreads back on early, it simplifies hotplug code and fixes
a number of outstanding races.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lai jiangshan <jiangshanlai@gmail.com>
---
 kernel/sched/core.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2342,7 +2342,9 @@ static int __set_cpus_allowed_ptr(struct
 
 	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
 		/*
-		 * Kernel threads are allowed on online && !active CPUs.
+		 * Kernel threads are allowed on online && !active CPUs,
+		 * however, during cpu-hot-unplug, even these might get pushed
+		 * away if not KTHREAD_IS_PER_CPU.
 		 *
 		 * Specifically, migration_disabled() tasks must not fail the
 		 * cpumask_any_and_distribute() pick below, esp. so on
@@ -2386,16 +2388,6 @@ static int __set_cpus_allowed_ptr(struct
 
 	__do_set_cpus_allowed(p, new_mask, flags);
 
-	if (p->flags & PF_KTHREAD) {
-		/*
-		 * For kernel threads that do indeed end up on online &&
-		 * !active we want to ensure they are strict per-CPU threads.
-		 */
-		WARN_ON(cpumask_intersects(new_mask, cpu_online_mask) &&
-			!cpumask_intersects(new_mask, cpu_active_mask) &&
-			p->nr_cpus_allowed != 1);
-	}
-
 	return affine_move_task(rq, p, &rf, dest_cpu, flags);
 
 out:
@@ -7518,6 +7510,13 @@ int sched_cpu_deactivate(unsigned int cp
 	int ret;
 
 	set_cpu_active(cpu, false);
+
+	/*
+	 * From this point forward, this CPU will refuse to run any task that
+	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
+	 * push those tasks away until this gets cleared, see
+	 * sched_cpu_dying().
+	 */
 	balance_push_set(cpu, true);
 
 	/*


