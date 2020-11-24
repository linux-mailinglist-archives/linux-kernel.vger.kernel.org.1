Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF402C2D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390552AbgKXQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390324AbgKXQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:40:58 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FFEC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:40:57 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f18so4802468ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+DR7uSi8hNd/sN4AJW2uBK+0mmU8RkJewoCRx75OxLs=;
        b=b0U8r42Jyk6+XZBLwCTHI5K4T4S2co5r+QWViAShkFd2rJN+mdbwgSElYt/gghGS1k
         QAdk5cQQBd6yLybWtgKNq1GQ/2vkes6l4kyCgZN3THCC0Qst+yaoOBKu0PrG+bSCWcV/
         IXtq1vbAXNEzTBafnWoIIdpQtXDCnA8NQyg9guvGQv9dVq3ZuHlS5UPjkSeC12KvAgii
         g7hSnI9V4ezYZMkk1uRrgI+2irbQuh3q2dl/4OOlwm3YxpD1Cqq+jVj1yWzaQ1T3W2gl
         LOLU7M+sfpBjFpii2OUt+CDFRr25BC6Ft+rEb7FmywQpIlV6SCFx4nddfktirABhCrrr
         o3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+DR7uSi8hNd/sN4AJW2uBK+0mmU8RkJewoCRx75OxLs=;
        b=AXxRf67Hq+F0dymhVSvvlvykqwcZ17as4nlEQIoepq45ihKHq3e3dqzmozgsFFXEz4
         rWaidFxs1pwn0rumdtl3npnGfS34ChRKiJyMq6x4RLVVb6YtKqF/TqMc3D4AbzwsPQLC
         eRjAFifS2sZkNNSZX5uDYpzHN6WBiXV64kYkuvrzdcGd0kfRxy8kxj9yySav6MkbB80r
         r2wLRaUHNzay0o6+p1po8YernIJJ9uwjL+jgl3KNwBXVhQH0oMjcmVA94ORLAO8BbEvS
         Mprljs9fZnhPiypDQ8rsJwSyhMPdvCFulRdZ4lkaAVtAyv7fIhX2jLJ62W916q3jkCRE
         weDw==
X-Gm-Message-State: AOAM5308ZpAg/UVbaOo97IUGAWQ6MHalUGPXGo2zViQsXlJPcawkXNZg
        5JkmlN5ehnRLgeZxWdyTscY=
X-Google-Smtp-Source: ABdhPJwixI/lEaS2q70h5NoCjKX5FJ4cnY3E1uVaJ80MAA6sm2oT/hfF7rCC9834o/vAOcAb0gPxPg==
X-Received: by 2002:a2e:6e14:: with SMTP id j20mr2055395ljc.372.1606236056086;
        Tue, 24 Nov 2020 08:40:56 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 26sm7662lfr.36.2020.11.24.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 08:40:55 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 24 Nov 2020 17:40:53 +0100
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
Message-ID: <20201124164053.GA23686@pc636>
References: <20201116220033.1837-2-urezki@gmail.com>
 <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
 <20201117130434.GA10769@pc636>
 <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
 <20201118161623.GA21171@pc636>
 <87mtzeunsi.fsf@yhuang-dev.intel.com>
 <20201119173604.GA991@pc636>
 <87zh3cu578.fsf@yhuang-dev.intel.com>
 <20201123135919.GA12236@pc636>
 <875z5vtrsc.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z5vtrsc.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> >> 
