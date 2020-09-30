Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EEC27E857
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgI3MSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3MSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:18:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:18:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o5so1084530qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AyhI4SDCTjbfs6U5TjKqKUjfQf8hLkCN3h3alZHnSNU=;
        b=MDDDWob0vNANB6fp89L7DaIVT9nKvCQmL7EpxuzcuvHOSPxum48BdU9QUIK1JhmVBt
         7o8diu1Tvt5WKx74I8KrZ3NwUBN8lVMLtIRQTZiOJxRIMJlptsH3e136kEFVcU8fmAJQ
         70fk9vvjoTmpkn+lkri9jL66Jo+7wAvP3kvsL1v4kXtidwQw3WsnY5cU2DKe6oOBv+lt
         RePIt4J9OAp1AM/HSK1pL8uN5N7LNwcjyDrmScMyoLoxN5vAHatOe5IZ+f4UtOeIk2xM
         8PG+mXdK0asVm0d4e1Jae+nlwK91I14HD2Y07fVHr/v6sfP1GzZej/CAYT4x3xxp3y0M
         jA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AyhI4SDCTjbfs6U5TjKqKUjfQf8hLkCN3h3alZHnSNU=;
        b=J8u0jq0T4+or8zGxSdVxnabCNhtSWOH8NOYlvljKhps61vbAQxr22y8+NkxTxUNe/Z
         Tmwh0LMwNR4wkzgIhBm/V1ULRg6n9v61d08bUHHJ3B8dN/9mCx+6Wo+Lr4iPeYj98LT2
         jaQA/oyKEpz2VL30kd18GGNMMSn0U8PR0CX1eEhqthQ+aO/X2ovOGekmuRVZtFaNUXJ3
         7wSjlDaHwiHdJuV3AqyaQCeXvAgr4Lw4Rx47rZxwTLLxZ5iGbOBWqdiTcYMaIrqa83Lu
         1qjCKf3gTUdjbqgHKOytRNNQp3n2r84IHSAfzDoaF9fRrIM6b+shsW8/9CMipLwMDWrm
         b8NQ==
X-Gm-Message-State: AOAM531GLv2n2pkXnzRyH2/v+o98EBw8LLYMbtY1O2zP2XZMfbY0pzYO
        GzDs+uqOCn1ajTdQONC/7qI=
X-Google-Smtp-Source: ABdhPJzze9ETO0Jx3Cu7WNhTph/8nBDoeO1B5Gv6wH8fU+w/P7iWVg3IGDTQRiziJEWuSrTOiDpxhQ==
X-Received: by 2002:a37:b342:: with SMTP id c63mr2360383qkf.146.1601468303741;
        Wed, 30 Sep 2020 05:18:23 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 18sm1870112qkd.120.2020.09.30.05.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 05:18:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 66CB427C0054;
        Wed, 30 Sep 2020 08:18:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 30 Sep 2020 08:18:21 -0400
X-ME-Sender: <xms:jHd0X7Me5njtqa9gvmWky4Wwc-AJJfcp48GX3A7wF9NBJI-T06wexQ>
    <xme:jHd0X18AigiOeEswrJ_V3HZW3m9hWfpwKkZVJfsaMXDSuZm1NDEG1IUqVPj6HJ4tC
    tWRrsROr-v2BKqJ7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphephedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:jHd0X6TaC1DirWu5yO_P7Vp7NBc2uhgMqwlAvlxss5alkA3GmRylrA>
    <xmx:jHd0X_vbjsei58Q5zvzoa8ryzwJo35vffOjfjmrNKkkIvda3pvJLJQ>
    <xmx:jHd0XzfwHgNkE8aVZ8pCaCA6bbFHYdy3KewFDDA3rJ6UUgEZMB4b0w>
    <xmx:jXd0X0F8k0W5dcWKhR-_rbb7MOh0jgysdv6yYCRcCWeMbw0fdTyPKQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56C4B3064674;
        Wed, 30 Sep 2020 08:18:20 -0400 (EDT)
Date:   Wed, 30 Sep 2020 20:18:18 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     g@hirez.programming.kicks-ass.net, Qian Cai <cai@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep null-ptr-deref
Message-ID: <20200930121818.GD17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
 <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930091610.GV2628@hirez.programming.kicks-ass.net>
 <20200930094937.GE2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:49:37AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 30, 2020 at 11:16:11AM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 30, 2020 at 07:08:23AM +0800, Boqun Feng wrote:
> > > I think there are two problems here:
> > > 
> > > 1) the "(null)" means we don't have the "usage_str" for a usage bit,
> > > which I think is the LOCK_USED_READ bit introduced by Peter at
> > > 23870f122768 ('locking/lockdep: Fix "USED" <- "IN-NMI" inversions').
> > > 
> > > 2) the next null-ptr-deref, and I think this is also caused by
> > > LOCK_USED_READ bit, because in the loop inside
> > > print_lock_class_header(), we iterate from 0 to LOCK_USAGE_STATES (which
> > > is 4*2 + 3), however the class->usage_traces[] only has
> > > XXX_LOCK_USAGE_STATES (which is 4*2 + 1) elements, so if we have
> > > LOCK_USED_READ bit set in ->usage_mask, we will try to access an element
> > > out of the ->usage_traces[] array.
> > > 
> > > Probably the following helps? And another possible fix is to enlarge the
> > > ->usage_trace[] array and record the call trace of LOCK_READ_USED.
> > 
> > Urgh.. yeah, I wanted to avoid saving that trace; it's pretty useless :/
> > The existing USED trace is already mostly pointless, the consistent
> > thing would be to remove both but that might be too radical.
> > 
> > But you're right in that I made a right mess of it. Not sure what's
> > best here.
> > 
> > Let me have a play.
> 
> How's something like this? It's bigger than I'd like, but I feel the
> result is more consistent/readable.
> 

