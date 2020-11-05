Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC002A7641
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgKED5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgKED5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:57:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5742F20786;
        Thu,  5 Nov 2020 03:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604548634;
        bh=qIk9u05EWbRNA4eKZJAdxo+1qirS9mO9h6wHQ8e1bcY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hFEcJZXTgiWX3DxNomAa86O2q4gKtQmVlmgTeI/mNcbxC1rJhj833Zt/b4/Wq0bgI
         GFjZ4fJSwoSk7ww2OkQdvr2hjv2e3oiJu02hO9q4k6nmw04C1iz9FdK5kgAw0/oJiW
         glhV9B1R9OKJOydhWAS2UOlOc2P9df21wYP1SrxQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F3E423522683; Wed,  4 Nov 2020 19:57:13 -0800 (PST)
Date:   Wed, 4 Nov 2020 19:57:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 6/7] rcu/tree: segcblist: Remove redundant smp_mb()s
Message-ID: <20201105035713.GL3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103142603.1302207-7-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:26:02AM -0500, Joel Fernandes (Google) wrote:
> This memory barrier is not needed as rcu_segcblist_add_len() already
> includes a memory barrier *before* and *after* the length of the list is
> updated.
> 
> Same reasoning for rcu_segcblist_enqueue().

I suggest a commit log like the following:

------------------------------------------------------------------------

The full memory barriers in rcu_segcblist_enqueue() and in rcu_do_batch()
are not needed because rcu_segcblist_add_len(), and thus also
rcu_segcblist_inc_len(), already includes a memory barrier *before*
and *after* the length of the list is updated.

This commit therefore removes these redundant smp_mb() invocations.

------------------------------------------------------------------------

Other than that, looks good!  I could hand-apply it, but that
would just cause more churn with the addition of the call to
rcu_segcblist_inc_seglen().  So could you please update the commit log
when you repost, whether to the mailing list or from your git tree?

							Thanx, Paul

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 1 -
>  kernel/rcu/tree.c          | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index e9e72d72f7a6..d96272e8d604 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -268,7 +268,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
>  			   struct rcu_head *rhp)
>  {
>  	rcu_segcblist_inc_len(rsclp);
> -	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
>  	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
>  	rhp->next = NULL;
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f6c6653b3ec2..fb2a5ac4a59c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  
>  	/* Update counts and requeue any remaining callbacks. */
>  	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
> -	smp_mb(); /* List handling before counting for rcu_barrier(). */
>  	rcu_segcblist_add_len(&rdp->cblist, -count);
>  
>  	/* Reinstate batch limit if we have worked down the excess. */
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
