Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571422BA07A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKTCeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:34:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:57018 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgKTCeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:34:23 -0500
IronPort-SDR: JLSeyX5JTUAm4wygmSdvN61pnDaIhyOzQnzRrKXFOu67PDwjOs8fCm63bp+eHqxjFHRv+r1PJV
 YbTMN4/eJwug==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="158440288"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="158440288"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:34:23 -0800
IronPort-SDR: pyr0PZg1wIIwvBczesvoSnPc0oCSt5HzcldCuTNhmi331eXLMOSXTJDPySoUzifOGPxrcoSXoQ
 Zz4fwbDT9WuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="535008625"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2020 18:34:20 -0800
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
        <20201119173604.GA991@pc636>
Date:   Fri, 20 Nov 2020 10:34:19 +0800
In-Reply-To: <20201119173604.GA991@pc636> (Uladzislau Rezki's message of "Thu,
        19 Nov 2020 18:36:04 +0100")
Message-ID: <87zh3cu578.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uladzislau Rezki <urezki@gmail.com> writes:

> On Thu, Nov 19, 2020 at 09:40:29AM +0800, Huang, Ying wrote:
>> Uladzislau Rezki <urezki@gmail.com> writes:
>> 
>> > On Wed, Nov 18, 2020 at 10:44:13AM +0800, huang ying wrote:
>> >> On Tue, Nov 17, 2020 at 9:04 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>> >> >
>> >> > On Tue, Nov 17, 2020 at 10:37:34AM +0800, huang ying wrote:
>> >> > > On Tue, Nov 17, 2020 at 6:00 AM Uladzislau Rezki (Sony)
>> >> > > <urezki@gmail.com> wrote:
>> >> > > >
>> >> > > > A current "lazy drain" model suffers from at least two issues.
>> >> > > >
>> >> > > > First one is related to the unsorted list of vmap areas, thus
>> >> > > > in order to identify the [min:max] range of areas to be drained,
>> >> > > > it requires a full list scan. What is a time consuming if the
>> >> > > > list is too long.
>> >> > > >
>> >> > > > Second one and as a next step is about merging all fragments
>> >> > > > with a free space. What is also a time consuming because it
>> >> > > > has to iterate over entire list which holds outstanding lazy
>> >> > > > areas.
>> >> > > >
>> >> > > > See below the "preemptirqsoff" tracer that illustrates a high
>> >> > > > latency. It is ~24 676us. Our workloads like audio and video
>> >> > > > are effected by such long latency:
>> >> > >
>> >> > > This seems like a real problem.  But I found there's long latency
>> >> > > avoidance mechanism in the loop in __purge_vmap_area_lazy() as
>> >> > > follows,
>> >> > >
>> >> > >         if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
>> >> > >             cond_resched_lock(&free_vmap_area_lock);
>> >> > >
>> >> > I have added that "resched threshold" because of on my tests i could
>> >> > simply hit out of memory, due to the fact that a drain work is not up
>> >> > to speed to process such long outstanding list of vmap areas.
>> >> 
>> >> OK.  Now I think I understand the problem.  For free area purging,
>> >> there are multiple "producers" but one "consumer", and it lacks enough
>> >> mechanism to slow down the "producers" if "consumer" can not catch up.
>> >> And your patch tries to resolve the problem via accelerating the
>> >> "consumer".
>> >>
>> > Seems, correct. But just in case one more time:
>> >
>> > the cond_resched_lock was added once upon a time to get rid of long
>> > preemption off time. Due to dropping the lock, "producers" can start
>> > generate further vmap area, so "consumer" can not catch up. Seems
>> 
>> Yes.  And in theory there are vfree() storm, that is, thousands vfree()
>> can be called in short time.  But I don't think that's practical use
>> case.
>> 
>> > Later on, a resched threshold was added. It is just a simple protection
>> > threshold, passing which, a freeing is prioritized back over allocation,
>> > so we guarantee that we do not hit out of memory.
>> 
>> Yes.  That can accelerate freeing if necessary.
>> 
>> >>
>> >> That isn't perfect, but I think we may have quite some opportunities
>> >> to merge the free areas, so it should just work.
>> >> 
>> > Yes, merging opportunity should do the work. But of course there are
>> > exceptions.
>> >
>> >> And I found the long latency avoidance logic in
>> >> __purge_vmap_area_lazy() appears problematic,
>> >> 
>> >>          if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
>> >>              cond_resched_lock(&free_vmap_area_lock);
>> >> 
>> >> Shouldn't it be something as follows?
>> >> 
>> >>          if (i >= BATCH && atomic_long_read(&vmap_lazy_nr) <
>> >> resched_threshold) {
>> >>              cond_resched_lock(&free_vmap_area_lock);
>> >>              i = 0;
>> >>          } else
>> >>              i++;
>> >> 
>> >> This will accelerate the purging via batching and slow down vmalloc()
>> >> via holding free_vmap_area_lock.  If it makes sense, can we try this?
>> >> 
>> > Probably we can switch to just using "batch" methodology:
>> >
>> > <snip>
>> >     if (!(i++ % batch_threshold))
>> >         cond_resched_lock(&free_vmap_area_lock);
>> > <snip>
>> 
>> That's the typical long latency avoidance method.
>> 
>> > The question is, which value we should use as a batch_threshold: 100, 1000, etc.
>> 
>> I think we can do some measurement to determine it?
>> 
> Hmm.. looking at it one more time i do not see what batching solves.

Without batch protection, we may release the lock and CPU anytime during
looping if "vmap_lazy_nr < resched_threshold".  Too many vmalloc/vfree
may be done during that.  So I think we can restrict it.  Batching can
improve the performance of purging itself too.

> Anyway we need to have some threshold(what we do have), that regulates
> a priority between vmalloc()/vfree().
>
> What we can do more with it are:
>
> - purging should be just performed asynchronously in workqueue context.
> Giving the fact, that now we also do a merge of outstanding areas, the
> data structure(rb-tree) will not be so fragmented.

Async works only if there are idle CPU time on other CPUs.  And it may
punish other innocent workloads instead of the heavy vmalloc/vfree
users.  So we should be careful about that.

> - lazy_max_pages() can slightly be decreased. If there are existing
> workloads which suffer from such long value. It would be good to get
> real complains and evidence.
>
>> > Apart of it and in regard to CONFIG_KASAN_VMALLOC, it seems that we are not
>> > allowed to drop the free_vmap_area_lock at all. Because any simultaneous
>> > allocations are not allowed within a drain region, so it should occur in
>> > disjoint regions. But i need to double check it.
>> >
>> >>
>> >> And, can we reduce lazy_max_pages() to control the length of the
>> >> purging list?  It could be > 8K if the vmalloc/vfree size is small.
>> >>
>> > We can adjust it for sure. But it will influence on number of global
>> > TLB flushes that must be performed.
>> 
>> Em...  For example, if we set it to 100, then the number of the TLB
>> flushes can be reduced to 1% of the un-optimized implementation
>> already.  Do you think so?
>> 
> If we set lazy_max_pages() to vague value such as 100, the performance
> will be just destroyed.

Sorry, my original words weren't clear enough.  What I really want to
suggest is to control the length of the purging list instead of reduce
lazy_max_pages() directly.  That is, we can have a "atomic_t
nr_purge_item" to record the length of the purging list and start
purging if (vmap_lazy_nr > lazy_max_pages && nr_purge_item >
max_purge_item).  vmap_lazy_nr is to control the virtual address space,
nr_purge_item is to control the batching purging latency.  "100" is just
an example, the real value should be determined according to the test
results.

Best Regards,
Huang, Ying
