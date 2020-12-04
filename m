Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8692CECCF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbgLDLMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgLDLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:12:47 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6EFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 03:12:06 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id e5so2887683pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 03:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5jT+Nn/jP36D/xoVCe9bwoBaOdsoIk7V6aoNzFbAvE=;
        b=BcdHi25Bn7RMXQbSWPD+ZBWFZnBRpnaIOvwShmEDBw1pmjgOAVFDuwoMj0CD4rkm0t
         VgKJ3IIjW1sovJBx5clrNBGHqhnRqEaLlSA/kV1XyUiggh3ZqhSjZIVWggX6dzph/JWr
         erQdvpszmb0Z41h9m4JuaeCb7Uqxaxn3IS2cTmzLQH4WEuzPxo08YUKIvV8aJ14+TBv1
         LPGHKTGu2bnLbaMKzUokmGF/HbZL7QI3k84xBPSACOYPZoX2V3luQ8/n1vU3OKzqlt8j
         Gqg8El0KZhE/w2vdWygMzcsLfWGDcQ2Gjat0/ElWH1z5s3AyWkwpS8wGJAVpTKQturEi
         UlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5jT+Nn/jP36D/xoVCe9bwoBaOdsoIk7V6aoNzFbAvE=;
        b=ikoyXlOhdoJx6UOG8KQHvlGN+tjnA73a0/U6nBal7vWP2oqXs67Nhzmri248FX+3IZ
         KWF9A8DcSmWA52TLFI8wg7TSA1+cEF/uo4aaNpwB+vBg7WB3iwQ+LWBeaY3k7pHxKYfu
         I8bg6cM+r+NDQ3iOT1SOru479S2iIh+P7sHjoXSgg3wZ4ylHc1bSbC4VXVQSrEosmi/Y
         3xJfR1yaWN1+1u2JM0FJhS4tnw8EL2E5sETgpNOMXwSuLh1b0l49bX4b0pegMCY+h7/H
         BgrZv0xm1G2YI9T4wleHeUCUWBZeWBKAOHE84am1uxrWkaH5LXCgiGPI+jEzYgxLgRhY
         1W3Q==
X-Gm-Message-State: AOAM531XMMkapi11hogHAilwH/CtPXsD5PKzvXGRtZOAlE6F/C728hx+
        Bvb2D3mA/28OfbecR11z3kmlIXduaqfVmvcwsSZjdQ==
X-Google-Smtp-Source: ABdhPJyyeobk+hofKbtl+NcmtLhH2L/XetFHyAPHUSkmPBkYWYiu9YEcv8h7TihQQQkqxEgO1q9iIfAFyfptA2CZYkI=
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr3740783pjq.13.1607080326455;
 Fri, 04 Dec 2020 03:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20201202121838.75218-1-songmuchun@bytedance.com>
 <320c8522-4ed5-809f-e6fc-8a185587519c@suse.cz> <CAMZfGtUAWSoH+HanAoifUGad_hfSkbR=x_8ZBdFMiMpoxmGcaQ@mail.gmail.com>
 <69367ce1-eb9b-d76d-0141-da871bd826ec@suse.cz>
