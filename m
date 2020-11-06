Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA62A9F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgKFVxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgKFVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:53:39 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A13C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:53:38 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id 7so3955410ejm.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Lrz5uJAiiLESdTPjmylRgOOL6zFs7nMEo6gXUlcAvc=;
        b=DiqBNJDrEa7mvU872CK0Pi6oRMRNNNJoLPeoOQrOk9I5zFPe1tNJIhFO2TGfkwbudb
         G82Vjx8lYZJ/NK2yOfoCk8WfbPo++S1Wh3F/NHqDnVWi42d1fQsOmU3NRU630a9ZRXfX
         J1/XKXM8wwb/uWSccP+PzxZmgZKwrPLzxiKA+Ouu+jLAMqtWr3cvCEjVHvdwpd04n6Yi
         PBDp9hHowksWwOO93kCcYc3ccMmac9UVvqKflXmK8vR8rYD0vHNuR58X8kDa2LBXgnKK
         JXE5HEeF8OYwOfpjpngoS2bYpEy+s2nvjZoMZmMmROPnGutsrfKMK3XhfkAWfRhWRlUT
         yGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Lrz5uJAiiLESdTPjmylRgOOL6zFs7nMEo6gXUlcAvc=;
        b=D81i6fhtlvW6z3cBaZvy6hDhsFDvGOYioG2vgZVeyUbrcEDc76XJtX3f/V0y0NSCn7
         YGWOFQbxzZqQTQl3pw7Xy2HFXpIqob+OAA0cGfd2jgs1FTiIbt/saG0Qxkjp9oT1j8/Y
         Q38S9Yr3gTzbnJll6hjRJbXb+5B+bG9e4HzxYrgxy8Skv2jjZH8bcUivqyJcZxTzg7xb
         ajJ/g3ZaJhqM53gg+8RzFpirY4KCqKfFEYknfQQI0ZES76NmlTcEjZyibJkY8pNoEMZh
         vsMaTt1D5C+Qi6iIQeep/LMbsN2nOHEsQ86V8TqXkyMC7D+tTYdJHSBqqtMiM1OxcgeD
         yjDA==
X-Gm-Message-State: AOAM531CJK5GkdqtynBTBdChazFSbnaXOYwrNCtriVRnzOPIFFBP2fQN
        GL+oo+5LgKmITqBsDFzkrjnZT7A0Ng2zLBGIN2E=
X-Google-Smtp-Source: ABdhPJwsh3aQno/4dYUGnxDieXScGGhq/yhW6CooR+F1wL41cYWyZXHwCubnIlbLPY+WBzVNxyr0fS0jmGGk25u+uIY=
X-Received: by 2002:a17:906:519b:: with SMTP id y27mr3901493ejk.25.1604699617454;
 Fri, 06 Nov 2020 13:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20201103130334.13468-1-shy828301@gmail.com> <20201103130334.13468-6-shy828301@gmail.com>
 <A842D483-D9F2-4347-9A4F-1939769BC831@nvidia.com>
In-Reply-To: <A842D483-D9F2-4347-9A4F-1939769BC831@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Nov 2020 13:53:25 -0800
Message-ID: <CAHbLzkrNyi9O-6fnPRLy883VMzoOPhWMB2UGWJa2ZmwXWS0Jmg@mail.gmail.com>
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

