Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF429BEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813740AbgJ0QyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:54:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46344 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1813728AbgJ0QyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:54:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id 33so2151070edq.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxOgqqlVfNE/0giJq5nhZZ7jCo399QUJ06fkJloHJeU=;
        b=k2HZ+kc9PzKK6W3Q8QLsthL3YlV+AV9D8RENdY4AZChhhm+yJvNIQzFS0WhpKvDA+x
         IdWOym9pXG4m+38XI2TpJg03kjaEdd5rKYCQa9vUzuegLUa7CjVhgnlbhFDgZSmrt/3d
         H112xEky60IFF5zf0hjWmdp8Khw54v7p0y5UJ0q9daG4LUeekjWrYnldkhxQX78v/8nI
         DiPC6gI25gBa8Cu+81oAtWIDaM9NrT2ayTpOoxBAd/BbNjwADzJ+fWfujAvvW3PM6zcR
         3N3godD2t9yjxnieR79nHyKt8SY1+rQKvK+Vr2oCEwKMY1CA7PJG9V3mmFOTA50Zignd
         i/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxOgqqlVfNE/0giJq5nhZZ7jCo399QUJ06fkJloHJeU=;
        b=fKICNjBcBTgTugDOm39yqGKlAnQ/iv1cvWqvh/sDZmVxsIVH7YOBxk5koTD+hD+3GE
         MGQZaCNkiJk+wQW7ZazDZY+WLpRqjgeioudwvEWjJperrGBv8o4nPjvr/snQvHqwo+VQ
         6/YpfoIY9snUvZxsbbgcnjwlj1iGaNAeIqNdPlDwoSd6kozpY1I7vfFovcKGtcDJkPOg
         3sfgAbaTwkPfcPzjR2qg48epaZFZKgT4zYR9fT1hs/BmNoYoaUIfiDznqk8OWpi/1Icx
         sKcPI6NnVncMXbLO8Z0OeU5ffrOtqfCld8YMX0SNjrAh47XRt+549M5AbthiIZZfdOFK
         u19A==
X-Gm-Message-State: AOAM5335bWCAcFvEXvU1rL2xy1WQctCqDCrFaUzFljsQXkPHnr40TwZA
        3cDU7Bja8urvidVPRo6oRnDMOEWWWQwa7AycU+4=
X-Google-Smtp-Source: ABdhPJzrxrMLAjgdC89YGfmF6JnIRNQrbMVaEXJ+3LUAvmaMnd6q2mfmEAZvbtsaMw5/IwHsNX7mn95NFYkX0ebdkhk=
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr3251195edy.168.1603817642883;
 Tue, 27 Oct 2020 09:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201007161736.ACC6E387@viggo.jf.intel.com> <20201007161745.26B1D789@viggo.jf.intel.com>
 <20201027152858.GA11135@linux>
In-Reply-To: <20201027152858.GA11135@linux>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Oct 2020 09:53:50 -0700
Message-ID: <CAHbLzkpiPCj+acoUmPiokPcK25OVe=myM=7AAYsAV40Npanb+Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 8:29 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Oct 07, 2020 at 09:17:45AM -0700, Dave Hansen wrote:
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Yang Shi <yang.shi@linux.alibaba.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
>
> I am still going through all the details, but just my thoughts on things
> that caught my eye:
>
> > --- a/include/linux/migrate.h~demote-with-migrate_pages       2020-10-07 09:15:31.028642442 -0700
> > +++ b/include/linux/migrate.h 2020-10-07 09:15:31.034642442 -0700
> > @@ -27,6 +27,7 @@ enum migrate_reason {
> >       MR_MEMPOLICY_MBIND,
> >       MR_NUMA_MISPLACED,
> >       MR_CONTIG_RANGE,
> > +     MR_DEMOTION,
> >       MR_TYPES
>
> I think you also need to add it under include/trace/events/migrate.h, so
> mm_migrate_pages event can know about it.

Agree.

>
> > +bool migrate_demote_page_ok(struct page *page, struct scan_control *sc)
>
> Make it static?
> Also, scan_control seems to be unused here.
>
> > +{
> > +     int next_nid = next_demotion_node(page_to_nid(page));
> > +
> > +     VM_BUG_ON_PAGE(!PageLocked(page), page);
>
> Right after the call to migrate_demote_page_ok, we call unlock_page
> which already has this check in place.
> I know that this is only to be on the safe side and we do not loss anything,
> but just my thoughts.
>
> > +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> > +{
> > +     /*
> > +      * Try to fail quickly if memory on the target node is not
> > +      * available.  Leaving out __GFP_IO and __GFP_FS helps with
> > +      * this.  If the desintation node is full, we want kswapd to
> > +      * run there so that its pages will get reclaimed and future
> > +      * migration attempts may succeed.
> > +      */
> > +     gfp_t flags = (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_NORETRY |
> > +                    __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE |
> > +                    __GFP_KSWAPD_RECLAIM);
>
> I think it would be nicer to have this as a real GFP_ thingy defined.
> e.g: GFP_DEMOTION
>
> > +     /* HugeTLB pages should not be on the LRU */
> > +     WARN_ON_ONCE(PageHuge(page));
>
> I am not sure about this one.
> This could only happen if the page, which now it is in another list, ends up in
> the buddy system. That is quite unlikely bth.
> And nevertheless, this is only a warning, which means that if this scenario gets
> to happen, we will be allocating a single page to satisfy a higher-order page, and
> I am not sure about the situation we will end up with.

IMHO, we should use BUG_ON instead of WARN_ON or we should just back
off if we see hugetlb page in this path and print out some warning.

>
> > +
> > +     if (PageTransHuge(page)) {
> > +             struct page *thp;
> > +
> > +             flags |= __GFP_COMP;
> > +
> > +             thp = alloc_pages_node(node, flags, HPAGE_PMD_ORDER);
> > +             if (!thp)
> > +                     return NULL;
> > +             prep_transhuge_page(thp);
> > +             return thp;
> > +     }
> > +
> > +     return __alloc_pages_node(node, flags, 0);
>
> Would make sense to transform this in some sort of new_demotion_page,
> which actually calls alloc_migration_target with the right stuff in place?
> And then pass a struct migration_target_control so alloc_migration_target
> does the right thing.
> alloc_migration_target also takes care of calling prep_transhuge_page
> when needed.
> e.g:
>
> static struct page *new_demotion_node(struct page *page, unsigned long private)
> {
>         struct migration_target_control mtc = {
>                 .nid = private,
>                 .gfp_mask = GFP_DEMOTION,
>         };
>
>         if (PageTransHuge(page))
>                 mtc.gfp_mask |= __GFP_COMP;
>
>         return alloc_migration_target(page, (unsigned long)&mtc);
> }
>
> The only thing I see is that alloc_migration_target seems to "override"
> the gfp_mask and does ORs GFP_TRANSHUGE for THP pages, which includes
> __GFP_DIRECT_RECLAIM (not appreciated in this case).
> But maybe this can be worked around by checking if gfp_mask == GFP_DEMOTION,
> and if so, just keep the mask as it is.

Makes sense to me.

>
> > +
> > +     if (list_empty(demote_pages))
> > +             return 0;
> > +
> > +     /* Demotion ignores all cpuset and mempolicy settings */
> > +     err = migrate_pages(demote_pages, alloc_demote_page, NULL,
> > +                         target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> > +                         &nr_succeeded);
>
> As I said, instead of alloc_demote_page, use a new_demote_page and make
> alloc_migration_target handle the allocations and prep thp pages.
>
>
> --
> Oscar Salvador
> SUSE L3
>
