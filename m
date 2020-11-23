Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA42C0CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgKWN7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgKWN7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:59:24 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:59:23 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d20so7966891lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iJ/fur3ZUS+E2VsmcG7tRAQUHvJX0t5x9I+syxFHQGc=;
        b=U8uzFglW0q515SRyvbcBQFMDMor4uSP5fBuyiKVqOzGN1bK5fbHQiWTYKOfBferKK3
         J/CYESUCRVyLubbIEHSp9uA3YyQIcjfx9EyidjC7N5DK4cPcDA4YtS1aZRt957BwdLHh
         Z8q5FOGr2A7VBGNVVp6vSvFtXEjV36aR1sjYgE9dN8Baf0fExZ4fdJyYIAVky+EPSgy+
         ZLvCUAWazOO/bJMioaH00HHwe/jCRiB1CYMtauVp9P9oBRod/p9zAbzW4rvu7NqS7lM+
         huvrh64Lnca/wZ6golg64vQ7GaHtL9fRKj9AbKmIgTIbB1Ej2dxh/MPO/67dDIydFOQP
         iibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iJ/fur3ZUS+E2VsmcG7tRAQUHvJX0t5x9I+syxFHQGc=;
        b=OPFQZ2F2b3FETGTps8Z/NXRZPMxCRlU3VNSrN9k6qt6K/ZCx93no9dup/MN84R9f35
         c6Y+LWVU91is28qQoQIudJWcvHQUxUXOK/kRqO2XakyBDs0iQUURFjWJ7BD6k+xxk7Un
         enqamZodKB2GvZezFtVuA1KQMVvDjhG/JL4j5qvhVGzqGz5LqJwuh3KSAW5OSVqcBXVp
         ssFfktFu4lrscNLMCBsm/Q43JnwPnf5FGVCJeJ+5gXnrdpEinFAP0lqcEyB0oLVjqjeY
         oHFOK54Yv61cpUqVY2pv+pC3GVGBhrGeVSEo6SuTRfIbwKU8KJPTRFwUwTD4Qa6PWytp
         Evyg==
X-Gm-Message-State: AOAM5323efySUq59VvmHV6Fmj9Jut5ub19A5AQltSaDUhv3/PUIuLNWX
        LF6hLQu04yaho2y5rnY/UVA=
X-Google-Smtp-Source: ABdhPJwzwrr2S2hewcmLzV7VsJFX1Wnsio/Ny3oIIcq3w15t6KJZZoT7DU51KS0O9+jOewDwqrXJLw==
X-Received: by 2002:ac2:53ae:: with SMTP id j14mr14375864lfh.216.1606139962333;
        Mon, 23 Nov 2020 05:59:22 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id l24sm305000lja.130.2020.11.23.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 05:59:21 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 23 Nov 2020 14:59:19 +0100
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/vmalloc: rework the drain logic
Message-ID: <20201123135919.GA12236@pc636>
References: <20201116220033.1837-1-urezki@gmail.com>
 <20201116220033.1837-2-urezki@gmail.com>
 <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
 <20201117130434.GA10769@pc636>
 <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
 <20201118161623.GA21171@pc636>
 <87mtzeunsi.fsf@yhuang-dev.intel.com>
 <20201119173604.GA991@pc636>
 <87zh3cu578.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh3cu578.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:34:19AM +0800, Huang, Ying wrote:
