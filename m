Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE82B9A96
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgKSS0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgKSS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:26:44 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E698C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:26:44 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ek7so3352277qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U1HEdLIcc4UdvMhCka09HnXOfZEKW6F4PWCyGqabJpU=;
        b=0zPt8CaD6GPDed3k4ERiK3VFr1NNO/aTupHaeVB5cdIZHgiB4pkoQimOv2CQMPYjra
         R7doXXRXv0QtrOKjLKhHKC954x01fO5rEbkKNYUgf59ctjK0Wo55jFOxvTl+ifWAwKTE
         uNff9bqgh4Ihb77fZFRQZEAs9n+Y8UaKvsiCpEOmIyHergScIAG8P78Wsau5tLadEQUa
         Cu61prE0ltJyIwCCIBVeTBl3xXEVSbpQ9qO/4blRsSMEYm1R3XxfTjxx5STAkhpVmCCJ
         D9ogNxsJxAKp7evnA3RTgJfD0LTAfo6MVj3Zf9CESGcJ2gw2/zOcOb5Wptedw7UWxaER
         F9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U1HEdLIcc4UdvMhCka09HnXOfZEKW6F4PWCyGqabJpU=;
        b=bdyFB3nqPyeEj3asM8WdkkPDu4WbxxGqOagp3dViwpiLa53egG/L77QHIfgIgvM9iv
         CfEnx3oh9lp6W2mscpQxcJfFybz/bZkLUgq8g/sA9lsQmn5oBKXUDLN/qfMjyRHDsFV4
         mnUVNpgcyQvnxSqvMYWqhqalWrXxFCQXDC/AYbGxlvvV1sbLwoJfkaVq4O6FBFJo8Ll5
         KJHFHUBiS4ijjFkESFSNIWvLBriaq2pctA0SuIwYNgO3NBHRZ5TlQKUfe/RwQ3loeYwO
         U6pimYNo63tQuvxPxe6X6cRH0EzsIt4OyI2cahoXrAunAoSWJmlYNR9I86WA8xMCER+2
         0nKA==
X-Gm-Message-State: AOAM533x4iyatf4HGjEc7y0q3Rq/rVFZp1gNFJhuhDFPXeZkLV+MZchp
        KJXLSGInQMz7KO+aaugvRjkcBg==
X-Google-Smtp-Source: ABdhPJy7UAFqTEEAw8KVcE5o5p+HCRgQpoqoiJUVhTRRdCbwV0jHj7KHYAvaN5vz7YcomTSrwIYYcg==
X-Received: by 2002:a0c:c78e:: with SMTP id k14mr12087939qvj.5.1605810403356;
        Thu, 19 Nov 2020 10:26:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2976])
        by smtp.gmail.com with ESMTPSA id x21sm416135qkx.31.2020.11.19.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 10:26:42 -0800 (PST)
