Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B402A670C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgKDPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgKDPGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:06:00 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82FCC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:05:59 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id x20so19554149qkn.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fx8WINTs3s9jcRpT27JUsSTP0o0MYBOovbzWfiytbXI=;
        b=qOfgss0GjHaALDQNx8nvu9Cz8QPms1xyvcE46wJgsPZEfjbLgCyKdEMuOdu5PxpV5B
         EshE7qunlPpxyTYeYvw1DeLcoVwLtvrEbTvUeeTulaMMjHuqoR+m24F6q+1btETEtGgd
         Oa8i4GzymXVa43QQrlaYs0caxL5HAn9wuFahU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fx8WINTs3s9jcRpT27JUsSTP0o0MYBOovbzWfiytbXI=;
        b=eVnISJqdSsm2XQo6c2vdVdFrRxCJHDBcTHPiCaJND+kQDw32/WCJlyNzNOhgotHm4H
         +LQp197JDsGYAjx/+qCyKOFQvdNMCMeK4bIouvOiAFtKBLbEgJ0mamlEb9xPfFkzjIy9
         Zy3Z6RHLw2GWu3GtZQHrbkiJ5qwwCaNH6nJF/LqsY/qOm5fRryvVlGnqgC7PAEaADyfG
         Sow2ppCKvMLqvpyKmIud2XZO/upAI36q5f98kHQCDAuiLULpskGsisgQwtVSZ83TDiGj
         IWDZ92VuyGWcC8OCWtiD0JWtzrt+PMG9Eo9dYbMQlJpyL4RnihpmxBDwBOnM4Kcga9MC
         S/2g==
X-Gm-Message-State: AOAM531Q6FcqXyTyN12WuItVwTX8f6N6kRtgaCZzT2lqH3AKcR43IAx9
        oD+7IJCUrwAlzCBp46n8oyFzQFQGLkhmWw==
X-Google-Smtp-Source: ABdhPJzmc6/NJff0Sm3rbmqK1nxAsS4Dop9m6dDQ/g6IQL92H1Yi9bEtreP48/OEf/wIlvwcFgTZEA==
X-Received: by 2002:a37:8984:: with SMTP id l126mr24770919qkd.443.1604502358803;
        Wed, 04 Nov 2020 07:05:58 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c12sm269499qtp.14.2020.11.04.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:05:57 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:05:57 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201104150557.GC2313912@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
 <58c89893-1bf7-29bb-7f97-2e48755e8dd7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c89893-1bf7-29bb-7f97-2e48755e8dd7@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:10:17PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 11/3/2020 7:56 PM, Joel Fernandes (Google) wrote:
> > Track how the segcb list changes before/after acceleration, during
> > queuing and during dequeuing.
> > 
> > This has proved useful to discover an optimization to avoid unwanted GP
> > requests when there are no callbacks accelerated. The overhead is minimal as
> > each segment's length is now stored in the respective segment.
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
> >   kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
> >   kernel/rcu/rcu_segcblist.h |  5 +++++
> >   kernel/rcu/tree.c          |  9 +++++++++
> >   4 files changed, 73 insertions(+)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 155b5cb43cfd..5f8f2ee1a936 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
> >   		  __entry->qlen)
> >   );
> > +TRACE_EVENT_RCU(rcu_segcb_stats,
> > +
> > +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> 
> I think we need to use long[] instead of int[] for cb_count everywhere in
> this patch?

More than 4 billion callbacks on a single cblist sounds like a bug though so
int should work. Plus I prefer to keep the tracepoint size small (on 64-bit
systems, long is 64 bits, int is 32 bits).

Thanks for all the reviews on this and other patches!

 - Joel


> 
> 
> Thanks
> Neeraj
> 
> > +
> > +		TP_ARGS(ctx, cb_count, gp_seq),
> > +
> > +		TP_STRUCT__entry(
> > +			__field(const char *, ctx)
> > +			__array(int, cb_count, RCU_CBLIST_NSEGS)
> > +			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
> > +		),
> > +
> > +		TP_fast_assign(
> > +			__entry->ctx = ctx;
> > +			memcpy(__entry->cb_count, cb_count, RCU_CBLIST_NSEGS * sizeof(int));
> > +			memcpy(__entry->gp_seq, gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
> > +		),
> > +
> > +		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
> > +			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> > +			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
> > +			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
> > +
> > +);
> > +
> >   /*
> >    * Tracepoint for the registration of a single RCU callback of the special
> >    * kvfree() form.  The first argument is the RCU type, the second argument
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 357c19bbcb00..2a03949d0b82 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/types.h>
> >   #include "rcu_segcblist.h"
> > +#include "rcu.h"
> >   /* Initialize simple callback list. */
> >   void rcu_cblist_init(struct rcu_cblist *rclp)
> > @@ -328,6 +329,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >   	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> >   }
> > +/*
> > + * Return how many CBs each segment along with their gp_seq values.
> > + *
> > + * This function is O(N) where N is the number of segments. Only used from
> > + * tracing code which is usually disabled in production.
> > + */
> > +#ifdef CONFIG_RCU_TRACE
> > +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > +			 int cbcount[RCU_CBLIST_NSEGS],
> > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> > +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> > +		gpseq[i] = rsclp->gp_seq[i];
> > +	}
> > +}
> > +
> > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> > +{
> > +	int cbs[RCU_CBLIST_NSEGS];
> > +	unsigned long gps[RCU_CBLIST_NSEGS];
> > +
> > +	if (!trace_rcu_segcb_stats_enabled())
> > +		return;
> > +
> > +	rcu_segcblist_countseq(rsclp, cbs, gps);
> > +
> > +	trace_rcu_segcb_stats(context, cbs, gps);
> > +}
> > +#endif
> > +
> >   /*
> >    * Extract only those callbacks still pending (not yet ready to be
> >    * invoked) from the specified rcu_segcblist structure and place them in
> > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > index cd35c9faaf51..7750734fa116 100644
> > --- a/kernel/rcu/rcu_segcblist.h
> > +++ b/kernel/rcu/rcu_segcblist.h
> > @@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
> >   bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
> >   void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
> >   			 struct rcu_segcblist *src_rsclp);
> > +#ifdef CONFIG_RCU_TRACE
> > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context);
> > +#else
> > +#define __trace_rcu_segcb_stats(...)
> > +#endif
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 24c00020ab83..f6c6653b3ec2 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1497,6 +1497,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >   	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
> >   		return false;
> > +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));
> > +
> >   	/*
> >   	 * Callbacks are often registered with incomplete grace-period
> >   	 * information.  Something about the fact that getting exact
> > @@ -1517,6 +1519,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >   	else
> >   		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
> > +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
> > +
> >   	return ret;
> >   }
> > @@ -2466,11 +2470,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >   	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
> >   	if (offloaded)
> >   		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> > +
> > +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
> >   	rcu_nocb_unlock_irqrestore(rdp, flags);
> >   	/* Invoke callbacks. */
> >   	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> >   	rhp = rcu_cblist_dequeue(&rcl);
> > +
> >   	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> >   		rcu_callback_t f;
> > @@ -2983,6 +2990,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
> >   		trace_rcu_callback(rcu_state.name, head,
> >   				   rcu_segcblist_n_cbs(&rdp->cblist));
> > +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> > +
> >   	/* Go handle any RCU core processing required. */
> >   	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> >   		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