In-Reply-To: <69367ce1-eb9b-d76d-0141-da871bd826ec@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Dec 2020 19:11:30 +0800
Message-ID: <CAMZfGtVT3R1Ts9N-HN+sxyRC7n+XzLFx0HyNdTMzsyYVf2yjBw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/page_alloc: speeding up the iteration
 of max_order
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 6:28 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/4/20 5:03 AM, Muchun Song wrote:
> > On Fri, Dec 4, 2020 at 1:37 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 12/2/20 1:18 PM, Muchun Song wrote:
> >> > When we free a page whose order is very close to MAX_ORDER and greater
> >> > than pageblock_order, it wastes some CPU cycles to increase max_order
> >> > to MAX_ORDER one by one and check the pageblock migratetype of that page
> >>
> >> But we have to do that. It's not the same page, it's the merged page and the new
> >> buddy is a different pageblock and we need to check if they have compatible
> >> migratetypes and can merge, or we have to bail out. So the patch is wrong.
> >>
> >> > repeatedly especially when MAX_ORDER is much larger than pageblock_order.
> >>
> >> Do we have such architectures/configurations anyway?
> >>
> >> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> > ---
> >> >  mm/page_alloc.c | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> > index 141f12e5142c..959541234e1d 100644
> >> > --- a/mm/page_alloc.c
> >> > +++ b/mm/page_alloc.c
> >> > @@ -1041,7 +1041,7 @@ static inline void __free_one_page(struct page *page,
> >> >               pfn = combined_pfn;
> >> >               order++;
> >> >       }
> >> > -     if (max_order < MAX_ORDER) {
> >
> > If we free a page with order == MAX_ORDER - 1, it has no buddy.
> > The following pageblock operation is also pointless.
>
> OK, I see.
>
> >> > +     if (max_order < MAX_ORDER && order < MAX_ORDER - 1) {
>
> Yes, this makes sense, as in your other patch we shouldn't check the buddy when
> order == MAX_ORDER - 1 already.
>
> >> >               /* If we are here, it means order is >= pageblock_order.
> >> >                * We want to prevent merge between freepages on isolate
> >> >                * pageblock and normal pageblock. Without this, pageblock
> >> > @@ -1062,6 +1062,8 @@ static inline void __free_one_page(struct page *page,
> >> >                                               is_migrate_isolate(buddy_mt)))
> >> >                               goto done_merging;
> >> >               }
> >> > +             if (unlikely(order != max_order - 1))
> >> > +                     max_order = order + 1;
> >> >               max_order++;
>
> OK I see now what you want to do here. the "if" may be true if we already
> entered the function with order > pageblock_order.
> I think we could just simplfy the "if" and "max_order++" above to:
>
> max_order = order + 2
>
> which starts to get a bit ugly, so why not change max_order to be -1 (compared
> to now) in the whole function:
>
> max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
> ...
> continue_merging:
>         while (order < max_order) {
> ...
> if (order < MAX_ORDER - 1) {
> // it's redundant to keep checking max_order < MAX_ORDER - 1 here after your
> change, right?
> ...
>
> max_order = order + 1; // less weird than "+ 2"
>
> Off by one errors, here we go!

Great! Good suggestions. Thanks.

>
> >> Or maybe I just don't understand what this is doing. When is the new 'if' even
> >> true? We just bailed out of "while (order < max_order - 1)" after the last
> >> "order++", which means it should hold that "order == max_order - 1")?
> >
> > No, I do not agree. The MAX_ORDER may be greater than 11.
> >
> > # git grep "CONFIG_FORCE_MAX_ZONEORDER"
> > # arch/arm/configs/imx_v6_v7_defconfig:CONFIG_FORCE_MAX_ZONEORDER=14
> > # arch/powerpc/configs/85xx/ge_imp3a_defconfig:CONFIG_FORCE_MAX_ZONEORDER=17
> > # arch/powerpc/configs/fsl-emb-nonhw.config:CONFIG_FORCE_MAX_ZONEORDER=13
> >
> > Have you seen it? On some architecture, the MAX_ORDER
> > can be 17. When we free a page with an order 16. Without this
> > patch, the max_order should be increased one by one from 10 to
> > 17.
> >
> > Thanks.
> >
> >
> >> Your description sounds like you want to increase max_order to MAX_ORDER in one
> >> step, which as I explained would be wrong. But the implementation looks actually
> >> like a no-op.
> >>
> >> >               max_order++;
> >> >               goto continue_merging;
> >> >       }
> >> >
> >>
> >
> >
> > --
> > Yours,
> > Muchun
> >
>


-- 
Yours,
Muchun
