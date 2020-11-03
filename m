Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27472A4DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKCSDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:03:19 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F01C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:03:19 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 12so11734195qkl.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5XFFRZP2f0RdQHV7wJHO5HTumhIh4bs2l1X48fl4oH4=;
        b=Bp8N5QgJ6Y9i6HADcUh9KS66ha99MTatHRYbQgFAVAA+0qQBCpdbKjLBNLZCjmQK4A
         A1MiaO7wyTO3JfQaJ4Pu83ZZKijtKPlKaw/s2wPGWRsrn88pUHJ2GQfayJ8NQH2dUize
         kfWgZHRC2pFxWai+ZmwrwQcpnjGgIRWZ+5i3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XFFRZP2f0RdQHV7wJHO5HTumhIh4bs2l1X48fl4oH4=;
        b=UoJIETTT3+3h/Id/zYC/5aHZ+L8Zwnl0XTGxj52z41HLvDfRiCL6GDQB1uzuAkjSiL
         8rz3G7Kn9dg9yYHLrhreqRmYlbN3QM7vZuxu8jk73xXNJYik6QhUfyu8HjRYk9stQpNO
         ZXIDYTIYHj1gOlpxIQQDS65/uGjX9/EXJQcGddTdFkwwiAvOuuBgfPNS4vrqGOQJNdWf
         zVPY0TkYPjsZFtkj4RK3WzRVji9bn1Gd7TI+quQLyi1jg0/oZQxjnVBscjZia0PKV0tN
         9mfiA3M6DKL0tDt1XYeYa9OpSx+xTHjKbpZl8y+aDS8ZNOPry//EU222dqgoZcaddQhs
         R4Ug==
X-Gm-Message-State: AOAM5326TxlLonm8hTmLoY/0ZUpmCODhSQA20HLNjHjdyj93xXETOBgA
        qWIowysZItke07yMfw1HBUD0/A==
X-Google-Smtp-Source: ABdhPJzyW/p+V6Xbddn7RRVe4Hbha2/V8DJOWqWb0D7EORI3aiDKLnmYRD3jrZPA9ibCRnuex5jXZA==
X-Received: by 2002:ae9:ef56:: with SMTP id d83mr21266624qkg.83.1604426597696;
        Tue, 03 Nov 2020 10:03:17 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x21sm11429076qkb.78.2020.11.03.10.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:03:17 -0800 (PST)
Date:   Tue, 3 Nov 2020 13:03:16 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 15/16] rcu/tree: Allocate a page when caller is
 preemptible
Message-ID: <20201103180316.GC1310511@google.com>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-15-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029165019.14218-15-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,
Few minor nits:

On Thu, Oct 29, 2020 at 05:50:18PM +0100, Uladzislau Rezki (Sony) wrote:
> Given that CONFIG_PREEMPT_COUNT is unconditionally enabled by the
> earlier commits in this series, the preemptible() macro now properly
> detects preempt-disable code regions even in kernels built with
> CONFIG_PREEMPT_NONE.
> 
> This commit therefore uses preemptible() to determine whether allocation
> is possible at all for double-argument kvfree_rcu().  If !preemptible(),
> then allocation is not possible, and kvfree_rcu() falls back to using
> the less cache-friendly rcu_head approach.  Even when preemptible(),
> the caller might be involved in reclaim, so the GFP_ flags used by
> double-argument kvfree_rcu() must avoid invoking reclaim processing.
> 
> Note that single-argument kvfree_rcu() must be invoked in sleepable
> contexts, and that its fallback is the relatively high latency
> synchronize_rcu().  Single-argument kvfree_rcu() therefore uses
> GFP_KERNEL|__GFP_RETRY_MAYFAIL to allow limited sleeping within the
> memory allocator.
> 
> [ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 48 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f2da2a1cc716..3f9b016a44dc 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3406,37 +3406,55 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  	}
>  }
>  
> +// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> +// state specified by flags.  If can_sleep is true, the caller must
> +// be schedulable and not be holding any locks or mutexes that might be
> +// acquired by the memory allocator or anything that it might invoke.
> +// If !can_sleep, then if !preemptible() no allocation will be undertaken,
> +// otherwise the allocation will use GFP_ATOMIC to avoid the remainder of
> +// the aforementioned deadlock possibilities.  Returns true if ptr was
> +// successfully recorded, else the caller must use a fallback.
>  static inline bool
> -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> +	unsigned long *flags, void *ptr, bool can_sleep)
>  {
>  	struct kvfree_rcu_bulk_data *bnode;
> +	bool can_alloc_page = preemptible();
> +	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL :
> +		GFP_ATOMIC) | __GFP_NOWARN;
>  	int idx;
>  
> -	if (unlikely(!krcp->initialized))
> +	*krcp = krc_this_cpu_lock(flags);
> +	if (unlikely(!(*krcp)->initialized))
>  		return false;
>  
> -	lockdep_assert_held(&krcp->lock);
>  	idx = !!is_vmalloc_addr(ptr);
>  
>  	/* Check if a new block is required. */

Maybe convert this comment also to //... like the new ones you added (and the
ones below).

> -	if (!krcp->bkvhead[idx] ||
> -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> -		bnode = get_cached_bnode(krcp);
> -		/* Switch to emergency path. */
> +	if (!(*krcp)->bkvhead[idx] ||
> +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> +		bnode = get_cached_bnode(*krcp);
> +		if (!bnode && can_alloc_page) {

I think you can directly put preemptible() here with a comment saying
allocate only if preemptible and get rid of can_alloc_page.

> +			krc_this_cpu_unlock(*krcp, *flags);
> +			bnode = (struct kvfree_rcu_bulk_data *)
> +				__get_free_page(gfp);
> +			*krcp = krc_this_cpu_lock(flags);
> +		}
> +

I think the "Switch to emergency path" comment should stay here before the
if().

thanks,

 - Joel

>  		if (!bnode)
>  			return false;
>  
>  		/* Initialize the new block. */
>  		bnode->nr_records = 0;
> -		bnode->next = krcp->bkvhead[idx];
> +		bnode->next = (*krcp)->bkvhead[idx];
>  
>  		/* Attach it to the head. */
> -		krcp->bkvhead[idx] = bnode;
> +		(*krcp)->bkvhead[idx] = bnode;
>  	}
>  
>  	/* Finally insert. */
> -	krcp->bkvhead[idx]->records
> -		[krcp->bkvhead[idx]->nr_records++] = ptr;
> +	(*krcp)->bkvhead[idx]->records
> +		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
>  
>  	return true;
>  }
> @@ -3474,20 +3492,16 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		ptr = (unsigned long *) func;
>  	}
>  
> -	krcp = krc_this_cpu_lock(&flags);
> -
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(ptr)) {
>  		// Probable double kfree_rcu(), just leak.
>  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
>  			  __func__, head);
>  
> -		// Mark as success and leave.
> -		success = true;
> -		goto unlock_return;
> +		return;
>  	}
>  
> -	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> +	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
>  	if (!success) {
>  		run_page_cache_worker(krcp);
>  
> -- 
> 2.20.1
> 
