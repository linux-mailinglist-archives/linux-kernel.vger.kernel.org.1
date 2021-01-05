Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A22EA5BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhAEHLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbhAEHLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:11:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ED8C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 23:11:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m5so1167101pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 23:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jF+DtZTdf3XOUzGrgz40msoOI/xU6UYEv4/RowGJ930=;
        b=HZWoYwmD/CdrJ8rzLKS14XErMJgI5t5wiROJYA3mQ1PAuaIUb99hqvUxbdObWI07a6
         lNnmjZyXuAMmaUxZaXPejfCeqYvQV+nNtZI096B53vB6/ucr2rHkROYwLo7JqA5bJaxP
         sUK5BH7S2G7Zr4qa4TBJ4UIZyD/2xs0gQaBTlTm0KVueuUqX57EUtqQASObLYs1qtGHR
         RQ7pGxpMqPpaXFEdvncuZSi29hsINhFck8r4DxdDHy/tm0YjQOGErJlTCeGRCgEJ9mgg
         Euw8Yq91kHK8NI+UWaQ7ZWYvkw1PCdY/Hwr01Y5y7AP/la+0Wt7TzC8/k3IcWzTPFpCy
         6jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jF+DtZTdf3XOUzGrgz40msoOI/xU6UYEv4/RowGJ930=;
        b=Usokuo4wF8PzoivcKqjltsE5VoB6Mv/WbwQSKBK5Mj1HChmyoOLWNeBAJV6KpBttT/
         7tV7zZEirPKrbrXJWf5p+E7YaAReQDomS3OqikpL4Pt6Y718Np2GhJWzDN/NAowho7M7
         wV9XHixzeS6CBxhh0t7QPA/4tfRmVKAn/YF+jYK9IJzUQv7f7F4y30Z3y5exwhl5l8A/
         WepRSQzlpqxK6GjpqA+jHqxIF2sSdkDS8uzCXibfxzWh+0zbfQN0Jc2P32D5S+sscUPN
         2EeyOyL6a806m4a56Xnz6EkH2P6SeL8SNeQZSIEQZJuQ3qPAB945YFVunDG7UJI73HhT
         8jrA==
X-Gm-Message-State: AOAM533y0USk8N4FBUjHUgJoFHjTY477d6sxxeib/sMWeUA/hNqxvFiV
        tEhbr9ARF2nWqFyaq2oTqy5DFNnug1vUb78PAxy/h5rLa/eWfyFmWkU=
X-Google-Smtp-Source: ABdhPJyl0WsuJL+NczdFKJGZo0dLamcwYR3uJs2y9R2saJkXN8MwuRU43VF57WxJvN6VP+c/ONR0IDzy9HAlRXxLBmA=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr2754358pjr.229.1609830674226;
 Mon, 04 Jan 2021 23:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-4-songmuchun@bytedance.com> <20210105063757.GA7244@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210105063757.GA7244@hori.linux.bs1.fc.nec.co.jp>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jan 2021 15:10:35 +0800
Message-ID: <CAMZfGtV7mo=dqUvZBgRzJDwTkZ5qsXLno_UwBOmBUwXGEd4NrQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 2:38 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Mon, Jan 04, 2021 at 02:58:41PM +0800, Muchun Song wrote:
> > When dissolve_free_huge_page() races with __free_huge_page(), we can
> > do a retry. Because the race window is small.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 72608008f8b4..db00ae375d2a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1763,10 +1763,11 @@ static int free_pool_huge_page(struct hstate *h=
, nodemask_t *nodes_allowed,
> >   * nothing for in-use hugepages and non-hugepages.
> >   * This function returns values like below:
> >   *
> > - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-u=
se
> > - *          (allocated or reserved.)
> > - *       0: successfully dissolved free hugepages or the page is not a
> > - *          hugepage (considered as already dissolved)
> > + *  -EAGAIN: race with __free_huge_page() and can do a retry
> > + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-=
use
> > + *           (allocated or reserved.)
> > + *       0:  successfully dissolved free hugepages or the page is not =
a
> > + *           hugepage (considered as already dissolved)
> >   */
> >  int dissolve_free_huge_page(struct page *page)
> >  {
> > @@ -1815,8 +1816,10 @@ int dissolve_free_huge_page(struct page *page)
> >                * We should make sure that the page is already on the fr=
ee list
> >                * when it is dissolved.
> >                */
> > -             if (unlikely(!PageHugeFreed(head)))
> > +             if (unlikely(!PageHugeFreed(head))) {
> > +                     rc =3D -EAGAIN;
> >                       goto out;
> > +             }
>
> If dissolve_free_huge_page() races with __free_huge_page() and we detect
> it with this check, the hugepage is expected to be freed or dissolved by
> __free_huge_page(), so is it enough just to return with rc =3D 0 without =
retrying?

The dissolve_free_huge_page() aims to free the page to the buddy
allocator not the hugepage pool. So it is not enough just to return 0,
right? Or did you mean that we set the page temporary here and
let the __free_huge_page do the freeing later for us? Thanks.

>
> Thanks,
> Naoya Horiguchi
>
> >
> >               /*
> >                * Move PageHWPoison flag from head page to the raw error=
 page,
> > @@ -1857,7 +1860,10 @@ int dissolve_free_huge_pages(unsigned long start=
_pfn, unsigned long end_pfn)
> >
> >       for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D 1 << minimum_orde=
r) {
> >               page =3D pfn_to_page(pfn);
> > +retry:
> >               rc =3D dissolve_free_huge_page(page);
> > +             if (rc =3D=3D -EAGAIN)
> > +                     goto retry;
> >               if (rc)
> >                       break;
> >       }
> > --
> > 2.11.0
> >
