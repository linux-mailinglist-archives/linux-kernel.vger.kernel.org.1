Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70733001CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhAVLmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:42:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbhAVLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:18:32 -0500
Date:   Fri, 22 Jan 2021 12:17:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611314253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwTRQGMy0i03jZO3dB3PKOrJQEnXm5M6Cbl9HlVv5ow=;
        b=yED0gM023rMSdxj6jRSDaYAczCErP0qbcKBAHB7OnuzqdueVSkP3OEVtJpMfz8GV6Bitiv
        DiN6oOvRfx2mAqIYseZWlsOt2tPVVEIbOKITyG9moGoFqBoZfn9/zG+7nuJMJBDPL7W1Q9
        DfntvM+jqzrx/+gw9/I7rvaDjjR/86DqQ30b4Jv2keGNezI8gue3jq0rSvcbdHs0XznNUt
        dVzPg0ZBKX9Vv6qjIpjQuVvqLwOuJpcJ29q3/0ibCkvrpyHdoMHOfiAd+QvyW8X96xkLjJ
        fB/+GSpiz14duYdpsfzHncuAjdL6cYgMa+7fH6fUTzzhbNUTsbinm7dGgSHcIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611314253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwTRQGMy0i03jZO3dB3PKOrJQEnXm5M6Cbl9HlVv5ow=;
        b=a7/ZJEji7l60cuGN/7n76DIsiqc37nyZDZTFCap6sq18Kw+tVHZtqkMWY/nzwUge7wQk2i
        y4kA3bl+yP1a/7BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210122111733.tcwfl43akypz3x42@linutronix.de>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
 <20210120215403.GH2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120215403.GH2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 13:54:03 [-0800], Paul E. McKenney wrote:
> > > +// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> > > +// state specified by flags.  If can_alloc is true, the caller must
> > > +// be schedulable and not be holding any locks or mutexes that might be
> > > +// acquired by the memory allocator or anything that it might invoke.
> > > +// Returns true if ptr was successfully recorded, else the caller must
> > > +// use a fallback.
> > 
> > The whole RCU department is getting swamped by the // comments. Can't we
> > have proper kernel doc and /* */ style comments like the remaining part
> > of the kernel?
> 
> Because // comments are easier to type and take up less horizontal space.

As for the typing I could try to sell you 
  ab // /*

for your .vimrc and then //<enter> would become /* ;) As for the
horizontal space, I don't have currently anything in my shop. I'm sorry.

> Also, this kvfree_call_rcu_add_ptr_to_bulk() function is local to
> kvfree_rcu(), and we don't normally docbook-ify such functions.

I didn't mean to promote using docbook to use every. For instance if you
look at kernel/trace/trace.c, there are no // comments around, just /*
style, even for things like tracing_selftest_running.

Basically I was curious if I could learn where this // is coming and if
I could stop it.

> > >  static inline bool
> > > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> > > +	unsigned long *flags, void *ptr, bool can_alloc)
> > >  {
> > >  	struct kvfree_rcu_bulk_data *bnode;
> > >  	int idx;
> > >  
> > > -	if (unlikely(!krcp->initialized))
> > > +	*krcp = krc_this_cpu_lock(flags);
> > > +	if (unlikely(!(*krcp)->initialized))
> > >  		return false;
> > >  
> > > -	lockdep_assert_held(&krcp->lock);
> > >  	idx = !!is_vmalloc_addr(ptr);
> > >  
> > >  	/* Check if a new block is required. */
> > > -	if (!krcp->bkvhead[idx] ||
> > > -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > -		bnode = get_cached_bnode(krcp);
> > > -		/* Switch to emergency path. */
> > > +	if (!(*krcp)->bkvhead[idx] ||
> > > +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > +		bnode = get_cached_bnode(*krcp);
> > > +		if (!bnode && can_alloc) {
> > > +			krc_this_cpu_unlock(*krcp, *flags);
> > > +			bnode = (struct kvfree_rcu_bulk_data *)
> > 
> > There is no need for this cast.
> 
> Without it, gcc version 7.5.0 says:
> 
> 	warning: assignment makes pointer from integer without a cast
> 

I'm sorry. I forgot the part where __get_free_page() does not return
(void *).
But maybe it should given that free_pages() casts that long back to
(void *) and __get_free_pages() -> page_address() returns (void *)
which is then casted long.

> > > +				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> > > +			*krcp = krc_this_cpu_lock(flags);
> > 
> > so if bnode is NULL you could retry get_cached_bnode() since it might
> > have been filled (given preemption or CPU migration changed something).
> > Judging from patch #3 you think that a CPU migration is a bad thing. But
> > why?
> 
> So that the later "(*krcp)->bkvhead[idx] = bnode" assignment associates
> it with the correct CPU.
> 
> Though now that you mention it, couldn't the following happen?
> 
> o	Task A on CPU 0 notices that allocation is needed, so it
> 	drops the lock disables migration, and sleeps while
> 	allocating.
> 
> o	Task B on CPU 0 does the same.
> 
> o	The two tasks wake up in some order, and the second one
> 	causes trouble at the "(*krcp)->bkvhead[idx] = bnode"
> 	assignment.

Yes it could, good point.
I would really recommend using migrate_disable() at a minimum and only
if it is really needed. It is more expensive than preempt_disable() and
it isn't exactly good in terms of scheduling since the task is run able
but restricted to a specific CPU.
If it is unavoidable it is unavoidable but in this case I wouldn't use
migrate_disable() but re-evaluate the situation after the allocation.

> Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
> the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?
> 
> 							Thanx, Paul

Sebastian
