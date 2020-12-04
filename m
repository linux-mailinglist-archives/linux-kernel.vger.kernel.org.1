Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD72CF0FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgLDPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbgLDPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:47:08 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7083C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 07:46:22 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id f1so3292464plt.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVUJ12oZxh3fE+tpbFaO7BT47tEH9r/2CUQ0iKEYM/c=;
        b=LFFRqpcEvv3LFHUcz7z5NPSi20nI0gQTb6xu3XzZR62RAFhUaNly9In3Q36dk4eg6/
         K0yiz/8gn4WUjFNWj0/k3wCqi4XNMUc6XGZYfeG0OWl2eRjanEVys0adqC8wwJql62en
         boKCtmV8FoJlsV4VkEN2tzuuJlTAnzriCMnxZfrG4kGXNNAy3CByQG7hyz6pIocRY1wa
         WkC2mvthsL1jUPY0WtCXInubtprX0+PtaPNicznRrllG2++axz+YiIfLG/m76OAep2Z1
         dgVr+0F68BoOuF3NvrKc+YFuiaR96p/Hw2c0YKznRj+zLdhQf8plfyGKbRD6nRgr/kcB
         gLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVUJ12oZxh3fE+tpbFaO7BT47tEH9r/2CUQ0iKEYM/c=;
        b=k6PpmgzUdu/KuBCCCbJ4M0JUy/3VLO/8OuE9OG/75Dc4oWsjGsGRykvX2G4efIoDq7
         sBYEktyHwDm0E/2bigVazgtViPUnjKpjVuf+5Mk2ObwySf35mf5XXYqdP5kwhbdlnm+g
         Lwc67r3UcFGXglttbcUqNllZjUQjZEKVKzthiHIaOfj67KjxOMU8u5EmBJe8yAYOeZim
         wymDDUNq993aca4NjjXu0ld9VXTl5btJSTjcV0dIOkyXyXOYrEY1YEk6rxPIFSAo7PhM
         rjrCnUsDjRZnkojZUCSQZsCNrgkxETies+aSDNJiaMEzvzxM7b1hCuveD5ZldrrB+iSf
         4GWQ==
X-Gm-Message-State: AOAM531fVGFzUTezVzi6YSopWayeO7lYnocyyX47wWU/O1F2dT2wAArG
        jfmmpebAPOxZ0FDOjCOW/tX1GCIpXsbwzBiaMJaNkYwXPudVnw==
X-Google-Smtp-Source: ABdhPJwDQT/rhn6e5+j2BJSKSv+SjHokbRSP8gl8seNIrhdC3fDvLCZ7VLaASR/oaciI3bW1yXsbwX8AoVRrmAE7PYU=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr4574169pjt.147.1607096782347;
 Fri, 04 Dec 2020 07:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20201204125640.51804-1-songmuchun@bytedance.com> <27277a9f-c726-b033-51c1-d88f978fabfd@suse.cz>
In-Reply-To: <27277a9f-c726-b033-51c1-d88f978fabfd@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Dec 2020 23:45:45 +0800
Message-ID: <CAMZfGtUJK+2MDwK1xLOOuGHfddA4+57FZVtSw6JURnPdTngeeg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm/page_alloc: speeding up the
 iteration of max_order
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 11:28 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/4/20 1:56 PM, Muchun Song wrote:
> > When we free a page whose order is very close to MAX_ORDER and greater
> > than pageblock_order, it wastes some CPU cycles to increase max_order
> > to MAX_ORDER one by one and check the pageblock migratetype of that page
> > repeatedly especially when MAX_ORDER is much larger than pageblock_order.
>
> I would add:
>
> We also should not be checking migratetype of buddy when "order == MAX_ORDER -
> 1" as the buddy pfn may be invalid, so adjust the condition. With the new check,
> we don't need the max_order check anymore, so we replace it.
>
> Also adjust max_order initialization so that it's lower by one than previously,
> which makes the code hopefully more clear.

Got it. Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Fixes: d9dddbf55667 ("mm/page_alloc: prevent merging between isolated and other
> pageblocks")
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Thanks!
>
> > ---
> > Changes in v2:
> >  - Rework the code suggested by Vlastimil. Thanks.
> >
> >  mm/page_alloc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index f91df593bf71..56e603eea1dd 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1002,7 +1002,7 @@ static inline void __free_one_page(struct page *page,
> >       struct page *buddy;
> >       bool to_tail;
> >
> > -     max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1);
> > +     max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
> >
> >       VM_BUG_ON(!zone_is_initialized(zone));
> >       VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> > @@ -1015,7 +1015,7 @@ static inline void __free_one_page(struct page *page,
> >       VM_BUG_ON_PAGE(bad_range(zone, page), page);
> >
> >  continue_merging:
> > -     while (order < max_order - 1) {
> > +     while (order < max_order) {
> >               if (compaction_capture(capc, page, order, migratetype)) {
> >                       __mod_zone_freepage_state(zone, -(1 << order),
> >                                                               migratetype);
> > @@ -1041,7 +1041,7 @@ static inline void __free_one_page(struct page *page,
> >               pfn = combined_pfn;
> >               order++;
> >       }
> > -     if (max_order < MAX_ORDER) {
> > +     if (order < MAX_ORDER - 1) {
> >               /* If we are here, it means order is >= pageblock_order.
> >                * We want to prevent merge between freepages on isolate
> >                * pageblock and normal pageblock. Without this, pageblock
> > @@ -1062,7 +1062,7 @@ static inline void __free_one_page(struct page *page,
> >                                               is_migrate_isolate(buddy_mt)))
> >                               goto done_merging;
> >               }
> > -             max_order++;
> > +             max_order = order + 1;
> >               goto continue_merging;
> >       }
> >
> >
>


-- 
Yours,
Muchun
