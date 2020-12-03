Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4002CCBB4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgLCBfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgLCBfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:35:50 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F9C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 17:35:09 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r5so275579eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwHhRJsP3DZwew8JQ92NqQyNUaCSoTst/Bc5po5pW7I=;
        b=M2fDHg/GuAjypin1DrEff5pK/6of2VtUHfBoE2rdszAyyX1POwuZbZhvqG8f0n6EkV
         0W8Wu4SCS7CjgwTcjDfHxMoNXAwLv2GDZ6m/1mw7MSkMhkE0FDVevbA6KYGH4EAJYPtL
         K54yaOv+NIJsz7g4x5fapWRMeVIBTK2+4xu4mYfqwTC05o5n7Tgtcwya5K47lOUtKPDT
         /VJ60S+YLMCAncwA0QIT88wM/XG7R2IiB5c4fec6JLSGNBINQ6M9iVZlguaqN9r2i5/8
         ov55uqiFheADaTfERJnyYDLmIl+N81yqTlzAtnCAsiJq8c00DFB93o865uMQpFyYKMOX
         oFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwHhRJsP3DZwew8JQ92NqQyNUaCSoTst/Bc5po5pW7I=;
        b=D90vjniiq8UA/JuSkPe/Rco4m8c4MGxbBinAaaga5yo+1KqBdz/+rOaLsYUclwCg7+
         Fd69Vs8eNzPpmKu2pqvQ2MwPeUWFt2wVDRvAqtVB958BdAbKng3q4HTvKQDuQCKBI9xc
         hwsSF9vCln8KPs3FfQpV/cVcsYknlc/ag7nV0wFuiYHtGV7XWFW+V4ePvBWM6a29qBFz
         xE645ANkmlnAZHEI3oMZqnnAVMg2aNgY7ZsjiAgxATM/B3ha/0rOT5TIzjOavhdGfiSw
         NDcPXObvLR0CQYMQPq4CYWRtVkSYaGP/QBbQ7HU7/zm3ZvLC6xEODfqs0i/gOjvcK0VB
         KXcQ==
X-Gm-Message-State: AOAM533uAMDWung93otNhIqByZpP/2+7wf4jm9WM1VkF8XbIZUwG4NnJ
        lVJa5uBhNq6wMVfvodgRB+oGU7ES7MTAoE2m6+C0eA==
X-Google-Smtp-Source: ABdhPJwK/jopuKSOlSKkXDBQPpswTyQag77kb7gGmBhCTsbhPtwsRix/53oObBaUNeEoL/jBVDryzigMFOdVB9evyTs=
X-Received: by 2002:a50:f404:: with SMTP id r4mr800225edm.62.1606959308396;
 Wed, 02 Dec 2020 17:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com> <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com> <20201203010809.GQ5487@ziepe.ca>
In-Reply-To: <20201203010809.GQ5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Dec 2020 20:34:32 -0500
Message-ID: <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 8:08 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Dec 02, 2020 at 07:19:45PM -0500, Pavel Tatashin wrote:
> > > It is a good moment to say, I really dislike how this was implemented
> > > in the first place.
> > >
> > > Scanning the output of gup just to do the is_migrate_movable() test is
> > > kind of nonsense and slow. It would be better/faster to handle this
> > > directly while gup is scanning the page tables and adding pages to the
> > > list.
> >
> > Hi Jason,
> >
> > I assume you mean to migrate pages as soon as they are followed and
> > skip those that are faulted, as we already know that faulted pages are
> > allocated from nomovable zone.
> >
> > The place would be:
> >
> > __get_user_pages()
> >       while(more pages)
> >           get_gate_page()
> >           follow_hugetlb_page()
> >           follow_page_mask()
> >
> >           if (!page)
> >                faultin_page()
> >
> >           if (page && !faulted && (gup_flags & FOLL_LONGTERM) )
> >                 check_and_migrate this page
>
> Either here or perhaps even lower down the call chain when the page is
> captured, similar to how GUP fast would detect it. (how is that done
> anyhow?)

Ah, thank you for pointing this out. I think I need to address it here:

https://soleen.com/source/xref/linux/mm/gup.c?r=96e1fac1#94

static __maybe_unused struct page *try_grab_compound_head()
              if (unlikely(flags & FOLL_LONGTERM) &&  is_migrate_cma_page(page))
                   return NULL;

I need to change is_migrate_cma_page() to all migratable pages. Will
study, and send an update with this fix.

>
> > I looked at that function, and I do not think the code will be cleaner
> > there, as that function already has a complicated loop.
>
> That function is complicated for its own reasons.. But complicated is
> not the point here..
>
> > The only drawback with the current approach that I see is that
> > check_and_migrate_movable_pages() has to check once the faulted
> > pages.
>
> Yes
>
> > This is while not optimal is not horrible.
>
> It is.
>
> > The FOLL_LONGTERM should not happen too frequently, so having one
> > extra nr_pages loop should not hurt the performance.
>
> FOLL_LONGTERM is typically used with very large regions, for instance
> we are benchmarking around the 300G level. It takes 10s of seconds for
> get_user_pages to operate. There are many inefficiencies in this
> path. This extra work of re-scanning the list is part of the cost.

OK, I did not realize that pinning was for such large regions, the
path must be optimized.

>
> Further, having these special wrappers just for FOLL_LONGTERM has a
> spill over complexity on the entire rest of the callchain up to here,
> we now have endless wrappers and varieties of function calls that
> generally are happening because the longterm path needs to end up in a
> different place than other paths.
>
> IMHO this is due to the lack of integration with the primary loop
> above
>
> > Also, I checked and most of the users of FOLL_LONGTERM pin only one
> > page at a time. Which means the extra loop is only to check a single
> > page.
>
> Er, I don't know what you checked but those are not the cases I
> see. Two big users are vfio and rdma. Both are pinning huge ranges of
> memory in very typical use cases.

What I meant is the users of the interface do it incrementally not in
large chunks. For example:

vfio_pin_pages_remote
   vaddr_get_pfn
        ret = pin_user_pages_remote(mm, vaddr, 1, flags |
FOLL_LONGTERM, page, NULL, NULL);
1 -> pin only one pages at a time

RDMA indeed can do it in one chunk though. Regardless, the VFIO should
probably be optimized to do it in a larger chunk, and the code path
should be optimized for the reasons you gave above.

>
> > However, those changes can come after this series. The current series
> > fixes a bug where hot-remove is not working with making minimal amount
> > of changes, so it is easy to backport it to stable kernels.
>
> This is a good point, good enough that you should probably continue as
> is

I will continue looking into this code, and see if I can address your
concerns in a follow-up fixes.


Thanks,
Pasha

>
> Jason
