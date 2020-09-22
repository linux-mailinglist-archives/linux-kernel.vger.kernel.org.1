Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B01E273736
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgIVAR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgIVAR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:17:57 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1895421789;
        Tue, 22 Sep 2020 00:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733877;
        bh=bcJpA2xzLbDVscLA1pFAHdb4cRS7gxuxM45mc8ufRkg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VTfIu66gW1K3flRRS62A2GiozcixV8ZUfrw+X8fuUPi1lSQqN8YgwjG1wbO5Ox6kA
         pPhKBeDPRs2IfZA1LQ7cwaCJFCmmtumbRcbwBEab7bvsx/+r0gGFSbED3HFx5wzVgN
         +FadtjckeK7SQkMArs/E1MN4yA8tHGJR0uCJp8sg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E03C735226C1; Mon, 21 Sep 2020 17:17:56 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:17:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 07/12] rcu: Shutdown nocb timer on de-offloading
Message-ID: <20200922001756.GP29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-8-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921124351.24035-8-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:43:46PM +0200, Frederic Weisbecker wrote:
> Make sure the nocb timer can't fire anymore before we reach the final
> de-offload state. Spuriously waking up the GP kthread is no big deal but
> we must prevent from executing the timer callback without nocb locking.

If we had just the previous patch and not this patch, would things break?
Or are you relying on the fact that there is not yet a connection to
userspace controls for this functionality?

Just looking out for bisectability...

							Thanx, Paul

> Inspired-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.h        |  1 +
>  kernel/rcu/tree_plugin.h | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 5b37f7103b0d..ca69238e2227 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -254,6 +254,7 @@ struct rcu_data {
>  };
>  
>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
> +#define RCU_NOCB_WAKE_OFF	-1
>  #define RCU_NOCB_WAKE_NOT	0
>  #define RCU_NOCB_WAKE		1
>  #define RCU_NOCB_WAKE_FORCE	2
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index eceef6dade9a..3361bd351f3b 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1637,6 +1637,8 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force,
>  static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  			       const char *reason)
>  {
> +	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_OFF)
> +		return;
>  	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT)
>  		mod_timer(&rdp->nocb_timer, jiffies + 1);
>  	if (rdp->nocb_defer_wakeup < waketype)
> @@ -2214,7 +2216,7 @@ static int rcu_nocb_cb_kthread(void *arg)
>  /* Is a deferred wakeup of rcu_nocb_kthread() required? */
>  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp)
>  {
> -	return READ_ONCE(rdp->nocb_defer_wakeup);
> +	return READ_ONCE(rdp->nocb_defer_wakeup) > RCU_NOCB_WAKE_NOT;
>  }
>  
>  /* Do a deferred wakeup of rcu_nocb_kthread(). */
> @@ -2299,6 +2301,12 @@ static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
>  	swait_event_exclusive(rdp->nocb_state_wq,
>  			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
>  							SEGCBLIST_KTHREAD_GP));
> +
> +	/* Make sure nocb timer won't stay around */
> +	rcu_nocb_lock_irqsave(rdp, flags);
> +	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_OFF);
> +	rcu_nocb_unlock_irqrestore(rdp, flags);
> +	del_timer_sync(&rdp->nocb_timer);
>  }
>  
>  static long rcu_nocb_rdp_deoffload(void *arg)
> @@ -2344,6 +2352,8 @@ static void __rcu_nocb_rdp_offload(struct rcu_data *rdp)
>  	 * SEGCBLIST_SOFTIRQ_ONLY mode.
>  	 */
>  	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> +	/* Re-enable nocb timer */
> +	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
>  	/*
>  	 * We didn't take the nocb lock while working on the
>  	 * rdp->cblist in SEGCBLIST_SOFTIRQ_ONLY mode.
> -- 
> 2.28.0
> 
