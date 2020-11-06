Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12C02A9F1F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgKFVef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgKFVee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:34:34 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:34:33 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id s25so3886711ejy.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5qzE0qfIl9B7mqpdXDyhyfp/5OpbdkdpRjzksR+7JFo=;
        b=IWy4DAX1gX81PlKKzFxgv53zVKorG95LX0anRz8hcf18BD9/UwdhBul/uOz319NHFm
         PsJ9TbyNyVC+y2sOEPdeEUfG1eyk9giDzr6GscTa38GEVpKkn6siPQ5P0MOmQepdXiwo
         S92QRRc4DdUvjDt8V4wHOEghMnSvkRTaB+N+5ZMW13ovQZ2hmDpvuBb4tumMFu4WyEUh
         eTHf3Qd1GDY8uxKuv5hYCQ4OJRhzWJS1z6agHEw0CGCew5vr3jXZRXSgWvb0pywW7/aI
         Z/+3HiHc6zHE4Ez/xXpRhGbxL6ljUykJ2nrUaq0H94WQIzwlhw6/xWJPx2CeOG+u2eKW
         lZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5qzE0qfIl9B7mqpdXDyhyfp/5OpbdkdpRjzksR+7JFo=;
        b=j3XxZy9xtdUE88NOjeKjwGE3qd+RZ20cPgKMb242yfXijbZgjb/PiyJI3LOuj2OUqw
         umNetRzwLdJjaPE33i5Bfz6h1Rb2LtbDkLh4LuoZwNhB9+5SCbNG+dAJiD7CO3LL1W06
         dvipG6k25NZgQdDL6pPl08UMtQoUVDreU479hwEwYRgMvy6dStg1Rr2lEBosBr53c5sY
         KNKrp4VY9cz+KqNavMyifVBQe5NsvxZk+4EcvvRiEA0+gUm+VJ4xzUfvE7B8D5jkLeWn
         eC0YccWxeE+iEddZ+A5KCMKVNuBW3+ndTMsnsUxTlbP4kiZKN7HMe+seoBe7MT4XLhvG
         NcDA==
X-Gm-Message-State: AOAM532YB3ItMuIkhj5B81F7dRkXOtauGhWM6+BsX8SSwb4CjmkWotWa
        c6ww5TrbBJkIODYAYaWkzXA4LWogIlFqxeYR6Bo=
X-Google-Smtp-Source: ABdhPJy80decEh9ghMWuqUqFHvyvhlwlwG3jHZMeWI+gGNKbfST2VnAlGLqJ5i41eON5Uw/kJ/NoQbyd6ES2ty7QP9Y=
X-Received: by 2002:a17:906:6a94:: with SMTP id p20mr3860222ejr.499.1604698471674;
 Fri, 06 Nov 2020 13:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20201103130334.13468-1-shy828301@gmail.com> <20201103130334.13468-3-shy828301@gmail.com>
 <E2ACBA14-4409-47D2-A6F7-C5E0660200AB@nvidia.com>
In-Reply-To: <E2ACBA14-4409-47D2-A6F7-C5E0660200AB@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Nov 2020 13:34:20 -0800
Message-ID: <CAHbLzkoMV3rvgzZdm3pqqHZ64NBm_dC0PsFxevCPFYzaq_FXsw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm: migrate: simplify the logic for handling
 permanent failure
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

On Fri, Nov 6, 2020 at 12:03 PM Zi Yan <ziy@nvidia.com> wrote:
>
> On 3 Nov 2020, at 8:03, Yang Shi wrote:
>
> > When unmap_and_move{_huge_page}() returns !-EAGAIN and !MIGRATEPAGE_SUC=
CESS,
> > the page would be put back to LRU or proper list if it is non-LRU movab=
le
> > page.  But, the callers always call putback_movable_pages() to put the
> > failed pages back later on, so it seems not very efficient to put every
> > single page back immediately, and the code looks convoluted.
> >
> > Put the failed page on a separate list, then splice the list to migrate
> > list when all pages are tried.  It is the caller's responsibility to
> > call putback_movable_pages() to handle failures.  This also makes the
> > code simpler and more readable.
> >
> > After the change the rules are:
> >     * Success: non hugetlb page will be freed, hugetlb page will be put
> >                back
> >     * -EAGAIN: stay on the from list
> >     * -ENOMEM: stay on the from list
> >     * Other errno: put on ret_pages list then splice to from list
>
> Can you put this before the switch case in the migrate_pages? That will
> be very helpful to understand the code.

Sure, I agree the switch case deserves some comments.

> >
> > The from list would be empty iff all pages are migrated successfully, i=
t
>
> s/iff/if unless you really mean if and only if. :)

Yes, I mean if and only if.

>
>
> Everything else looks good to me. Thanks for making the code cleaner.
> With the changes above, you can add Reviewed-by: Zi Yan <ziy@nvidia.com>.

Thanks.

