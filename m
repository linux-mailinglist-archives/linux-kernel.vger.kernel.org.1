Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55819F8B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgDFPSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 11:18:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37068 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgDFPSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:18:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id n17so2997765qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WQ13gZGSY3xmTiTHkeegkoNeGoRVkcyOr4aTKqDUvPo=;
        b=jJDudxfj5wKpWpddExP1afDNqtGIYk8TIA61nm2OSLBr9igEgJaANnQQoyGdw07pEP
         0qpJ6JOFdx1iJxh6SHnuOmlolxkHzTb/bUfcRfuWunfnbboGW29PEoe4adThFAFL6B2y
         3t7UNFkIH1HjVQ6Tw8jwPYuPimpDSlOuDVNCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQ13gZGSY3xmTiTHkeegkoNeGoRVkcyOr4aTKqDUvPo=;
        b=EEaibDUQMiQhvpvzo8AMBxBAISSBAGgzLqh35kRDl4IUDpHqYvN5unba2TvPU4HDX+
         dPD+CE62W9g5CD4oURHfsosv6+EnJeMTm6G5sIzljBz13BlEq7TRGveK5e3I1lOKM3Tk
         lguybgGRsx+rbK6qJijNvaHFrstBN4O5IWqrUanzdiOl5VelNU0QzaSUBRXikGdPVcX+
         o75LJYRzbWr4FcQxaq3q4rd07tzNDmA3d3xY6OSTIWkyK25kszJ9SBlGE2otETnsHHUu
         7qTgkARNCf7rmVm0dMZhKZfRgFDGX6YujjdoKqKdV/siH4swazdgnUM7Uwcdh29nP5fX
         4lbw==
X-Gm-Message-State: AGi0PuaNzX1E9IcM4vTstR+wOf6wqY+3pBRnxhEF8YqzbWTzAZCQHphu
        0Ce9LBFXNFxy40ppoxGQHuBdJQ==
X-Google-Smtp-Source: APiQypLLLO9aSkifISuDu7aJrPbXHCxjjcrPdxH3Lj57aeYNe7wVxnZ9UUE20vr3KvFXSyx96VTr2g==
X-Received: by 2002:aed:21bc:: with SMTP id l57mr20695595qtc.218.1586186333394;
        Mon, 06 Apr 2020 08:18:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p38sm15775352qtf.50.2020.04.06.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:18:52 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:18:51 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200406151851.GF83565@google.com>
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200404195129.GA83565@google.com>
 <20200405172105.GA7539@pc636>
 <20200405233028.GC83565@google.com>
 <20200406125640.GA23256@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406125640.GA23256@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,

On Mon, Apr 06, 2020 at 02:56:40PM +0200, Uladzislau Rezki wrote:
> Hello, Joel.
> 
> > > > 
> > > > Hi Vlad,
> > > > 
> > > > One concern I have is this moves the problem a bit further down. My belief is
> > > > we should avoid the likelihood of even needing an rcu_head allocated for the
> > > > headless case, to begin with - than trying to do damage-control when it does
> > > > happen. The only way we would end up needing an rcu_head is if we could not
> > > > allocate an array.
> > > > 
> > > Let me share my view on all such caching. I think that now it becomes less as
> > > the issue, because of we have now https://lkml.org/lkml/2020/4/2/383 patch.
> > > I see that it does help a lot. I tried to simulate low memory condition and 
> > > apply high memory pressure with that. I did not manage to trigger the
> > > "synchronize rcu" path at all. It is because of using much more permissive
> > > parameters when we request a memory from the SLAB(direct reclaim, etc...).
> > 
> > That's a good sign that we don't hit this path in your tests.
> > 
> Just one request, of course if you have a time :)
> Could you please double check on your test environment to stress the system
> to check if you also can not hit it?

Sure, I am planning to do so and happy to spend time on it :) One question I
had about the below test:

> How i test it. Please apply below patch:
> <snip>
> t a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5e26145e9ead..25f7ac8583e1 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3203,6 +3203,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>         if (head) {
>                 ptr = (void *) head - (unsigned long) func;
> +               head = NULL;
>         } else {
>                 /*
>                  * Please note there is a limitation for the head-less
> @@ -3233,16 +3234,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>          * Under high memory pressure GFP_NOWAIT can fail,
>          * in that case the emergency path is maintained.
>          */
> -       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> -       if (!success) {
> +       /* success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr); */

If you drop this, then it is not realistic right? I mean it changes behavior
of the code completely. We need to try to allocate array and then try to
allocate the head.

> +       /* if (!success) { */
>                 /* Is headless object? */
>                 if (head == NULL) {
>                         /* Drop the lock. */
>                         krc_this_cpu_unlock(krcp, flags);
>  
>                         head = attach_rcu_head_to_object(ptr);
> -                       if (head == NULL)
> +                       if (head == NULL) {
> +                               success = false;
>                                 goto inline_return;
> +                       }
>  
>                         /* Take it back. */
>                         krcp = krc_this_cpu_lock(&flags);
> @@ -3267,7 +3270,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>                  */
>                 expedited_drain = true;
>                 success = true;
> -       }
> +       /* } */
>  
>         WRITE_ONCE(krcp->count, krcp->count + 1);
>  
> @@ -3297,7 +3300,9 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>                 if (!rcu_kfree_nowarn)
>                         WARN_ON_ONCE(1);
>                 debug_rcu_head_unqueue(ptr);
> -               synchronize_rcu();
> +               /* synchronize_rcu(); */
> +               printk(KERN_ERR "-> hit synchronize_rcu() path.\n");
> +               trace_printk("-> hit synchronize_rcu() path.\n");
>                 kvfree(ptr);
>         }
>  }
> <snip>
> 
> lower the memory size and run kfree rcu tests. It would be appreciated.

