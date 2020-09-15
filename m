Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5326AE71
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgIOUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgIOUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:08:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE040C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:08:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so5682966qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cCa+OmWkXMGwpGNjjetb0s9gVrFoGTJt0n0J5CyBpZQ=;
        b=Vj/kDBweJd5lPbpQR+j9Fehja/T/HLbZIb2ToPV8IjEvTQ+zQnolYmodl2ZnSWu0V9
         FO1+b4pCW1fQsR9NzFdHPiP561Rp2y6wmSKMeQdY2Xgj7L9uPparDacUDFBPp6UEBC33
         gRSC8P6JWi/NYzFtO7cfjSbAbM+V2SJG/Cmgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cCa+OmWkXMGwpGNjjetb0s9gVrFoGTJt0n0J5CyBpZQ=;
        b=ArWHwJ1uBqjmqoRjNxwKxjn6Cr+i6KZn8Yp+JbsBs2mWk3En/lXOYqV5ywOzN4b0oa
         dU1KVlIQY1fi+9Rn0Y562nTgFshL7M5mrx/ulaWsxgWyBicqLVtekF7u+BkDFZivAWYT
         l06Vlyew4/MATICPjkdTyy7iNYPt7r/CqAZD3ND2oD7T5NzOokv7vLnpX24llR9Me8cz
         qzJVnf7dAzU5nqEBxjftB5Y/rY95sLUFuVGRZUv/k4oPUp/VNZqrsFNZIDU2RdakHlHL
         Rap64UvjlxtGh9JGAIM21pODywOG/KeO1PQf6hfE/AhJKnXJOfljfGCNZ8bs2PXRDs0F
         AnbQ==
X-Gm-Message-State: AOAM530be8kKDniiQNMDvMKSaANTAfNvtFkd+YwldyijnnGf4p5OhKxx
        S9fLk2yAmTSm3+oKpbQ7Kkcj3Q==
X-Google-Smtp-Source: ABdhPJyhXtV8t9UC4HW3YaUxJSzv3IWll1l8RS3gcnNZgfCtoEYk6vy6GoXUwG2PxNolekjYWTVtEw==
X-Received: by 2002:a37:9b82:: with SMTP id d124mr19835677qke.8.1600200506913;
        Tue, 15 Sep 2020 13:08:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r24sm16845627qtm.70.2020.09.15.13.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 13:08:26 -0700 (PDT)
Date:   Tue, 15 Sep 2020 16:08:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200915200825.GA2987924@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:51:09PM -0400, Julien Desfossez wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Instead of only selecting a local task, select a task for all SMT
> siblings for every reschedule on the core (irrespective which logical
> CPU does the reschedule).
> 
> During a CPU hotplug event, schedule would be called with the hotplugged
> CPU not in the cpumask. So use for_each_cpu(_wrap)_or to include the
> current cpu in the task pick loop.
> 
> There are multiple loops in pick_next_task that iterate over CPUs in
> smt_mask. During a hotplug event, sibling could be removed from the
> smt_mask while pick_next_task is running. So we cannot trust the mask
> across the different loops. This can confuse the logic. Add a retry logic
> if smt_mask changes between the loops.
[...]
> +static struct task_struct *
> +pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +{
[...]
> +	/* reset state */
> +	rq->core->core_cookie = 0UL;
> +	for_each_cpu_or(i, smt_mask, cpumask_of(cpu)) {
> +		struct rq *rq_i = cpu_rq(i);
> +
> +		rq_i->core_pick = NULL;
> +
> +		if (rq_i->core_forceidle) {
> +			need_sync = true;
> +			rq_i->core_forceidle = false;
> +		}
> +
> +		if (i != cpu)
> +			update_rq_clock(rq_i);
> +	}
> +
> +	/*
> +	 * Try and select tasks for each sibling in decending sched_class
> +	 * order.
> +	 */
> +	for_each_class(class) {
> +again:
> +		for_each_cpu_wrap_or(i, smt_mask, cpumask_of(cpu), cpu) {
> +			struct rq *rq_i = cpu_rq(i);
> +			struct task_struct *p;
> +
> +			/*
> +			 * During hotplug online a sibling can be added in
> +			 * the smt_mask * while we are here. If so, we would
> +			 * need to restart selection by resetting all over.
> +			 */
> +			if (unlikely(smt_weight != cpumask_weight(smt_mask)))
> +				goto retry_select;
> +
> +			if (rq_i->core_pick)
> +				continue;
> +
> +			/*
> +			 * If this sibling doesn't yet have a suitable task to
> +			 * run; ask for the most elegible task, given the
> +			 * highest priority task already selected for this
> +			 * core.
> +			 */
> +			p = pick_task(rq_i, class, max);
> +			if (!p) {
> +				/*
> +				 * If there weren't no cookies; we don't need
> +				 * to bother with the other siblings.
> +				 */
> +				if (i == cpu && !need_sync)
> +					goto next_class;

We find that there is a problem with this code, it force idles RT tasks
whenever one sibling is running tagged CFS task, with the other one running
untagged RT task.

Below diff should fix it, still testing it:

---8<-----------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cc90eb50d481..26d05043b640 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4880,10 +4880,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_task(rq_i, class, max);
 			if (!p) {
 				/*
-				 * If there weren't no cookies; we don't need
-				 * to bother with the other siblings.
+				 * If the rest of the core is not running a
+				 * tagged task, i.e.  need_sync == 0, and the
+				 * current CPU which called into the schedule()
+				 * loop does not have any tasks for this class,
+				 * skip selecting for other siblings since
+				 * there's no point. We don't skip for RT/DL
+				 * because that could make CFS force-idle RT.
 				 */
-				if (i == cpu && !need_sync)
+				if (i == cpu && !need_sync && class == &fair_sched_class)
 					goto next_class;
 
 				continue;
