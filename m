Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A6127AB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgI1Jrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgI1Jro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:47:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB20C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:47:44 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k25so241712qtu.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h6dtZrQEHTVXDQ9SWrxyMq7ApTdHga02y4/uZKx0ah0=;
        b=CeISYcFT/NpMRZxKb0K1XGuFPSTQtWnbBadKmNQrkuOHjvt/yzDqoGVS7mVIQP+E/h
         xkIo+trErcbaoXLBhKAnyMdmOB/c0WjZe9SJH8zLx4Kr1nqziWoUll2qKNi1dL6lJvrZ
         wQtAZeEWeaJo5TG0SCqG09YtiOoTMq0pEJ6pfYbJTA8OcG9/HkQ4adBgABm0icWNjJjg
         flCzEHy9LVswJJo135Jl9ygANxwocg2nhhsrypYQB2xmOBzEth1bDIeF+kHehtFFGtvF
         q3rwr1hu59+oSxP0guY1/zNY6uXXxnxamfqT3QOUUsztJ8LHXBaTbtu9oRyEp1K9JVix
         9pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h6dtZrQEHTVXDQ9SWrxyMq7ApTdHga02y4/uZKx0ah0=;
        b=DlHG4vuEvFp3CRj+QGorXCGry3wId+9hxr8nrhzxVqngwtbMTvZcUE/DtbWjumgHCN
         5u2ucq5ASK0iTQqtHnOIF9qo/XVKaHS6+4Y9biWdIdVERq5ysZJ0HOjBWVJSpHC75bf0
         zpaKtVIkFZ3B6OfBOlBlrdH9cqHvLyRMr1yXUImSvjCmQH7b+rvs8lPVcDPp7+HwPXms
         9HoF/zB8GwZIwaPWCcpsJe7nd9HYeG4ZVSSknxmOgL7q7a2OKBpAnqr5LlY3mEhPfHSE
         maxCyQPR7I8NAexD1OSYAlnzjgNwFmIFExMHFhOKva4h/PU7NHLHvII0KzfsmOzjn+MD
         XwHQ==
X-Gm-Message-State: AOAM531D2DmPM9w/qA+vbwFC6mk4TxuEAW75vHV/eksZYDC8ZyiaRHoG
        LNr71PoJ6HBEwmPhMdSXZuA=
X-Google-Smtp-Source: ABdhPJwLwjG56DIQxYEwIQ85owFpv+QvFWlm9SEAw9R9lABJ4ZHNldV3VI3jdV8ctVEXwuZl4aWX4Q==
X-Received: by 2002:ac8:4e19:: with SMTP id c25mr663300qtw.283.1601286463372;
        Mon, 28 Sep 2020 02:47:43 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m18sm435847qkg.77.2020.09.28.02.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 02:47:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 26C8027C0058;
        Mon, 28 Sep 2020 05:47:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 28 Sep 2020 05:47:42 -0400
X-ME-Sender: <xms:PLFxX9UTg8xhUwSwu10XKZdAPE7UGUGY9gnXFIhe4pbEYXL8NApIng>
    <xme:PLFxX9nr8h3GOiw5OJenQJO7BfxKsciRZ1toF5E9qq250AwxeYz01hXQ5oZDaPKtk
    dEeyDSlPkhvyANXAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduud
    drjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhi
    gihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:PLFxX5a5v5HkAqhKsRsrvGEf2bqBRJOhV8uUy5v9nekwbIdWhBhq4w>
    <xmx:PLFxXwU1ir6HkBQfZGdSTgh55_4OgIUA1cTgZ8QoZMdkL6iGcnQLng>
    <xmx:PLFxX3nVWr_Gdi2U7TFtgMWJ_1Y2psOf7cWmrXDxrdxOrGY5nXDJ4Q>
    <xmx:PrFxXwDVTu2r2v5VMMsKcJV6f9tuq0AQwP3b_LlhopC2cQ9l7RE5IQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75420328005D;
        Mon, 28 Sep 2020 05:47:40 -0400 (EDT)
