Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423F41E32ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404516AbgEZWtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 18:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404223AbgEZWtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:49:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F8EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:49:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b6so22485820qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/doIfRpDGRW5pLPj2aWNwxyip/T9/cUAIn4PAEcGXhg=;
        b=KtnUTj5xsYcZWCrfRa7ZpNwJdv9KMtiKwsq8ADuv5J5FnhrGIEGdj/RYMjo6uvCxW2
         r7qVBMjPju0VD3qn0dHTYPKR1p0A3vhCbAcSiJUN6mccKmSZbkO82HGkF5KJ4yXWVY2W
         QZwn7R5FUwzmgcoqakt44UP5e/n7NTbazEXHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/doIfRpDGRW5pLPj2aWNwxyip/T9/cUAIn4PAEcGXhg=;
        b=ZME+RmhCSdjN0rxvLI4wsyGkF8YV7iXga4l/2GUoGpAwj619kC7O3x1jEG5Pr91vVr
         26+CcI4M7Ja0e9R+FIKYVJ+qauzvFz+oh5Ehs4UJxGXYnmvrbOSq90zqL3JXnjXfvhbe
         F4UhhnmDZSziRav20Gl2t/g3VvpNQzoPuZU/cGfyhdgXckOsEEZS76KBac17DaHKHhMU
         RMzpnloL/R/qZ07Nt3PTl42MeFAH3j/e4GhepscKxU4OmhwTPcebdlB++RW0fwfF7FBO
         Gf6sHAgWlKtHPOu5JsfXxlUBzjXmd3nKorNBBAnZOfhiAUtJJ+pPCmdAY3lO6Y5gyZIc
         PycA==
X-Gm-Message-State: AOAM5335Y7o8zqpZPw653MNVtTa2/+qSTVHYipvUFmgYBQRtLGpzpsFD
        KyZebrFZ/MndNmmicwbrOoEn7A==
X-Google-Smtp-Source: ABdhPJxzNfDo10Z0gml9PqP21HolqoPvCjKgpID3GBub2wRdWnlFgxpxqiXABQWVT6FjyykrmWQ/lA==
X-Received: by 2002:a37:8807:: with SMTP id k7mr1193804qkd.226.1590533349797;
        Tue, 26 May 2020 15:49:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k13sm873488qtm.80.2020.05.26.15.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:49:09 -0700 (PDT)
Date:   Tue, 26 May 2020 18:49:08 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200526224908.GC16672@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200526212017.GE76276@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526212017.GE76276@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:20:17PM -0400, Joel Fernandes wrote:
 
> > The switch happens on the target with IRQs disabled and rdp->nocb_lock
> > held to avoid races between local callbacks handling and kthread
> > offloaded callbacks handling.
> > nocb_cb kthread is first parked to avoid any future race with
> > concurrent rcu_do_batch() executions. Then the cblist is set to offloaded
> > so that the nocb_gp kthread ignores this rdp.
> 
> nit: you mean cblist is set to non-offloaded mode right?
> 
> Also, could you clarify better the rcu_barrier bits in the changelog. I know
> there's some issue if the cblist has both offloaded and non-offloaded
> callbacks, but it would be good to clarify this here better IMHO.

And for archival purposes: rcu_barrier needs excluding here because it is
possible that for a brief period of time, the callback kthread has been
parked to do the mode-switch, and it could be executing a bunch of callbacks
when it was asked to park.

Meanwhile, more interrupts happen and more callbacks are queued which are now
executing in softirq. This ruins the ordering of callbacks that rcu_barrier
needs.

thanks,

 - Joel


> 
> [...]
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index d8ea2bef5574..4bed48da7702 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -171,9 +171,9 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
> >   * Mark the specified rcu_segcblist structure as offloaded.  This
> >   * structure must be empty.
> >   */
> > -void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
> > +void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
> >  {
> > -	rsclp->offloaded = 1;
> > +	rsclp->offloaded = offload;
> >  }
> >  #endif
> >  
> > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > index 4c1503a82492..8f7c6c34cb1b 100644
> > --- a/kernel/rcu/rcu_segcblist.h
> > +++ b/kernel/rcu/rcu_segcblist.h
> > @@ -83,7 +83,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
> >  void rcu_segcblist_init(struct rcu_segcblist *rsclp);
> >  void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
> >  #ifdef CONFIG_RCU_NOCB_CPU
> > -void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
> > +void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
> >  #endif
> >  bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
> >  bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index f19e81e0c691..c74a4df8d5f2 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1943,6 +1943,10 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> >  		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > +		if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
> > +			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > +			continue;
> > +		}
> >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> >  		if (bypass_ncbs &&
> >  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> > @@ -2176,6 +2180,50 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
> >  		do_nocb_deferred_wakeup_common(rdp);
> >  }
> >  
> > +static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> > +{
> > +	unsigned long flags;
> > +	struct rcu_node *rnp = rdp->mynode;
> > +
> > +	printk("De-offloading %d\n", rdp->cpu);
> 
> nit: s/printk/pr_debug/ ?
> 
> thanks,
> 
>  - Joel
> 
> > +	kthread_park(rdp->nocb_cb_kthread);
> > +
> > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > +	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
> > +	raw_spin_lock_rcu_node(rnp);
> > +	rcu_segcblist_offload(&rdp->cblist, false);
> > +	raw_spin_unlock_rcu_node(rnp);
> > +	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > +}
> > +
> > +static long rcu_nocb_rdp_deoffload(void *arg)
> > +{
> > +	struct rcu_data *rdp = arg;
> > +
> > +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> > +	__rcu_nocb_rdp_deoffload(rdp);
> > +
> > +	return 0;
> > +}
> > +
> > +void rcu_nocb_cpu_deoffload(int cpu)
> > +{
> > +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > +
> > +	mutex_lock(&rcu_state.barrier_mutex);
> > +	cpus_read_lock();
> > +	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
> > +		if (cpu_online(cpu)) {
> > +			work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
> > +		} else {
> > +			__rcu_nocb_rdp_deoffload(rdp);
> > +		}
> > +		cpumask_clear_cpu(cpu, rcu_nocb_mask);
> > +	}
> > +	cpus_read_unlock();
> > +	mutex_unlock(&rcu_state.barrier_mutex);
> > +}
> > +
> >  void __init rcu_init_nohz(void)
> >  {
> >  	int cpu;
> > @@ -2218,7 +2266,7 @@ void __init rcu_init_nohz(void)
> >  		rdp = per_cpu_ptr(&rcu_data, cpu);
> >  		if (rcu_segcblist_empty(&rdp->cblist))
> >  			rcu_segcblist_init(&rdp->cblist);
> > -		rcu_segcblist_offload(&rdp->cblist);
> > +		rcu_segcblist_offload(&rdp->cblist, true);
> >  	}
> >  	rcu_organize_nocb_kthreads();
> >  }
> > -- 
> > 2.25.0
> > 
