Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E34A273723
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgIVAKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgIVAKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:16 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDDE23A6C;
        Tue, 22 Sep 2020 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733415;
        bh=SbOLFijeUsQie1Rbaq7PoNsbqiP4T5R5dg8/lMwJ9HI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=heIrrpocums7wE9rOXA5BoNuzHPPLXLcjCaF23QR1/lxYvZ2SSRx+hZsMJl9EG8J3
         9qu1yL7+5C4p1496ubo5RRuDkzNozZKuxykwRdBXo9jjP6nekCf8LO/YfsfkX98jQH
         lpf8OIF5LksG95lze6VZLYOtHH5HOHMsZNtnv1LY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 95EEB35226C1; Mon, 21 Sep 2020 17:10:15 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:10:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 05/12] rcu: De-offloading GP kthread
Message-ID: <20200922001015.GO29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921124351.24035-6-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:43:44PM +0200, Frederic Weisbecker wrote:
> In order to de-offload the callbacks processing of an rdp, we must clear
> SEGCBLIST_OFFLOAD and notify the GP kthread so that it clears its own
> bit flag and ignore the target rdp from its loop. The CB kthread
> is also notified the same way. Whoever acknowledges and clears its
> own bit last must notify the de-offloading worker so that it can resume
> the de-offloading while being sure that callbacks won't be handled
> remotely anymore.
> 
> Inspired-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_plugin.h | 53 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3ea43c75c7a3..e4e7e7c4bfb6 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1900,6 +1900,33 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
>  	__call_rcu_nocb_wake(rdp, true, flags);
>  }
>  
> +static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
> +{
> +	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_GP;
> +
> +	return rcu_segcblist_test_flags(&rdp->cblist, flags);
> +}
> +
> +static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_state)
> +{
> +	struct rcu_segcblist *cblist = &rdp->cblist;
> +
> +	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
> +		return true;
> +	} else {
> +		/*
> +		 * De-offloading. Clear our flag and notify the de-offload worker.
> +		 * We will ignore this rdp until it ever gets re-offloaded.
> +		 */
> +		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
> +		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
> +		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
> +			*needwake_state = true;
> +		return false;
> +	}
> +}
> +
> +
>  /*
>   * No-CBs GP kthreads come here to wait for additional callbacks to show up
>   * or for grace periods to end.
> @@ -1927,8 +1954,17 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	 * and the global grace-period kthread are awakened if needed.
>  	 */
>  	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> +		bool needwake_state = false;
> +		if (!nocb_gp_enabled_cb(rdp))
> +			continue;
>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
>  		rcu_nocb_lock_irqsave(rdp, flags);
> +		if (!nocb_gp_update_state(rdp, &needwake_state)) {
> +			rcu_nocb_unlock_irqrestore(rdp, flags);
> +			if (needwake_state)
> +				swake_up_one(&rdp->nocb_state_wq);
> +			continue;
> +		}
>  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>  		if (bypass_ncbs &&
>  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> @@ -2194,7 +2230,8 @@ static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
>  	unsigned long flags;
>  	struct rcu_node *rnp = rdp->mynode;
>  	struct rcu_segcblist *cblist = &rdp->cblist;
> -	bool wake_cb = false;
> +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
> +	bool wake_cb = false, wake_gp = false;
>  
>  	printk("De-offloading %d\n", rdp->cpu);
>  
> @@ -2212,8 +2249,19 @@ static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
>  	if (wake_cb)
>  		swake_up_one(&rdp->nocb_cb_wq);
>  
> +	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
> +	if (rdp_gp->nocb_gp_sleep) {
> +		rdp_gp->nocb_gp_sleep = false;
> +		wake_gp = true;
> +	}
> +	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
> +
> +	if (wake_gp)
> +		wake_up_process(rdp_gp->nocb_gp_kthread);
> +
>  	swait_event_exclusive(rdp->nocb_state_wq,
> -			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
> +			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
> +							SEGCBLIST_KTHREAD_GP));
>  }
>  
>  static long rcu_nocb_rdp_deoffload(void *arg)
> @@ -2292,6 +2340,7 @@ void __init rcu_init_nohz(void)
>  			rcu_segcblist_init(&rdp->cblist);
>  		rcu_segcblist_offload(&rdp->cblist, true);
>  		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
> +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);

OK, I will bite at this nit...

Why not "SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP"?

							Thanx, Paul

>  	}
>  	rcu_organize_nocb_kthreads();
>  }
> -- 
> 2.28.0
> 
