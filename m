Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5227BFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgI2Ii6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgI2Iiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:38:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D40C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:38:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so3556743qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wNxZsxbLvCMFxlDhPXL+cS3czzmsURxJF3wNkez0/n8=;
        b=qXQPhpbgyg6aqhcQtcnINkSq2dfm0LrlyOwffEz10gH9Sh5fv77nXfyC4O0Oky2kcg
         gExXpXB1KciLPj8cthjFSWYZF+y2HppBZYle1ASHIvxWEliZqhVOQYB5O3+zVEhHsMKJ
         Mvfiwux38RGAVHXTPOKnVbTs+ko8a3d4rrJjUON/tm6Gp3+zQ1HvBKsbnTSxs9fSDYyF
         UipLMqKj7pGGp4hV2K9CHSpbK7MTR8QG6YXTg7vtsODyTbemdheIYdkfueFRawjohFrx
         DIY1XozyWMGDLnUNd0jIV9rzSo6itAqM7Pm3rwJAQTnsZvEdPV0Aebbyj8Lq85NTv3KH
         /R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wNxZsxbLvCMFxlDhPXL+cS3czzmsURxJF3wNkez0/n8=;
        b=G4MGjiiyF4mhlBDJZCU7ekBhdsOW97rgJtCM7HkfmZ18XQvSTSzFqfsuBlAiOYDDEb
         ZBCkrcDI/1YrpQoFuPbKOW4FCRpO3GwBq9XsUd+O5S40a5MT+D036BhVh1hgU1jtUElQ
         QeF5KTT9kFjV1vR7LAeEZTuc/FY4eYgyGgGwIHuhgVS+e89XxP8XrPGrUxhoPHj8T5Z2
         U5d6Df2XjklYIc0FdRW6DCUhhwZGu4B/+sikhTXOdD0uqKcCej8AzXh/FTNX8kn25QCC
         atrXnnkfkZMtFA9F2vE/1t+m/2JA/BckNrwL0kvovUSlMyKQaTLjwkjNeyp+ojOPCIVm
         alZQ==
X-Gm-Message-State: AOAM533a/6Ho1JzBpXMU+g0pDpjf1QwjsWcSLka1f9uEcMQA2Qs88i10
        xIuiqQHPFb/VFBauwXKG0OaIQdMDwtIXe4/kXfM=
X-Google-Smtp-Source: ABdhPJzFfebg2ClF5+UVCKk05dn1cBrNGM77uQlAG0YUJHDkE5t2I63gzCmCZHh8E7bFhS1fTT9p+d1hDf8/ivrI20Q=
X-Received: by 2002:a37:7844:: with SMTP id t65mr3160367qkc.136.1601368734576;
 Tue, 29 Sep 2020 01:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com> <20200929080814.GB22035@dhcp22.suse.cz>
In-Reply-To: <20200929080814.GB22035@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 29 Sep 2020 17:38:43 +0900
Message-ID: <CAAmzW4OK=ubyNWsjwfOkj4vZz2Tjuo0G9ceTMXUkx8W+3PEM=g@mail.gmail.com>
Subject: Re: [PATCH v2 for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 9=EC=9B=94 29=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:08, M=
ichal Hocko <mhocko@suse.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon 28-09-20 17:50:46, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > memalloc_nocma_{save/restore} APIs can be used to skip page allocation
> > on CMA area, but, there is a missing case and the page on CMA area coul=
d
> > be allocated even if APIs are used. This patch handles this case to fix
> > the potential issue.
> >
> > Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
> > could have the pages on CMA area so we need to skip it if ALLOC_CMA isn=
't
> > specified.
> >
> > Fixes: 8510e69c8efe (mm/page_alloc: fix memalloc_nocma_{save/restore} A=
PIs)
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  mm/page_alloc.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index fab5e97..104d2e1 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3367,9 +3367,16 @@ struct page *rmqueue(struct zone *preferred_zone=
,
> >       struct page *page;
> >
> >       if (likely(order =3D=3D 0)) {
> > -             page =3D rmqueue_pcplist(preferred_zone, zone, gfp_flags,
> > +             /*
> > +              * MIGRATE_MOVABLE pcplist could have the pages on CMA ar=
ea and
> > +              * we need to skip it when CMA area isn't allowed.
> > +              */
> > +             if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> > +                             migratetype !=3D MIGRATE_MOVABLE) {
> > +                     page =3D rmqueue_pcplist(preferred_zone, zone, gf=
p_flags,
> >                                       migratetype, alloc_flags);
> > -             goto out;
> > +                     goto out;
> > +             }
> >       }
>
> This approach looks definitely better than the previous version.

Thanks!

> >
> >       /*
> > @@ -3381,7 +3388,7 @@ struct page *rmqueue(struct zone *preferred_zone,
> >
> >       do {
> >               page =3D NULL;
> > -             if (alloc_flags & ALLOC_HARDER) {
> > +             if (order > 0 && alloc_flags & ALLOC_HARDER) {
> >                       page =3D __rmqueue_smallest(zone, order, MIGRATE_=
HIGHATOMIC);
> >                       if (page)
> >                               trace_mm_page_alloc_zone_locked(page, ord=
er, migratetype);
>
> But this condition is not clear to me. __rmqueue_smallest doesn't access
> pcp lists. Maybe I have missed the point in the original discussion but
> this deserves a comment at least.

Before the pcplist skipping is applied, order-0 request can not reach here.
But, now, an order-0 request can reach here. Free memory on
MIGRATE_HIGHATOMIC is reserved for high-order atomic allocation
so an order-0 request should skip it.

I will add a code comment on the next version.

Thanks.
