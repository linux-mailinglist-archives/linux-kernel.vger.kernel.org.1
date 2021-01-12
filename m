Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354C92F2B16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392555AbhALJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbhALJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:19:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE2C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:18:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id g12so300430ejf.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qfe9Npb8wm8W3Nx6KHLBI0GR4sRyQOFWZ/Gy5vmV5F4=;
        b=iMGd/9IaaW7DBT3wuCuI8RIBPTq7yxq3pCSYH0KcQ39YaQ6ohaPykce+qOJozTZN9a
         RtAV3ithfeDnvSazKxyis+cAREsMrIiu16kHBjA1AXcmcMi/PIPpSewly2nT/yY0pcc6
         4nFwZJeVB3OzmfLdyku60ZPE2/48YEFdzsMGcdhcUn6qI0kOakIqTxXkm+odu8LPA3Ie
         yWqwy/JPr4iQlLpU1f8B/q3wKQsNSyyOpIrAXQt7b4TiFtFj5L8a8vvpiyxIDAc2E/Lb
         QOJhXNR52So2+AKv2MrJesjPyd0iLCO0PdtBc4v9tyF84+JAV4GW9j00F7YfIlRu3FC7
         kSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qfe9Npb8wm8W3Nx6KHLBI0GR4sRyQOFWZ/Gy5vmV5F4=;
        b=olx8wj6Cwu+Fvks8j0ihHgyl0XMxT0VIwzY8a/Recj8zNDkloyUy1/8hLIFuTlnlZ8
         xk5fhsUI35Khu+77IEadbConr/PYxP9P7+tEuNplxvJyhZwahw2VDwXD/QtNLinabJey
         QvaZXmbTPl5MAxZxPjdsth6Pbh9jpaWYprWgAgOEfWv8ebUlFUmpJ4Ddgwg0MABoPRK+
         +jjmOIZZ3OXoBZk2OydbEw7VMuuUkcPX7aaCubTzIvqzYTVIO2PmG/V7x7lz+H67Qmr3
         jWvd0Epce0ZI9v3NC8i11k/qVFuWhgjqmQKuP+KZSFwgHaJjFeQYZ/jfVGK5NjpwrYbj
         A+ug==
X-Gm-Message-State: AOAM532RZBAdB1X9W55jol3+Ahy2dOWbgs5anvFRsXTKz/xwsTkQMdLP
        d5vSwWnyJ9ne48P0+13rark1yBcO8SzMauvpmLYIg1vLX80=
X-Google-Smtp-Source: ABdhPJzkznHTCYSLSjiYmRel+KVPA3sXYSdVro4Pf4T5plbbh+OR4IiAuYOMAdliSvGBh57bfxP5X1lqUIRGY0XG2jE=
X-Received: by 2002:a17:906:a3c7:: with SMTP id ca7mr2614585ejb.523.1610443109228;
 Tue, 12 Jan 2021 01:18:29 -0800 (PST)
MIME-Version: 1.0
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com> <20210106104255.GK13207@dhcp22.suse.cz>
 <7d7c5dc4-7784-5dcc-fc00-4fe99f0a4a90@redhat.com> <CAPcyv4iN4t2P_rQS23E7Bb-eLUAt389Y5t4X-yoRQrxvsN3DWQ@mail.gmail.com>
 <75bb1429-d133-d303-a67a-be16c654ada8@redhat.com>
In-Reply-To: <75bb1429-d133-d303-a67a-be16c654ada8@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 01:18:20 -0800
Message-ID: <CAPcyv4gXaUswZS_a4-oiQZWVZ4QDJrKps4XGs=xxLE0Ls=PSmg@mail.gmail.com>
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section collisions
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 1:16 AM David Hildenbrand <david@redhat.com> wrote:
>
> [...]
>
> >>> Well, I would love to have no surprises either. So far there was not
> >>> actual argument why the pmem reserved space cannot be fully initialized.
> >>
> >> Yes, I'm still hoping Dan can clarify that.
> >
> > Complexity and effective utility (once pfn_to_online_page() is fixed)
> > are the roadblocks in my mind. The altmap is there to allow for PMEM
> > capacity to be used as memmap space, so there would need to be code to
> > break that circular dependency and allocate a memmap for the metadata
> > space from DRAM and the rest of the memmap space for the data capacity
> > from pmem itself. That memmap-for-pmem-metadata will still represent
> > offline pages. So once pfn_to_online_page() is fixed, what pfn-walker
> > is going to be doing pfn_to_page() on PMEM metadata? Secondly, there
>
> Assume I do
>
> pgmap = get_dev_pagemap(pfn, NULL);
> if (pgmap)
>         return pfn_to_page(pfn);
> return NULL;
>
> on a random pfn because I want to inspect ZONE_DEVICE PFNs.

