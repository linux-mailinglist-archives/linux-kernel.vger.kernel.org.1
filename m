Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977552D9555
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgLNJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbgLNJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:32:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF26C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LLjpPd6DbjQhi11KMqanvHxJwhSj0mosnlEjJVAXgGw=; b=HhXgu5VLoSKCxRRWRjLe5ukKWJ
        EJdxvfJIOSGLjJuWRWWGe+iosGwYxqnyXDSpU5S7NrYg/kLgfltzyFNkiaF57tmAamhFmxYgoqDhG
        QY+6qW+P7TLBpXSIjOKpAMa+SW/+JxpbZmNRVHRlKVh5v7AoH2eDj/9Qm9LNZhFZRYAiuqzfnmJ2j
        XveNQKeThkYwqGSa8Rapfb05BN9XZ29jYX+wjDAFs8q0CpKwxBanv0uw29TnHhQlylgTZfuQl41sM
        3RfPd3rM2gfMiy0Ys12GKzn4x7YZxlVcLojr04IvgloqlFy+D0IN/n+wwaPnSnT4Eg/JHkkAPF0jl
        zVhBOf1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kokCU-0005g4-8i; Mon, 14 Dec 2020 09:31:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2B233059C6;
        Mon, 14 Dec 2020 10:31:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77CE3200CFB30; Mon, 14 Dec 2020 10:31:22 +0100 (CET)
Date:   Mon, 14 Dec 2020 10:31:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201214093122.GX3040@hirez.programming.kicks-ass.net>
References: <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
 <20201211174442.GU3040@hirez.programming.kicks-ass.net>
 <20201211204337.GX3371@techsingularity.net>
 <20201211221905.GV3040@hirez.programming.kicks-ass.net>
 <20201211225002.GY3371@techsingularity.net>
 <CAKfTPtDBX+scBZiYtDSkXYn7SKDoGYWJiMpCiUvdW1XFz-Fb-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDBX+scBZiYtDSkXYn7SKDoGYWJiMpCiUvdW1XFz-Fb-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 09:11:29AM +0100, Vincent Guittot wrote:
> On Fri, 11 Dec 2020 at 23:50, Mel Gorman <mgorman@techsingularity.net> wrote:

> > I originally did something like that on purpose too but Vincent called
> > it out so it is worth mentioning now to avoid surprises. That said, I'm
> > at the point where anything SIS-related simply needs excessive exposure
> > because no matter what it does, someone is unhappy with it.
> 
> Yeah, I don't like extending the idle core search loop for something
> that is not related to the idle core search. This adds more work out
> of  control of the sis_prop. So I'm still against hiding some idle cpu
> search in idle core search.

The idea, of course, is to do less. The current code is pretty crap in
that it will do a whole bunch of things multiple times.

Also, a possible follow up, would be something like the below (and
remove all the sds->has_idle_cores crud), which brings core scanning
under SIS_PROP.

But it all needs lots of benchmarking :/

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6095,6 +6095,9 @@ static inline bool test_idle_cores(int c
 
 static inline int __select_idle_core(int core, struct cpumask *cpus, int *idle_cpu)
 {
+	if (idle_cpu && (available_idle_cpu(core) || sched_idle_cpu(cpu))
+		*idle_cpu = core;
+
 	return -1;
 }
 
@@ -6109,7 +6112,6 @@ static int select_idle_cpu(struct task_s
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int this = smp_processor_id();
-	bool smt = test_idle_cores(this, false);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct sched_domain *this_sd;
 	u64 time;
@@ -6120,7 +6122,7 @@ static int select_idle_cpu(struct task_s
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP)) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6140,26 +6142,17 @@ static int select_idle_cpu(struct task_s
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (smt) {
-			i = __select_idle_core(cpu, cpus, &idle_cpu);
-			if ((unsigned)i < nr_cpumask_bits)
-				return i;
-
-		} else {
-			if (!--nr)
-				return -1;
-
-			if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
-				idle_cpu = cpu;
-				break;
-			}
+		if (!--nr)
+			break;
+
+		i = __select_idle_core(cpu, cpus, &idle_cpu);
+		if ((unsigned)i < nr_cpumask_bits) {
+			idle_cpu = i;
+			break;
 		}
 	}
 
-	if (smt)
-		set_idle_cores(this, false);
-
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP)) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
