Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E9296CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462275AbgJWKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462199AbgJWKZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03115C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NxCP0nGs+kPuLSUOy59iPOp4qNReH+RBMGCrj722TzY=; b=3YQjlwZq5qXcZI+rL17BVecLjr
        rcJjM+2ng772bWfelESqnAsQOUWI0k8MAUVVDg/oPCgAfiR22zgcYUHq+ua0HhDiI86dJO7TSA6Pn
        RMO6/HgyZM4Z0ac7l+6f2mCkecLFUIetlnGfRh+mqYaTt9qYkjiCmRFpDXLRTA95lKmbWjA8AnSeD
        9qHbFd3v0s3FLYGb/vc11FMHaQ40wPUT+xpMaPq6l6T7f+RwwOC86p/3g+LGoOFgMGF9pc+5CuQds
        StZhtTydwU5Y3/Z9FFz+2SkikHMCeD/OKfZ+HnzQgj1PGMCF+vVr6XzJx/2p2yPZxru8gP8mZa7Zo
        LOJxmzlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFp-0003BJ-Ec; Fri, 23 Oct 2020 10:25:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9101307865;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 677F129DDA661; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102347.190759694@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 12/19] sched,rt: Use cpumask_any*_distribute()
References: <20201023101158.088940906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a bunch of cpumask_any*() instances with
cpumask_any*_distribute(), by injecting this little bit of random in
cpu selection, we reduce the chance two competing balance operations
working off the same lowest_mask pick the same CPU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpumask.h |    6 ++++++
 kernel/sched/deadline.c |    6 +++---
 kernel/sched/rt.c       |    6 +++---
 lib/cpumask.c           |   18 ++++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -199,6 +199,11 @@ static inline int cpumask_any_and_distri
 	return cpumask_next_and(-1, src1p, src2p);
 }
 
+static inline int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	return cpumask_first(srcp);
+}
+
 #define for_each_cpu(cpu, mask)			\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
@@ -252,6 +257,7 @@ int cpumask_any_but(const struct cpumask
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
+int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1981,8 +1981,8 @@ static int find_later_rq(struct task_str
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(later_mask,
-							sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(later_mask,
+							      sched_domain_span(sd));
 			/*
 			 * Last chance: if a CPU being in both later_mask
 			 * and current sd span is valid, that becomes our
@@ -2004,7 +2004,7 @@ static int find_later_rq(struct task_str
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(later_mask);
+	cpu = cpumask_any_distribute(later_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1752,8 +1752,8 @@ static int find_lowest_rq(struct task_st
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(lowest_mask,
-						     sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(lowest_mask,
+							      sched_domain_span(sd));
 			if (best_cpu < nr_cpu_ids) {
 				rcu_read_unlock();
 				return best_cpu;
@@ -1770,7 +1770,7 @@ static int find_lowest_rq(struct task_st
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(lowest_mask);
+	cpu = cpumask_any_distribute(lowest_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -267,3 +267,21 @@ int cpumask_any_and_distribute(const str
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_and_distribute);
+
+int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	int next, prev;
+
+	/* NOTE: our first selection will skip 0. */
+	prev = __this_cpu_read(distribute_cpu_mask_prev);
+
+	next = cpumask_next(prev, srcp);
+	if (next >= nr_cpu_ids)
+		next = cpumask_first(srcp);
+
+	if (next < nr_cpu_ids)
+		__this_cpu_write(distribute_cpu_mask_prev, next);
+
+	return next;
+}
+EXPORT_SYMBOL(cpumask_any_distribute);