On Fri, Nov 6, 2020 at 12:17 PM Zi Yan <ziy@nvidia.com> wrote:
>
> On 3 Nov 2020, at 8:03, Yang Shi wrote:
>
> > In the current implementation unmap_and_move() would return -ENOMEM if
> > THP migration is unsupported, then the THP will be split.  If split is
> > failed just exit without trying to migrate other pages.  It doesn't mak=
e
> > too much sense since there may be enough free memory to migrate other
> > pages and there may be a lot base pages on the list.
> >
> > Return -ENOSYS to make consistent with hugetlb.  And if THP split is
> > failed just skip and try other pages on the list.
> >
> > Just skip the whole list and exit when free memory is really low.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/migrate.c | 62 ++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 46 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 8f6a61c9274b..b3466d8c7f03 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1172,7 +1172,7 @@ static int unmap_and_move(new_page_t get_new_page=
,
> >       struct page *newpage =3D NULL;
> >
> >       if (!thp_migration_supported() && PageTransHuge(page))
> > -             return -ENOMEM;
> > +             return -ENOSYS;
> >
> >       if (page_count(page) =3D=3D 1) {
> >               /* page was freed from under us. So we are done. */
> > @@ -1376,6 +1376,20 @@ static int unmap_and_move_huge_page(new_page_t g=
et_new_page,
> >       return rc;
> >  }
> >
> > +static inline int try_split_thp(struct page *page, struct page *page2,
> > +                             struct list_head *from)
> > +{
> > +     int rc =3D 0;
> > +
> > +     lock_page(page);
> > +     rc =3D split_huge_page_to_list(page, from);
> > +     unlock_page(page);
> > +     if (!rc)
> > +             list_safe_reset_next(page, page2, lru);
>
> This does not work as expected, right? After macro expansion, we have
> page2 =3D list_next_entry(page, lru). Since page2 is passed as a pointer,=
 the change
> does not return back the caller. You need to use the pointer to page2 her=
e.

Yes, I should pass in **page2. Thanks for catching this.

>
> > +
> > +     return rc;
> > +}
> > +
> >  /*
> >   * migrate_pages - migrate the pages specified in a list, to the free =
pages
> >   *              supplied as the target for the page migration
> > @@ -1445,24 +1459,40 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
> >                                               reason, &ret_pages);
> >
> >                       switch(rc) {
> > +                     /*
> > +                      * THP migration might be unsupported or the
> > +                      * allocation could've failed so we should
> > +                      * retry on the same page with the THP split
> > +                      * to base pages.
> > +                      *
> > +                      * Head page is retried immediately and tail
> > +                      * pages are added to the tail of the list so
> > +                      * we encounter them after the rest of the list
> > +                      * is processed.
> > +                      */
> > +                     case -ENOSYS:
> > +                             /* THP migration is unsupported */
> > +                             if (is_thp) {
> > +                                     if (!try_split_thp(page, page2, f=
rom)) {
> > +                                             nr_thp_split++;
> > +                                             goto retry;
> > +                                     }
> > +
> > +                                     nr_thp_failed++;
> > +                                     nr_failed +=3D nr_subpages;
> > +                                     break;
> > +                             }
> > +
> > +                             /* Hugetlb migration is unsupported */
> > +                             nr_failed++;
> > +                             break;
> >                       case -ENOMEM:
> >                               /*
> > -                              * THP migration might be unsupported or =
the
> > -                              * allocation could've failed so we shoul=
d
> > -                              * retry on the same page with the THP sp=
lit
> > -                              * to base pages.
> > -                              *
> > -                              * Head page is retried immediately and t=
ail
> > -                              * pages are added to the tail of the lis=
t so
> > -                              * we encounter them after the rest of th=
e list
> > -                              * is processed.
> > +                              * When memory is low, don't bother to tr=
y to migrate
> > +                              * other pages, just exit.
>
> The comment does not match the code below. For THPs, the code tries to sp=
lit the THP
> and migrate the base pages if the split is successful.

The comment here just covers the "goto out" rather than the split
because I thought it is covered by the comment before "case -ENOSYS",
which says "unsupported or the allocation could've failed", so I
didn't repeat here.

>
> >                                */
> >                               if (is_thp) {
> > -                                     lock_page(page);
> > -                                     rc =3D split_huge_page_to_list(pa=
ge, from);
> > -                                     unlock_page(page);
> > -                                     if (!rc) {
> > -                                             list_safe_reset_next(page=
, page2, lru);
> > +                                     if (!try_split_thp(page, page2, f=
rom)) {
> >                                               nr_thp_split++;
> >                                               goto retry;
> >                                       }
> > @@ -1490,7 +1520,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
> >                               break;
> >                       default:
> >                               /*
> > -                              * Permanent failure (-EBUSY, -ENOSYS, et=
c.):
> > +                              * Permanent failure (-EBUSY, etc.):
> >                                * unlike -EAGAIN case, the failed page i=
s
> >                                * removed from migration page list and n=
ot
> >                                * retried in the next outer loop.
> > --
> > 2.26.2
>
>
> =E2=80=94
> Best Regards,
> Yan Zi
