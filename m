Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB31F2AA0C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 00:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgKFXPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 18:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgKFXPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:15:51 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169F0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 15:15:50 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v4so2920528edi.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ai8EmKDHyiLBVZh++sfBm1AUReXQa1dAN4Sl9vvvSDA=;
        b=a1e1CoOTUklIGwbuJOs2oxCqSMI1pORvNQka6iht4Ejy6vsvYudNfLr04WXM4PguS7
         dgFUHgBlXJcPtGS4uNtPSWB52gxCAkXb6rAHIkxls3yWgtiyt+Okp7Tkma4f3hO/2NjH
         6cFqdycCyrt7FTswfBrVzkC40CxUpNpLyqODt47Gj1ebW7xP1qV3KdEGqKP5STwZF4Q/
         S0cUVgEvEeswBUvEawVzNwOF3Ic4il3FhDsxQRkT2p7+hP4OkFmvNvlifxspZZZuETbz
         P6uaLmIryLVFTA/h4I5gG+Ku7qBqu34upTJnipxpxNu8sP8wmyHWWaKorHCaznzJaT+Z
         Upqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ai8EmKDHyiLBVZh++sfBm1AUReXQa1dAN4Sl9vvvSDA=;
        b=tbD+LJM4GGWAQYiT/8XCAo1lWMNm2fJw85qJrcOd6mdWaGa1wNl2Zw00pbufWLotEy
         7Kyg4MYL4genJFtgqH5TuKq2dHBlrLNV7lK2RbSgTurCcoO9NUScJEPO6Unmfyn3AgpU
         274ZfwsBa/Ee6i/kS2rScgQ7rtir85T1X/FRBvl63L/IjJyamTjegdjGIZPqSQONAbJp
         Ni40aIL9/B3OarcvYkH+H8xhGX3X6YH66ZPZzZ47v81bd8p+LtSL2zTKTMjxLkAjW8bU
         sBd0GHD9sxQB2BP5Pys7oLH4GLoAnc2OeCDJus7gH6bPVX4hSSC4KdZ/xzhAA/WavCS8
         /+/A==
X-Gm-Message-State: AOAM533ztQeM1S/7GUT2rjjfl3FrqWmsrvPpo2+phfbGA5gAKOMsNdNs
        Fwr9MX0I88Yvbdro9qig3lAuxTdZF8AbP9VCaWM=
X-Google-Smtp-Source: ABdhPJySZotRc2Ycq94PJUT63mDsWNbcJBmv0qYea980pivG0amtvZ2eeHdjGY8jQWLiQK7jSYldswu3sJFKLWK1Q10=
X-Received: by 2002:aa7:cdd9:: with SMTP id h25mr4616889edw.294.1604704548633;
 Fri, 06 Nov 2020 15:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20201103130334.13468-1-shy828301@gmail.com> <20201103130334.13468-6-shy828301@gmail.com>
 <A842D483-D9F2-4347-9A4F-1939769BC831@nvidia.com> <CAHbLzkrXuvT5pMrJQDPwJtXWKK5LC53UoXRkx2-xkWfwX488wg@mail.gmail.com>
