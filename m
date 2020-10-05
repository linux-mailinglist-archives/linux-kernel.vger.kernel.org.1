Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B919283BBF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgJEP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgJEP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:56:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC8C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z/ADoBDMX8ZRqOWWhC2GgaxEqH5RD3lOHio6vPJy740=; b=PF30+QM2uXscf5VBvriahXX0MU
        pu+7Of06P+I2C/GXTI+/d2yBuJn+zCg1VV9CDqK8NoieCZcx/VAqNXP5TK/F/Y83NNOaa0f5CcN95
        tFy9p3cJqsNQRsF5xZfytf6QhgBBcy9gxY5qpD4tGIa5mDUzdHb4VANUE8DAz5m1YOsDMwBQrpy5Z
        r7NDQ3vAqeet8Uwt3D/vvfOfKDLJnPxx9FUSixReXRBpBxmXwglkW+D0KZfCaaHJ95dRNPrlAs2su
        ro4dwn4SDyv98PwNEOnvlkqm/hRAdDLwWvp3ao4TaS9p1FkaWNp/d1iJ4nPdjCxSnZu5xwjt+sCJ5
        OmxWrVJg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPSq9-000464-UG; Mon, 05 Oct 2020 15:55:54 +0000
Date:   Mon, 5 Oct 2020 16:55:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Message-ID: <20201005155553.GM20115@casper.infradead.org>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:03:56AM -0400, Zi Yan wrote:
> On 2 Oct 2020, at 4:30, David Hildenbrand wrote:
> > Yes, I think one important feature would be that we don't end up placing
> > a gigantic page where only a handful of pages are actually populated
> > without green light from the application - because that's what some user
> > space applications care about (not consuming more memory than intended.
> > IIUC, this is also what this patch set does). I'm fine with placing
> > gigantic pages if it really just "defragments" the address space layout,
> > without filling unpopulated holes.
> >
> > Then, this would be mostly invisible to user space, and we really
> > wouldn't have to care about any configuration.
> 
> I agree that the interface should be as simple as no configuration to
> most users. But I also wonder why we have hugetlbfs to allow users to
> specify different kinds of page sizes, which seems against the discussion
> above. Are we assuming advanced users should always use hugetlbfs instead
> of THPs?

Evolution doesn't always produce the best outcomes ;-)

A perennial mistake we've made is "Oh, this is a strange & new & weird
feature that most applications will never care about, let's put it in
hugetlbfs where nobody will notice and we don't have to think about it
in the core VM"

And then what was initially strange & new & weird gradually becomes
something that most applications just want to have happen automatically,
and telling them all to go use hugetlbfs becomes untenable, so we move
the feature into the core VM.

It is absurd that my phone is attempting to manage a million 4kB pages.
I think even trying to manage a quarter-million 16kB pages is too much
work, and really it would be happier managing 65,000 64kB pages.

Extend that into the future a decade or two, and we'll be expecting
that it manages memory in megabyte sized units and uses PMD and PUD
mappings by default.  PTE mappings will still be used, but very much
on a "Oh you have a tiny file, OK, we'll fragment a megabyte page into
smaller pages to not waste too much memory when mapping it" basis.  So,
yeah, PUD sized mappings have problems today, but we should be writing
software now so a Pixel 15 in a decade can boot a kernel built five
years from now and have PUD mappings Just Work without requiring the
future userspace programmer to "use hugetlbfs".

One of the longer-term todo items is to support variable sized THPs for
anonymous memory, just like I've done for the pagecache.  With that in
place, I think scaling up from PMD sized pages to PUD sized pages starts
to look more natural.  Itanium and PA-RISC (two architectures that will
never be found in phones...) support 1MB, 4MB, 16MB, 64MB and upwards.
The RiscV spec you pointed me at the other day confines itself to adding
support for 16, 64 & 256kB today, but does note that 8MB, 32MB and 128MB
sizes would be possible additions in the future.


But, back to today, what to do with this patchset?  Even on my 16GB
laptop, let alone my 4GB phone, I'm uncertain that allocating a 1GB
page is ever the right decision to make.  But my laptop runs a "mixed"
workload, and if you could convince me that Firefox would run 10% faster
by using a 1GB page as its in-memory cache, well, I'd be sold.

I do like having the kernel figure out what's in the best interests of the
system as a whole.  Apps don't have enough information, and while they
can provide hints, they're often wrong.  So, let's say an app maps 8GB
of anonymous memory.  As the app accesses it, we should probably start
by allocating 4kB pages to back that memory.  As time goes on and that
memory continues to be accessed and more memory is accessed, it makes
sense to keep track of that, replacing the existing 4kB pages with, say,
16-64kB pages and allocating newly accessed memory with larger pages.
Eventually that should grow to 2MB allocations and PMD mappings.
And then continue on, all the way to 1GB pages.

We also need to be able to figure out that it's not being effective
any more.  One of the issues with tracing accessed/dirty at the 1GB level
is that writing an entire 1GB page is going to take 0.25 seconds on a x4
gen3 PCIe link.  I know swapping sucks, but that's extreme.  So to use
1GB pages effectively today, we need to fragment them before choosing to
swap them out (*)  Maybe that's the point where we can start to say "OK,
this sized mapping might not be effective any more".  On the other hand,
that might not work for some situations.  Imagine, eg, a matrix multiply
(everybody's favourite worst-case scenario).  C = A * B where each of A,
B and C is too large to fit in DRAM.  There are going to be points of the
calculation where each element of A is going to be walked sequentially,
and so it'd be nice to use larger PTEs to map it, but then we need to
destroy that almost immediately to allow other things to use the memory.


I think I'm leaning towards not merging this patchset yet.  I'm in
agreement with the goals (allowing systems to use PUD-sized pages
automatically), but I think we need to improve the infrastructure to
make it work well automatically.  Does that make sense?

(*) It would be nice if hardware provided a way to track D/A on a sub-PTE
level when using PMD/PUD sized mappings.  I don't know of any that does
that today.