I am happy to try out the diff if I can understand how the above diff is
close enough with current code's behavior, if we are not using the array. One
other issue with current kfree rcu tests is, the test is itself the reason
for the pressure -- I believe we should also have some testing that shows
that the memory pressure is caused else where (such as a real user workload
causing OOM), and then we see how RCU behaves under OOM -- if we have too
many synchronous latencies, does the additional caching remove such latenies
under OOM? etc.  I also want to look into your vmalloc tests.

> > I guess also, with your latest patch on releasing the lock to be in a
> > non-atomic context, and then doing the allocation, it became even more
> > permissive? If you drop that patch and tried, do you still not hit the
> > synchronous path more often?
> > 
> Yep. If i drop the patch, i can hit it.

Ah, cool. So basically the direct-reclaim path does the synchronous waiting,
instead of synchronize_rcu(). Either way, we wait synchronously. How to chose
which way is better though? If direct reclaim improves the memory situation,
then we should enter that path. But if direct reclaim takes too much time
(thus hurting the kfree_rcu() latency), then perhaps it is better for
kfree_rcu() to just do the synchronize_rcu() and let someone else enter the
direct-reclaim path. We should probably quantify and see which approach works
better.

> > Could you also try introducing memory pressure by reducing your system's
> > total memory and see how it behaves?
> > 
> I simulated low memory condition by setting the system memory to 145MB.
> That was the minimum amount the KVM system was capable of booting. After
> that i used kfree rcu tests to simulate memory pressure.

Ah, ok. I do a similar thing. Thanks for sharing. It would be nice if we can
both commit something into the tree (like modify the rcu torture KVM scripts
to simulate this automatically (while also generating memory pressure
external to RCU).

> > > > So instead of adding a pool for rcu_head allocations, how do you feel about
> > > > pre-allocation of the per-cpu cache array instead, which has the same effect
> > > > as you are intending?
> > > > 
> > > In the v2 i have a list of such objects. It is also per-CPU(it is scaled to CPUs),
> > > but the difference is, those objects require much less memory, it is 8 + sizeof(struct
> > > rcu_head) bytes comparing to one page. Therefore the memory footprint is lower.
> > 
> > Yes, true. That is one drawback is it higher memory usage. But if you have at
> > least 1 kfree_rcu() request an each CPU, then pre-allocation does not
> > increase memory usage any more than it already has right now. Unless, we
> > extend my proposal to cache more than 2 pages per-cpu which I think you
> > mentioned below.
> > 
> If we cache two pages per-CPU, i think that is fine. When it comes to increasing
> it, it can be a bit wasting. For example consider 128 CPUs system.

Right, if we could we assume that the system's memory scales with number of
CPUs, it could be reasonable.

> > > I have doubts that we would ever hit this emergency list, because of mentioned
> > > above patch, but from the other hand i can not say and guarantee 100%. Just in
> > > case, we may keep it. 
> > 
> > You really have to hit OOM in your tests to trigger it I suppose. Basically
> > the emergency pool improves situation under OOM, but otherwise does not
> > improve it due to the direct-reclaim that happens as you mentioned. Right?
> >
> See above how i simulated it. Direct reclaim is our GFP_KERNEL + other flags
> helper. If even after reclaim process there is no memory, then emergency list
> is supposed to be used. But we can drop this patch, i mean "emergency list"
> if we agree on it. The good point would be if you could stress your system
> by the i did. See above description :)

Yes I will stress it and make time to do so today :)
 
> > > But i think that we should allow to be used two pages as cached ones, no matter 
> > > whether it is vmalloc ptrs. or SLAB ones. So basically, two cached pages can be
> > > used by vmalloc path and SLAB path. And probably it makes sense because of two
> > > phases: one is when we collect pointers, second one is memory reclaim path. Thus
> > > one page per one phase, i.e. it would be paired.
> > 
> > You are saying this with regard to my proposal right?  I agree number of
> > pages could be increased. The caching mechanism already in-place could be
> > starting point for that extension.
> > 
> We already have two pages. What we need is to allow to use them in both
> paths, vmalloc one and SLAB one, i mean reclaim path. At least that fits
> well to the collecting/reclaim phases.

Ah yes, that's even better.

thanks,

 - Joel

