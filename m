Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35442C68E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgK0PoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730819AbgK0PoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:44:14 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3A2C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 07:44:13 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x4so1139519pln.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 07:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEjXV2CA4jRtXtFdtsbnBy8ifv8488Jbk6i8FFwe9TM=;
        b=KAq9MFqGpsvUcfrIAbh8pJo4fh76R7rtXZTU5jGvNoJ3htVxlfGR8JshjO6jxcHH/y
         fE4R+Yf01YcJfquB6LA1A4pMTU8QH2UuQH5vTBJFnxb8ONhQr2YPAa4lwWxziyMouLuA
         4C2k1xDZSRLVIfTYAB8K0yoPNxrQ8okKz82vfjtRY1uw4tZ1XkGr0+sr8jzVH3Q0v/Mg
         UKVCT3V8GuLWl47TUWgeEWcQovWZ97PM+BJfM73+upveHcWX0gTfdHx0pXD9G4Wohx7a
         7VK532Pu47q3y3jikRTKSO78nrVVCbrX5FVV53oOc8pc3Y1+j7lYx0kLRG/ok3ZvedaU
         SA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEjXV2CA4jRtXtFdtsbnBy8ifv8488Jbk6i8FFwe9TM=;
        b=baceftBI+cfDqIMU6xVtD/JqIC3jCKsRKb51sNjIliDBv6Gn44GRW0j46531ubK/vd
         LynHTgS7SeNW28a8+Y4so63xRoj/VwkMmDJEKWkO1OVQKmpQvE8SO0miYgQRxadw91uO
         z8M2cdnWXswHP3reLnu/6sE0tNveoAV/VvGpvOfPpMIomOJ0dpcTeiS5oHg2fELfc2wp
         KcYTwp25o5/MFe52JNRyOJ4WL/h7G2DTXl1bKRB09NWwjIpWJJJ35DIGGGqSD/K72lJj
         5E6/lQVIglLbhiyKsKqGZ9JpZ3VCRgye4D1BuNZXdPwUsIvbVJAAgc+37K0a1MVjc3pr
         nF+w==
X-Gm-Message-State: AOAM531k2cOZ/ii/q9AsQo/65PE7i/pI/NjskOUbk1wKQmHVhkPjlkvA
        LgIM7RSN8nUguNRqHmTpCpqjs981BeRUQzuZrDnlYg==
X-Google-Smtp-Source: ABdhPJycsUoHNLGjSenG6L1QQWNj1cvDhj8fSiRquSj89Yi97LcANL0xhyfkKVLnoZpwDR1fylAEKjk9acyEqCgq9+k=
X-Received: by 2002:a17:902:ff06:b029:da:420e:24b9 with SMTP id
 f6-20020a170902ff06b02900da420e24b9mr6286221plj.20.1606491852729; Fri, 27 Nov
 2020 07:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20201127141900.43348-1-songmuchun@bytedance.com> <9e32e476-3812-2616-b2f5-a9b6f3531b8b@suse.cz>
In-Reply-To: <9e32e476-3812-2616-b2f5-a9b6f3531b8b@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 27 Nov 2020 23:43:33 +0800
Message-ID: <CAMZfGtWurskRPG8mZ33f4qP8MNi4JKZ0RzVdRd9r9_6TdAFe2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/page_alloc: Do not isolate redundant pageblock
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 11:17 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/27/20 3:19 PM, Muchun Song wrote:
> > Current pageblock isolation logic could isolate each pageblock individually
> > since commit d9dddbf55667 ("mm/page_alloc: prevent merging between isolated
> > and other pageblocks"). So we not need to concern about page allocator
> > merges buddies from different pageblocks and changes MIGRATE_ISOLATE to
> > some other migration type.
>
> Yeah, that should be the case now.
>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >   mm/page_alloc.c | 26 ++++++++------------------
> >   1 file changed, 8 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index cefbef32bf4a..608a2c2b8ab7 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8313,16 +8313,14 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> >   }
> >
> >   #ifdef CONFIG_CONTIG_ALLOC
> > -static unsigned long pfn_max_align_down(unsigned long pfn)
> > +static unsigned long pfn_align_down(unsigned long pfn)
> >   {
> > -     return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
> > -                          pageblock_nr_pages) - 1);
> > +     return pfn & ~(pageblock_nr_pages - 1);
> >   }
> >
> > -static unsigned long pfn_max_align_up(unsigned long pfn)
> > +static unsigned long pfn_align_up(unsigned long pfn)
> >   {
> > -     return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
> > -                             pageblock_nr_pages));
> > +     return ALIGN(pfn, pageblock_nr_pages);
> >   }
>
> How bout just removing these wrappers completely and using ALIGN and ALIGN_DOWN
> directly, as there are just two uses for each?

Sounds good to me.  Will do.

>
> >   /* [start, end) must belong to a single zone. */
> > @@ -8415,14 +8413,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
> >       INIT_LIST_HEAD(&cc.migratepages);
> >
> >       /*
> > -      * What we do here is we mark all pageblocks in range as
> > -      * MIGRATE_ISOLATE.  Because pageblock and max order pages may
> > -      * have different sizes, and due to the way page allocator
> > -      * work, we align the range to biggest of the two pages so
> > -      * that page allocator won't try to merge buddies from
> > -      * different pageblocks and change MIGRATE_ISOLATE to some
> > -      * other migration type.
> > -      *
> >        * Once the pageblocks are marked as MIGRATE_ISOLATE, we
> >        * migrate the pages from an unaligned range (ie. pages that
> >        * we are interested in).  This will put all the pages in
> > @@ -8438,8 +8428,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
> >        * put back to page allocator so that buddy can use them.
> >        */
> >
> > -     ret = start_isolate_page_range(pfn_max_align_down(start),
> > -                                    pfn_max_align_up(end), migratetype, 0);
> > +     ret = start_isolate_page_range(pfn_align_down(start), pfn_align_up(end),
> > +                                    migratetype, 0);
> >       if (ret)
> >               return ret;
> >
> > @@ -8522,8 +8512,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
> >               free_contig_range(end, outer_end - end);
> >
> >   done:
> > -     undo_isolate_page_range(pfn_max_align_down(start),
> > -                             pfn_max_align_up(end), migratetype);
> > +     undo_isolate_page_range(pfn_align_down(start), pfn_align_up(end),
> > +                             migratetype);
> >       return ret;
> >   }
> >   EXPORT_SYMBOL(alloc_contig_range);
> >
>


-- 
Yours,
Muchun
