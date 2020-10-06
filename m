Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00609284B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgJFL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:59:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgJFL7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:59:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601985572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPMVXWxdq6yHN+Hq+boIdJVu+2V9FZaUzwuN43Yg5a0=;
        b=WgXWtOQauAU77ro8qQj2YBh2Y56xSjkUdq9b15B5dAoL3iRmw78VLOaCAT5tpSenFUtSfj
        YR+VPVWjPMBX1HCO5cY62fRf+55TWV5rlhr8gg8C/bTlThWayRnagfIOoozT6sfCOOjDFK
        FuPmHTTvTyLLKuu4snRcp8X5BqFe2lE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55F61AFBB;
        Tue,  6 Oct 2020 11:59:31 +0000 (UTC)
Date:   Tue, 6 Oct 2020 13:59:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20201006115927.GD29020@dhcp22.suse.cz>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
 <f84c2b88-9912-d716-e83e-749fbfb6ff30@redhat.com>
 <8850ABA0-0B42-41DB-9ADC-0E2BB1F841D0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8850ABA0-0B42-41DB-9ADC-0E2BB1F841D0@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-10-20 14:05:17, Zi Yan wrote:
> On 5 Oct 2020, at 13:39, David Hildenbrand wrote:
> 
> >>>> consideting that 2MB THP have turned out to be quite a pain but
> >>>> situation has settled over time. Maybe our current code base is prepared
> >>>> for that much better.
> >>
> >> I am planning to refactor my code further to reduce the amount of
> >> the added code, since PUD THP is very similar to PMD THP. One thing
> >> I want to achieve is to enable split_huge_page to split any order of
> >> pages to a group of any lower order of pages. A lot of code in this
> >> patchset is replicating the same behavior of PMD THP at PUD level.
> >> It might be possible to deduplicate most of the code.
> >>
> >>>>
> >>>> Exposing that interface to the userspace is a different story of course.
> >>>> I do agree that we likely do not want to be very explicit about that.
> >>>> E.g. an interface for address space defragmentation without any more
> >>>> specifics sounds like a useful feature to me. It will be up to the
> >>>> kernel to decide which huge pages to use.
> >>>
> >>> Yes, I think one important feature would be that we don't end up placing
> >>> a gigantic page where only a handful of pages are actually populated
> >>> without green light from the application - because that's what some user
> >>> space applications care about (not consuming more memory than intended.
> >>> IIUC, this is also what this patch set does). I'm fine with placing
> >>> gigantic pages if it really just "defragments" the address space layout,
> >>> without filling unpopulated holes.
> >>>
> >>> Then, this would be mostly invisible to user space, and we really
> >>> wouldn't have to care about any configuration.
> >>
> >>
> >> I agree that the interface should be as simple as no configuration to
> >> most users. But I also wonder why we have hugetlbfs to allow users to
> >> specify different kinds of page sizes, which seems against the discussion
> >> above. Are we assuming advanced users should always use hugetlbfs instead
> >> of THPs?
> >
> > Well, with hugetlbfs you get a real control over which pagesizes to use.
> > No mixture, guarantees.
> >
> > In some environments you might want to control which application gets
> > which pagesize. I know of database applications and hypervisors that
> > sometimes really want 2MB huge pages instead of 1GB huge pages. And
> > sometimes you really want/need 1GB huge pages (e.g., low-latency
> > applications, real-time KVM, ...).
> >
> > Simple example: KVM with postcopy live migration
> >
> > While 2MB huge pages work reasonably fine, migrating 1GB gigantic pages
> > on demand (via userfaultdfd) is a painfully slow / impractical.
> 
> 
> The real control of hugetlbfs comes from the interfaces provided by
> the kernel. If kernel provides similar interfaces to control page sizes
> of THPs, it should work the same as hugetlbfs. Mixing page sizes usually
> comes from system memory fragmentation and hugetlbfs does not have this
> mixture because of its special allocation pools not because of the code
> itself.

Not really. Hugetlb is defined to provide a consistent and single page
size access to the memory. To the degree that you fail early if you
cannot guarantee that. This is not an implementation detail. This is the
semantic of the feature. Control goes along with the interface.

> If THPs are allocated from the same pools, they would act
> the same as hugetlbfs. What am I missing here?

THPs are a completely different beast. They are aiming to be transparent
so that user doesn't really have to control them explicitly[1]. They should
be dynamically created and demoted as the system manages resources
behind users back. In short they optimize rather than guanratee. This is
also the reason why a complete control sounds quite alien to me. Say you
explicitly ask for THP_SIZEFOO but the kernel decides a completely
different size later on. What is the actual contract you as a user are
getting?

In an ideal world the kernel would pick up the best large page
automagically. I am a bit skeptical we will reach such an enlightment
soon (if ever) so a certain level of hinting is likely needed to prevent
2MB THP fiasco again [1]. But the control should correspond to the
functionality users are getting.

> I just do not get why hugetlbfs is so special that it can have pagesize
> fine control when normal pages cannot get. The “it should be invisible
> to userpsace” argument suddenly does not hold for hugetlbfs.

In short it provides a guarantee.

Does the above clarifies it a bit?


[1] this is not entirely true though because there is a non-trivial
admin interface around THP. Mostly because they turned out to be too
transparent and many people do care about internal fragmentation,
allocation latency, locality (small page on a local node or a large on a
slightly further one?) or simply follow a cargo cult - just have a look
how many admin guides recommend disabling THPs. We got seriously burned
by 2MB THP because of the way how they were enforced on users.
-- 
Michal Hocko
SUSE Labs
