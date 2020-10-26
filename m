Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13800298C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774635AbgJZMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774626AbgJZMBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:01:09 -0400
Received: from localhost (unknown [176.177.109.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D5B22281;
        Mon, 26 Oct 2020 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603713668;
        bh=qdf3h/zutIWsyOkbj2VUmEclleb3GPZkmclXVLokVKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbJZNQYTer006cByNMjTPUHvd3UNK0MlXIC2nTyROKg4alhernbaDnHKL74hstsjT
         Dn7yIiWD90IZv5iYoHOtjzDB/m7dLXQtXprxPZN2Vzcv/OiW16YxIPcTfh+nfBHUI5
         GAS3RubBikxT4OPWhVzsI6KHZM1elJyIOtwK7/ro=
Date:   Mon, 26 Oct 2020 13:01:06 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v8 5/6] rcu/tree: segcblist: Remove redundant smp_mb()s
Message-ID: <20201026120106.GF104441@lothringen>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021190813.3005054-6-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


65;6003;1cOn Wed, Oct 21, 2020 at 03:08:12PM -0400, Joel Fernandes (Google) wrote:
> This memory barrier is not needed as rcu_segcblist_add_len() already
> includes a memory barrier *before* the length of the list is updated.

*before* and *after*.

As you have both cases below.

Thanks

> 
> Same reasoning for rcu_segcblist_enqueue().
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 1 -
>  kernel/rcu/tree.c          | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 19ff82b805fb..f0fcdf9d0f7f 100644
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
> index 346a05506935..6c6d3c7036e6 100644
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
> 2.29.0.rc1.297.gfa9743e501-goog
> 
