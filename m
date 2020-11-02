Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5B2A2FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgKBQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgKBQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:39:48 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED97FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:39:47 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o9so17684675ejg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B/opXhjxVMn7dgQCgM7LMi0cf/+TlZIo/peykaGDUVo=;
        b=Gg8NJGKq96Wv5WC/mk6lOMHNlv2IEakY+2VmUyrKm82ZxPIM1gk4glArjTsiA7w3NL
         baoFCODuW1dfrDl1CYxJ1zcmV3PxBE2pSY5e1xAcv1wDyt5v6T/31bj+YSWilYtzQ/9S
         QaWlbLEnwzrd2wzKDMzwqRA103H097kNusfaa1cLgUpAFVyl+WCVTOUwdr5mSpQZAmkV
         oG6GEH0wGBPgRFxmfJy0z8b4vnDCGkUUxZJKbLj1/E9WJaX+bQiyRmtMNd5zEr58cr1N
         /OdhlDaxW7QS1e7Ryc+EnfOys6nuDZ+aWkFb3fmXSMG2ChjAlCScWoU+wcpfLc0V3bOY
         bmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B/opXhjxVMn7dgQCgM7LMi0cf/+TlZIo/peykaGDUVo=;
        b=rTNS1QCqEC4tu1TtCcfJ2jzHl8b6P/LcP2zDBGDo71LyMnqnCDauAwNdR00BzvWDU7
         HRDT4GYRCmZIHxYmJ6BVC8x0//Sn+QRvEpVdbAiJ8yUtn7ADpDzSHncyV8xq4nvnJ079
         OV5XqG5Rrkovm7z8RTrCscI9Xfw3aYUc+FbpJj8wrxmDFzz/2tt/PkQvaJbCWpiRnO1g
         MePeQonEFrS1Dc0IJarYduScClaPu7YOAYCNK3QuZ347ig47/jGVA7GtYIpKPKQ8xI9M
         /G9oSZyR0aMxGyQ5sg7hnERhZLzvGpc9O2ZJ3iIr13F3WWm3NTImctt3QKKgADDu5OYk
         5TIw==
X-Gm-Message-State: AOAM530U7VlW/gUKz2EUHNiuC1ZWLNN9KVOFaoZivlipj8VTo3kFBHoQ
        i/f7seMm6t3iin9UU4TinE78DlBFQWFSxw6ZdmA=
X-Google-Smtp-Source: ABdhPJzYWyBWQeE/ZzYre2IhqnKkQJMMpFCMDRwy6L0pz6BdCd/4La6FwRYvJMyInwzd05osDe4AVvuF1oGKfm7UOZA=
X-Received: by 2002:a17:906:814:: with SMTP id e20mr3050113ejd.514.1604335186678;
 Mon, 02 Nov 2020 08:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20201029200435.3386066-1-zi.yan@sent.com> <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com> <20201030133625.GJ1478@dhcp22.suse.cz>
 <CAHbLzkqnmXqB-UThT9dMOwVpuweE6XwA78SF-_qD9=1EVpMSUg@mail.gmail.com>
 <BE903088-CF3E-4264-A9CA-8A27AC12EF65@nvidia.com> <CAHbLzkoSChyP4Jjz_LNxP3Maf-eVH0cfqRoN9=s75V0SMLEL-w@mail.gmail.com>
 <eb3be332-8fed-af88-b060-c710f6245f7d@suse.cz>
In-Reply-To: <eb3be332-8fed-af88-b060-c710f6245f7d@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 2 Nov 2020 08:39:33 -0800
Message-ID: <CAHbLzkr9Ar-+_DiAL-0PZ6FXLSfDEgXrNsh+vFUaDeg58j7f8A@mail.gmail.com>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page isolation.
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 5:03 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/30/20 7:55 PM, Yang Shi wrote:
> > On Fri, Oct 30, 2020 at 11:39 AM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 30 Oct 2020, at 14:33, Yang Shi wrote:
> >>
> >> > On Fri, Oct 30, 2020 at 6:36 AM Michal Hocko <mhocko@suse.com> wrote=
:
> >> >>
> >> >> On Fri 30-10-20 08:20:50, Zi Yan wrote:
> >> >>> On 30 Oct 2020, at 5:43, Michal Hocko wrote:
> >> >>>
> >> >>>> [Cc Vlastimil]
> >> >>>>
> >> >>>> On Thu 29-10-20 16:04:35, Zi Yan wrote:
> >> >>>>> From: Zi Yan <ziy@nvidia.com>
> >> >>>>>
> >> >>>>> In isolate_migratepages_block, when cc->alloc_contig is true, we=
 are
> >> >>>>> able to isolate compound pages, nr_migratepages and nr_isolated =
did not
> >> >>>>> count compound pages correctly, causing us to isolate more pages=
 than we
> >> >>>>> thought. Use thp_nr_pages to count pages. Otherwise, we might be=
 trapped
> >> >>>>> in too_many_isolated while loop, since the actual isolated pages=
 can go
> >> >>>>> up to COMPACT_CLUSTER_MAX*512=3D16384, where COMPACT_CLUSTER_MAX=
 is 32,
> >> >>>>> since we stop isolation after cc->nr_migratepages reaches to
> >> >>>>> COMPACT_CLUSTER_MAX.
> >> >>>>>
> >> >>>>> In addition, after we fix the issue above, cc->nr_migratepages c=
ould
> >> >>>>> never be equal to COMPACT_CLUSTER_MAX if compound pages are isol=
ated,
> >> >>>>> thus page isolation could not stop as we intended. Change the is=
olation
> >> >>>>> stop condition to >=3D.
> >> >>>>>
> >> >>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> >>>>> ---
> >> >>>>>  mm/compaction.c | 8 ++++----
> >> >>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> >>>>>
> >> >>>>> diff --git a/mm/compaction.c b/mm/compaction.c
> >> >>>>> index ee1f8439369e..0683a4999581 100644
> >> >>>>> --- a/mm/compaction.c
> >> >>>>> +++ b/mm/compaction.c
> >> >>>>> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_=
control *cc, unsigned long low_pfn,
> >> >>>>>
> >> >>>>>  isolate_success:
> >> >>>>>            list_add(&page->lru, &cc->migratepages);
> >> >>>>> -          cc->nr_migratepages++;
> >> >>>>> -          nr_isolated++;
> >> >>>>> +          cc->nr_migratepages +=3D thp_nr_pages(page);
> >> >>>>> +          nr_isolated +=3D thp_nr_pages(page);
> >> >>>>
> >> >>>> Does thp_nr_pages work for __PageMovable pages?
> >> >>>
> >> >>> Yes. It is the same as compound_nr() but compiled
> >> >>> to 1 when THP is not enabled.
> >> >>
> >> >> I am sorry but I do not follow. First of all the implementation of =
the
> >> >> two is different and also I was asking about __PageMovable which sh=
ould
> >> >> never be THP IIRC. Can they be compound though?
> >> >
> >> > I have the same question, can they be compound? If they can be
> >> > compound, PageTransHuge() can't tell from THP and compound movable
> >> > page, right?
> >>
> >> Right. I have updated the patch and use compound_nr instead.
> >
> > Thanks. Actually I'm wondering what kind of movable page could be
> > compound. Any real examples?
>
> Looks like there's currently none. Compaction also wouldn't work properly=
 with
> movable pages with order>0 as the free page scanner looks for order-0 pag=
es
> only. But it won't hurt to use compound_nr() anyway.

Thanks, yes this is what I thought otherwise we have troubles in
migration path too.

>
> >>
> >> =E2=80=94
> >> Best Regards,
> >> Yan Zi
> >
>