> Uladzislau Rezki <urezki@gmail.com> writes:
> 
> > On Thu, Nov 19, 2020 at 09:40:29AM +0800, Huang, Ying wrote:
> >> Uladzislau Rezki <urezki@gmail.com> writes:
> >> 
> >> > On Wed, Nov 18, 2020 at 10:44:13AM +0800, huang ying wrote:
> >> >> On Tue, Nov 17, 2020 at 9:04 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >> >> >
> >> >> > On Tue, Nov 17, 2020 at 10:37:34AM +0800, huang ying wrote:
> >> >> > > On Tue, Nov 17, 2020 at 6:00 AM Uladzislau Rezki (Sony)
> >> >> > > <urezki@gmail.com> wrote:
> >> >> > > >
> >> >> > > > A current "lazy drain" model suffers from at least two issues.
> >> >> > > >
> >> >> > > > First one is related to the unsorted list of vmap areas, thus
> >> >> > > > in order to identify the [min:max] range of areas to be drained,
> >> >> > > > it requires a full list scan. What is a time consuming if the
> >> >> > > > list is too long.
> >> >> > > >
> >> >> > > > Second one and as a next step is about merging all fragments
> >> >> > > > with a free space. What is also a time consuming because it
> >> >> > > > has to iterate over entire list which holds outstanding lazy
> >> >> > > > areas.
> >> >> > > >
> >> >> > > > See below the "preemptirqsoff" tracer that illustrates a high
> >> >> > > > latency. It is ~24 676us. Our workloads like audio and video
> >> >> > > > are effected by such long latency:
> >> >> > >
> >> >> > > This seems like a real problem.  But I found there's long latency
> >> >> > > avoidance mechanism in the loop in __purge_vmap_area_lazy() as
> >> >> > > follows,
> >> >> > >
> >> >> > >         if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> >> >> > >             cond_resched_lock(&free_vmap_area_lock);
> >> >> > >
> >> >> > I have added that "resched threshold" because of on my tests i could
> >> >> > simply hit out of memory, due to the fact that a drain work is not up
> >> >> > to speed to process such long outstanding list of vmap areas.
> >> >> 
> >> >> OK.  Now I think I understand the problem.  For free area purging,
> >> >> there are multiple "producers" but one "consumer", and it lacks enough
> >> >> mechanism to slow down the "producers" if "consumer" can not catch up.
> >> >> And your patch tries to resolve the problem via accelerating the
> >> >> "consumer".
> >> >>
> >> > Seems, correct. But just in case one more time:
> >> >
> >> > the cond_resched_lock was added once upon a time to get rid of long
> >> > preemption off time. Due to dropping the lock, "producers" can start
> >> > generate further vmap area, so "consumer" can not catch up. Seems
> >> 
> >> Yes.  And in theory there are vfree() storm, that is, thousands vfree()
> >> can be called in short time.  But I don't think that's practical use
> >> case.
> >> 
> >> > Later on, a resched threshold was added. It is just a simple protection
> >> > threshold, passing which, a freeing is prioritized back over allocation,
> >> > so we guarantee that we do not hit out of memory.
> >> 
> >> Yes.  That can accelerate freeing if necessary.
> >> 
> >> >>
> >> >> That isn't perfect, but I think we may have quite some opportunities
> >> >> to merge the free areas, so it should just work.
> >> >> 
> >> > Yes, merging opportunity should do the work. But of course there are
> >> > exceptions.
> >> >
> >> >> And I found the long latency avoidance logic in
> >> >> __purge_vmap_area_lazy() appears problematic,
> >> >> 
> >> >>          if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> >> >>              cond_resched_lock(&free_vmap_area_lock);
> >> >> 
> >> >> Shouldn't it be something as follows?
> >> >> 
> >> >>          if (i >= BATCH && atomic_long_read(&vmap_lazy_nr) <
> >> >> resched_threshold) {
> >> >>              cond_resched_lock(&free_vmap_area_lock);
> >> >>              i = 0;
> >> >>          } else
> >> >>              i++;
> >> >> 
> >> >> This will accelerate the purging via batching and slow down vmalloc()
> >> >> via holding free_vmap_area_lock.  If it makes sense, can we try this?
> >> >> 
> >> > Probably we can switch to just using "batch" methodology:
> >> >
> >> > <snip>
> >> >     if (!(i++ % batch_threshold))
> >> >         cond_resched_lock(&free_vmap_area_lock);
> >> > <snip>
> >> 
> >> That's the typical long latency avoidance method.
> >> 
> >> > The question is, which value we should use as a batch_threshold: 100, 1000, etc.
> >> 
> >> I think we can do some measurement to determine it?
> >> 
> > Hmm.. looking at it one more time i do not see what batching solves.
> 
> Without batch protection, we may release the lock and CPU anytime during
> looping if "vmap_lazy_nr < resched_threshold".  Too many vmalloc/vfree
> may be done during that.  So I think we can restrict it.  Batching can
> improve the performance of purging itself too.
> 
In theory:
I see your point. It is a trade-off though, to allow faster vmalloc or vfree.
Batching will make alloc more tight, and yes, speed up the process of draining
holding a CPU until batch is drained + introducing latency for other tasks.

In practical:
I mentioned about that, i think we need to measure the batching approach, say
we set it to 100, providing some figures so we see some evidence from practical
point of view. For example run test_vmalloc.sh to analyze it. If you see some
advantages from performance point of view it would be great. Just share some
data.

> > Anyway we need to have some threshold(what we do have), that regulates
> > a priority between vmalloc()/vfree().
> >
> > What we can do more with it are:
> >
> > - purging should be just performed asynchronously in workqueue context.
> > Giving the fact, that now we also do a merge of outstanding areas, the
> > data structure(rb-tree) will not be so fragmented.
> 
> Async works only if there are idle CPU time on other CPUs.  And it may
> punish other innocent workloads instead of the heavy vmalloc/vfree
> users.  So we should be careful about that.
> 
Yep, scheduling latency will be as a side affect of such approach. The question
is if it is negligible and can be considered as a risk. I do not think it would 
be a big problem.

I have other issue with it though, which i can not explain so far. If i am doing 
the "purge" in the separate worker, i see that a memory leaks after heavy test
runs.

> > - lazy_max_pages() can slightly be decreased. If there are existing
> > workloads which suffer from such long value. It would be good to get
> > real complains and evidence.
> >
> >> > Apart of it and in regard to CONFIG_KASAN_VMALLOC, it seems that we are not
> >> > allowed to drop the free_vmap_area_lock at all. Because any simultaneous
> >> > allocations are not allowed within a drain region, so it should occur in
> >> > disjoint regions. But i need to double check it.
> >> >
> >> >>
> >> >> And, can we reduce lazy_max_pages() to control the length of the
> >> >> purging list?  It could be > 8K if the vmalloc/vfree size is small.
> >> >>
> >> > We can adjust it for sure. But it will influence on number of global
> >> > TLB flushes that must be performed.
> >> 
> >> Em...  For example, if we set it to 100, then the number of the TLB
> >> flushes can be reduced to 1% of the un-optimized implementation
> >> already.  Do you think so?
> >> 
> > If we set lazy_max_pages() to vague value such as 100, the performance
> > will be just destroyed.
> 
> Sorry, my original words weren't clear enough.  What I really want to
> suggest is to control the length of the purging list instead of reduce
> lazy_max_pages() directly.  That is, we can have a "atomic_t
> nr_purge_item" to record the length of the purging list and start
> purging if (vmap_lazy_nr > lazy_max_pages && nr_purge_item >
> max_purge_item).  vmap_lazy_nr is to control the virtual address space,
> nr_purge_item is to control the batching purging latency.  "100" is just
> an example, the real value should be determined according to the test
> results.
> 
OK. Now i see what you meant. Please note, the merging is in place, so
the list size gets reduced.

--
Vlad Rezki
