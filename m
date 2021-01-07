Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD322ECEDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbhAGLjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbhAGLjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:39:21 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32840C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 03:38:41 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s15so3331949plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 03:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSIDm95nmFNLU0RfgmsDhpelBGAdD7UZISvgZRUQxDA=;
        b=CexN865DftZyxIRECrgQK9qHf4ouW+/d/KCO+1McQOZPjIypqm7uDPNQikrJDXPZYk
         r3hoSREJyEr1CQqG6OVok7rQs56Tc0FYZsEWfwTiACI/5dkw52PLpD1jLFkzQ+UwunXo
         cSWNFTl1PUbdbB1IbGi/fETmPJfPO9AvntL0DemzDgORYY54rYKrAmHbzkaOA4fj0nK8
         Yqzo3YHSFeaMceltvUtLKBiT9TAJvKAPGHwH/ddgjrWGE8Np6cQ8nuTsTtDFonpJt3Gr
         u/l1UO1DYWBaJ4+noGGYOSwSoEVnY1lqOJf9Wx7O/GZe+/qh9arqNiP8ibJeyA1Q/+nK
         20xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSIDm95nmFNLU0RfgmsDhpelBGAdD7UZISvgZRUQxDA=;
        b=P3Hu5FeWmMfJKvxHfu7vc1uj/CsiUDqPneNfeiBnoFmOmTU+LVW/imu5lP2wDhtJyV
         OSynCrsAa3wZh51Pt7CBfKMzJEzc5CdYqOTqVUqFjqEY7qo+wHA7X4ugcUR6zqSVpENQ
         dr2BvkitEZoovpIW8ktyIyjJnr0TqUBAeHzvvLTdzs7QB9SvPXJHpQcWhNsq+HbxWxkk
         5Udi//JestJ+jiqGFCAH+qTY2GYs0xa4EQm4UI8fUZCc3k57GIDWANCpc4INytcRvl1D
         xUnMlzpsQ1qJ4URuq2ddyvapL0keDSNKO6PHz+mdXLbJOAja4FHCZjiQg+2J69IqFnDi
         cOSQ==
X-Gm-Message-State: AOAM5300CrCBUdl8u+ZVTqTdcE61PYa7Aq8DdQwUs8MQrWHlE1NFgkMx
        2Islx2mHZCOZRs6oSmXz1PVZPrmpPzfbVX5AChDjCQ==
X-Google-Smtp-Source: ABdhPJxPYevznrszZ8GNHJjcEGFaIq9f8IvfrsbX2N9xLULjb/nfyVjKe9RE/B36Ww0j7vKCzbdH8+rhDJrMn8M9kr4=
X-Received: by 2002:a17:902:b416:b029:dc:3657:9265 with SMTP id
 x22-20020a170902b416b02900dc36579265mr8732224plr.24.1610019520708; Thu, 07
 Jan 2021 03:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com> <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz> <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz>
In-Reply-To: <20210107111827.GG13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 19:38:00 +0800
Message-ID: <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 7:18 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-01-21 16:53:13, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 4:41 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 07-01-21 13:39:38, Muchun Song wrote:
> > > > On Thu, Jan 7, 2021 at 12:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 06-01-21 16:47:36, Muchun Song wrote:
> > > > > > There is a race condition between __free_huge_page()
> > > > > > and dissolve_free_huge_page().
> > > > > >
> > > > > > CPU0:                         CPU1:
> > > > > >
> > > > > > // page_count(page) == 1
> > > > > > put_page(page)
> > > > > >   __free_huge_page(page)
> > > > > >                               dissolve_free_huge_page(page)
> > > > > >                                 spin_lock(&hugetlb_lock)
> > > > > >                                 // PageHuge(page) && !page_count(page)
> > > > > >                                 update_and_free_page(page)
> > > > > >                                 // page is freed to the buddy
> > > > > >                                 spin_unlock(&hugetlb_lock)
> > > > > >     spin_lock(&hugetlb_lock)
> > > > > >     clear_page_huge_active(page)
> > > > > >     enqueue_huge_page(page)
> > > > > >     // It is wrong, the page is already freed
> > > > > >     spin_unlock(&hugetlb_lock)
> > > > > >
> > > > > > The race windows is between put_page() and spin_lock() which
> > > > > > is in the __free_huge_page().
> > > > >
> > > > > The race window reall is between put_page and dissolve_free_huge_page.
> > > > > And the result is that the put_page path would clobber an unrelated page
> > > > > (either free or already reused page) which is quite serious.
> > > > > Fortunatelly pages are dissolved very rarely. I believe that user would
> > > > > require to be privileged to hit this by intention.
> > > > >
> > > > > > We should make sure that the page is already on the free list
> > > > > > when it is dissolved.
> > > > >
> > > > > Another option would be to check for PageHuge in __free_huge_page. Have
> > > > > you considered that rather than add yet another state? The scope of the
> > > > > spinlock would have to be extended. If that sounds more tricky then can
> > > > > we check the page->lru in the dissolve path? If the page is still
> > > > > PageHuge and reference count 0 then there shouldn't be many options
> > > > > where it can be queued, right?
> > > >
> > > > Did you mean that we iterate over the free list to check whether
> > > > the page is on the free list?
> > >
> > > No I meant to check that the page is enqueued which along with ref count
> > > = 0 should mean it has been released to the pool unless I am missing
> > > something.
> >
> > The page can be on the free list or active list or empty when it
> > is freed to the pool. How to check whether it is on the free list?
>
> As I've said, I might be missing something here. But if the page is
> freed why does it matter whether it is on a active list or free list
> from the dissolve operation POV?

As you said "check the page->lru". I have a question.
How to check the page->lru in the dissolve path?

BTW, dissolve_free_huge_page aims to free the page
to buddy allocator. put_page (for HugeTLB page) aims
to free the page to the hugepage pool.

> --
> Michal Hocko
> SUSE Labs
