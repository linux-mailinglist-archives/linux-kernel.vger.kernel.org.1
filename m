Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8705B2CF350
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgLDRos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgLDRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:44:47 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567AEC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:44:07 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lt17so9900015ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oymlK03Wh8YRUzVLq1s/12paUCKiSfJbtYoo+/za7mY=;
        b=OCb5gancMDQQAwGdeUcoXjOdlLRXM+2LpnxejfSTQEo2rna1ODp8elvvMBODJeLQQQ
         OsuetAzdlgl2nFEUlecLwdOOZBqSlhF4r3/XBRJdnlvnK/gHXp8JHAzcU+q5fHXgLj+S
         C+fZOEymqDxZfsqGfCO5JxiRddXMKNACa96CdP/4jxu49n8DOPRZKjI9Ew7y21t3/1+q
         5J/iA7tcf0SUYeBZqwB3qyw/pp3Ex3iJSsx4GCMKu29Ar5X24G13/X+gQ0g6aOh5YJtI
         UPaia4dxHqlwxWhJ5X/yv/6GAfPawdlvkfPW/lme/BNoyqbOjl4dg4lTxixKMhY42Qit
         1Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oymlK03Wh8YRUzVLq1s/12paUCKiSfJbtYoo+/za7mY=;
        b=XiAZCH9sbVjIRY+dijCg/IELqJY4PcrPWaanYX9HwyH2PQeSPXBRfs4ncgqmGSMEN2
         WRylF/p2cl7tCMf2fjqjDHp750w3ppCDTjBIswHS8FTq8T3mHCjSpHKnnaP5vgGsURfA
         N98qljWZPB7V9mXuQiWjHNPnXGFrnOAviCKKKnigzohvPh07HBTViMbTKDj58ZY/Uhcu
         hfGBSQhVvSISlaezVcPFcfja0IFXVjv5HSyjy1z2ExyXuYZxS5CJRyUW16jIR5poau3o
         zPoG6dsI2nxi29D06rXWnDPpctD2ChT+eVJOm3fDkzKpVMPd5KmTRDZKJPZs+K7/13DA
         z4+g==
X-Gm-Message-State: AOAM530r/k7LZqj4YIH97Tncz7+CamZZTfLsTkwvN5gaNY8SHOjpUKs/
        FEv/SB/FkTtJ4oOX4UWDe6DYvUCfArH19Z49BkaeRA==
X-Google-Smtp-Source: ABdhPJyHfiw7zYCoUG0FCVQMOgtGanSw19dqm9iww/NLBOJbjkzLYRB2moTjLPFgjVQDUNFBDK0SYnWzyKTwzPb5hwQ=
X-Received: by 2002:a17:906:ce51:: with SMTP id se17mr8106464ejb.314.1607103845993;
 Fri, 04 Dec 2020 09:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com> <20201204041358.GB17056@js1304-desktop>
In-Reply-To: <20201204041358.GB17056@js1304-desktop>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Dec 2020 12:43:29 -0500
Message-ID: <CA+CK2bDtmeyMgd7gkdbb+0hfm5rSow-Lc+FOrZM3tUZAOR+FRw@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        mike.kravetz@oracle.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 11:14 PM Joonsoo Kim <js1304@gmail.com> wrote:
>
> On Wed, Dec 02, 2020 at 12:23:30AM -0500, Pavel Tatashin wrote:
> > We do not allocate pin pages in ZONE_MOVABLE, but if pages were already
> > allocated before pinning they need to migrated to a different zone.
> > Currently, we migrate movable CMA pages only. Generalize the function
> > that migrates CMA pages to migrate all movable pages.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/migrate.h        |  1 +
> >  include/trace/events/migrate.h |  3 +-
> >  mm/gup.c                       | 56 +++++++++++++---------------------
> >  3 files changed, 24 insertions(+), 36 deletions(-)
> >
> > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > index 0f8d1583fa8e..00bab23d1ee5 100644
> > --- a/include/linux/migrate.h
> > +++ b/include/linux/migrate.h
> > @@ -27,6 +27,7 @@ enum migrate_reason {
> >       MR_MEMPOLICY_MBIND,
> >       MR_NUMA_MISPLACED,
> >       MR_CONTIG_RANGE,
> > +     MR_LONGTERM_PIN,
> >       MR_TYPES
> >  };
> >
> > diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> > index 4d434398d64d..363b54ce104c 100644
> > --- a/include/trace/events/migrate.h
> > +++ b/include/trace/events/migrate.h
> > @@ -20,7 +20,8 @@
> >       EM( MR_SYSCALL,         "syscall_or_cpuset")            \
> >       EM( MR_MEMPOLICY_MBIND, "mempolicy_mbind")              \
> >       EM( MR_NUMA_MISPLACED,  "numa_misplaced")               \
> > -     EMe(MR_CONTIG_RANGE,    "contig_range")
> > +     EM( MR_CONTIG_RANGE,    "contig_range")                 \
> > +     EMe(MR_LONGTERM_PIN,    "longterm_pin")
> >
> >  /*
> >   * First define the enums in the above macros to be exported to userspace
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 724d8a65e1df..1d511f65f8a7 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1593,19 +1593,18 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
> >  }
> >  #endif
> >
> > -#ifdef CONFIG_CMA
> > -static long check_and_migrate_cma_pages(struct mm_struct *mm,
> > -                                     unsigned long start,
> > -                                     unsigned long nr_pages,
> > -                                     struct page **pages,
> > -                                     struct vm_area_struct **vmas,
> > -                                     unsigned int gup_flags)
> > +static long check_and_migrate_movable_pages(struct mm_struct *mm,
> > +                                         unsigned long start,
> > +                                         unsigned long nr_pages,
> > +                                         struct page **pages,
> > +                                         struct vm_area_struct **vmas,
> > +                                         unsigned int gup_flags)
> >  {
> >       unsigned long i;
> >       unsigned long step;
> >       bool drain_allow = true;
> >       bool migrate_allow = true;
> > -     LIST_HEAD(cma_page_list);
> > +     LIST_HEAD(page_list);
> >       long ret = nr_pages;
> >       struct migration_target_control mtc = {
> >               .nid = NUMA_NO_NODE,
> > @@ -1623,13 +1622,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> >                */
> >               step = compound_nr(head) - (pages[i] - head);
> >               /*
> > -              * If we get a page from the CMA zone, since we are going to
> > -              * be pinning these entries, we might as well move them out
> > -              * of the CMA zone if possible.
> > +              * If we get a movable page, since we are going to be pinning
> > +              * these entries, try to move them out if possible.
> >                */
> > -             if (is_migrate_cma_page(head)) {
> > +             if (is_migrate_movable(get_pageblock_migratetype(head))) {
>
> is_migrate_movable() isn't a check for the ZONE. It's a check for the
> MIGRATE_TYPE. MIGRATE_TYPE doesn't require hard guarantee for
> migration, and, most of memory, including ZONE_NORMAL, is
> MIGRATE_MOVABLE. With this code, long term gup would always fails due
> to not enough memory. I think that correct change would be
> "is_migrate_cma_page(hear) && zone == ZONE_MOVABLE".

Good point. The above should be OR not AND.

zone_idx(page_zone(head)) == ZONE_MOVABLE || is_migrate_cma_page(hear)

Pasha