Date:   Thu, 19 Nov 2020 13:24:49 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: bail out from psi memstall when cond_resched
Message-ID: <20201119182449.GA1144379@cmpxchg.org>
References: <1605669776-24242-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20201119125557.GM3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119125557.GM3121392@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:55:57PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 18, 2020 at 11:22:56AM +0800, Zhaoyang Huang wrote:
> > Memory reclaiming will run as several seconds in memory constraint system, which
> > will be deemed as heavy memstall. Have the memory reclaim be more presiced by
> > bailing out when cond_resched
>
> How is this supposed to work on PREEMPT=y where cond_resched() is a NOP
> and you can get preempted at any random point?
> 
> (leaving the rest for Johannes)
>  
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/vmscan.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a815f73..a083c85 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -316,6 +316,15 @@ static inline bool memcg_congested(struct pglist_data *pgdat,
> >  }
> >  #endif
> >  
> > +static inline void psi_cond_resched(void)
> > +{
> > +	unsigned long *flags;
> > +
> > +	if (current->flags & PF_MEMSTALL)
> > +		psi_memstall_leave(&flags);
> > +	cond_resched();
> > +	psi_memstall_enter(&flags);
> > +}
> >  /*
> >   * This misses isolated pages which are not accounted for to save counters.
> >   * As the data only determines if reclaim or compaction continues, it is
> > @@ -557,7 +566,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  		total_scan -= shrinkctl->nr_scanned;
> >  		scanned += shrinkctl->nr_scanned;
> >  
> > -		cond_resched();
> > +		psi_cond_resched();
> >  	}

I guess there is some merit to discounting that time: if you're out of
time slice, you couldn't run the workload either at this time, so the
scheduling delay is not exactly productivity lost due to memory.

But as Peter says, you'd have to handle random preemption at any time,
not just cond_resched(). I think it should be doable.

The below stops the clock on any memstalls when the task is queued but
not scheduled. This includes preemption periods, but also the schedule
delay after a wakeup. Lightly tested.

It would rely on p->psi_flags for control flow, which were previously
only used for debugging. But that simplifies cgroup moving a bit.

Thoughts?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c0766c..f53823b6852b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -811,26 +811,38 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep)
 {
 	struct psi_group *group, *common = NULL;
+	int set = TSK_ONCPU, clear = TSK_ONCPU;
 	int cpu = task_cpu(prev);
 	void *iter;
 
+	/*
+	 * Preemption periods and scheduling delays after wakeup are
+	 * due to a lack of CPU, not memory. We stop the clock on the
+	 * memory stall in such situations (see also psi_enqueue());
+	 * resume the stall when the task is actually scheduled again.
+	 */
+	if (!sleep && prev->in_memstall)
+		clear |= TSK_MEMSTALL;
+	if (next->in_memstall && !(next->psi_flags & TSK_MEMSTALL))
+		set |= TSK_MEMSTALL;
+
 	if (next->pid) {
-		psi_flags_change(next, 0, TSK_ONCPU);
-		/*
-		 * When moving state between tasks, the group that
-		 * contains them both does not change: we can stop
-		 * updating the tree once we reach the first common
-		 * ancestor. Iterate @next's ancestors until we
-		 * encounter @prev's state.
-		 */
+		psi_flags_change(next, 0, set);
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			/*
+			 * When moving ONCPU between tasks, the group
+			 * that contains them both does not change: we
+			 * can stop updating the tree once we reach
+			 * the first common ancestor. Iterate @next's
+			 * ancestors until we encounter @prev's state.
+			 */
+			if ((set|clear) == TSK_ONCPU &&
+			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
 				common = group;
 				break;
 			}
-
-			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
+			psi_group_change(group, cpu, 0, set, true);
 		}
 	}
 
@@ -843,11 +855,10 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		return;
 
 	if (prev->pid) {
-		psi_flags_change(prev, TSK_ONCPU, 0);
-
+		psi_flags_change(prev, clear, 0);
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
+			psi_group_change(group, cpu, clear, 0, true);
 	}
 }
 
@@ -964,7 +975,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
  */
 void cgroup_move_task(struct task_struct *task, struct css_set *to)
 {
-	unsigned int task_flags = 0;
+	unsigned int task_flags;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -978,23 +989,10 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	}
 
 	rq = task_rq_lock(task, &rf);
-
-	if (task_on_rq_queued(task)) {
-		task_flags = TSK_RUNNING;
-		if (task_current(rq, task))
-			task_flags |= TSK_ONCPU;
-	} else if (task->in_iowait)
-		task_flags = TSK_IOWAIT;
-
-	if (task->in_memstall)
-		task_flags |= TSK_MEMSTALL;
-
+	task_flags = task->psi_flags;
 	if (task_flags)
 		psi_task_change(task, task_flags, 0);
-
-	/* See comment above */
 	rcu_assign_pointer(task->cgroups, to);
-
 	if (task_flags)
 		psi_task_change(task, 0, task_flags);
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 33d0daf83842..cb36e2e2b6c7 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -69,14 +69,20 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (!wakeup || p->sched_psi_wake_requeue) {
-		if (p->in_memstall)
-			set |= TSK_MEMSTALL;
-		if (p->sched_psi_wake_requeue)
-			p->sched_psi_wake_requeue = 0;
-	} else {
+	if (p->sched_psi_wake_requeue) {
+		/*
+		 * A migration wakeup has nothing to do here but set
+		 * TSK_RUNNING: TSK_IOWAIT has already been cleared on
+		 * the old queue in ttwu(); TSK_MEMSTALL will be
+		 * restored when the task resumes in schedule().
+		 */
+		p->sched_psi_wake_requeue = 0;
+	} else if (wakeup) {
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
+		/* Don't count queue time as memory pressure */
+		if (p->in_memstall)
+			clear |= TSK_MEMSTALL;
 	}
 
 	psi_task_change(p, clear, set);
@@ -89,10 +95,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (!sleep) {
-		if (p->in_memstall)
-			clear |= TSK_MEMSTALL;
-	} else {
+	if (sleep) {
 		/*
 		 * When a task sleeps, schedule() dequeues it before
 		 * switching to the next one. Merge the clearing of