In-Reply-To: <CAHbLzkrXuvT5pMrJQDPwJtXWKK5LC53UoXRkx2-xkWfwX488wg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Nov 2020 15:15:36 -0800
Message-ID: <CAHbLzkq6PRPXkf6qYr4=OK2_RAyKUp-Qc1q5isfuog+RD8W5cA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm: migrate: return -ENOSYS if THP migration is unsupported
To:     Zi Yan <ziy@nvidia.com>
Cc:     Michal Hocko <mhocko@suse.com>, Song Liu <songliubraving@fb.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 2:02 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Nov 6, 2020 at 12:17 PM Zi Yan <ziy@nvidia.com> wrote:
> >
> > On 3 Nov 2020, at 8:03, Yang Shi wrote:
> >
> > > In the current implementation unmap_and_move() would return -ENOMEM i=
f
> > > THP migration is unsupported, then the THP will be split.  If split i=
s
> > > failed just exit without trying to migrate other pages.  It doesn't m=
ake
> > > too much sense since there may be enough free memory to migrate other
> > > pages and there may be a lot base pages on the list.
> > >
> > > Return -ENOSYS to make consistent with hugetlb.  And if THP split is
> > > failed just skip and try other pages on the list.
> > >
> > > Just skip the whole list and exit when free memory is really low.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  mm/migrate.c | 62 ++++++++++++++++++++++++++++++++++++++------------=
--
> > >  1 file changed, 46 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index 8f6a61c9274b..b3466d8c7f03 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -1172,7 +1172,7 @@ static int unmap_and_move(new_page_t get_new_pa=
ge,
> > >       struct page *newpage =3D NULL;
> > >
> > >       if (!thp_migration_supported() && PageTransHuge(page))
> > > -             return -ENOMEM;
> > > +             return -ENOSYS;
> > >
> > >       if (page_count(page) =3D=3D 1) {
> > >               /* page was freed from under us. So we are done. */
> > > @@ -1376,6 +1376,20 @@ static int unmap_and_move_huge_page(new_page_t=
 get_new_page,
> > >       return rc;
> > >  }
> > >
> > > +static inline int try_split_thp(struct page *page, struct page *page=
2,
> > > +                             struct list_head *from)
> > > +{
> > > +     int rc =3D 0;
> > > +
> > > +     lock_page(page);
> > > +     rc =3D split_huge_page_to_list(page, from);
> > > +     unlock_page(page);
> > > +     if (!rc)
> > > +             list_safe_reset_next(page, page2, lru);
> >
> > This does not work as expected, right? After macro expansion, we have
> > page2 =3D list_next_entry(page, lru). Since page2 is passed as a pointe=
r, the change
> > does not return back the caller. You need to use the pointer to page2 h=
ere.
> >
> > > +
> > > +     return rc;
> > > +}
> > > +
> > >  /*
> > >   * migrate_pages - migrate the pages specified in a list, to the fre=
e pages
> > >   *              supplied as the target for the page migration
> > > @@ -1445,24 +1459,40 @@ int migrate_pages(struct list_head *from, new=
_page_t get_new_page,
> > >                                               reason, &ret_pages);
> > >
> > >                       switch(rc) {
> > > +                     /*
> > > +                      * THP migration might be unsupported or the
> > > +                      * allocation could've failed so we should
> > > +                      * retry on the same page with the THP split
> > > +                      * to base pages.
> > > +                      *
> > > +                      * Head page is retried immediately and tail
> > > +                      * pages are added to the tail of the list so
> > > +                      * we encounter them after the rest of the list
> > > +                      * is processed.
> > > +                      */
> > > +                     case -ENOSYS:
> > > +                             /* THP migration is unsupported */
> > > +                             if (is_thp) {
> > > +                                     if (!try_split_thp(page, page2,=
 from)) {
> > > +                                             nr_thp_split++;
> > > +                                             goto retry;
> > > +                                     }
> > > +
> > > +                                     nr_thp_failed++;
> > > +                                     nr_failed +=3D nr_subpages;
> > > +                                     break;
> > > +                             }
> > > +
> > > +                             /* Hugetlb migration is unsupported */
> > > +                             nr_failed++;
> > > +                             break;
> > >                       case -ENOMEM:
> > >                               /*
> > > -                              * THP migration might be unsupported o=
r the
> > > -                              * allocation could've failed so we sho=
uld
> > > -                              * retry on the same page with the THP =
split
> > > -                              * to base pages.
> > > -                              *
> > > -                              * Head page is retried immediately and=
 tail
> > > -                              * pages are added to the tail of the l=
ist so
> > > -                              * we encounter them after the rest of =
the list
> > > -                              * is processed.
> > > +                              * When memory is low, don't bother to =
try to migrate
> > > +                              * other pages, just exit.
> >
> > The comment does not match the code below. For THPs, the code tries to =
split the THP
> > and migrate the base pages if the split is successful.
>
> BTW, actually I don't think -ENOSYS is a proper return value for this
> case since it typically means "the syscall doesn't exist". IMHO, it
> should return -EINVAL. And actually the return value doesn't matter
> since all callers of migrate_pages() just check if the return value !=3D
> 0. And, neither -ENOSYS nor -EINVAL won't be visible by userspace
> since migrate_pages() just returns the number of failed pages for this
> case.
>
> Anyway the return value is a little bit messy, it may return -ENOMEM,
> 0 or nr_failed. But it looks the callers just care about if ret !=3D 0,
> so it may be better to let it return nr_failed for -ENOMEM case too.

By relooking all the callsites, it seems I overlooked two cases:
     * compaction: it checks if the return value is -ENOMEM if so it
may return COMPACT_CONTENDED
     * migrate_pages syscall: it may return -ENOMEM to the userspace,
but the man page doesn't document this case, not sure if it is
legitimate

>
> >
> > >                                */
> > >                               if (is_thp) {
> > > -                                     lock_page(page);
> > > -                                     rc =3D split_huge_page_to_list(=
page, from);
> > > -                                     unlock_page(page);
> > > -                                     if (!rc) {
> > > -                                             list_safe_reset_next(pa=
ge, page2, lru);
> > > +                                     if (!try_split_thp(page, page2,=
 from)) {
> > >                                               nr_thp_split++;
> > >                                               goto retry;
> > >                                       }
> > > @@ -1490,7 +1520,7 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
> > >                               break;
> > >                       default:
> > >                               /*
> > > -                              * Permanent failure (-EBUSY, -ENOSYS, =
etc.):
> > > +                              * Permanent failure (-EBUSY, etc.):
> > >                                * unlike -EAGAIN case, the failed page=
 is
> > >                                * removed from migration page list and=
 not
> > >                                * retried in the next outer loop.
> > > --
> > > 2.26.2
> >
> >
> > =E2=80=94
> > Best Regards,
> > Yan Zi
