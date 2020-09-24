Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7220276F23
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIXK5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIXK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:57:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4BBC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iz3b2Q3XSZhhs0irwvW6g7XtupthcZ6Zn194D8YFf88=; b=F1S3PQ/z7nY4MP7sX1K/nCY2BB
        cfsBPVkFZlkHwuw+23PKSfP1yg6SGl7/X7sq973KXyeZFlRlsBWdW6uMPjsVpskMm1o3ec5pzMpBf
        D/sOI2tLxh9RbUcBOcWNyln23f0j2YCdGHUOTBx5KDzaoG5RLFZ/z5FxmE040MGfRLXnf+smla6x1
        9/D9DTa/pZDa+Zk1XR/3tE0eAOkXYyVlc8z/ovqgDarxzQFjwZraTj8SimrYoQgmeqXNJKc5bHupn
        YPPzgnDGfmI49qFviraGpS2nJU32d5mJYYvvsX150r5ypW7prpeysytZTOa1EHaXAjbNlDgob0tHx
        6F2NhBtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLOw7-000801-TN; Thu, 24 Sep 2020 10:57:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88E59300DB4;
        Thu, 24 Sep 2020 12:57:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52BFC202A40A3; Thu, 24 Sep 2020 12:57:14 +0200 (CEST)
Date:   Thu, 24 Sep 2020 12:57:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        raistlin@linux.it
Subject: Re: [PATCH v3] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20200924105714.GB2628@hirez.programming.kicks-ass.net>
References: <20200919014249.GA31707@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919014249.GA31707@iZj6chx1xj0e0buvshuecpZ>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 09:42:49AM +0800, Peng Liu wrote:
> When user changes sched_rt_{runtime, period}_us, then
> 
>   sched_rt_handler()
>     -->	sched_dl_bandwidth_validate()
> 	{
> 		new_bw = global_rt_runtime()/global_rt_period();
> 
> 		for_each_possible_cpu(cpu) {
> 			dl_b = dl_bw_of(cpu);
> 			if (new_bw < dl_b->total_bw)
> 				ret = -EBUSY;
> 		}
> 	}
> 
> Under CONFIG_SMP, dl_bw is per root domain , but not per CPU,
> dl_b->total_bw is the allocated bandwidth of the whole root domain.
> we should compare dl_b->total_bw against cpus*new_bw, where 'cpus'
> is the number of CPUs of the root domain.

Is there an actual problem there? Spell it out.

> Also, below annotation(in kernel/sched/sched.h) implied implementation
> only appeared in SCHED_DEADLINE v2[1], then deadline scheduler kept
> evolving till got merged(v9), but the annotation remains unchanged,
> meaningless and misleading, correct it.
> 
> * With respect to SMP, the bandwidth is given on a per-CPU basis,
> * meaning that:
> *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
> *  - dl_total_bw array contains, in the i-eth element, the currently
> *    allocated bandwidth on the i-eth CPU.
> 
> [1] https://lkml.org/lkml/2010/2/28/119

Don't use lkml.org links, use lkml.kernel.org/r/$MsgID instead.

> [!CONFIG_SMP build error]
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>

Quite frankly this patch is horrible #ifdef soup.

Can't you make something like the below work?

---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3862a28cd05d..3f309e0f69f5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -97,6 +97,17 @@ static inline unsigned long dl_bw_capacity(int i)
 		return __dl_bw_capacity(i);
 	}
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	struct root_domain *rd = cpu_rq(i)->rd;
+
+	if (rd->visit_gen == gen)
+		return true;
+
+	rd->visit_gen = gen;
+	return false;
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -112,6 +123,11 @@ static inline unsigned long dl_bw_capacity(int i)
 {
 	return SCHED_CAPACITY_SCALE;
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	return false;
+}
 #endif
 
 static inline
@@ -2513,31 +2529,35 @@ const struct sched_class dl_sched_class
 
 int sched_dl_global_validate(void)
 {
+	static u64 generation = 0;
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
-	struct dl_bw *dl_b;
-	int cpu, ret = 0;
+	int cpu, cpus, ret = 0;
 	unsigned long flags;
+	struct dl_bw *dl_b;
+	u64 gen = ++generation;
 
 	/*
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
-	 *
-	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
-	 * cycling on root_domains... Discussion on different/better
-	 * solutions is welcome!
 	 */
 	for_each_possible_cpu(cpu) {
+
 		rcu_read_lock_sched();
+		if (dl_bw_visited(cpu, gen))
+			goto next;
+
 		dl_b = dl_bw_of(cpu);
+		cpus = dl_bw_cpus(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw < dl_b->total_bw)
+		if (new_bw * cpus < dl_b->total_bw)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
+	next:
 		rcu_read_unlock_sched();
 
 		if (ret)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..7f0947db6e2c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -801,6 +801,8 @@ struct root_domain {
 	struct dl_bw		dl_bw;
 	struct cpudl		cpudl;
 
+	u64			visit_gen;
+
 #ifdef HAVE_RT_PUSH_IPI
 	/*
 	 * For IPI pull requests, loop across the rto_mask.
