Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFED2EB9D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbhAFGGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhAFGGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:06:49 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89DAC06134D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 22:06:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t8so1106840pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 22:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu3XTCtN8+YlWQXGEuBkVBXbO4gwbn3nfLwvPmsRKvE=;
        b=xTJyxzSUznkoxx6Uwj7tYJINTN1kUnIuZP6iOJsl/uKjWgk4rnAG9ZZSRjNzCAgUv6
         hiCJttv3gwWCIZD5+0KM+FYT4QQCJyxShxktYpHj+YF+LYamgobBy/iVIxD6NrF3JYkd
         aTShqLeRcIVOISgA1wHRoMPfAv/MlG4jed2sNcKbocw+5S9sDh7Bclb8ACNh6JaV/heP
         BRVhn601+nGrWOHVnTqxMkYkGhg+1tVHu4/+75VffA/TUiTD/EwUiudJp2AUlp8BCB/s
         lrWA3aVjdl+nPn9mi224ztrpJlv7weRwPr/TDF40GbMjeF6F9FFL/sYMi4+S167lD4r4
         6CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu3XTCtN8+YlWQXGEuBkVBXbO4gwbn3nfLwvPmsRKvE=;
        b=SAt8cmM91z78/xtR/wOxla1fICJEG28J/GMqrBpQmz7lvGQF5fsb9CqzRVJO7UpqxI
         ncq9kqRwQ2y/tN7UNAA6H10qIODtPhRFMxE9qf5T1dOFWPPk5TxHKfuJeFEcngwrjsZu
         o8PdHN6SUtpNYeO0CLeOcKZE3f1/Ok+ImMXHZSayhXuu4La24TgaJ+r7bdLbCXOaNvsE
         5xY+/zJocDlV2Ul/kYrZJeoXwQaeWQWl/b6LPK9YLu1VYRCgaxQqUl7BBvjNu+pICh9i
         XsHmQtQQoij1deJh8MWL6hA9hQVaRFZ6uigV4ygjCjfHz/DTjnmJHkAenwDHp0vfsQDm
         k7UA==
X-Gm-Message-State: AOAM530MY3rdZk5wiVNdGhDye8FU4EBWbRnzh3BieQjnKNnkOfkD5erI
        7fW7spTMC6c+JXcGmt4nEKm5RY9eeUzH9xLOAo1KMA==
X-Google-Smtp-Source: ABdhPJw7cRMbBCXW5SN511upyvlIXqdnjQhMIt6wAKK3G2xGPCLv6v5Vt2RI6LGcqhI16TbiNv3xihfQCaXgH/6x570=
X-Received: by 2002:a63:50a:: with SMTP id 10mr2810393pgf.273.1609913168372;
 Tue, 05 Jan 2021 22:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-3-songmuchun@bytedance.com> <b41d2f1d-da2c-07ae-6bd0-31022a3378ea@oracle.com>
 <CAMZfGtV-zYoWrHZETd2soOGifRpbhQH=myzQc0NtjpgzC-Fygw@mail.gmail.com> <19e24147-f3cd-c6d2-dd0a-57e6182d60d8@oracle.com>
In-Reply-To: <19e24147-f3cd-c6d2-dd0a-57e6182d60d8@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 6 Jan 2021 14:05:30 +0800
Message-ID: <CAMZfGtXXrq-B4=LM7Cy1SFCAC-OZcJOjxHpTv4QpKBB8Kh5qyQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 7:22 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/4/21 6:55 PM, Muchun Song wrote:
> > On Tue, Jan 5, 2021 at 8:02 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 1/3/21 10:58 PM, Muchun Song wrote:
> >>> There is a race condition between __free_huge_page()
> >>> and dissolve_free_huge_page().
> >>>
> >>> CPU0:                         CPU1:
> >>>
> >>> // page_count(page) == 1
> >>> put_page(page)
> >>>   __free_huge_page(page)
> >>>                               dissolve_free_huge_page(page)
> >>>                                 spin_lock(&hugetlb_lock)
> >>>                                 // PageHuge(page) && !page_count(page)
> >>>                                 update_and_free_page(page)
> >>>                                 // page is freed to the buddy
> >>>                                 spin_unlock(&hugetlb_lock)
> >>>     spin_lock(&hugetlb_lock)
> >>>     clear_page_huge_active(page)
> >>>     enqueue_huge_page(page)
> >>>     // It is wrong, the page is already freed
> >>>     spin_unlock(&hugetlb_lock)
> >>>
> >>> The race windows is between put_page() and spin_lock() which
> >>> is in the __free_huge_page().
> >>>
> >>> We should make sure that the page is already on the free list
> >>> when it is dissolved.
> >>>
> >>> Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>  mm/hugetlb.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 48 insertions(+)
> >>>
> >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >>> index 1f3bf1710b66..72608008f8b4 100644
> >>> --- a/mm/hugetlb.c
> >>> +++ b/mm/hugetlb.c
> >>> @@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
> >>>  static int num_fault_mutexes;
> >>>  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
> >>>
> >>> +static inline bool PageHugeFreed(struct page *head)
> >>> +{
> >>> +     return page_private(head) == -1UL;
> >>
> >>         return page_private(head + 4) == -1UL;
> >>
> >>> +}
> >>> +
> >>> +static inline void SetPageHugeFreed(struct page *head)
> >>> +{
> >>> +     set_page_private(head + 4, -1UL);
> >>> +}
> >>> +
> >>> +static inline void ClearPageHugeFreed(struct page *head)
> >>> +{
> >>> +     set_page_private(head + 4, 0);
> >>> +}
> >>
> >> It is unfortunate that we can not use some existing value like
> >> page_huge_active() to determine if dissolve_free_huge_page() should
> >> proceed with freeing the page to buddy.  If the existing check,
> >>
> >>         if (!page_count(page)) {
> >>
> >> was changed to
> >>
> >>         if (!page_count(page) && !page_huge_active(page)) {
> >>
> >> the race window would be shrunk.  However, the most straight forward
> >> way to fully close the window is with the approach taken here.
> >
> > I also thought about this fix. But this is not enough. Because
> > we just call put_page to free the HugeTLB page without
> > setting activeness in some place (e.g. error handling
> > routines).
> >
> > If we use page_huge_active, we should set activeness
> > before put_page. But we cannot guarantee this.
>
> Just FYI,
> I went back and explored the option of doing set_page_huge_active
> when a page was put on the active list and clear_page_huge_active
> when put on the free list.  This would be much like what you are
> doing with PageHugeFreed.  Commit bcc54222309c which added page_huge_active
> implied that this was possible.  Then I remembered a race fixed in
> cb6acd01e2e4 that required delaying the call to set_page_huge_active
> in hugetlb_no_page.  So, such a scheme would not work.

Sounds like a tortuous story. :)

>
> Also,
> It seems we could use head[3].mapping for PageHugeFreed ?  Not much
> of an advantage.  It does not add another tail page needed to store
> page metadata.  And, this fits within the already defined
> HUGETLB_CGROUP_MIN_ORDER.

It is fine to me. Will do. Thanks.

> --
> Mike Kravetz