>
> > was not so before.  This has no impact to current existing callsites.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/migrate.c | 58 ++++++++++++++++++++++++++--------------------------
> >  1 file changed, 29 insertions(+), 29 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 8a2e7e19e27b..c33c92495ead 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1169,7 +1169,8 @@ static int unmap_and_move(new_page_t get_new_page=
,
> >                                  free_page_t put_new_page,
> >                                  unsigned long private, struct page *pa=
ge,
> >                                  int force, enum migrate_mode mode,
> > -                                enum migrate_reason reason)
> > +                                enum migrate_reason reason,
> > +                                struct list_head *ret)
> >  {
> >       int rc =3D MIGRATEPAGE_SUCCESS;
> >       struct page *newpage =3D NULL;
> > @@ -1206,7 +1207,14 @@ static int unmap_and_move(new_page_t get_new_pag=
e,
> >                * migrated will have kept its references and be restored=
.
> >                */
> >               list_del(&page->lru);
> > +     }
> >
> > +     /*
> > +      * If migration is successful, releases reference grabbed during
> > +      * isolation. Otherwise, restore the page to right list unless
> > +      * we want to retry.
> > +      */
> > +     if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
> >               /*
> >                * Compaction can migrate also non-LRU pages which are
> >                * not accounted to NR_ISOLATED_*. They can be recognized
> > @@ -1215,35 +1223,16 @@ static int unmap_and_move(new_page_t get_new_pa=
ge,
> >               if (likely(!__PageMovable(page)))
> >                       mod_node_page_state(page_pgdat(page), NR_ISOLATED=
_ANON +
> >                                       page_is_file_lru(page), -thp_nr_p=
ages(page));
> > -     }
> >
> > -     /*
> > -      * If migration is successful, releases reference grabbed during
> > -      * isolation. Otherwise, restore the page to right list unless
> > -      * we want to retry.
> > -      */
> > -     if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
> >               if (reason !=3D MR_MEMORY_FAILURE)
> >                       /*
> >                        * We release the page in page_handle_poison.
> >                        */
> >                       put_page(page);
> >       } else {
> > -             if (rc !=3D -EAGAIN) {
> > -                     if (likely(!__PageMovable(page))) {
> > -                             putback_lru_page(page);
> > -                             goto put_new;
> > -                     }
> > +             if (rc !=3D -EAGAIN)
> > +                     list_add_tail(&page->lru, ret);
> >
> > -                     lock_page(page);
> > -                     if (PageMovable(page))
> > -                             putback_movable_page(page);
> > -                     else
> > -                             __ClearPageIsolated(page);
> > -                     unlock_page(page);
> > -                     put_page(page);
> > -             }
> > -put_new:
> >               if (put_new_page)
> >                       put_new_page(newpage, private);
> >               else
> > @@ -1274,7 +1263,8 @@ static int unmap_and_move(new_page_t get_new_page=
,
> >  static int unmap_and_move_huge_page(new_page_t get_new_page,
> >                               free_page_t put_new_page, unsigned long p=
rivate,
> >                               struct page *hpage, int force,
> > -                             enum migrate_mode mode, int reason)
> > +                             enum migrate_mode mode, int reason,
> > +                             struct list_head *ret)
> >  {
> >       int rc =3D -EAGAIN;
> >       int page_was_mapped =3D 0;
> > @@ -1290,7 +1280,7 @@ static int unmap_and_move_huge_page(new_page_t ge=
t_new_page,
> >        * kicking migration.
> >        */
> >       if (!hugepage_migration_supported(page_hstate(hpage))) {
> > -             putback_active_hugepage(hpage);
> > +             list_move_tail(&hpage->lru, ret);
> >               return -ENOSYS;
> >       }
> >
> > @@ -1372,8 +1362,10 @@ static int unmap_and_move_huge_page(new_page_t g=
et_new_page,
> >  out_unlock:
> >       unlock_page(hpage);
> >  out:
> > -     if (rc !=3D -EAGAIN)
> > +     if (rc =3D=3D MIGRATEPAGE_SUCCESS)
> >               putback_active_hugepage(hpage);
> > +     else if (rc !=3D -EAGAIN && rc !=3D MIGRATEPAGE_SUCCESS)
> > +             list_move_tail(&hpage->lru, ret);
> >
> >       /*
> >        * If migration was not successful and there's a freeing callback=
, use
> > @@ -1404,8 +1396,8 @@ static int unmap_and_move_huge_page(new_page_t ge=
t_new_page,
> >   *
> >   * The function returns after 10 attempts or if no pages are movable a=
ny more
> >   * because the list has become empty or no retryable pages exist any m=
ore.
> > - * The caller should call putback_movable_pages() to return pages to t=
he LRU
> > - * or free list only if ret !=3D 0.
> > + * It is caller's responsibility to call putback_movable_pages() to re=
turn pages
> > + * to the LRU or free list only if ret !=3D 0.
> >   *
> >   * Returns the number of pages that were not migrated, or an error cod=
e.
> >   */
> > @@ -1426,6 +1418,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
> >       struct page *page2;
> >       int swapwrite =3D current->flags & PF_SWAPWRITE;
> >       int rc, nr_subpages;
> > +     LIST_HEAD(ret_pages);
> >
> >       if (!swapwrite)
> >               current->flags |=3D PF_SWAPWRITE;
> > @@ -1448,11 +1441,12 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
> >                       if (PageHuge(page))
> >                               rc =3D unmap_and_move_huge_page(get_new_p=
age,
> >                                               put_new_page, private, pa=
ge,
> > -                                             pass > 2, mode, reason);
> > +                                             pass > 2, mode, reason,
> > +                                             &ret_pages);
> >                       else
> >                               rc =3D unmap_and_move(get_new_page, put_n=
ew_page,
> >                                               private, page, pass > 2, =
mode,
> > -                                             reason);
> > +                                             reason, &ret_pages);
> >
> >                       switch(rc) {
> >                       case -ENOMEM:
> > @@ -1519,6 +1513,12 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
> >       nr_thp_failed +=3D thp_retry;
> >       rc =3D nr_failed;
> >  out:
> > +     /*
> > +      * Put the permanent failure page back to migration list, they
> > +      * will be put back to the right list by the caller.
> > +      */
> > +     list_splice(&ret_pages, from);
> > +
> >       count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> >       count_vm_events(PGMIGRATE_FAIL, nr_failed);
> >       count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> > --
> > 2.26.2
>
>
> =E2=80=94
> Best Regards,
> Yan Zi
