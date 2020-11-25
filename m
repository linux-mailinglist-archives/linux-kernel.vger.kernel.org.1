Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC452C35CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgKYAxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 19:53:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:41650 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgKYAxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:53:02 -0500
IronPort-SDR: O32Z7CXL2XhF4PCm2XBHrdJIPn24qZHp4ifVlJe8g6cP8EQPCNwnPlw8HasQtdY8u2UfthMD7e
 CRn0JFngkdVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151881525"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="151881525"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 16:53:01 -0800
IronPort-SDR: tEuKFr65FPTIhA9P+8K0hGO91Y9a3lraO39G3XtcUIcDYhzaebvNJEW3rWHMll1wCPQNVeU4iW
 DT4zwS5uL+wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="536673896"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by fmsmga005.fm.intel.com with ESMTP; 24 Nov 2020 16:52:59 -0800
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
References: <20201116220033.1837-2-urezki@gmail.com>
        <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
        <20201117130434.GA10769@pc636>
        <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
        <20201118161623.GA21171@pc636> <87mtzeunsi.fsf@yhuang-dev.intel.com>
        <20201119173604.GA991@pc636> <87zh3cu578.fsf@yhuang-dev.intel.com>
        <20201123135919.GA12236@pc636> <875z5vtrsc.fsf@yhuang-dev.intel.com>
        <20201124164053.GA23686@pc636>
Date:   Wed, 25 Nov 2020 08:52:58 +0800
In-Reply-To: <20201124164053.GA23686@pc636> (Uladzislau Rezki's message of
        "Tue, 24 Nov 2020 17:40:53 +0100")
Message-ID: <87o8jms1ed.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uladzislau Rezki <urezki@gmail.com> writes:
>> >> > - lazy_max_pages() can slightly be decreased. If there are existing
>> >> > workloads which suffer from such long value. It would be good to get
>> >> > real complains and evidence.
>> >> >
>> >> >> > Apart of it and in regard to CONFIG_KASAN_VMALLOC, it seems that we are not
>> >> >> > allowed to drop the free_vmap_area_lock at all. Because any simultaneous
>> >> >> > allocations are not allowed within a drain region, so it should occur in
>> >> >> > disjoint regions. But i need to double check it.
>> >> >> >
>> >> >> >>
>> >> >> >> And, can we reduce lazy_max_pages() to control the length of the
>> >> >> >> purging list?  It could be > 8K if the vmalloc/vfree size is small.
>> >> >> >>
>> >> >> > We can adjust it for sure. But it will influence on number of global
>> >> >> > TLB flushes that must be performed.
>> >> >> 
>> >> >> Em...  For example, if we set it to 100, then the number of the TLB
>> >> >> flushes can be reduced to 1% of the un-optimized implementation
>> >> >> already.  Do you think so?
>> >> >> 
>> >> > If we set lazy_max_pages() to vague value such as 100, the performance
>> >> > will be just destroyed.
>> >> 
>> >> Sorry, my original words weren't clear enough.  What I really want to
>> >> suggest is to control the length of the purging list instead of reduce
>> >> lazy_max_pages() directly.  That is, we can have a "atomic_t
>> >> nr_purge_item" to record the length of the purging list and start
>> >> purging if (vmap_lazy_nr > lazy_max_pages && nr_purge_item >
>> >> max_purge_item).  vmap_lazy_nr is to control the virtual address space,
>> >> nr_purge_item is to control the batching purging latency.  "100" is just
>> >> an example, the real value should be determined according to the test
>> >> results.
>> >> 
>> > OK. Now i see what you meant. Please note, the merging is in place, so
>> > the list size gets reduced.
>> 
>> Yes.  In theory, even with merging, the length of the purging list may
>> become too long in some cases.  And the code/algorithm changes that are
>> needed by controlling the length of the purging list is much less than
>> that are needed by merging.  So I suggest to do length controlling
>> firstly, then merging.  Again, just my 2 cents.
>> 
> All such kind of tuning parameters work for one case and does not for
> others. Therefore i prefer to have something more generic that tends
> to improve the things, instead of thinking how to tune parameters to
> cover all test cases and workloads.

It's a new mechanism to control the length of the purging list directly.
So, I don't think that's just parameter tuning.  It's just a simple and
direct method.  It can work together with merging method to control the
purging latency even if the vmap areas cannot be merged in some cases.
But these cases may not exist in practice, so I will not insist to use
this method.

Best Regards,
Huang, Ying
