Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9B277FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 06:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgIYE71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 00:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgIYE71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 00:59:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CAC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 21:59:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so745089qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 21:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9lveR0EfEXycscOiFjp8iB1hZRBuocElkDtt6NhPp+8=;
        b=J8aoXyUt/W4MWBZxCe+RV2QU01z9QdUF3sp7xESqbx7nJj4ofdkWVe7uoRY0Uhqw9b
         2v27+GUeyJFNzTqeaQVKdgk9zS23qs0tZAMNPoAY3+3b4falT5jZ1Wt5Kq1SiD+OMHCK
         9Mb0Fpsdo2m44QGoBHXRSi7fKVltOrPFhh4M0+hWogcRwkZYnfSzKQjaBoelHPY1Zu6y
         plbPQNxwcZ8nuxETZEa2pQfMnUQ37cC6ycEFkEgV1UTlQU9167KwnRapaLut8KtVJBp8
         pMWDr130xUeyRCkZShEjRUCyPF2CHoOURZY5miaLI+5KB+YmXXVncumvnfx9UcJrszkm
         ckXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9lveR0EfEXycscOiFjp8iB1hZRBuocElkDtt6NhPp+8=;
        b=eeVwJ4hUvGiJ9kHjZIM3WDyGSWzPFzSPlJNtpP4weIREN4gMsm9y0u0oykiYK/KBqC
         lG6weuWNbD6dSK0EKib9bc/ZU3z0qG0UUStdbi1vBuI/4DopY0QOpOXkOZaExMN+Dgeq
         Syy4DF96V/O+atzsFMSmDnXjUbF00j/bHRqrAOYAlMNygA99dnda1FoW2sFH43XcxSj6
         NADIf5TRIe1NIptsn5ynPwozgmTnd/A9MhdXnfilGbgIpeaHTT6A00C7fq5uHbR+lQM/
         Oh5cUyS1rcuyj36/P+kknCZBoSmD40752nhMriXS9Wd7Uqd1jLu5XdbyfL1CQ18ZXwR9
         UE9g==
X-Gm-Message-State: AOAM530Sa1oTjza3s3onTisTKFVG1Mtsk35FupcrZEAVlkO/vEdkvNvo
        ujN/ULQE6rlPF2H74spaFFzVnOVOylnXRNGYd0mCMpBz
X-Google-Smtp-Source: ABdhPJxzW7OOnOvfFymZ6Oq6P+NBeoD6492ou9+Wg3YzK/7kGglVCEzlj5GhtG/K+Zdvf9fhirrjBfKarkCv+bnYNpI=
X-Received: by 2002:a05:6214:903:: with SMTP id dj3mr2838395qvb.14.1601009966015;
 Thu, 24 Sep 2020 21:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
 <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz> <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
 <20200827133523.GC3090@techsingularity.net> <CAAmzW4PTgbVzf1dkvnzpHpYYTbLyeNM=OzywUBvkFw9rUhtR4w@mail.gmail.com>
In-Reply-To: <CAAmzW4PTgbVzf1dkvnzpHpYYTbLyeNM=OzywUBvkFw9rUhtR4w@mail.gmail.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 25 Sep 2020 13:59:15 +0900
Message-ID: <CAAmzW4NabiAc+Nh=jtg9fUZTodQHHjf=mFTn=w32AJ43L9o2Aw@mail.gmail.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 8=EC=9B=94 28=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:54, J=
oonsoo Kim <js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2020=EB=85=84 8=EC=9B=94 27=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:35=
, Mel Gorman <mgorman@techsingularity.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> >
> > On Wed, Aug 26, 2020 at 02:12:44PM +0900, Joonsoo Kim wrote:
> > > > > And, it requires to break current code
> > > > > layering that order-0 page is always handled by the pcplist. I'd =
prefer
> > > > > to avoid it so this patch uses different way to skip CMA page all=
ocation
> > > > > from the pcplist.
> > > >
> > > > Well it would be much simpler and won't affect most of allocations.=
 Better than
> > > > flushing pcplists IMHO.
> > >
> > > Hmm...Still, I'd prefer my approach.
> >
> > I prefer the pcp bypass approach. It's simpler and it does not incur a
> > pcp drain/refill penalty.
> >
> > > There are two reasons. First,
> > > layering problem
> > > mentioned above. In rmqueue(), there is a code for MIGRATE_HIGHATOMIC=
.
> > > As the name shows, it's for high order atomic allocation. But, after
> > > skipping pcplist
> > > allocation as you suggested, we could get there with order 0 request.
> >
> > I guess your concern is that under some circumstances that a request th=
at
> > passes a watermark check could fail due to a highatomic reserve and to
> > an extent this is true. However, in that case the system is already low
> > on memory depending on the allocation context, the pcp lists may get
> > flushed anyway.
>
> My concern is that non-highorder (order-0) allocation could pollute/use t=
he
> MIGRATE_HIGHATOMIC pageblock. It's reserved for highorder atomic
> allocation so it's not good if an order-0 request could get there. It wou=
ld
> cause more fragmentation on that pageblock.
>
> > > We can also
> > > change this code, but, I'd hope to maintain current layering. Second,
> > > a performance
> > > reason. After the flag for nocma is up, a burst of nocma allocation
> > > could come. After
> > > flushing the pcplist one times, we can use the free page on the
> > > pcplist as usual until
> > > the context is changed.
> >
> > It's not guaranteed because CMA pages could be freed between the nocma =
save
> > and restore triggering further drains due to a reschedule.  Similarly,
> > a CMA allocation in parallel could refill with CMA pages on the per-cpu
> > list. While both cases are unlikely, it's more unpredictable than a
> > straight-forward pcp bypass.
>
> Agreed that it's unpredictable than the pcp bypass. But, as you said,
> those cases
> would be rare.
>
> > I don't really see it as a layering violation of the API because all
> > order-0 pages go through the PCP lists. The fact that order-0 is servic=
ed
> > from the pcp list is an internal implementation detail, the API doesn't
> > care.
>
> What I mean is an internal implementation layering violation. We could ma=
ke
> a rule even in internal implementation to make code simpler and maintaina=
ble.
> I guess that order-0 is serviced from the pcp list is one of those.
>
> Anyway, although I prefer my approach, I'm okay with using pcp bypass.

Hello, Andrew and Vlastimil.

It's better to fix this possible bug introduced in v5.9-rc1 before
v5.9 is released.
Which approach do you prefer?
If it is determined, I will immediately send a patch as you suggested.

Thanks.
