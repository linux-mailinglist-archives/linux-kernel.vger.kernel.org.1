Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A0F280E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgJBHcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:32:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:34080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJBHcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:32:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601623927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+4lGymTonwUKn49OsGa2hsWMCGqR/XylF0uFTOA2l4=;
        b=sKboYHkMhjDKJ3drUFYX2m+oMS+TtE4WiL9ObDOu4w3wHcve5iEGkFSngHcBVQEudP18qU
        9yftr2g9nZTqoVSbye8IRlzz4W/dsRyM6Rz7A+SbAxmgjt9x7+C0VUqZPb848Iax21Evhk
        qsuz9k1T33AQ1B+FuKhEYUkvgVHntJ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE162AC4D;
        Fri,  2 Oct 2020 07:32:06 +0000 (UTC)
Date:   Fri, 2 Oct 2020 09:32:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Message-ID: <20201002073205.GC20872@dhcp22.suse.cz>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-10-20 11:14:14, Zi Yan wrote:
> On 30 Sep 2020, at 7:55, Michal Hocko wrote:
> 
> > On Mon 28-09-20 13:53:58, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> Hi all,
> >>
> >> This patchset adds support for 1GB PUD THP on x86_64. It is on top of
> >> v5.9-rc5-mmots-2020-09-18-21-23. It is also available at:
> >> https://github.com/x-y-z/linux-1gb-thp/tree/1gb_thp_v5.9-rc5-mmots-2020-09-18-21-23
> >>
> >> Other than PUD THP, we had some discussion on generating THPs and contiguous
> >> physical memory via a synchronous system call [0]. I am planning to send out a
> >> separate patchset on it later, since I feel that it can be done independently of
> >> PUD THP support.
> >
> > While the technical challenges for the kernel implementation can be
> > discussed before the user API is decided I believe we cannot simply add
> > something now and then decide about a proper interface. I have raised
> > few basic questions we should should find answers for before the any
> > interface is added. Let me copy them here for easier reference
> Sure. Thank you for doing this.
> 
> For this new interface, I think it should generate THPs out of populated
> memory regions synchronously. It would be complement to khugepaged, which
> generate THPs asynchronously on the background.
> 
> > - THP allocation time - #PF and/or madvise context
> I am not sure this is relevant, since the new interface is supposed to
> operate on populated memory regions. For THP allocation, madvise and
> the options from /sys/kernel/mm/transparent_hugepage/defrag should give
> enough choices to users.

OK, so no #PF, this makes things easier.

> > - lazy/sync instantiation
> 
> I would say the new interface only does sync instantiation. madvise has
> provided the lazy instantiation option by adding MADV_HUGEPAGE to populated
> memory regions and letting khugepaged generate THPs from them.

OK

> > - huge page sizes controllable by the userspace?
> 
> It might be good to allow advanced users to choose the page sizes, so they
> have better control of their applications.

Could you elaborate more? Those advanced users can use hugetlb, right?
They get a very good control over page size and pool preallocation etc.
So they can get what they need - assuming there is enough memory.

> For normal users, we can provide
> best-effort service. Different options can be provided for these two cases.

Do we really need two sync mechanisms to compact physical memory? This
adds an API complexity because it has to cover all possible huge pages
and that can be a large set of sizes. We already have that choice for
hugetlb mmap interface but that is needed to cover all existing setups.
I would argue this doesn't make the API particurarly easy to use.

> The new interface might want to inform user how many THPs are generated
> after the call for them to decide what to do with the memory region.

Why would that be useful? /proc/<pid>/smaps should give a good picture
already, right?

> > - aggressiveness - how hard to try
> 
> The new interface would try as hard as it can, since I assume users really
> want THPs when they use this interface.
> 
> > - internal fragmentation - allow to create THPs on sparsely or unpopulated
> >   ranges
> 
> The new interface would only operate on populated memory regions. MAP_POPULATE
> like option can be added if necessary.

OK, so initialy you do not want to populate more memory. How do you
envision a future extension to provide such a functionality. A different
API, modification to existing?

> > - do we need some sort of access control or privilege check as some THPs
> >   would be a really scarce (like those that require pre-reservation).
> 
> It seems too much to me. I suppose if we provide page size options to users
> when generating THPs, users apps could coordinate themselves. BTW, do we have
> access control for hugetlb pages? If yes, we could borrow their method.

We do not. Well, there is a hugetlb cgroup controller but I am not sure
this is the right method. A lack of hugetlb access controll is a serious
shortcoming which has turned this interface into "only first class
citizens" feature with a very closed coordination with an admin.
-- 
Michal Hocko
SUSE Labs
