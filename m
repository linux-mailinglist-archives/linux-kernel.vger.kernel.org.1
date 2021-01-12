Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FCF2F3378
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbhALPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhALPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:00:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F377C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:59:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m5so1830542pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a38rsa+oJPxhFV5dbDxkGdFt7ckWx72VOIR5CzRWxbo=;
        b=ilkHdplTgxpRIFCuJ9bYoUCQXd+TBCSuJci7gKx14NEBzoudleiWjfE0mwbWobGHD4
         xm5b3PA51/3AzeMI4TPFL4zjJbrl4NnMiV7gEH4wGo+AMcHZLIfj0X5+jdhoToPELku0
         N68QTvRmLjft4vpxZOtTrmBqYVu2DURPZEsn9je984dLKgrXnnKzJZVox0djshEuxRwn
         8L44CZrYM47qMXZMvRO+Hyqxhna9NgFKwDNVHSNouzc87HJYUWLSe2fJi0NpUIDMA3Bn
         GKqj2JG9AoTumN840MLj10h//aMdc70jin9/wVvqP5ocBHEojg3lYEnY/peX139tU/0H
         185Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a38rsa+oJPxhFV5dbDxkGdFt7ckWx72VOIR5CzRWxbo=;
        b=hHDrbg+T/yJ2Cl3/gmCZP7rWwyJ54MZVXguLjG0CSCkWmMsRqcvf3ME3QVGxcbEgYl
         eqFNuhKYE51dMQO9SQYUMWnWyndVR/VknM0UpUQCkwLcAaL/7bYiT8KI1Jh7WfuoyLbY
         UIG8KCKgWO14YMJmviQsjZZaiL+QNkSDwecWKj0/dok35MTfX/fxvS3BIkxeeKkcj6k1
         2UZm4X6NhpN5LzZiMXUpTdmYIouEpE8cpaVyr3CrB5SW/KOXUKcnQO9vNQHNMA6T1uy5
         CDiag+zB3GxM9cIK4vaLUwwsZX3oKVnZm3Ez5sFKqlU+JbH/gXlXfQzHUad1yYocWWpc
         elHA==
X-Gm-Message-State: AOAM533k+gT2OBR2zF54sRlQVaEUpDUbc0eofzod/5ks30I3mmiuEodO
        OFLAyrzBX+1nYcChiRAzblLCLUV1GKbt2ocrpFGrTA==
X-Google-Smtp-Source: ABdhPJyhgal5NozlKzbp3qJRFGeaEGAi1pquLRa2OCtb3h3QSICphnx0otTEbid82VuZT2Ef6+XbTfkLI/VLRG1q+zQ=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr5238068pjh.13.1610463585073;
 Tue, 12 Jan 2021 06:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com> <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com> <CAMZfGtWnATsqgdqVONgAFWAAJU=KGxVJQEt38b8JTV+UtRzkYw@mail.gmail.com>
 <423ee403-bba7-acf6-8934-9db36d3a719a@redhat.com> <CAMZfGtXfA6JA3eYLhT8YGLJJocopix_mp7uSDPfcmooFEE7xNA@mail.gmail.com>
 <3386dc6d-5f68-c1e3-ba27-d0e95364aa3e@redhat.com>
In-Reply-To: <3386dc6d-5f68-c1e3-ba27-d0e95364aa3e@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 22:59:03 +0800
Message-ID: <CAMZfGtVfZYxVCZQAkyx__F7+=UhOYyW=iC_=bGpc8d8BaaeXkQ@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 10:28 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.01.21 15:17, Muchun Song wrote:
> > On Tue, Jan 12, 2021 at 9:51 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 12.01.21 14:40, Muchun Song wrote:
> >>> On Tue, Jan 12, 2021 at 7:11 PM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>> On 12.01.21 12:00, David Hildenbrand wrote:
> >>>>> On 10.01.21 13:40, Muchun Song wrote:
> >>>>>> If the refcount is one when it is migrated, it means that the page
> >>>>>> was freed from under us. So we are done and do not need to migrate.
> >>>>>>
> >>>>>> This optimization is consistent with the regular pages, just like
> >>>>>> unmap_and_move() does.
> >>>>>>
> >>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>>>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>>>>> Acked-by: Yang Shi <shy828301@gmail.com>
> >>>>>> ---
> >>>>>>  mm/migrate.c | 6 ++++++
> >>>>>>  1 file changed, 6 insertions(+)
> >>>>>>
> >>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>>>> index 4385f2fb5d18..a6631c4eb6a6 100644
> >>>>>> --- a/mm/migrate.c
> >>>>>> +++ b/mm/migrate.c
> >>>>>> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >>>>>>              return -ENOSYS;
> >>>>>>      }
> >>>>>>
> >>>>>> +    if (page_count(hpage) == 1) {
> >>>>>> +            /* page was freed from under us. So we are done. */
> >>>>>> +            putback_active_hugepage(hpage);
> >>>>>> +            return MIGRATEPAGE_SUCCESS;
> >>>>>> +    }
> >>>>>> +
> >>>>>>      new_hpage = get_new_page(hpage, private);
> >>>>>>      if (!new_hpage)
> >>>>>>              return -ENOMEM;
> >>>>>>
> >>>>>
> >>>>> Question: What if called via alloc_contig_range() where we even want to
> >>>>> "migrate" free pages, meaning, relocate it?
> >>>>>
> >>>>
> >>>> To be more precise:
> >>>>
> >>>> a) We don't have dissolve_free_huge_pages() calls on the
> >>>> alloc_contig_range() path. So we *need* migration IIUC.
> >>>
> >>> Without this patch, if you want to migrate a HUgeTLB page,
> >>> the page is freed to the hugepage pool. With this patch,
> >>> the page is also freed to the hugepage pool.
> >>> I didn't see any different. I am missing something?
> >>
> >> I am definitely not an expert on hugetlb pools, that's why I am asking.
> >>
> >> Isn't it, that with your code, no new page is allocated - so
> >> dissolve_free_huge_pages() might just refuse to dissolve due to
> >> reservations, bailing out, no?
> >
> > Without this patch, the new page can be allocated from the
> > hugepage pool. The dissolve_free_huge_pages() also
> > can refuse to dissolve due to reservations. Right?
>
> Oh, you mean the migration target might be coming from the pool? I guess
> yes, looking at alloc_migration_target()->alloc_huge_page_nodemask().

Yeah, you are right. If we want to free a HugeTLB page to
the buddy allocator, we should dissolve_free_huge_page()
to do that. Migrating cannot guarantee this at least now.

>
> In that case, yes, I think we run into a similar issue already.
>
> Instead of trying to allocate new huge pages in
> dissolve_free_huge_pages() to "relocate free pages", we bail out.
>
> This all feels kind of wrong. After we migrated a huge page we should
> free it back to the buddy, so most of our machinery just keeps working
> without caring about free huge pages.
>
>
> I can see how your patch will not change the current (IMHO broken) behavior.
>
> --
> Thanks,
>
> David / dhildenb
>
