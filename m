Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACBA273764
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgIVA1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbgIVA1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:27:33 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81B023A9A;
        Tue, 22 Sep 2020 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600734452;
        bh=dtYc39MVgJFjRczJ5+ycdeO9YjYmRsr+ge2DSIIgCQw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aILr1eZttNjitMpSaW2VCXKdn87jnKoPny5xUjmUs4aMJ9RKJPh8TZNAaUnJopsN3
         HRRtupCT6v8xwVMsFAiOHG2docbhS+/QqQHXx1XlBUXsP0vru50ZRJ0ag/2giBAeo6
         ykNmnhRJNYLqTSemmhPWTm079ynbm+RyqlWr8xS4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A1C5535226C1; Mon, 21 Sep 2020 17:27:32 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:27:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 01/12] rcu: Implement rcu_segcblist_is_offloaded()
 config dependent
Message-ID: <20200922002732.GT29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921124351.24035-2-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:43:40PM +0200, Frederic Weisbecker wrote:
> This simplify the usage of this API and avoid checking the kernel
> config from the callers.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>

Nice cleanup!  I clearly should have done it this way to start with.

Any reason I shouldn't pull this into -rcu right now?

							Thanx, Paul

> ---
>  kernel/rcu/rcu_segcblist.h |  2 +-
>  kernel/rcu/tree.c          | 21 +++++++--------------
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 5c293afc07b8..492262bcb591 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -62,7 +62,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
>  /* Is the specified rcu_segcblist offloaded?  */
>  static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
>  {
> -	return rsclp->offloaded;
> +	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
>  }
>  
>  /*
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ce77d9ac716..c0286ce8fc03 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1583,8 +1583,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
>  {
>  	bool ret = false;
>  	bool need_qs;
> -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
>  
>  	raw_lockdep_assert_held_rcu_node(rnp);
>  
> @@ -2011,8 +2010,7 @@ static void rcu_gp_cleanup(void)
>  		needgp = true;
>  	}
>  	/* Advance CBs to reduce false positives below. */
> -	offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -		    rcu_segcblist_is_offloaded(&rdp->cblist);
> +	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
>  	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
>  		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
>  		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
> @@ -2207,8 +2205,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
>  	unsigned long flags;
>  	unsigned long mask;
>  	bool needwake = false;
> -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
>  	struct rcu_node *rnp;
>  
>  	rnp = rdp->mynode;
> @@ -2375,8 +2372,7 @@ int rcutree_dead_cpu(unsigned int cpu)
>  static void rcu_do_batch(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
> -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
>  	struct rcu_head *rhp;
>  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
>  	long bl, count;
> @@ -2620,8 +2616,7 @@ static __latent_entropy void rcu_core(void)
>  	unsigned long flags;
>  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
> -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
>  
>  	if (cpu_is_offline(smp_processor_id()))
>  		return;
> @@ -2919,8 +2914,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>  
>  	/* Go handle any RCU core processing required. */
> -	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> +	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
>  		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
>  	} else {
>  		__call_rcu_core(rdp, head, flags);
> @@ -3655,8 +3649,7 @@ static int rcu_pending(int user)
>  
>  	/* Has RCU gone idle with this CPU needing another grace period? */
>  	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
> -	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
> -	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
> +	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
>  	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>  		return 1;
>  
> -- 
> 2.28.0
> 
