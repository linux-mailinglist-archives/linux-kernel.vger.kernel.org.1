Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A0727374D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgIVAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbgIVAYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:24:54 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4546623A79;
        Tue, 22 Sep 2020 00:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600734293;
        bh=1i72I6ReI4I0vb4/9IrxFkMANwrUjbDHvzuX1cJumbs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d2MtSFb1NemAw+7qw55kECtaw3Ttk+ljjQMKIMaJbLRXQz1oJQGSmmC7ydNadZ3qe
         ZGd15fAfXkHBUclxrAjlkrcUsSbmOOkJ712KZsXQ15JW/EyU3ymXmljQk8cvF6MA5D
         hCBJJVVITWo56HFkkzopzKLNP/FRiP1g2d9I9eCA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EEF3535226C1; Mon, 21 Sep 2020 17:24:52 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:24:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 11/12] rcu: Locally accelerate callbacks as long as
 offloading isn't complete
Message-ID: <20200922002452.GR29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-12-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921124351.24035-12-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:43:50PM +0200, Frederic Weisbecker wrote:
> I have no idea what I'm doing but doing that looks necessary to me.

Now -there- is a commit log that inspires confidence!!!  ;-)

> Inspired-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 928907e9ba94..8cef5ea8d1f0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2619,7 +2619,6 @@ static __latent_entropy void rcu_core(void)
>  	unsigned long flags;
>  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
> -	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
>  	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
>  
>  	if (cpu_is_offline(smp_processor_id()))
> @@ -2640,11 +2639,11 @@ static __latent_entropy void rcu_core(void)
>  
>  	/* No grace period and unregistered callbacks? */
>  	if (!rcu_gp_in_progress() &&
> -	    rcu_segcblist_is_enabled(&rdp->cblist) && !offloaded) {
> -		local_irq_save(flags);
> +	    rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
> +		rcu_nocb_lock_irqsave(rdp, flags);
>  		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>  			rcu_accelerate_cbs_unlocked(rnp, rdp);

It might also be that rcu_advance_cbs() is needed somewhere.  I will
need to look carefully to work out whether either of them need to be
invoked at this particular point in the code.

							Thanx, Paul

> -		local_irq_restore(flags);
> +		rcu_nocb_unlock_irqrestore(rdp, flags);
>  	}
>  
>  	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
> -- 
> 2.28.0
> 
