Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814C72A66FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgKDPBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKDPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:01:46 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94D3C061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:01:45 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id b11so10019645qvr.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JwF5wC0Y2b6uvUgvIM5m58EEGQa1/Iyo9vXHealTFN4=;
        b=PVKUmkPy7SyrTJ7S29rxEfNpSL0OgI0EPGM+rBoNOLjYJup0lQDdi5kna5OOI1PYrM
         X4rGKh+hg3XIq7qXSlSWvWwBnrmDxhKk1Lo+Y1rYfV26TE0d3nKs/5OwOxXGFiCr5+oX
         ZY5N25J5hDX5QcbrNnzPfJXIzq8opGrPhTCXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JwF5wC0Y2b6uvUgvIM5m58EEGQa1/Iyo9vXHealTFN4=;
        b=CvIbMYMPLKl9GVc9JwvS7+55OXGLy09BprTO+0dXE0wY8h2XZTHkKjUA+d7bkGNCid
         9TGX/M3V1x2R3A5j/6nfix4tlN2l/x77LfAgug44tDVM4FsHJiXsNdQuTaHUU5h7VkPf
         cLhFqbLv1xqW+eJXE0Q3lGXQFJNXZT42b5256FarOSjIljs6nVJYSsKyDNgLefhFatBn
         39MB7/cIAzpmFTvXTe2PHb7RtjjPHLvQrdQ+tS059UWUWTSkB6UPOjEamNfpg8mYui8u
         9Ci2h6rle72uX362VfGpXAkyEormryI7+zPzaf/4PwWxuSb51C43oebCcagHbZhXWC1p
         hRGQ==
X-Gm-Message-State: AOAM533HkZp12dk4vYlwVxX/b059c9rZyFeoorMVBhaqs0O9utAYmt25
        dPqa+AhELdiTRb7zI7a6I4xPaw==
X-Google-Smtp-Source: ABdhPJyCL64N7H6IRbb2vU3pQjTP5YK3vxVRbgyYHgxiKCSHp4IMGNdaacnGox18ia9fndgi+Z5n8w==
X-Received: by 2002:ad4:4b32:: with SMTP id s18mr21449778qvw.16.1604502104958;
        Wed, 04 Nov 2020 07:01:44 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t12sm2479953qkg.132.2020.11.04.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:01:44 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:01:43 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 01/16] rcu/tree: Add a work to allocate pages from
 regular context
Message-ID: <20201104150143.GB2313912@google.com>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201103175422.GB1310511@google.com>
 <20201104121203.GB17782@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104121203.GB17782@pc636>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 01:12:03PM +0100, Uladzislau Rezki wrote:
> On Tue, Nov 03, 2020 at 12:54:22PM -0500, Joel Fernandes wrote:
> > On Thu, Oct 29, 2020 at 05:50:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > > The current memmory-allocation interface presents to following
> > > difficulties that this patch is designed to overcome
> > [...]
> > > ---
> > >  kernel/rcu/tree.c | 109 ++++++++++++++++++++++++++++------------------
> > >  1 file changed, 66 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 06895ef85d69..f2da2a1cc716 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -177,7 +177,7 @@ module_param(rcu_unlock_delay, int, 0444);
> > >   * per-CPU. Object size is equal to one page. This value
> > >   * can be changed at boot time.
> > >   */
> > > -static int rcu_min_cached_objs = 2;
> > > +static int rcu_min_cached_objs = 5;
> > >  module_param(rcu_min_cached_objs, int, 0444);
> > >  
> > >  /* Retrieve RCU kthreads priority for rcutorture */
> > > @@ -3084,6 +3084,9 @@ struct kfree_rcu_cpu_work {
> > >   *	In order to save some per-cpu space the list is singular.
> > >   *	Even though it is lockless an access has to be protected by the
> > >   *	per-cpu lock.
> > > + * @page_cache_work: A work to refill the cache when it is empty
> > > + * @work_in_progress: Indicates that page_cache_work is running
> > > + * @hrtimer: A hrtimer for scheduling a page_cache_work
> > >   * @nr_bkv_objs: number of allocated objects at @bkvcache.
> > >   *
> > >   * This is a per-CPU structure.  The reason that it is not included in
> > > @@ -3100,6 +3103,11 @@ struct kfree_rcu_cpu {
> > >  	bool monitor_todo;
> > >  	bool initialized;
> > >  	int count;
> > > +
> > > +	struct work_struct page_cache_work;
> > > +	atomic_t work_in_progress;
> > 
> > Does it need to be atomic? run_page_cache_work() is only called under a lock.
> > You can use xchg() there. And when you do the atomic_set, you can use
> > WRITE_ONCE as it is a data-race.
> > 
> We can use xchg together with *_ONCE() macro. Could you please clarify what
> is your concern about using atomic_t? Both xchg() and atomic_xchg() guarantee
> atamarity. Same as WRITE_ONCE() or atomic_set().

Right, whether there's lock or not does not matter as xchg() is also
atomic-swap.

atomic_t is a more complex type though, I would directly use int since
atomic_t is not needed here and there's no lost-update issue here. It could
be matter of style as well.

BTW I did think atomic_xchg() adds additional memory barriers
but I could not find that to be the case in the implementation. Is that not
the case? Docs says "atomic_xchg must provide explicit memory barriers around
the operation.".

> > > @@ -4449,24 +4482,14 @@ static void __init kfree_rcu_batch_init(void)
> > >  
> > >  	for_each_possible_cpu(cpu) {
> > >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > -		struct kvfree_rcu_bulk_data *bnode;
> > >  
> > >  		for (i = 0; i < KFREE_N_BATCHES; i++) {
> > >  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> > >  			krcp->krw_arr[i].krcp = krcp;
> > >  		}
> > >  
> > > -		for (i = 0; i < rcu_min_cached_objs; i++) {
> > > -			bnode = (struct kvfree_rcu_bulk_data *)
> > > -				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > -
> > > -			if (bnode)
> > > -				put_cached_bnode(krcp, bnode);
> > > -			else
> > > -				pr_err("Failed to preallocate for %d CPU!\n", cpu);
> > > -		}
> > > -
> > >  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> > > +		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
> > >  		krcp->initialized = true;
> > 
> > During initialization, is it not better to still pre-allocate? That way you
> > don't have to wait to get into a situation where you need to initially
> > allocate.
> > 
> Since we have a worker that does it when a cache is empty there is no
> a high need in doing it during initialization phase. If we can reduce
> an amount of code it is always good :)

I am all for not having more code than needed. But you would hit
synchronize_rcu() slow path immediately on first headless kfree_rcu() right?
That seems like a step back from the current code :)

thanks,

 - Joel