Date:   Mon, 28 Sep 2020 17:47:38 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Qian Cai <cai@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lockdep: Optimize the memory usage of circular queue
Message-ID: <20200928094738.GB17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200917080210.108095-1-boqun.feng@gmail.com>
 <20200928085104.GE2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928085104.GE2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:51:04AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 17, 2020 at 04:01:50PM +0800, Boqun Feng wrote:
> 
> >  	__cq_init(cq);
> >  	__cq_enqueue(cq, source_entry);
> >  
> > +	while (lock || (lock = __cq_dequeue(cq))) {
> > +		if (!lock->class)
> > +			return BFS_EINVALIDNODE;
> >  
> >  		/*
> > +		 * Step 1: check whether we already finish on this one.
> > +		 *
> >  		 * If we have visited all the dependencies from this @lock to
> >  		 * others (iow, if we have visited all lock_list entries in
> >  		 * @lock->class->locks_{after,before}) we skip, otherwise go
> 
> > @@ -1698,29 +1685,68 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
> >  
> >  			/* If nothing left, we skip */
> >  			if (!dep)
> > +				goto next;
> >  
> >  			/* If there are only -(*R)-> left, set that for the next step */
> > +			lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> > +		}
> >  
> > +		/*
> > +		 * Step 3: we haven't visited this and there is a strong
> > +		 *         dependency path to this, so check with @match.
> > +		 */
> > +		if (match(lock, data)) {
> > +			*target_entry = lock;
> > +			return BFS_RMATCH;
> > +		}
> > +
> > +		/*
> > +		 * Step 4: if not match, expand the path by adding the
> > +		 *         afterwards or backwards dependencis in the search
> > +		 *
> > +		 * Note we only enqueue the first of the list into the queue,
> > +		 * because we can always find a sibling dependency from one
> > +		 * (see label 'next'), as a result the space of queue is saved.
> > +		 */
> > +		head = get_dep_list(lock, offset);
> > +		entry = list_first_or_null_rcu(head, struct lock_list, entry);
> > +		if (entry) {
> > +			unsigned int cq_depth;
> > +
> > +			if (__cq_enqueue(cq, entry))
> > +				return BFS_EQUEUEFULL;
> >  
> >  			cq_depth = __cq_get_elem_count(cq);
> >  			if (max_bfs_queue_depth < cq_depth)
> >  				max_bfs_queue_depth = cq_depth;
> >  		}
> > +
> > +		/*
> > +		 * Update the ->parent, so when @entry is iterated, we know the
> > +		 * previous dependency.
> > +		 */
> > +		list_for_each_entry_rcu(entry, head, entry)
> > +			visit_lock_entry(entry, lock);
> 
> This confused me for a while. I think it might be a little clearer if we
> put this inside the previous block.
> 
> Alternatively, we could try and write it something like so:
> 
> 		/*
> 		 * Step 4: if not match, expand the path by adding the
> 		 *         afterwards or backwards dependencis in the search
> 		 */
> 		first = true;
> 		head = get_dep_list(lock, offset);
> 		list_for_each_entry_rcu(entry, head, entry) {
> 			visit_lock_entry(entry, lock);
> 
> 			if (!first)
> 				continue;
> 
> 			/*
> 			 * Only enqueue the first entry of the list,
> 			 * we'll iterate it's siblings at the next
> 			 * label.
> 			 */
> 			first = false;
> 			if (__cq_enqueue(cq, entry))
> 				return BFS_EQUEUEFULL;
> 
> 			cq_depth = __cq_get_elem_count(cq);
> 			if (max_bfs_queue_depth < cq_depth)
> 				max_bfs_queue_depth = cq_depth;
> 		}
> 
> Hmm?
> 

Better than mine ;-)