I keep getting hung up on the motivation to do random pfn inspection?

The problems we have found to date have required different solutions.
The KVM bug didn't use get_dev_pagemap() to inspect the pfn because it
could rely on the fact that the page already had an elevated reference
count. The get_user_pages() path only looks up ZONE_DEVICE pfns when
it see {pte,pmd,pud}_devmap set in the page table entry. pfn walkers
have been a problem, but with pfn_to_online_page() fixed what is the
remaining motivation to inspect ZONE_DEVICE pfns?

> IIUC, the memmap I get might usually be initialized, except we're
> hitting a PFN in the reserved altmap space. Correct?

The pagemap currently returns true for every pfn in the range
including those in the altmap.



>
> Do we expect this handling to not be valid - i.e., initialization to be
> of no utility? (to make it fly we would have to explicitly check for
> PFNs in the altmap reserved space, which wouldn't be too problematic)
>
> > is a PMEM namespace mode called "raw" that eschews DAX and 'struct
> > page' for pmem and just behaves like a memory-backed block device. The
> > end result is still that pfn walkers need to discover if a PMEM pfn
> > has a page, so I don't see what "sometimes there's an
> > memmap-for-pmem-metadata" buys us?
>
> Right, but that's as easy as doing a pfn_valid() first.
>
>
> Let me try to express what I (and I think Michal) mean:
>
> In pagemap_range(), we
>
> 1. move_pfn_range_to_zone()->memmap_init_zone(): initialize the memmap
> of the PMEM device used as memmap itself ("self host", confusing). We
> skip initializing the memmap for the the reserved altmap space.
>
> 2. memmap_init_zone_device(): initialize the memmap of everything
> outside of the altmap space.
>
> IIUC, the memmap of the reserved altmap space remains uninitialized.
> What speaks against just initializing that part in e.g., 2. or similarly
> after 1.?
>
>
> I'm planning on documenting the result of this discussion in the code,
> so people don't have to scratch their head whenever stumbling over the
> altmap reserved space.
>
> >
> >>
> >>> On the other hand making sure that pfn_to_online_page sounds like the
> >>> right thing to do. And having an explicit check for zone device there in
> >>> a slow path makes sense to me.
> >>
> >> As I said, I'd favor to simplify and just get rid of the special case,
> >> instead of coming up with increasingly complex ways to deal with it.
> >> pfn_to_online_page() used to be simple, essentially checking a single
> >> flag was sufficient in most setups.
> >
> > I think the logic to throw away System RAM that might collide with
> > PMEM and soft-reserved memory within a section is on the order of the
> > same code complexity as the patch proposed here, no? Certainly the
> > throw-away concept itself is easier to grasp, but I don't think that
> > would be reflected in the code patch to achieve it... willing to be
> > proved wrong with a patch.
>
> Well, at least it sounds easier to go over memblock holes and
> align-up/down some relevant PFNs to section boundaries, ending up with
> no affect to runtime performance later (e.g., pfn_to_online_page()). But
> I agree that most probably the devil is in the detail - e.g., handling
> different kind of holes (different flavors of "reserved") and syncing up
> other data structures (e.g., resource tree).
>
> I don't have time to look into that right now, but might look into it in
> the future. For now I'm fine with this approach, assuming we don't
> discover other corner cases that turn it even more complex. I'm happy
> that we finally talk about it and fix it!
>
>
> --
> Thanks,
>
> David / dhildenb
>
