Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201382AA079
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 23:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgKFWlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 17:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgKFWlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 17:41:44 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1116C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 14:41:43 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id b11so1215718qvr.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJ67opO7C728cJP3Weo9LnZt/RwZ0Q6XMY8gffqYTN8=;
        b=SwKk4P7ekzqDI8nemhvLYShZV4oWgRGNmYNMR2u8dimxwQqx2v+3dIiLUpjo/fXoKN
         ZQBUoEtAsAGAbl6nVjskEcRbqojxJwk3A6JKJSe536r8k5/reqJO6/SIyEA/tNl7lpiU
         HWOtVuRXX9BwiH4pD69o2d5abDvtaeWo7LKBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJ67opO7C728cJP3Weo9LnZt/RwZ0Q6XMY8gffqYTN8=;
        b=nYqd+h5rKVqDFdwoHXGyzY/gTohA+YrzXtJTQaSyE3z7iNSUYjxIorL1hcO+oVdgj4
         fxvEVaMCh7DN0Et13hFY8Ni6gMjsJx+rOVw8lV2QwOkbYUyhGUoBwzlgV6xo/blMXOfb
         G93EokoFNuHZsHAkcmN6vARIfnOMnJlK9uR0qqM+D3JyH0vgHdzYpPrY7iIdKqvwSWKz
         MYJvHRIxg1JeIm2ac7IjTRfH2Oi5vhdmPWFVHQm3JeZnIz1u0RBrJ4vJ4FOWrK8xY8yR
         Zy/3twLXpSYexm49HG3xuKDZSEXQwk8h23TGRM5oXVWE42cYBw2Yvat45M4FCeAFZZeX
         iUow==
X-Gm-Message-State: AOAM5335ccXdixz8tyk0j9KMuRO4ZqQW21j65r3oarIiaGbTVHWKs8M+
        hbh4ljWT6rK8vTaJtZZwk8nM7g==
X-Google-Smtp-Source: ABdhPJwlAS6XxBBDv4+ky2kP0opSdjWtxHNFiv+rAyLcs68VZB08ahycnQ5JQwGH+4yCjQBxGZMBgg==
X-Received: by 2002:a05:6214:9d2:: with SMTP id dp18mr3832526qvb.29.1604702502856;
        Fri, 06 Nov 2020 14:41:42 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id a200sm1519240qkb.66.2020.11.06.14.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 14:41:42 -0800 (PST)
Date:   Fri, 6 Nov 2020 17:41:41 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 7/7] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201106224141.GA1397669@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-8-joel@joelfernandes.org>
 <20201105185551.GO3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105185551.GO3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 10:55:51AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 03, 2020 at 09:26:03AM -0500, Joel Fernandes (Google) wrote:
> > Memory barriers are needed when updating the full length of the
> > segcblist, however it is not fully clearly why one is needed before and
> > after. This patch therefore adds additional comments to the function
> > header to explain it.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Looks good, thank you!  As always, I could not resist the urge to
> do a bit of wordsmithing, so that the queued commit is as shown
> below.  Please let me know if I messed anything up.

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 7dac7adefcae7558b3a85a16f51186d621623733
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Tue Nov 3 09:26:03 2020 -0500
> 
>     rcu/segcblist: Add additional comments to explain smp_mb()
>     
>     One counter-intuitive property of RCU is the fact that full memory
>     barriers are needed both before and after updates to the full
>     (non-segmented) length.  This patch therefore helps to assist the
>     reader's intuition by adding appropriate comments.
>     
>     [ paulmck:  Wordsmithing. ]
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index bb246d8..b6dda7c 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -94,17 +94,77 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>   * field to disagree with the actual number of callbacks on the structure.
>   * This increase is fully ordered with respect to the callers accesses
>   * both before and after.
> + *
> + * So why on earth is a memory barrier required both before and after
> + * the update to the ->len field???
> + *
> + * The reason is that rcu_barrier() locklessly samples each CPU's ->len
> + * field, and if a given CPU's field is zero, avoids IPIing that CPU.
> + * This can of course race with both queuing and invoking of callbacks.
> + * Failng to correctly handle either of these races could result in
> + * rcu_barrier() failing to IPI a CPU that actually had callbacks queued
> + * which rcu_barrier() was obligated to wait on.  And if rcu_barrier()
> + * failed to wait on such a callback, unloading certain kernel modules
> + * would result in calls to functions whose code was no longer present in
> + * the kernel, for but one example.
> + *
> + * Therefore, ->len transitions from 1->0 and 0->1 have to be carefully
> + * ordered with respect with both list modifications and the rcu_barrier().
> + *
> + * The queuing case is CASE 1 and the invoking case is CASE 2.
> + *
> + * CASE 1: Suppose that CPU 0 has no callbacks queued, but invokes
> + * call_rcu() just as CPU 1 invokes rcu_barrier().  CPU 0's ->len field
> + * will transition from 0->1, which is one of the transitions that must be
> + * handled carefully.  Without the full memory barriers before the ->len
> + * update and at the beginning of rcu_barrier(), the following could happen:
> + *
> + * CPU 0				CPU 1
> + *
> + * call_rcu().
> + *                      		rcu_barrier() sees ->len as 0.
> + * set ->len = 1.
> + *                      		rcu_barrier() does nothing.
> + *					module is unloaded.
> + * callback invokes unloaded function!
> + *
> + * With the full barriers, any case where rcu_barrier() sees ->len as 0 will
> + * have unambiguously preceded the return from the racing call_rcu(), which
> + * means that this call_rcu() invocation is OK to not wait on.  After all,
> + * you are supposed to make sure that any problematic call_rcu() invocations
> + * happen before the rcu_barrier().

