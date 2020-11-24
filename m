Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AA62C1B68
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 03:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgKXCZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 21:25:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:38552 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgKXCZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 21:25:28 -0500
IronPort-SDR: 7/ThDDh6KuM90qesWWHY5sMzCLxPo5b7sn3f1bCaELjn4Zc8hzYfP6DkW7cX0hpnsf1PHPbYx0
 iFuEMl6p7uUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151720715"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="151720715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 18:25:27 -0800
IronPort-SDR: iX2S56Ti2fLBcjwwxppu8BjGZ84jPPR3KCYVkn5vWZQTVKZ/p5qsXFHDipFMvJ+D3YR3QMY1cf
 YbTSiWgmNVXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="361686276"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2020 18:25:24 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/vmalloc: rework the drain logic
References: <20201116220033.1837-1-urezki@gmail.com>
        <20201116220033.1837-2-urezki@gmail.com>
        <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
        <20201117130434.GA10769@pc636>
        <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
        <20201118161623.GA21171@pc636> <87mtzeunsi.fsf@yhuang-dev.intel.com>
        <20201119173604.GA991@pc636> <87zh3cu578.fsf@yhuang-dev.intel.com>
        <20201123135919.GA12236@pc636>
Date:   Tue, 24 Nov 2020 10:25:23 +0800
In-Reply-To: <20201123135919.GA12236@pc636> (Uladzislau Rezki's message of
        "Mon, 23 Nov 2020 14:59:19 +0100")
Message-ID: <875z5vtrsc.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uladzislau Rezki <urezki@gmail.com> writes:
>> >> >> And I found the long latency avoidance logic in
>> >> >> __purge_vmap_area_lazy() appears problematic,
>> >> >> 
>> >> >>          if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
>> >> >>              cond_resched_lock(&free_vmap_area_lock);
>> >> >> 
>> >> >> Shouldn't it be something as follows?
>> >> >> 
>> >> >>          if (i >= BATCH && atomic_long_read(&vmap_lazy_nr) <
>> >> >> resched_threshold) {
>> >> >>              cond_resched_lock(&free_vmap_area_lock);
>> >> >>              i = 0;
>> >> >>          } else
>> >> >>              i++;
>> >> >> 
>> >> >> This will accelerate the purging via batching and slow down vmalloc()
>> >> >> via holding free_vmap_area_lock.  If it makes sense, can we try this?
>> >> >> 
>> >> > Probably we can switch to just using "batch" methodology:
>> >> >
>> >> > <snip>
>> >> >     if (!(i++ % batch_threshold))
>> >> >         cond_resched_lock(&free_vmap_area_lock);
>> >> > <snip>
>> >> 
>> >> That's the typical long latency avoidance method.
>> >> 
>> >> > The question is, which value we should use as a batch_threshold: 100, 1000, etc.
>> >> 
>> >> I think we can do some measurement to determine it?
>> >> 
>> > Hmm.. looking at it one more time i do not see what batching solves.
>> 
>> Without batch protection, we may release the lock and CPU anytime during
>> looping if "vmap_lazy_nr < resched_threshold".  Too many vmalloc/vfree
>> may be done during that.  So I think we can restrict it.  Batching can
>> improve the performance of purging itself too.
>> 
> In theory:
> I see your point. It is a trade-off though, to allow faster vmalloc or vfree.
> Batching will make alloc more tight, and yes, speed up the process of draining
> holding a CPU until batch is drained + introducing latency for other tasks.
>
> In practical:
> I mentioned about that, i think we need to measure the batching approach, say
> we set it to 100, providing some figures so we see some evidence from practical
> point of view. For example run test_vmalloc.sh to analyze it. If you see some
> advantages from performance point of view it would be great. Just share some
> data.

Per my understanding, this is the common practice in kernel to satisfy
both throughput and latency requirement.  But it may be not important
for this specific case.  I am afraid I have no time to work on this now.
Just my 2 cents.  If you don't think that's a good idea, just ignore it.

>> > Anyway we need to have some threshold(what we do have), that regulates
>> > a priority between vmalloc()/vfree().
>> >
>> > What we can do more with it are:
>> >
>> > - purging should be just performed asynchronously in workqueue context.
>> > Giving the fact, that now we also do a merge of outstanding areas, the
>> > data structure(rb-tree) will not be so fragmented.
>> 
>> Async works only if there are idle CPU time on other CPUs.  And it may
>> punish other innocent workloads instead of the heavy vmalloc/vfree
>> users.  So we should be careful about that.
>> 
> Yep, scheduling latency will be as a side affect of such approach. The question
> is if it is negligible and can be considered as a risk. I do not think it would 
> be a big problem.
>
> I have other issue with it though, which i can not explain so far. If i am doing 
> the "purge" in the separate worker, i see that a memory leaks after heavy test
> runs.
>
>> > - lazy_max_pages() can slightly be decreased. If there are existing
>> > workloads which suffer from such long value. It would be good to get
>> > real complains and evidence.
>> >
>> >> > Apart of it and in regard to CONFIG_KASAN_VMALLOC, it seems that we are not
>> >> > allowed to drop the free_vmap_area_lock at all. Because any simultaneous
>> >> > allocations are not allowed within a drain region, so it should occur in
>> >> > disjoint regions. But i need to double check it.
>> >> >
>> >> >>
>> >> >> And, can we reduce lazy_max_pages() to control the length of the
>> >> >> purging list?  It could be > 8K if the vmalloc/vfree size is small.
>> >> >>
>> >> > We can adjust it for sure. But it will influence on number of global
>> >> > TLB flushes that must be performed.
>> >> 
>> >> Em...  For example, if we set it to 100, then the number of the TLB
>> >> flushes can be reduced to 1% of the un-optimized implementation
>> >> already.  Do you think so?
>> >> 
>> > If we set lazy_max_pages() to vague value such as 100, the performance
>> > will be just destroyed.
>> 
>> Sorry, my original words weren't clear enough.  What I really want to
>> suggest is to control the length of the purging list instead of reduce
>> lazy_max_pages() directly.  That is, we can have a "atomic_t
>> nr_purge_item" to record the length of the purging list and start
>> purging if (vmap_lazy_nr > lazy_max_pages && nr_purge_item >
>> max_purge_item).  vmap_lazy_nr is to control the virtual address space,
>> nr_purge_item is to control the batching purging latency.  "100" is just
>> an example, the real value should be determined according to the test
>> results.
>> 
> OK. Now i see what you meant. Please note, the merging is in place, so
> the list size gets reduced.

Yes.  In theory, even with merging, the length of the purging list may
become too long in some cases.  And the code/algorithm changes that are
needed by controlling the length of the purging list is much less than
that are needed by merging.  So I suggest to do length controlling
firstly, then merging.  Again, just my 2 cents.

Best Regards,
Huang, Ying
