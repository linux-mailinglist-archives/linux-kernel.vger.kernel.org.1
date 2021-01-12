Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7777D2F3D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437826AbhALVeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437055AbhALUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:52:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A46C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:52:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b2so3902484edm.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igUkdL4hc98zgwZyYfUvzpN2tIurwQ9y1Rg/DLI8Hes=;
        b=XKg4ur4aKi8mS1g2q2IzWLf7nq3NPbpuz37jjJzPntepgC/Jh/GUl1Lc+ZFtHqbwJm
         I9HRLMMUfLZ4JAwoit/6XFM9b3QoHv9XS6PJ3SG5jN3OP5etdxuM5SerHnefSQscANXO
         Ex/ooAYHonG28OZSy39VOeyRzJFG6CM6QbtkTPh5u1HAuM64FRxzyv060nBP6mxDPeVs
         MOXkMGCcPE5toPO108rHy3h8YGSc0dMp6QsVxHJ+PAVjE8jXxiHFO9MsmMVOwulCR4hG
         SfXh9NVe8+5ybflZUk6jvYu46HMJj1F3esvKBsqqpBauP3xJcAHNok/gg0DsirH6KWx8
         UT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igUkdL4hc98zgwZyYfUvzpN2tIurwQ9y1Rg/DLI8Hes=;
        b=BaUmM4IMl72ApcLwXJDgLW2YYXo+Hkux9ulp91NbZPUEDx9O9egVgv7qDysmlDA7Mp
         jjp/YA88altXIYXaFBgeSpgLIkPAh43ZmnQ39GP7n6uU58d3IA+lG7zFxbvOIPTuj18x
         wajhG47gOmAXg+6mK469fpN23W6eMWLDzigU/qRNKG13C0+5GdizEJ7+21krj9okx4iL
         29on1miAyGITWyDxRwNTjevh8dBI1asHepQN+V1T7A4ULhAmaUeSJlPO8DNRqtfLFg4w
         hPfrVAWMlnv6Sn00UPO/79qTHLDDae7OSMLn6Kki+mfmrz8lBmgS3f7aDZkjtI20Vns9
         7LAw==
X-Gm-Message-State: AOAM5324pRLef6W7gYA/GNHL9H2edzqb7nUY8pW2GAXUua56mJ8g1bCQ
        fRI9TxzC4yA6CCafYgCdelpxoJoY84yi7Mdf5jNJGZYLD4c=
X-Google-Smtp-Source: ABdhPJyuyWgqRIMJC98ViB7sEAgKRXvqDgVKMOXcoLQs2zafRAgYEYid196V0DbGfnqFYnbaAhDjD0xvcGpN7W34Y9E=
X-Received: by 2002:a05:6402:1102:: with SMTP id u2mr838270edv.18.1610484734302;
 Tue, 12 Jan 2021 12:52:14 -0800 (PST)
MIME-Version: 1.0
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com> <20210106104255.GK13207@dhcp22.suse.cz>
 <7d7c5dc4-7784-5dcc-fc00-4fe99f0a4a90@redhat.com> <CAPcyv4iN4t2P_rQS23E7Bb-eLUAt389Y5t4X-yoRQrxvsN3DWQ@mail.gmail.com>
 <75bb1429-d133-d303-a67a-be16c654ada8@redhat.com> <CAPcyv4gXaUswZS_a4-oiQZWVZ4QDJrKps4XGs=xxLE0Ls=PSmg@mail.gmail.com>
 <b12d3dab-b2a0-e274-7eba-e16971067883@redhat.com>
In-Reply-To: <b12d3dab-b2a0-e274-7eba-e16971067883@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 12:52:05 -0800
Message-ID: <CAPcyv4jJdpfnhBa2H26Wdz6a6+2z92UqaGcf_vAH_bScKXe6sA@mail.gmail.com>
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section collisions
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.01.21 10:18, Dan Williams wrote:
> > On Thu, Jan 7, 2021 at 1:16 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> [...]
> >>
> >>>>> Well, I would love to have no surprises either. So far there was not
> >>>>> actual argument why the pmem reserved space cannot be fully initialized.
> >>>>
> >>>> Yes, I'm still hoping Dan can clarify that.
> >>>
> >>> Complexity and effective utility (once pfn_to_online_page() is fixed)
> >>> are the roadblocks in my mind. The altmap is there to allow for PMEM
> >>> capacity to be used as memmap space, so there would need to be code to
> >>> break that circular dependency and allocate a memmap for the metadata
> >>> space from DRAM and the rest of the memmap space for the data capacity
> >>> from pmem itself. That memmap-for-pmem-metadata will still represent
> >>> offline pages. So once pfn_to_online_page() is fixed, what pfn-walker
> >>> is going to be doing pfn_to_page() on PMEM metadata? Secondly, there
> >>
> >> Assume I do
> >>
> >> pgmap = get_dev_pagemap(pfn, NULL);
> >> if (pgmap)
> >>         return pfn_to_page(pfn);
> >> return NULL;
> >>
> >> on a random pfn because I want to inspect ZONE_DEVICE PFNs.
> >
> > I keep getting hung up on the motivation to do random pfn inspection?
> >
> > The problems we have found to date have required different solutions.
> > The KVM bug didn't use get_dev_pagemap() to inspect the pfn because it
> > could rely on the fact that the page already had an elevated reference
> > count. The get_user_pages() path only looks up ZONE_DEVICE pfns when
> > it see {pte,pmd,pud}_devmap set in the page table entry. pfn walkers
> > have been a problem, but with pfn_to_online_page() fixed what is the
> > remaining motivation to inspect ZONE_DEVICE pfns?
>
> 1) Let's assume we want to implement zone shrinking
> (remove_pfn_range_from_zone()->shrink_zone_span()) for ZONE_DEVICE at
> some point.

I don't expect that will ever be something the kernel will want to do
given the association of pgmap to the lifetime of a given device
configuration. The mechanism to mutate a ZONE_DEVICE mapping is unbind
device, reconfigure device, bind device to establish a new ZONE_DEVICE
mapping.

>
> A simple approach would be going via get_dev_pagemap(pfn,
> NULL)->pfn_to_page(pfn), checking for the zone.
>
> If that's not possible, then extending dev_pagemap (e.g., indicating the
> nid) might also work (unless there is another way to get the nid).
>
>
> 2) Let's take a look at mm/memory-failure.c:memory_failure_dev_pagemap()
>
> IIUC, we might end up doing pfn_to_page(pfn) on a pfn in the reserved
> altmap space, so one with an uninitialized memmap.
>
> E.g., in dax_lock_page() we access page->mapping, which might just be
> garbage. dax_mapping() will de-reference garbage.
>
> Most probably I am missing something here.

No you're not, this is a real issue because get_dev_pagemap() is valid
for the metadata space. I need to add a patch to validate
get_dev_pagemap() vs the pfns that are data vs metadata.


>
>
>
> Question is: what are the expectations regarding the memmap if
> get_dev_pagemap() succeeded.
>
> I'm fine documenting that "get_dev_pagemap() does not guarantee that the
> "struct page" returned by pfn_to_page() was initialized and can safely
> be used. E.g., it might be a pfn in the reserved altmap space, for which
> the memmap is never initialized. Accessing it might be dangerous.".
>
> Then, there has to be a check at relevant places (e.g.,
> memory_failure_dev_pagemap()), checking somehow if the memmap content
> can actually be used.

Ok, let me audit and fix that up.

Thanks David.