> >> >> That's the typical long latency avoidance method.
> >> >> 
> >> >> > The question is, which value we should use as a batch_threshold: 100, 1000, etc.
> >> >> 
> >> >> I think we can do some measurement to determine it?
> >> >> 
> >> > Hmm.. looking at it one more time i do not see what batching solves.
> >> 
> >> Without batch protection, we may release the lock and CPU anytime during
> >> looping if "vmap_lazy_nr < resched_threshold".  Too many vmalloc/vfree
> >> may be done during that.  So I think we can restrict it.  Batching can
> >> improve the performance of purging itself too.
> >> 
> > In theory:
> > I see your point. It is a trade-off though, to allow faster vmalloc or vfree.
> > Batching will make alloc more tight, and yes, speed up the process of draining
> > holding a CPU until batch is drained + introducing latency for other tasks.
> >
> > In practical:
> > I mentioned about that, i think we need to measure the batching approach, say
> > we set it to 100, providing some figures so we see some evidence from practical
> > point of view. For example run test_vmalloc.sh to analyze it. If you see some
> > advantages from performance point of view it would be great. Just share some
> > data.
> 
> Per my understanding, this is the common practice in kernel to satisfy
> both throughput and latency requirement.  But it may be not important
> for this specific case.  I am afraid I have no time to work on this now.
> Just my 2 cents.  If you don't think that's a good idea, just ignore it.
> 
I will keep it in mind, thanks for your input.

> >> > Anyway we need to have some threshold(what we do have), that regulates
> >> > a priority between vmalloc()/vfree().
> >> >
> >> > What we can do more with it are:
> >> >
> >> > - purging should be just performed asynchronously in workqueue context.
> >> > Giving the fact, that now we also do a merge of outstanding areas, the
> >> > data structure(rb-tree) will not be so fragmented.
> >> 
> >> Async works only if there are idle CPU time on other CPUs.  And it may
> >> punish other innocent workloads instead of the heavy vmalloc/vfree
> >> users.  So we should be careful about that.
> >> 
> > Yep, scheduling latency will be as a side affect of such approach. The question
> > is if it is negligible and can be considered as a risk. I do not think it would 
> > be a big problem.
> >
> > I have other issue with it though, which i can not explain so far. If i am doing 
> > the "purge" in the separate worker, i see that a memory leaks after heavy test
> > runs.
> >
> >> > - lazy_max_pages() can slightly be decreased. If there are existing
> >> > workloads which suffer from such long value. It would be good to get
> >> > real complains and evidence.
> >> >
> >> >> > Apart of it and in regard to CONFIG_KASAN_VMALLOC, it seems that we are not
> >> >> > allowed to drop the free_vmap_area_lock at all. Because any simultaneous
> >> >> > allocations are not allowed within a drain region, so it should occur in
> >> >> > disjoint regions. But i need to double check it.
> >> >> >
> >> >> >>
> >> >> >> And, can we reduce lazy_max_pages() to control the length of the
> >> >> >> purging list?  It could be > 8K if the vmalloc/vfree size is small.
> >> >> >>
> >> >> > We can adjust it for sure. But it will influence on number of global
> >> >> > TLB flushes that must be performed.
> >> >> 
> >> >> Em...  For example, if we set it to 100, then the number of the TLB
> >> >> flushes can be reduced to 1% of the un-optimized implementation
> >> >> already.  Do you think so?
> >> >> 
> >> > If we set lazy_max_pages() to vague value such as 100, the performance
> >> > will be just destroyed.
> >> 
> >> Sorry, my original words weren't clear enough.  What I really want to
> >> suggest is to control the length of the purging list instead of reduce
> >> lazy_max_pages() directly.  That is, we can have a "atomic_t
> >> nr_purge_item" to record the length of the purging list and start
> >> purging if (vmap_lazy_nr > lazy_max_pages && nr_purge_item >
> >> max_purge_item).  vmap_lazy_nr is to control the virtual address space,
> >> nr_purge_item is to control the batching purging latency.  "100" is just
> >> an example, the real value should be determined according to the test
> >> results.
> >> 
> > OK. Now i see what you meant. Please note, the merging is in place, so
> > the list size gets reduced.
> 
> Yes.  In theory, even with merging, the length of the purging list may
> become too long in some cases.  And the code/algorithm changes that are
> needed by controlling the length of the purging list is much less than
> that are needed by merging.  So I suggest to do length controlling
> firstly, then merging.  Again, just my 2 cents.
> 
All such kind of tuning parameters work for one case and does not for
others. Therefore i prefer to have something more generic that tends
to improve the things, instead of thinking how to tune parameters to
cover all test cases and workloads.

Anyway, thank you for your comments!

--
Vlad Rezki
