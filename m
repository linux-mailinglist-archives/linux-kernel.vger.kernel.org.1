Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4426283FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgJETiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgJETiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:38:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA2CC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=A/OqTcP/ll/EOqyoCasxl2O3QCdiYXCnbxBZDY6AU10=; b=VIysEGHGlH/DBIJrRGDVrfX5au
        6HdnYBjD7HOCPNLi1xoBCmML5dvFPi/KTzWvn5k05DhsVgfiQBzYAXP1OYGBDnI3AOd+fkBhsSNVG
        NxTuYjML3AW5Vg7LrK1SjizJSO0azt7u7SCKsbNLY5RusJpBZ+epgMyEyNPLDSQsnkFdUL2FQ+y0g
        5o0vb9W04kMT1sToB/H/eY8LJ/x2HKiB17xFa3CMsRF1bTnpq2hEGI0V32vBq6TppDOzL8qlwgdGj
        zzKp+s4v3//nj311WeOIGSfXX91ARhlsSbMkKVQ4rIh7PmfVHmZf+XrF6x6YXazra7m0XlhFLSmwA
        SpOj3CmA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPWIs-0001FU-QA; Mon, 05 Oct 2020 19:37:46 +0000
Date:   Mon, 5 Oct 2020 20:37:46 +0100
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
Message-ID: <20201005193746.GO20115@casper.infradead.org>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
 <20201005155553.GM20115@casper.infradead.org>
 <302C73F4-27BF-459C-8D78-5CBAF812E5CB@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <302C73F4-27BF-459C-8D78-5CBAF812E5CB@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 03:12:55PM -0400, Zi Yan wrote:
> On 5 Oct 2020, at 11:55, Matthew Wilcox wrote:
> > One of the longer-term todo items is to support variable sized THPs for
> > anonymous memory, just like I've done for the pagecache.  With that in
> > place, I think scaling up from PMD sized pages to PUD sized pages starts
> > to look more natural.  Itanium and PA-RISC (two architectures that will
> > never be found in phones...) support 1MB, 4MB, 16MB, 64MB and upwards.
> > The RiscV spec you pointed me at the other day confines itself to adding
> > support for 16, 64 & 256kB today, but does note that 8MB, 32MB and 128MB
> > sizes would be possible additions in the future.
> 
> Just to understand the todo items clearly. With your pagecache patchset,
> kernel should be able to understand variable sized THPs no matter they
> are anonymous or not, right?

... yes ... modulo bugs and places I didn't fix because only anonymous
pages can get there ;-)  There are still quite a few references to
HPAGE_PMD_MASK / SIZE / NR and I couldn't swear that they're all related
to things which are actually PMD sized.  I did fix a couple of places
where the anonymous path assumed that pages were PMD sized because I
thought we'd probably want to do that sooner rather than later.

> For anonymous memory, we need kernel policies
> to decide what THP sizes to use at allocation, what to do when under
> memory pressure, and so on. In terms of implementation, THP split function
> needs to support from any order to any lower order. Anything I am missing here?

I think that's the bulk of the work.  The swap code also needs work so we
don't have to split pages to swap them out.

> > I think I'm leaning towards not merging this patchset yet.  I'm in
> > agreement with the goals (allowing systems to use PUD-sized pages
> > automatically), but I think we need to improve the infrastructure to
> > make it work well automatically.  Does that make sense?
> 
> I agree that this patchset should not be merged in the current form.
> I think PUD THP support is a part of variable sized THP support, but
> current form of the patchset does not have the “variable sized THP”
> spirit yet and is more like a special PUD case support. I guess some
> changes to existing THP code to make PUD THP less a special case would
> make the whole patchset more acceptable?
> 
> Can you elaborate more on the infrastructure part? Thanks.

Oh, this paragraph was just summarising the above.  We need to
be consistently using thp_size() instead of HPAGE_PMD_SIZE, etc.
I haven't put much effort yet into supporting pages which are larger than
PMD-size -- that is, if a page is mapped with a PMD entry, we assume
it's PMD-sized.  Once we can allocate a larger-than-PMD sized page,
that's off.  I assume a lot of that is dealt with in your patchset,
although I haven't audited it to check for that.

> > (*) It would be nice if hardware provided a way to track D/A on a sub-PTE
> > level when using PMD/PUD sized mappings.  I don't know of any that does
> > that today.
> 
> I agree it would be a nice hardware feature, but it also has a high cost.
> Each TLB would support this with 1024 bits, which is about 16 TLB entry size,
> assuming each entry takes 8B space. Now it becomes why not having a bigger
> TLB. ;)

Oh, we don't have to track at the individual-page level for this to be
useful.  Let's take the RISC-V Sv39 page table entry format as an example:

63-54 attributes
53-28 PPN2
27-19 PPN1
18-10 PPN0
9-8 RSW
7-0 DAGUXWRV

For a 2MB page, we currently insist that 18-10 are zero.  If we repurpose
eight of those nine bits as A/D bits, we can track at 512kB granularity.
For 1GB pages, we can use 16 of the 18 bits to track A/D at 128MB
granularity.  It's not great, but it is quite cheap!
