Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6089D2F2B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbhALJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbhALJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:44:52 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52B6C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:44:12 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 15so1078076pgx.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhKAvdyLV9ozaBHs7ibd8aRJfyvsfFlYNbqMhqyg060=;
        b=cbC/HNTUF0dIEuvA/YKvArU6Ak+cJb0cXhRxx830ejv1rNkYMLAQX5DZq+XLl/P2rF
         I+X1mN8YSVuG8hWZ0N3G5ThmqDczJu5S4W4Hvdxrlb/XeJuYtrzFW7qWDiBoS2vZ1udl
         xKXI8aNFa8rzyCEO/TYnu7uNHkPNxGQQ8GNVkVWW2gHgZsKWc4HT7V3oZS/c9Q3ik6uF
         xBKdj4pxtQMEg/nfFDy4YPXZqVuNHpSAwzJwJbty7HUtsTnFui5ne2IQgvMZo7USbpbb
         SGpu582Zqv30wOZdOcCzKGMWK1yQEKh1uY+Z+WB7APrFtD8kPshhKfCBEDeAk+OPQA5U
         6nBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhKAvdyLV9ozaBHs7ibd8aRJfyvsfFlYNbqMhqyg060=;
        b=mNxYPQX7jtZwbHxmdYwEYxwFhD743z//gsEHl5i/cJwR07mF5S0FqQt4IH0PbYCMIi
         GJkk8y5rKjKyS42ciZ5geEKUDUD3P9JqB0nJcJ34bDWwFIGTg+J+FJGx/iq3BZ+5Vi0r
         VYS/wZ4W3WGDqPibhbb8+hLXTxEbs5RDfDhjA1WW2dQv0LbIEB7zCcrG52xG5eepDhGI
         Ntt5M/5+4C8Pl6VFJsp1+xZsUv1l7FzuHqqRZiUiOYjtbLW+4CNNLyTX0Ysj0pvN+Ytm
         6vBJOReJhqNAcCUP5svo1nTxIkHpq3YzAJbXAqoGAmGZc43wbLgQJRzkAL/vSPuHSaaU
         vHZg==
X-Gm-Message-State: AOAM532mRZ4HN/odPpcGlm6JhaOvKO1u1kEXlF9fFMFU5dtAjs5EnLi3
        6+ESWVmTH0Mt6eGJCC5etcBmvXAKXd41apJ1oDP8kA==
X-Google-Smtp-Source: ABdhPJxvDFvvlZabl5kzZ+R1L5yEdMbs49iCNkUUDD0duSQUClowazshDTSh0023giqQ2cNQDuWnlyLk023Il7JCBMs=
X-Received: by 2002:a63:480f:: with SMTP id v15mr3875523pga.341.1610444652212;
 Tue, 12 Jan 2021 01:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com> <20210112094222.GI22493@dhcp22.suse.cz>
In-Reply-To: <20210112094222.GI22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 17:43:30 +0800
Message-ID: <CAMZfGtV_b8o3aQgbxrDO0aLi=g6SsEmYfoqjM19o9p_XQNAbUg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB
 page whose refcount is one
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 5:42 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Sun 10-01-21 20:40:12, Muchun Song wrote:
> > If the refcount is one when it is migrated, it means that the page
> > was freed from under us. So we are done and do not need to migrate.
>
> I would consider the following easier to understand. Feel free to reuse.
> "
> All pages isolated for the migration have an elevated reference count
> and therefore seeing a reference count equal to 1 means that the last
> user of the page has dropped the reference and the page has became
> unused and there doesn't make much sense to migrate it anymore. This has
> been done for regular pages and this patch does the same for hugetlb
> pages. Although the likelyhood of the race is rather small for hugetlb
> pages it makes sense the two code paths in sync.
> "

Thanks.

>
> >
> > This optimization is consistent with the regular pages, just like
> > unmap_and_move() does.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Acked-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> > ---
> >  mm/migrate.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 4385f2fb5d18..a6631c4eb6a6 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >               return -ENOSYS;
> >       }
> >
> > +     if (page_count(hpage) == 1) {
> > +             /* page was freed from under us. So we are done. */
> > +             putback_active_hugepage(hpage);
> > +             return MIGRATEPAGE_SUCCESS;
> > +     }
> > +
> >       new_hpage = get_new_page(hpage, private);
> >       if (!new_hpage)
> >               return -ENOMEM;
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