Looks good to me.

For one thing, I do think that LOCK_READ_USED trace is helpful for
better reporting, because if there is a read lock in the dependency path
which causes the deadlock, it's better to have the LOCK_READ_USED trace
to know at least the initial READ usage. For example, if we have

	void f1(...)
	{
		write_lock(&A);
		spin_lock(&C);
		// A -> C
		...
	}

	void g(...)
	{
		read_lock(&A);
		...
	}
	void f2(...)
	{
		spin_lock(&B);
		g(...);
		// B -> A
	}

	void f3(...) {
		spin_lock(&C);
		spin_lock(&B);
		// C -> B, trigger lockdep splat
	}

when lockdep reports the deadlock (at the time f3() is called), it will
be useful if we have a trace like:

	INITIAL READ usage at:
	g+0x.../0x...
	f2+0x.../0x...

Thoughts?

Regards,
Boqun

> ---
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index bb35b449f533..a55b1d314ae8 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -35,8 +35,12 @@ enum lockdep_wait_type {
>  /*
>   * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
>   * the total number of states... :-(
> + *
> + * XXX_LOCK_USAGE_STATES is the number of lines in lockdep_states.h, for each
> + * of those we generates 4 states, Additionally we (for now) report on USED.
>   */
> -#define XXX_LOCK_USAGE_STATES		(1+2*4)
> +#define XXX_LOCK_USAGE_STATES		2
> +#define LOCK_TRACE_STATES		(XXX_LOCK_USAGE_STATES*4 + 1)
>  
>  /*
>   * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
> @@ -106,7 +110,7 @@ struct lock_class {
>  	 * IRQ/softirq usage tracking bits:
>  	 */
>  	unsigned long			usage_mask;
> -	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
> +	const struct lock_trace		*usage_traces[LOCK_TRACE_STATES];
>  
>  	/*
>  	 * Generation counter, when doing certain classes of graph walking,
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 454355c033d2..4f98ac8b4575 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -600,6 +600,8 @@ static const char *usage_str[] =
>  #include "lockdep_states.h"
>  #undef LOCKDEP_STATE
>  	[LOCK_USED] = "INITIAL USE",
> +	[LOCK_USED_READ] = "INITIAL READ USE",
> +	/* abused as string storage for verify_lock_unused() */
>  	[LOCK_USAGE_STATES] = "IN-NMI",
>  };
>  #endif
> @@ -2231,7 +2233,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
>  #endif
>  	printk(KERN_CONT " {\n");
>  
> -	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
> +	for (bit = 0; bit < LOCK_TRACE_STATES; bit++) {
>  		if (class->usage_mask & (1 << bit)) {
>  			int len = depth;
>  
> @@ -4354,27 +4356,24 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
>  	old_mask = hlock_class(this)->usage_mask;
>  	hlock_class(this)->usage_mask |= new_mask;
>  
> -	/*
> -	 * Save one usage_traces[] entry and map both LOCK_USED and
> -	 * LOCK_USED_READ onto the same entry.
> -	 */
> -	if (new_bit == LOCK_USED || new_bit == LOCK_USED_READ) {
> -		if (old_mask & (LOCKF_USED | LOCKF_USED_READ))
> -			goto unlock;
> -		new_bit = LOCK_USED;
> +	if (new_bit < LOCK_TRACE_STATES) {
> +		if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
> +			return 0;
>  	}
>  
> -	if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
> -		return 0;
> -
>  	switch (new_bit) {
> +	case 0 ... LOCK_USED-1:
> +		ret = mark_lock_irq(curr, this, new_bit);
> +		if (!ret)
> +			return 0;
> +		break;
> +
>  	case LOCK_USED:
>  		debug_atomic_dec(nr_unused_locks);
>  		break;
> +
>  	default:
> -		ret = mark_lock_irq(curr, this, new_bit);
> -		if (!ret)
> -			return 0;
> +		break;
>  	}
>  
>  unlock:
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index b0be1560ed17..67dc46e46552 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -20,9 +20,12 @@ enum lock_usage_bit {
>  #undef LOCKDEP_STATE
>  	LOCK_USED,
>  	LOCK_USED_READ,
> -	LOCK_USAGE_STATES
> +	LOCK_USAGE_STATES,
>  };
>  
> +/* states after LOCK_USED are not traced and printed */
> +static_assert(LOCK_TRACE_STATES == LOCK_USED_READ);
> +
>  #define LOCK_USAGE_READ_MASK 1
>  #define LOCK_USAGE_DIR_MASK  2
>  #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
> @@ -121,7 +124,7 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>  extern struct list_head all_lock_classes;
>  extern struct lock_chain lock_chains[];
>  
> -#define LOCK_USAGE_CHARS (1+LOCK_USAGE_STATES/2)
> +#define LOCK_USAGE_CHARS (2*XXX_LOCK_USAGE_STATES + 1)
>  
>  extern void get_usage_chars(struct lock_class *class,
>  			    char usage[LOCK_USAGE_CHARS]);
