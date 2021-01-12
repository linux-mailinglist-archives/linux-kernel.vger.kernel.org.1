Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F62F31DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhALNlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbhALNlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:41:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5A5C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:40:53 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y8so1408656plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZLzXJhYGy3+C++xiu5/GWXfuaP9n5Tamv3Y6rIuM/8=;
        b=kOHEJUMIVd1E1RjqgU/ztHKBOTzyewT5NmxKsCh1MyIjNkQpn3ynCh447I7c+wigJD
         etc888HHTL5ebznnHgGueMOVDbMT40gwfn7zf1Rj0qlH3rZYbTUS0B9F81+cbdzIl8ZQ
         012pn+8i0o5UYncK3n4aPa4tu/Raf/oO4yTkCJk8wSwHmcRwwJnaBg/LQKRt7YurwGqZ
         fjzLjWgYYry5eGhPEb5n1oVFZILi9NslRItFQYWLAc3g3BHziIWIzMZZmD8OkFMiQTN3
         sTpipoSNX10cvyUbzpx64SqgZ7gxmscTdg+U/QtR05PtI4NDnm8nRDbHCVbcMEhabAd0
         n4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZLzXJhYGy3+C++xiu5/GWXfuaP9n5Tamv3Y6rIuM/8=;
        b=Dcy0Aw40JZ7os0GcbqUKZPuOo9yodpg4wTxttdVKfuTAKukILzyaTNWGJqLOt7Peg/
         U6AqcxVrEg03BELHh7Yjj0fxeiFhEXLITazqyWn2gYQtw5I9nLAb7OjfqdBVBC7Lqm7C
         HlWtmGnZk4MNC6ht+ymDQWF5Dg0aVGfyuOPzirnpjjh69BqwKOlRwcVejDp/4r/GGZR7
         u0gDE0OzO0xDgCbFvR5FBL0/EjpsuGYzJciOKBDqHRqlBOTsZnhNcrSXeHYlrr16khjm
         MEWaVIrtQ0IRshO1AnTZhNCemZ6yxxY0RhelVMN5UDntLSBkq2OxT21/j+Kxw9C4FTZF
         Vzlg==
X-Gm-Message-State: AOAM532wuxYvJskSm40taJgePsxISne5/TDNAXecpgZi78re+1EtA/Hc
        nH82l0ukEYLnXCJ3/FKlbzVDrFWeGMLinVzJwpgO3w==
X-Google-Smtp-Source: ABdhPJwJEZGJ+XMYd1YH6xipHivHKF33qK778JtZmPGOLOYl8IQZuZfMXbQjQf/X6ZwG1AmN6AudjfgxIr54JVMOkRc=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr4678691pjt.147.1610458852955;
 Tue, 12 Jan 2021 05:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com> <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
In-Reply-To: <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 21:40:07 +0800
Message-ID: <CAMZfGtWnATsqgdqVONgAFWAAJU=KGxVJQEt38b8JTV+UtRzkYw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB
 page whose refcount is one
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 7:11 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.01.21 12:00, David Hildenbrand wrote:
> > On 10.01.21 13:40, Muchun Song wrote:
> >> If the refcount is one when it is migrated, it means that the page
> >> was freed from under us. So we are done and do not need to migrate.
> >>
> >> This optimization is consistent with the regular pages, just like
> >> unmap_and_move() does.
> >>
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> >> Acked-by: Yang Shi <shy828301@gmail.com>
> >> ---
> >>  mm/migrate.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 4385f2fb5d18..a6631c4eb6a6 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >>              return -ENOSYS;
> >>      }
> >>
> >> +    if (page_count(hpage) == 1) {
> >> +            /* page was freed from under us. So we are done. */
> >> +            putback_active_hugepage(hpage);
> >> +            return MIGRATEPAGE_SUCCESS;
> >> +    }
> >> +
> >>      new_hpage = get_new_page(hpage, private);
> >>      if (!new_hpage)
> >>              return -ENOMEM;
> >>
> >
> > Question: What if called via alloc_contig_range() where we even want to
> > "migrate" free pages, meaning, relocate it?
> >
>
> To be more precise:
>
> a) We don't have dissolve_free_huge_pages() calls on the
> alloc_contig_range() path. So we *need* migration IIUC.

Without this patch, if you want to migrate a HUgeTLB page,
the page is freed to the hugepage pool. With this patch,
the page is also freed to the hugepage pool.
I didn't see any different. I am missing something?


>
> b) dissolve_free_huge_pages() will fail if going below the reservation.
> In that case we really want to migrate free pages. This even applies to
> memory offlining.
>
> Either I am missing something important or this patch is more dangerous
> than it looks like.
>
> --
> Thanks,
>
> David / dhildenb
>
