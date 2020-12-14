Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B032B2DA3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441273AbgLNWyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:54:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:55368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441262AbgLNWxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:53:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E343BAC7F;
        Mon, 14 Dec 2020 22:52:54 +0000 (UTC)
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>, xuyu@linux.alibaba.com,
        mgorman@suse.de, aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
References: <20201124194925.623931-1-riel@surriel.com>
 <alpine.LSU.2.11.2012141226350.1925@eggly.anvils>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v6 0/3] mm,thp,shm: limit shmem THP alloc gfp_mask
Message-ID: <e3f67a5f-9835-2752-3d35-fb5f6d701cf1@suse.cz>
Date:   Mon, 14 Dec 2020 23:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2012141226350.1925@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 10:16 PM, Hugh Dickins wrote:
> On Tue, 24 Nov 2020, Rik van Riel wrote:
> 
>> The allocation flags of anonymous transparent huge pages can be controlled
>> through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
>> help the system from getting bogged down in the page reclaim and compaction
>> code when many THPs are getting allocated simultaneously.
>> 
>> However, the gfp_mask for shmem THP allocations were not limited by those
>> configuration settings, and some workloads ended up with all CPUs stuck
>> on the LRU lock in the page reclaim code, trying to allocate dozens of
>> THPs simultaneously.
>> 
>> This patch applies the same configurated limitation of THPs to shmem
>> hugepage allocations, to prevent that from happening.
>> 
>> This way a THP defrag setting of "never" or "defer+madvise" will result
>> in quick allocation failures without direct reclaim when no 2MB free
>> pages are available.
>> 
>> With this patch applied, THP allocations for tmpfs will be a little
>> more aggressive than today for files mmapped with MADV_HUGEPAGE,
>> and a little less aggressive for files that are not mmapped or
>> mapped without that flag.
>> 
>> v6: make khugepaged actually obey tmpfs mount flags
>> v5: reduce gfp mask further if needed, to accomodate i915 (Matthew Wilcox)
>> v4: rename alloc_hugepage_direct_gfpmask to vma_thp_gfp_mask (Matthew Wilcox)
>> v3: fix NULL vma issue spotted by Hugh Dickins & tested
>> v2: move gfp calculation to shmem_getpage_gfp as suggested by Yu Xu
> 
> Andrew, please don't rush
> 
> mmthpshmem-limit-shmem-thp-alloc-gfp_mask.patch
> mmthpshm-limit-gfp-mask-to-no-more-than-specified.patch
> mmthpshmem-make-khugepaged-obey-tmpfs-mount-flags.patch
> 
> to Linus in your first wave of mmotm->5.11 sendings.
> Or, alternatively, go ahead and send them to Linus, but
> be aware that I'm fairly likely to want adjustments later.
> 
> Sorry for limping along so far behind, but I still have more
> re-reading of the threads to do, and I'm still investigating
> why tmpfs huge=always becomes so ineffective in my testing with
> these changes, even if I ramp up from default defrag=madvise to
> defrag=always:
>                     5.10   mmotm
> thp_file_alloc   4641788  216027
> thp_file_fallback 275339 8895647

So AFAICS before the patch shmem allocated hugepages basically with:
mapping_gfp_mask(inode->i_mapping) |  __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN
where mapping_gfp_mask() should be the default GFP_HIGHUSER_MOVABLE unless I
missed some shmem-specific override of the mask.

So the important flags mean all zones avilable, both __GFP_DIRECT_RECLAIM and
__GFP_KSWAPD_RECLAIM, but also __GFP_NORETRY which makes it less aggressive.

Now, with defrag=madvise and without madvised vma, there's just
GFP_TRANSHUGE_LIGHT, which means no __GFP_DIRECT_RECLAIM (and no
__GFP_KSWAPD_RECLAIM). Thus no reclaim and compaction at all. Indeed "little
less aggressive" is an understatement.

On the other hand, with defrag=always and again without madvised vma there
should be GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM | __GFP_NORETRY, so
compared to "before the patch" this is only missing __GFP_KSWAPD_RECLAIM. I
would be surprised if this meant so much difference in your testing as you show
above - I think you would have to be allocating those THPs just at a rate where
kswapd+kcompactd can keep up and nothing else "steals" the pages that background
reclaim+compaction creates.
In that (subjectively unlikely) case, I think significant improvement should be
visible with defrag=defer over defrag=madvise.

> I've been looking into it off and on for weeks (gfp_mask wrangling is
> not my favourite task! so tend to find higher priorities to divert me);
> hoped to arrive at a conclusion before merge window, but still have
> nothing constructive to say yet, hence my silence so far.
> 
> Above's "a little less aggressive" appears understatement at present.
> I respect what Rik is trying to achieve here, and I may end up
> concluding that there's nothing better to be done than what he has.
> My kind of hugepage-thrashing-in-low-memory may be so remote from
> normal usage, and could be skirting the latency horrors we all want
> to avoid: but I haven't reached that conclusion yet - the disparity
> in effectiveness still deserves more investigation.
> 
> (There's also a specific issue with the gfp_mask limiting: I have
> not yet reviewed the allowing and denying in detail, but it looks
> like it does not respect the caller's GFP_ZONEMASK - the gfp in
> shmem_getpage_gfp() and shmem_read_mapping_page_gfp() is there to
> satisfy the gma500, which wanted to use shmem but could only manage
> DMA32.  I doubt it wants THPS, but shmem_enabled=force forces them.)
> 
> Thanks,
> Hugh
> 

