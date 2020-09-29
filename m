Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E327B95E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgI2B2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgI2B2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:28:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476C8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:28:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o5so2920532qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xKV+Kc0YURbZ9OuArrhLoETNqVLN6dHTtHTSNaBaB7U=;
        b=Mq6Cl8wM4kps/RaLae0PaTPMYi+Zb6zhxcab8XToESKjVw2h8tyNmq0lCk7MralPNY
         3cWEXDlSCQSNw1G6kipkq/qoOJkU5NuEoOUmjH63yNkBATNzK9o1xu4Wjvr/A8xkMuBT
         qGo4APYOocCMYHC/UB7CridjOaNQ+3VRf/B2BrAefxK0OUuVy9/DoIl2qMXkruicQ36o
         C5hjWLqTG3WMk5nbBdEV7qmZhxp86asvr4lTQEOt160eASXMnjtnv75v7w6DrwVtZM4Y
         ncomlD3plN0eQV6nuYdloE5TkZLPk5PsU0sKX3RrFwpFbAq/mtgR4mtKAM4DcxJGGFDW
         RU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xKV+Kc0YURbZ9OuArrhLoETNqVLN6dHTtHTSNaBaB7U=;
        b=KbyAJQZrspM5Tid2RW4rMxP1/Z1dLpjEWbLP/HKmQyNmkF4hp2I0jB9NRr06pMnPIq
         9DvwBwVCoWPqUf6xW79m9Xuub409p9dWjodSJ2Eju8LEQ9We55bmeVcD/ZYraHqGpWjA
         aasVnjmWqKoetpcIeY2GColbIVmknXaqeSKgMBN1LsiVmmwK+m2lqxvLy0D3SSMm0JB2
         DOJBZibu1igaTGxwNmJDfESpEHvPND4kw5lksg/61/7TqYWrliS+FXH/gIgIJqUGogB5
         v4Cnf8kHeJDoI32kLOeKJU6GdW7eAjttz5/svI12OWKAPjmy6Frj7GWIJpmEczT/hb/H
         ICWg==
X-Gm-Message-State: AOAM533adudpSwcUO0ZYG7zCb44pi+A8ixmdcIUhmJu/f/WmzkC94lwQ
        bbBsCvGJGjGcAWtUmcVRTcbr7Vr3xe+8gX1pxpg=
X-Google-Smtp-Source: ABdhPJxm87mnlzuAQWKv5NHqKbuOg5XpUnUIj6aPFE1elvaN0vb2KubMmDkF/pnKAanzxP17CPB3yxgnQ5ISMPB0DbU=
X-Received: by 2002:a37:d95:: with SMTP id 143mr2423293qkn.224.1601342896418;
 Mon, 28 Sep 2020 18:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com> <20200928165215.f46924bfff9a109131048f81@linux-foundation.org>
In-Reply-To: <20200928165215.f46924bfff9a109131048f81@linux-foundation.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 29 Sep 2020 10:28:05 +0900
Message-ID: <CAAmzW4OY7z+bF=aFOsNuadc8M_f1Pb7jifuxzQo5AL6mCuO5Ng@mail.gmail.com>
Subject: Re: [PATCH v2 for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 9=EC=9B=94 29=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:52, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Mon, 28 Sep 2020 17:50:46 +0900 js1304@gmail.com wrote:
>
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
>
> Changelog doesn't describe the end-user visible effects of the bug.
> Please send this description?

How about this one?

memalloc_nocma_{save/restore} APIs can be used to skip page allocation
on CMA area, but, there is a missing case and the page on CMA area could
be allocated even if APIs are used. This patch handles this case to fix
the potential issue.

For now, these APIs are used to prevent long-term pinning on the CMA page.
When the long-term pinning is requested on the CMA page, it is migrated to
the non-CMA page before pinning. This non-CMA page is allocated by using
memalloc_nocma_{save/restore} APIs. If APIs doesn't work as intended,
the CMA page is allocated and it is pinned for a long time. This long-term =
pin
for the CMA page causes cma_alloc() failure and it could result in wrong
behaviour on the device driver who uses the cma_alloc().

Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
could have the pages on CMA area so we need to skip it if ALLOC_CMA isn't
specified.

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
> >
> >       /*
>
> We still really really don't want to be adding overhead to the page
> allocation hotpath for a really really obscure feature from a single
> callsite.

In fact, if we clear the __GFP_MOVABLE flag when initializing the
allocation context, we can avoid CMA page allocation without
adding this overhead to the page allocation hotpath. But, I think
this is not a good practice since it cheats the allocation type. There
would be a side-effect, for example, we cannot use the memory on
the ZONE_MOVABLE in this case.

> Do we have an understanding of how many people's kernels are enabling
> CONFIG_CMA?

AFAIK, the almost embedded system enables CONFIG_CMA. For example,
the handset, TV, AVN in a car. Recently, Roman makes CMA usable for huge
page allocation so users are continuously increased.

> I previously suggested retrying the allocation in
> __gup_longterm_locked() but you said "it cannot ensure that we
> eventually get the non-CMA page".  Please explain why?

To avoid allocating a CMA page, the pcplist should be empty. Retry doesn't
guarantee that we will hit the case that the pcplist is empty. It increases
the probability for this case, but, I think that relying on the
probability is not
a good practice.

> What about manually emptying the pcplists beforehand?

It also increases the probability. schedule() or interrupt after emptying b=
ut
before the allocation could invalidate the effect.

> Or byassing the pcplists for this caller and calling __rmqueue() directly=
?

What this patch does is this one.

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
> What does this hunk do?

MIGRATE_HIGHATOMIC is a reserved area for high order atomic allocation.
This hunk makes that order-0 allocation skip this area.

Thanks.
