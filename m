Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D00276583
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 02:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgIXA7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 20:59:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:17872 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgIXA7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 20:59:43 -0400
IronPort-SDR: y5c+UHPChk1zGZDHkhnX5fQlYpKkAdHeu6iMnDUHZB8c/bRGYFGh4Ipn8HE++g4dDGypcFOgAN
 HnJ4fGEZJb2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="161986787"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="161986787"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 17:59:42 -0700
IronPort-SDR: HSpho6kL3zwPe/VHHvrj7yevgwanFGrmVX3hFHAd1upyYQ6JywtFX6Qmv6PILP066RNfh3BndQ
 uROw/ULe8tPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="322789760"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2020 17:59:40 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
References: <20200922184838.978540-1-aquini@redhat.com>
        <878sd1qllb.fsf@yhuang-dev.intel.com>
        <20200923043459.GL795820@optiplex-lnx>
        <87sgb9oz1u.fsf@yhuang-dev.intel.com>
        <20200923130138.GM795820@optiplex-lnx>
Date:   Thu, 24 Sep 2020 08:59:40 +0800
In-Reply-To: <20200923130138.GM795820@optiplex-lnx> (Rafael Aquini's message
        of "Wed, 23 Sep 2020 09:01:38 -0400")
Message-ID: <87blhwng5f.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Aquini <aquini@redhat.com> writes:

> On Wed, Sep 23, 2020 at 01:13:49PM +0800, Huang, Ying wrote:
>> Rafael Aquini <aquini@redhat.com> writes:
>> 
>> > On Wed, Sep 23, 2020 at 10:21:36AM +0800, Huang, Ying wrote:
>> >> Hi, Rafael,
>> >> 
>> >> Rafael Aquini <aquini@redhat.com> writes:
>> >> 
>> >> > The swap area descriptor only gets struct swap_cluster_info *cluster_info
>> >> > allocated if the swapfile is backed by non-rotational storage.
>> >> > When the swap area is laid on top of ordinary disk spindles, lock_cluster()
>> >> > will naturally return NULL.
>> >> 
>> >> Thanks for reporting.  But the bug looks strange.  Because in a system
>> >> with only HDD swap devices, during THP swap out, the swap cluster
>> >> shouldn't be allocated, as in
>> >> 
>> >> shrink_page_list()
>> >>   add_to_swap()
>> >>     get_swap_page()
>> >>       get_swap_pages()
>> >>         swap_alloc_cluster()
>> >>
>> >
>> > The underlying problem is that swap_info_struct.cluster_info is always NULL 
>> > on the rotational storage case.
>> 
>> Yes.
>> 
>> > So, it's very easy to follow that constructions 
>> > like this one, in split_swap_cluster 
>> >
>> > ...
>> >         ci = lock_cluster(si, offset);
>> >         cluster_clear_huge(ci);
>> > ...
>> >
>> > will go for a NULL pointer dereference, in that case, given that lock_cluster 
>> > reads:
>> >
>> > ...
>> > 	struct swap_cluster_info *ci;
>> >         ci = si->cluster_info;
>> >         if (ci) {
>> >                 ci += offset / SWAPFILE_CLUSTER;
>> >                 spin_lock(&ci->lock);
>> >         }
>> >         return ci;
>> > ...
>> 
>> But on HDD, we shouldn't call split_swap_cluster() at all, because we
>> will not allocate swap cluster firstly.  So, if we run into this,
>> there should be some other bug, we need to figure it out.
>>
>
> split_swap_cluster() gets called by split_huge_page_to_list(),
> if the page happens to be in the swapcache, and it will always
> go that way, regardless the backing storage type:
>
> ...
>             __split_huge_page(page, list, end, flags);
>             if (PageSwapCache(head)) {
>                     swp_entry_t entry = { .val = page_private(head) };
>
>                     ret = split_swap_cluster(entry);
>             } else
>                     ret = 0;
> ...
>
> The problem is not about allocating the swap_cluster -- it's obviously
> not allocated in these cases. The problem is that on rotational
> storage you don't even have the base structure that allows you to
> keep the swap clusters (cluster_info does not get allocated, at all,
> so si->cluster_info is always NULL)
>
> You can argue about other bugs all you want, it doesn't change
> the fact that this code is incomplete as it sits, because it 
> misses checking for a real case where lock_cluster() will return NULL.

I don't want to argue about anything.  I just want to fix the bug.  The
fix here will hide the real bug instead of fixing it.  For the situation
you described (PageSwapCache() returns true for a THP backed by a normal
swap entry (not swap cluster)), we will run into other troubles too.  So
we need to find the root cause and fix it.

Can you help me to collect more information to fix the real bug?  Or,
how to reproduce it?

Best Regards,
Huang, Ying
