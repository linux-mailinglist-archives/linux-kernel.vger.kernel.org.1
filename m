Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC47E2CF5DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLDUxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:53:15 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95294C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:52:35 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so6767496qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xPWnnh6vZQTtFvZJIVOrhc3HGhSgSZqYkemGx+VVR/I=;
        b=RfdV89Gq2f4iCb4TtgiteOyTSJJiv4MovGwdwdYr31uoZahwrOMrKYsPdeHpENbEGk
         JIsi7bOPcPRd+dCgkoakgzfY1yCbkMBqd5zbbB5n4dntxdYXB8z7Xcm9nLlmWsqU21AI
         9IMF3ObABHP1qWQlJJvtfKZHuSKfK0STWH7C1uqzQmT8HtvJrpNalmJWWYamOXIWDrQm
         dxydJQejqE5wguGVjp+IXmQbL1yo2oKzw4PdXh+XbsLYPaNd88yPCgifKByhL5TXrPsb
         Y62hEpTwkNP5ihuCMcms6Nck0LOPv9QJdTfPsARSjq8Nvu3OqsYeNTAsEcLGaRruW9RN
         V/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xPWnnh6vZQTtFvZJIVOrhc3HGhSgSZqYkemGx+VVR/I=;
        b=SV4FTsv8X/e+gvVmn9pluY02xMlRBwExbMSs0CUngdqzCqROE0Is4O3AY24A5pRoSw
         ntpIIlohRIrl7evye0VK3TaEOokrwcTWaq2cehYbzEfdSOTOXDYj+9yTgZhOcrEiFMdF
         +eDP5cMCTdU+9PH9F2xuiMpXDjOZppMW0Z34DtkKOzwrqyGcEnN14NU9+fLPb55jKysr
         KAUgxo/vvmyJPMlulnLfbcWEN+f4jUGS6v0kWhN9u4TGoO7qCXxAEdMWxdXCh4If38V/
         wcJXQXyEDYPscLzXWgNDEhFtfx9fgkmZpPUonrHAWxOc2ml1IZo7onbkWfL3rniOE/53
         sD5Q==
X-Gm-Message-State: AOAM530jP8bPMd6F/IoUr9tWW+1YvmKgOe7X+1NDvjq2FRSKGs1GqK71
        rsQWszjuRUAdQkf2RoI9hvCafw==
X-Google-Smtp-Source: ABdhPJx+Iji2zhoCycJWUu1vTV+SSIROuayO5pjwDOlSTssLKMfU0Ftl/WNc/2BM/wo4bNoeFkcM6A==
X-Received: by 2002:a37:c82:: with SMTP id 124mr11128661qkm.360.1607115154755;
        Fri, 04 Dec 2020 12:52:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u20sm1927358qtb.9.2020.12.04.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:52:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1klI49-006E8l-C1; Fri, 04 Dec 2020 16:52:33 -0400
Date:   Fri, 4 Dec 2020 16:52:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201204205233.GF5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca>
 <87360lnxph.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87360lnxph.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 03:05:46PM -0500, Daniel Jordan wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Dec 02, 2020 at 08:34:32PM -0500, Pavel Tatashin wrote:
> >> What I meant is the users of the interface do it incrementally not in
> >> large chunks. For example:
> >> 
> >> vfio_pin_pages_remote
> >>    vaddr_get_pfn
> >>         ret = pin_user_pages_remote(mm, vaddr, 1, flags |
> >> FOLL_LONGTERM, page, NULL, NULL);
> >> 1 -> pin only one pages at a time
> >
> > I don't know why vfio does this, it is why it so ridiculously slow at
> > least.
> 
> Well Alex can correct me, but I went digging and a comment from the
> first type1 vfio commit says the iommu API didn't promise to unmap
> subpages of previous mappings, so doing page at a time gave flexibility
> at the cost of inefficiency.

iommu restrictions are not related to with gup. vfio needs to get the
page list from the page tables as efficiently as possible, then you
break it up into what you want to feed into the IOMMU how the iommu
wants.

vfio must maintain a page list to call unpin_user_pages() anyhow, so
it makes alot of sense to assemble the page list up front, then do the
iommu, instead of trying to do both things page at a time.

It would be smart to rebuild vfio to use scatter lists to store the
page list and then break the sgl into pages for iommu
configuration. SGLs will consume alot less memory for the usual case
of THPs backing the VFIO registrations.

ib_umem_get() has some example of how to code this, I've been thinking
we could make this some common API, and it could be further optimized.

> Yesterday I tried optimizing vfio to skip gup calls for tail pages after
> Matthew pointed out this same issue to me by coincidence last week.

Please don't just hack up vfio like this. Everyone needs faster gup,
we really need to solve this in the core code. Plus this is tricky,
vfio is already using follow_pfn wrongly, drivers should not be open
coding MM stuff.

> Currently debugging, but if there's a fundamental reason this won't work
> on the vfio side, it'd be nice to know.

AFAIK there is no guarentee that just because you see a compound head
that the remaining pages in the page tables are actually the tail
pages. This is only true sometimes, for instance if an entire huge
page is placed in a page table level.

I belive Ralph pointed to some case where we might break a huge page
from PMD to PTEs then later COW one of the PTEs. In this case the
compound head will be visible but the page map will be non-contiguous
and the page flags on each 4k entry will be different.

Only GUP's page walkers know that the compound page is actually at a
PMD level and can safely apply the 'everything is the same'
optimization.

The solution here is to make core gup faster, espcially for the cases
where it is returning huge pages. We can approach this by:
 - Batching the compound & tail page acquisition for higher page
   levels, eg gup fast does this already, look at record_subpages()
   gup slow needs it too
 - Batching unpin for compound & tail page, the opposite of the 'refs'
   arg for try_grab_compound_head()
 - Devise some API where get_user_pages can directly return
   contiguous groups of pages to avoid memory traffic
 - Reduce the cost of a FOLL_LONGTERM pin eg here is a start:
    https://lore.kernel.org/linux-mm/0-v1-5551df3ed12e+b8-gup_dax_speedup_jgg@nvidia.com
   And CMA should get some similar treatment. Scanning the output page
   list multiple times is slow.

I would like to get to a point where the main GUP walker functions can
output in more formats than just page array. For instance directly
constructing and chaining a biovec or sgl would dramatically improve
perfomance and decrease memory consumption. Being able to write in
hmm_range_fault's pfn&flags output format would delete a whole bunch
of duplicated code.

Jason