> > +next:
> > +		/*
> > +		 * Step 5: fetch the next dependency to process.
> > +		 *
> > +		 * If there is a previous dependency, we fetch the sibling
> > +		 * dependency in the dep list of previous dependency.
> > +		 *
> > +		 * Otherwise set @lock to NULL to fetch the next entry from
> > +		 * queue.
> > +		 */
> > +		if (lock->parent) {
> > +			head = get_dep_list(lock->parent, offset);
> > +			lock = list_next_or_null_rcu(head, &lock->entry,
> > +						     struct lock_list, entry);
> > +		} else {
> > +			lock = NULL;
> > +		}
> 
> I think that if we hide this in a __bfs_next() helper, the iteration
> becomes nicer.
> 
> >  	}
> > -exit:
> > +
> > +	return BFS_RNOMATCH;
> >  }
> 
> How's this?
> 

I think your version is better and should be functionally identical to
mine, also FWIW, I tested with a lockdep boot selftests, everything
worked fine.

Regards,
Boqun

> ---
> Subject: lockdep: Optimize the memory usage of circular queue
> From: Boqun Feng <boqun.feng@gmail.com>
> Date: Thu, 17 Sep 2020 16:01:50 +0800
> 
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> Qian Cai reported a BFS_EQUEUEFULL warning [1] after read recursive
> deadlock detection merged into tip tree recently. Unlike the previous
> lockep graph searching, which iterate every lock class (every node in
> the graph) exactly once, the graph searching for read recurisve deadlock
> detection needs to iterate every lock dependency (every edge in the
> graph) once, as a result, the maximum memory cost of the circular queue
> changes from O(V), where V is the number of lock classes (nodes or
> vertices) in the graph, to O(E), where E is the number of lock
> dependencies (edges), because every lock class or dependency gets
> enqueued once in the BFS. Therefore we hit the BFS_EQUEUEFULL case.
> 
> However, actually we don't need to enqueue all dependencies for the BFS,
> because every time we enqueue a dependency, we almostly enqueue all
> other dependencies in the same dependency list ("almostly" is because
> we currently check before enqueue, so if a dependency doesn't pass the
> check stage we won't enqueue it, however, we can always do in reverse
> ordering), based on this, we can only enqueue the first dependency from
> a dependency list and every time we want to fetch a new dependency to
> work, we can either:
> 
>   1)	fetch the dependency next to the current dependency in the
> 	dependency list
> or
> 
>   2)	if the dependency in 1) doesn't exist, fetch the dependency from
> 	the queue.
> 
> With this approach, the "max bfs queue depth" for a x86_64_defconfig +
> lockdep and selftest config kernel can get descreased from:
> 
>         max bfs queue depth:                   201
> 
> to (after apply this patch)
> 
>         max bfs queue depth:                   61
> 
> While I'm at it, clean up the code logic a little (e.g. directly return
> other than set a "ret" value and goto the "exit" label).
> 
> [1]: https://lore.kernel.org/lkml/17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com/
> 
> Reported-by: Qian Cai <cai@redhat.com>
> Reported-by: syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200917080210.108095-1-boqun.feng@gmail.com
> ---
>  kernel/locking/lockdep.c |  101 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 61 insertions(+), 40 deletions(-)
> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1606,6 +1606,15 @@ static inline void bfs_init_rootb(struct
>  	lock->only_xr = (hlock->read != 0);
>  }
>  
> +static inline struct lock_list *__bfs_next(struct lock_list *lock, int offset)
> +{
> +	if (!lock || !lock->parent)
> +		return NULL;
> +
> +	return list_next_or_null_rcu(get_dep_list(lock->parent, offset),
> +				     &lock->entry, struct lock_list, entry);
> +}
> +
>  /*
>   * Breadth-First Search to find a strong path in the dependency graph.
>   *
> @@ -1639,36 +1648,25 @@ static enum bfs_result __bfs(struct lock
>  			     struct lock_list **target_entry,
>  			     int offset)
>  {
> +	struct circular_queue *cq = &lock_cq;
> +	struct lock_list *lock = NULL;
>  	struct lock_list *entry;
> -	struct lock_list *lock;
>  	struct list_head *head;
> -	struct circular_queue *cq = &lock_cq;
> -	enum bfs_result ret = BFS_RNOMATCH;
> +	unsigned int cq_depth;
> +	bool first;
>  
>  	lockdep_assert_locked();
>  
> -	if (match(source_entry, data)) {
> -		*target_entry = source_entry;
> -		ret = BFS_RMATCH;
> -		goto exit;
> -	}
> -
> -	head = get_dep_list(source_entry, offset);
> -	if (list_empty(head))
> -		goto exit;
> -
>  	__cq_init(cq);
>  	__cq_enqueue(cq, source_entry);
>  
> -	while ((lock = __cq_dequeue(cq))) {
> -		bool prev_only_xr;
> -
> -		if (!lock->class) {
> -			ret = BFS_EINVALIDNODE;
> -			goto exit;
> -		}
> +	while ((lock = __bfs_next(lock, offset)) || (lock = __cq_dequeue(cq))) {
> +		if (!lock->class)
> +			return BFS_EINVALIDNODE;
>  
>  		/*
> +		 * Step 1: check whether we already finish on this one.
> +		 *
>  		 * If we have visited all the dependencies from this @lock to
>  		 * others (iow, if we have visited all lock_list entries in
>  		 * @lock->class->locks_{after,before}) we skip, otherwise go
> @@ -1680,13 +1678,13 @@ static enum bfs_result __bfs(struct lock
>  		else
>  			mark_lock_accessed(lock);
>  
> -		head = get_dep_list(lock, offset);
> -
> -		prev_only_xr = lock->only_xr;
> -
> -		list_for_each_entry_rcu(entry, head, entry) {
> -			unsigned int cq_depth;
> -			u8 dep = entry->dep;
> +		/*
> +		 * Step 2: check whether prev dependency and this form a strong
> +		 *         dependency path.
> +		 */
> +		if (lock->parent) { /* Parent exists, check prev dependency */
> +			u8 dep = lock->dep;
> +			bool prev_only_xr = lock->parent->only_xr;
>  
>  			/*
>  			 * Mask out all -(S*)-> if we only have *R in previous
> @@ -1701,26 +1699,49 @@ static enum bfs_result __bfs(struct lock
>  				continue;
>  
>  			/* If there are only -(*R)-> left, set that for the next step */
> -			entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> +			lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> +		}
> +
> +		/*
> +		 * Step 3: we haven't visited this and there is a strong
> +		 *         dependency path to this, so check with @match.
> +		 */
> +		if (match(lock, data)) {
> +			*target_entry = lock;
> +			return BFS_RMATCH;
> +		}
>  
> +		/*
> +		 * Step 4: if not match, expand the path by adding the
> +		 *         afterwards or backwards dependencis in the search
> +		 *
> +		 */
> +		first = true;
> +		head = get_dep_list(lock, offset);
> +		list_for_each_entry_rcu(entry, head, entry) {
>  			visit_lock_entry(entry, lock);
> -			if (match(entry, data)) {
> -				*target_entry = entry;
> -				ret = BFS_RMATCH;
> -				goto exit;
> -			}
> -
> -			if (__cq_enqueue(cq, entry)) {
> -				ret = BFS_EQUEUEFULL;
> -				goto exit;
> -			}
> +
> +			/*
> +			 * Note we only enqueue the first of the list into the
> +			 * queue, because we can always find a sibling
> +			 * dependency from one (see _bfs_next()), as a result
> +			 * the space of queue is saved.
> +			 */
> +			if (!first)
> +				continue;
> +
> +			first = false;
> +
> +			if (__cq_enqueue(cq, entry))
> +				return BFS_EQUEUEFULL;
> +
>  			cq_depth = __cq_get_elem_count(cq);
>  			if (max_bfs_queue_depth < cq_depth)
>  				max_bfs_queue_depth = cq_depth;
>  		}
>  	}
> -exit:
> -	return ret;
> +
> +	return BFS_RNOMATCH;
>  }
>  
>  static inline enum bfs_result
