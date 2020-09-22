Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29427373B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgIVAWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgIVAWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:22:16 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EDFB23A79;
        Tue, 22 Sep 2020 00:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600734135;
        bh=e49y5Dzl/hUqqNxBXDA/Rg4oTBr9m/jjIdqj+E/Qoc8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BM5fK/PdIsIS60cl3zh44bMoEvkYOCEyBM2LQXtosuNCflZZ9/fls6bOL4Bx9/zBE
         BYtZEuh0ZhwTt/kdlXBycEvMTPt2rtLdbbGhTuvg0eUN2JQ3wkbgLsrJKx81tQ49x1
         S2k6EB0wKvFAOPalC7kt5UoIQvQoYsBPlPkpn+kw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 088B735226C1; Mon, 21 Sep 2020 17:22:15 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:22:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 10/12] rcu: Process batch locally as long as
 offloading isn't complete
Message-ID: <20200922002214.GQ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-11-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921124351.24035-11-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:43:49PM +0200, Frederic Weisbecker wrote:
> During the offloading or de-offloading process, make sure to process
> the callbacks batch locally whenever the segcblist isn't entirely
> offloaded. This enforces callback service processing while we are still
> in intermediate (de-)offloading state.
> 
> FIXME: Note that __call_rcu_core() isn't called during these intermediate
> states. Some pieces there may still be necessary.

Joel's per-segment callback-count work might help there, though I believe
that to be a separate issue.

The key point is that if there are a lot of callbacks, but all of them
are ready to be invoked, then there isn't much point in making the
grace periods complete faster.  Right now, lacking per-segment counts,
RCU just assumes that none of the callbacks are ready to be invoked.

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
>  kernel/rcu/rcu_segcblist.h | 12 ++++++++++++
>  kernel/rcu/tree.c          |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 00ebeb8d39b7..f7da3d535888 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -92,6 +92,18 @@ static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
>  	return false;
>  }
>  
> +static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rsclp)
> +{
> +	int flags = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP | SEGCBLIST_OFFLOADED;
> +
> +	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
> +		if ((rsclp->flags & flags) == flags)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * Are all segments following the specified segment of the specified
>   * rcu_segcblist structure empty of callbacks?  (The specified
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b4292489db0c..928907e9ba94 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2620,6 +2620,7 @@ static __latent_entropy void rcu_core(void)
>  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
>  	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
>  
>  	if (cpu_is_offline(smp_processor_id()))
>  		return;
> @@ -2649,7 +2650,7 @@ static __latent_entropy void rcu_core(void)
>  	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
>  
>  	/* If there are callbacks ready, invoke them. */
> -	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist) &&
> +	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
>  	    likely(READ_ONCE(rcu_scheduler_fully_active)))
>  		rcu_do_batch(rdp);
>  
> -- 
> 2.28.0
> 