Unfortunately, I did not understand your explanation. To me the barrier
*before* the setting of length is needed on CPU0 only for 1->0 transition
(Dequeue). Where as in
your example above, it is for enqueue.

This was case 1 in my patch:

+ * To illustrate the problematic scenario to avoid:
+ * P0 (what P1 sees)	P1
+ * set len = 0
+ *                      rcu_barrier sees len as 0
+ * dequeue from list
+ *                      rcu_barrier does nothing.
+ *


Here, P1 should see the transition of 1->0 *after* the CB is dequeued. Which
means you needed a memory barrier *before* the setting of len from 1->0 and
*after* the dequeue. IOW, rcu_barrier should 'see' the memory ordering as:

1. dequeue
2. set len from 1 -> 0.

For the enqueue case, it is the reverse, rcu_barrier should see:
1. set len from 0 -> 1
2. enqueue

Either way, the point I think I was trying to make is that the length should
always be seen as non-zero if the list is non-empty. Basically, the
rcu_barrier() should always not do the fast-path if the list is non-empty.
Worst-case it might do the slow-path when it is not necessary, but it should
never do the fast-path when it was not supposed to.

Thoughts?

thanks,

 - Joel



> + *
> + *
> + * CASE 2: Suppose that CPU 0 is invoking its last callback just as CPU 1 invokes
> + * rcu_barrier().  CPU 0's ->len field will transition from 1->0, which is one
> + * of the transitions that must be handled carefully.  Without the full memory
> + * barriers after the ->len update and at the end of rcu_barrier(), the following
> + * could happen:
> + * 
> + * CPU 0				CPU 1
> + *
> + * start invoking last callback
> + * set ->len = 0 (reordered)
> + *                      		rcu_barrier() sees ->len as 0
> + *                      		rcu_barrier() does nothing.
> + *					module is unloaded
> + * callback executing after unloaded!
> + *
> + * With the full barriers, any case where rcu_barrier() sees ->len as 0
> + * will be fully ordered after the completion of the callback function,
> + * so that the module unloading operation is completely safe.
> + * 
>   */
>  void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
> -	smp_mb__before_atomic(); /* Up to the caller! */
> +	smp_mb__before_atomic(); // Read header comment above.
>  	atomic_long_add(v, &rsclp->len);
> -	smp_mb__after_atomic(); /* Up to the caller! */
> +	smp_mb__after_atomic();  // Read header comment above.
>  #else
> -	smp_mb(); /* Up to the caller! */
> +	smp_mb(); // Read header comment above.
>  	WRITE_ONCE(rsclp->len, rsclp->len + v);
> -	smp_mb(); /* Up to the caller! */
> +	smp_mb(); // Read header comment above.
>  #endif
>  }
>  
