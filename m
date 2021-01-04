Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CFF2E9741
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbhADO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:27:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:53272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbhADO1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:27:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609770386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kceaip5a0ZIcxd3Dv7w40HK/0opj1KKZx/md5Mk5mQc=;
        b=ZYM/Ebto70SXCoH8rOo3zUgcXj0b0pBCVhiZdeIChWT2F3HP+Of1Zqx8lYxYLXIe32Zz8p
        BZVZABaPkuv0QrtQEheOdgee9MMAnGWKzMAnxo/ZeEG/JbWKLVeDehwbzhoqmeIXdJgFz4
        IwzsmtNfhSGwoG7F5fKx8976lFkWPW4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8ECFBB7A5;
        Mon,  4 Jan 2021 14:26:26 +0000 (UTC)
Date:   Mon, 4 Jan 2021 15:26:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: uninitialized pmem struct pages
Message-ID: <20210104142624.GI13207@dhcp22.suse.cz>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 11:45:39, David Hildenbrand wrote:
> On 04.01.21 11:03, Michal Hocko wrote:
> > Hi,
> > back in March [1] you have recommended 53cdc1cb29e8
> > ("drivers/base/memory.c: indicate all memory blocks as removable") to be
> > backported to stable trees and that has led to a more general discussion
> > about the current state of pfn walkers wrt. uninitialized pmem struct
> > pages. We haven't concluded any specific solution for that except for a
> > general sentiment that pfn_to_online_page should be able to catch those.
> > I might have missed any follow ups on that but I do not think we have
> > landed on any actual solution in the end. Have I just missed any followups?
> 
> Thanks for raising this issue. It's still on my list of "broken and
> non-trivial to fix" things.
> 
> So, as far as I recall, we still have the following two issues remaining:
> 
> 1. pfn_to_online_page() false positives
> 
> The semantics of pfn_to_online_page() were broken with sub-section
> hot-add in corner cases.
> 
> If we have ZONE_DEVICE hot-added memory that overlaps in a section with
> boot memory, this memory section will contain parts ZONE_DEVICE memory
> and parts !ZONE_DEVICE memory. This can happen in sub-section
> granularity (2MB IIRC). pfn_to_online_page() will succeed on ZONE_DEVICE
> memory parts as the whole section is marked as online. Bad.

OK, I was not aware of this problem. Anyway, those pages should be still
allocated and their state should retain their last state. I would have
to double check but this shouldn't be harmfull. Or what would be an
actual problem?

> One instance where this is still an issue is
> mm/memory-failure.c:memory_failure() and
> mm/memory-failure.c:soft_offline_page(). I thought for a while about
> "fixing" these, but to me it felt like fixing pfn_to_online_page() is
> actually the right approach.
> 
> But worse, before ZONE_DEVICE hot-add
> 1. The whole section memmap does already exist (early sections always
> have a full memmap for the whole section)
> 2. The whole section memmap is initialized (although eventually with
> dummy node/zone 0/0 for memory holes until that part is fixed) and might
> be accessed by pfn walkers.
> 
> So when hotadding ZONE_DEVICE we are modifying already existing and
> visible memmaps. Bad.

Could you elaborate please?
 
> 2. Deferred init of ZONE_DEVICE ranges
> 
> memmap_init_zone_device() runs after the ZONE_DEVICE zone was resized
> and outside the memhp lock. I did not follow if the use of
> get_dev_pagemap() actually makes sure that memmap_init_zone_device() in
> pagemap_range() actually completed. I don't think it does.

So a pfn walker can see an unitialized struct page for a while, right?

The problem that I have encountered is that some zone device pages are
not initialized at all. That sounds like a different from those 2 above.
I am having hard time to track what kind of pages those are and why we
cannot initialized their zone/node and make them reserved at least.

> > Is anybody working on that?
> > 
> 
> I believe Dan mentioned somewhere that he wants to see a real instance
> of this producing a BUG before actually moving forward with a fix. I
> might be wrong.

We have seen reports about those uninitialized struct pages on our 5.3
based kernels. Backporting 53cdc1cb29e8 helped for the particular report
but I still consider it a workaround rather than a fix. I do not have
any reports for other pfn walkers but we might be just lucky and I will
sleep better if I do not have rely on the luck.

[...]

I will think about your proposed solutions after I manage to get through
my email backlog.

Thanks!

-- 
Michal Hocko
SUSE Labs
