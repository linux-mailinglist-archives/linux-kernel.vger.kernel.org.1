Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70FD2CC213
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgLBQUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbgLBQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:20:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E247C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Ifuu5gVJfH2ZI53Y855JriQ73b9BW76FbTWvo/IPvg=; b=jxP9/wVZOIaJAktuIxLdq6HO1r
        GgtrsgCYAwmR913CAQGf51f06CstHwRemx6oIFmw6fz9jdmholfnNuJG9NWc8ZCadR/cCyLBuW5My
        CELnvp+CPXcalj6/4+64hmYpFpuRAAZkX3Yx2g6jIlElatqTMQwqZS+oVS5GFT2KL8EvFUipbEhCg
        VBa8rKSgELFPWx/JevNldC0y1D0OTL+fGJunc82cxeTDQUa1imS6bT7wFtrDsYWH8huBwrS8IhwSQ
        pCxWfJlS9K3U3Y0FA2XgsAeJ5q7RO/HKw0vdbd0PqANWNXQuFxDykjRahLEneftCINB8tFsp4A9Wv
        oxem3JNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkUqu-0002tA-8q; Wed, 02 Dec 2020 16:19:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 222623069B1;
        Wed,  2 Dec 2020 17:19:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E309721434778; Wed,  2 Dec 2020 17:19:34 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:19:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Message-ID: <20201202161934.GL3021@hirez.programming.kicks-ass.net>
References: <20201202150205.35750-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202150205.35750-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:02:04AM +0900, Namhyung Kim wrote:

> +#ifdef CONFIG_CGROUP_PERF
> +static inline void
> +perf_sw_event_cgroup_switch(struct task_struct *prev, struct task_struct *next)
> +{
> +	struct cgroup *prev_cgrp, *next_cgrp;
> +
> +	rcu_read_lock();
> +
> +	prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> +	next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> +
> +	if (prev_cgrp != next_cgrp)
> +		perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> +
> +	rcu_read_unlock();
> +}
> +#else
> +static inline void perf_sw_event_cgroup_switch(struct task_struct *prev,
> +					       struct task_struct *next) {}
> +#endif  /* CONFIG_CGROUP_PERF */
> +
>  extern struct static_key_false perf_sched_events;
>  
>  static __always_inline bool
> @@ -1220,6 +1241,7 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
>  					     struct task_struct *next)
>  {
>  	perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> +	perf_sw_event_cgroup_switch(prev, next);
>  
>  	if (static_branch_unlikely(&perf_sched_events))
>  		__perf_event_task_sched_out(prev, next);

Urgh.. that's horrible, try something like this.

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9a38f579bc76..5eb284819ee5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1174,25 +1174,19 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
  * which is guaranteed by us not actually scheduling inside other swevents
  * because those disable preemption.
  */
-static __always_inline void
-perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
+static __always_inline void __perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
 {
-	if (static_key_false(&perf_swevent_enabled[event_id])) {
-		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
+	struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
 
-		perf_fetch_caller_regs(regs);
-		___perf_sw_event(event_id, nr, regs, addr);
-	}
+	perf_fetch_caller_regs(regs);
+	___perf_sw_event(event_id, nr, regs, addr);
 }
 
 extern struct static_key_false perf_sched_events;
 
-static __always_inline bool
-perf_sw_migrate_enabled(void)
+static __always_inline bool __perf_sw_enabled(int swevt)
 {
-	if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
-		return true;
-	return false;
+	return static_key_false(&perf_swevent_enabled[swevt]);
 }
 
 static inline void perf_event_task_migrate(struct task_struct *task)
@@ -1207,11 +1201,9 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_in(prev, task);
 
-	if (perf_sw_migrate_enabled() && task->sched_migrated) {
-		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
-
-		perf_fetch_caller_regs(regs);
-		___perf_sw_event(PERF_COUNT_SW_CPU_MIGRATIONS, 1, regs, 0);
+	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
+	    task->sched_migrated) {
+		__perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
 		task->sched_migrated = 0;
 	}
 }
@@ -1219,7 +1211,13 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
 static inline void perf_event_task_sched_out(struct task_struct *prev,
 					     struct task_struct *next)
 {
-	perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
+	if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
+		__perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
+
+	if (__perf_sw_enabled(PERF_COUNT_SW_CGROUP_SWITCHES) &&
+	    (task_css_check(prev, perf_event_cgrp_id, 1)->cgroup !=
+	     task_css_check(next, perf_event_cgrp_id, 1)->cgroup))
+		__perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
 
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_out(prev, next);
@@ -1475,8 +1473,6 @@ static inline int perf_event_refresh(struct perf_event *event, int refresh)
 static inline void
 perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
-perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)			{ }
-static inline void
 perf_bp_event(struct perf_event *event, void *data)			{ }
 
 static inline int perf_register_guest_info_callbacks
