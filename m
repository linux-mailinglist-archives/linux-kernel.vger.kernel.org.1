Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323AB2A0E26
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgJ3Sz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgJ3Sz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:55:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35883C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:55:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so10028352eji.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SpmAhXEjATLtxu6nBA8LZUlE07GKFiy6OiJGOpSxj8o=;
        b=Fs9x9IDcQzweGhPcbRreVMjC4xKt1zDCfWkTYNojskWNiSM6gIsaJ/m72dKBYO7L4+
         8NicyMzwVGs57bn5fNvVLIu7yQbk4FlbvenJfb+Fuq+gq1up+nEyUbneVZakzPTj+1Za
         EkJh8QPFJFRs8eMJ1xjzpJu/gWTTjdNV9PlPRJtn1xTmCqdkzlOQrLIeoLITCYN+ZWen
         hKWRzJ948pAOW8vpQe89qOm0aMUytuXoX7+Qa8a2RA8+laA7ze/gP8SKfxpcfy+ouv+6
         xT1M2LiMFsyMxnQwheZ3RrJPowp0G3T801TA2ZROMAVEj8ZvDgwvla79iMxKDxl9jgB5
         h1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SpmAhXEjATLtxu6nBA8LZUlE07GKFiy6OiJGOpSxj8o=;
        b=P050paS2Aac4N3KKxJ76WVFW+MDHXLpzcUDEkWUcHF2BtaoadCaXlsH/x7tsNgilfI
         Xf1bLJrxg4gpqPLDAfnPuqXl/kVexljrCSj8Ygt2umr3vZyaJwr8zhR3RywwCiEaptOC
         mg6LpzXzo2na0boWs7r6/1ZZRnAmoVlrLyVGmyJMhuthd1Z105ApZajzywNrTgWStPth
         CrgCGwWLymEUFwM0kOEx4KiNpI1vZNkUcknsrZgw9Q9KPXfk54RNR9Dd7Pe0f5ZlZJ2M
         Xjc9aRkH21098u09LI6n+6crAfgQTR+ufcYFc9zXyFGGAB0EYt8v62EF3CA3w38eu9eg
         JOoQ==
X-Gm-Message-State: AOAM533S+wqU/Bi0hO2WGW+6wZyr01y+NSxYgdWNyA6ecSe1nZAZ2B3Z
        oTROo6XoXngug51YxtkS5qxVnzIKhwzV8tRLN5Q=
X-Google-Smtp-Source: ABdhPJzFHRV93uC00xVcjRy5x6wfPBGXIyYJDllHLxCr9ihxvA2R9gJUKiD/JWUlks5UjP048Qq1b5wat+9hhOdtieI=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr3815005ejh.383.1604084155916;
 Fri, 30 Oct 2020 11:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201029200435.3386066-1-zi.yan@sent.com> <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com> <20201030133625.GJ1478@dhcp22.suse.cz>
 <CAHbLzkqnmXqB-UThT9dMOwVpuweE6XwA78SF-_qD9=1EVpMSUg@mail.gmail.com> <BE903088-CF3E-4264-A9CA-8A27AC12EF65@nvidia.com>
In-Reply-To: <BE903088-CF3E-4264-A9CA-8A27AC12EF65@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Oct 2020 11:55:44 -0700
Message-ID: <CAHbLzkoSChyP4Jjz_LNxP3Maf-eVH0cfqRoN9=s75V0SMLEL-w@mail.gmail.com>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page isolation.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:39 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 30 Oct 2020, at 14:33, Yang Shi wrote:
>
> > On Fri, Oct 30, 2020 at 6:36 AM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> On Fri 30-10-20 08:20:50, Zi Yan wrote:
> >>> On 30 Oct 2020, at 5:43, Michal Hocko wrote:
> >>>
> >>>> [Cc Vlastimil]
> >>>>
> >>>> On Thu 29-10-20 16:04:35, Zi Yan wrote:
> >>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>
> >>>>> In isolate_migratepages_block, when cc->alloc_contig is true, we ar=
e
> >>>>> able to isolate compound pages, nr_migratepages and nr_isolated did=
 not
> >>>>> count compound pages correctly, causing us to isolate more pages th=
an we
> >>>>> thought. Use thp_nr_pages to count pages. Otherwise, we might be tr=
apped
> >>>>> in too_many_isolated while loop, since the actual isolated pages ca=
n go
> >>>>> up to COMPACT_CLUSTER_MAX*512=3D16384, where COMPACT_CLUSTER_MAX is=
 32,
> >>>>> since we stop isolation after cc->nr_migratepages reaches to
> >>>>> COMPACT_CLUSTER_MAX.
> >>>>>
> >>>>> In addition, after we fix the issue above, cc->nr_migratepages coul=
d
> >>>>> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolate=
d,
> >>>>> thus page isolation could not stop as we intended. Change the isola=
tion
> >>>>> stop condition to >=3D.
> >>>>>
> >>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>> ---
> >>>>>  mm/compaction.c | 8 ++++----
> >>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/compaction.c b/mm/compaction.c
> >>>>> index ee1f8439369e..0683a4999581 100644
> >>>>> --- a/mm/compaction.c
> >>>>> +++ b/mm/compaction.c
> >>>>> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_con=
trol *cc, unsigned long low_pfn,
> >>>>>
> >>>>>  isolate_success:
> >>>>>            list_add(&page->lru, &cc->migratepages);
> >>>>> -          cc->nr_migratepages++;
> >>>>> -          nr_isolated++;
> >>>>> +          cc->nr_migratepages +=3D thp_nr_pages(page);
> >>>>> +          nr_isolated +=3D thp_nr_pages(page);
> >>>>
> >>>> Does thp_nr_pages work for __PageMovable pages?
> >>>
> >>> Yes. It is the same as compound_nr() but compiled
> >>> to 1 when THP is not enabled.
> >>
> >> I am sorry but I do not follow. First of all the implementation of the
> >> two is different and also I was asking about __PageMovable which shoul=
d
> >> never be THP IIRC. Can they be compound though?
> >
> > I have the same question, can they be compound? If they can be
> > compound, PageTransHuge() can't tell from THP and compound movable
> > page, right?
>
> Right. I have updated the patch and use compound_nr instead.

Thanks. Actually I'm wondering what kind of movable page could be
compound. Any real examples?

>
> =E2=80=94
> Best Regards,
> Yan Zi
