Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A538F2F2E16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbhALLgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbhALLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:36:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:35:29 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id be12so1265849plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QLLdsmjlUXD8ZcmN6OfppjkNNypBTtU+sGe4+bM98Y=;
        b=HatddMj3Nb+5ix0xm5HiDy9AAbfoiZeBVH4pXzG70aFjUn13J/ansi0iyM9h8zgV9B
         5Jf0XMRvh3nkOq9KyGKbPR9eoqf95+ZUlAvzEA3z6qDQ89RR8dDxqarfbXvIs6oemqQU
         itw2ayQ2h9cb49gWKsJiTJ04zZ28AXwMtTfDU1Fm72BzYX6Hew1QaLZsg6Exah+G2qdN
         b0WfiVOlqbIH+UHi4ObUPbDppUuAM3Pkh1Ihs4FfMW9uQt6BFKkTFpSiBKKk9wFz5qWU
         O9u4nl2hEGA9taENgivAmW3tKE69I7DMk5p2NOP8p2RVSkvFcGkVVb0ERZqqwaTFfAed
         zXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QLLdsmjlUXD8ZcmN6OfppjkNNypBTtU+sGe4+bM98Y=;
        b=VynYDjbsWeJaUmS1EULYX8Ol0A7Q9/+JMDYx0vin8yRVwMA9lcS136rN0EmEwJInSd
         gaKncff+3xwppYzQqrJD10iQHVdvRooczCw3wMtvVIaip9LzN9xtKoKCyHY2k2yBMRV1
         wcSUHX9UkTBjue+6oIia0bFX255rXQ94utY730svfytOoE0Jd9pgI1h5RlzPL3vn1+Zl
         g8i4qcQxuDlNGi1u1VHvSZHqUxTjS8NhxBl92yx2OmR166F3ob76vyFiaIep3ZipOALt
         27/BdTMhMCkT61A0/ZkpEMc0F//qqXQkuQZTTQI2BdgmJhBr4HfJsHReWB4R6KYV0NA+
         D++A==
X-Gm-Message-State: AOAM531RE9VlMyOFvdeWZn30Hztwo+DclzmmNguwVF30c6W/ws8F6Nca
        uQ1AdvlRmadMNlNkAEX1MKC7GA+eaxC8/D8iAuORvA==
X-Google-Smtp-Source: ABdhPJxx1CVCheR6Stp3vqmoxoihh85LIgzCfQUCw04RbIpBz5X+OfH/Fs4Vj4t2NU/KXdMU/qKfpjoBThxmeHzrUyw=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr4290338pjh.13.1610451329003;
 Tue, 12 Jan 2021 03:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-5-songmuchun@bytedance.com> <c61cdf1d-2feb-ecb3-393d-ca25175c73f4@oracle.com>
 <20210112083335.GH22493@dhcp22.suse.cz> <CAMZfGtVCntwNM=2RHHp=qDLN3L71ouQy=9V_e=VTNHtCDHsmWA@mail.gmail.com>
 <20210112100602.GL22493@dhcp22.suse.cz> <CAMZfGtVvrMegtXhZbPxgX_6ryJGoU6B64coLkBBUe4yf0jG-9A@mail.gmail.com>
 <20210112111158.GM22493@dhcp22.suse.cz>
In-Reply-To: <20210112111158.GM22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 19:34:45 +0800
Message-ID: <CAMZfGtXRRC-G=vOw9q=bCmyst=acXsM98A+u-v8ZVL8Nxi1h=g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
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

On Tue, Jan 12, 2021 at 7:12 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-01-21 18:49:17, Muchun Song wrote:
> > On Tue, Jan 12, 2021 at 6:06 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 12-01-21 17:51:05, Muchun Song wrote:
> > > > On Tue, Jan 12, 2021 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 11-01-21 17:20:51, Mike Kravetz wrote:
> > > > > > On 1/10/21 4:40 AM, Muchun Song wrote:
> > > > > > > There is a race between dissolve_free_huge_page() and put_page(),
> > > > > > > and the race window is quite small. Theoretically, we should return
> > > > > > > -EBUSY when we encounter this race. In fact, we have a chance to
> > > > > > > successfully dissolve the page if we do a retry. Because the race
> > > > > > > window is quite small. If we seize this opportunity, it is an
> > > > > > > optimization for increasing the success rate of dissolving page.
> > > > > > >
> > > > > > > If we free a HugeTLB page from a non-task context, it is deferred
> > > > > > > through a workqueue. In this case, we need to flush the work.
> > > > > > >
> > > > > > > The dissolve_free_huge_page() can be called from memory hotplug,
> > > > > > > the caller aims to free the HugeTLB page to the buddy allocator
> > > > > > > so that the caller can unplug the page successfully.
> > > > > > >
> > > > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > > > ---
> > > > > > >  mm/hugetlb.c | 26 +++++++++++++++++++++-----
> > > > > > >  1 file changed, 21 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > I am unsure about the need for this patch.  The code is OK, there are no
> > > > > > issues with the code.
> > > > > >
> > > > > > As mentioned in the commit message, this is an optimization and could
> > > > > > potentially cause a memory offline operation to succeed instead of fail.
> > > > > > However, we are very unlikely to ever exercise this code.  Adding an
> > > > > > optimization that is unlikely to be exercised is certainly questionable.
> > > > > >
> > > > > > Memory offline is the only code that could benefit from this optimization.
> > > > > > As someone with more memory offline user experience, what is your opinion
> > > > > > Michal?
> > > > >
> > > > > I am not a great fun of optimizations without any data to back them up.
> > > > > I do not see any sign this code has been actually tested and the
> > > > > condition triggered.
> > > >
> > > > This race is quite small. I only trigger this only once on my server.
> > > > And then the kernel panic. So I sent this patch series to fix some
> > > > bugs.
> > >
> > > Memory hotplug shouldn't panic when this race happens. Are you sure you
> > > have seen a race that is directly related to this patch?
> >
> > I mean the panic is fixed by:
> >
> >   [PATCH v3 3/6] mm: hugetlb: fix a race between freeing and dissolving the page
>
> OK, so the answer is that this is not really triggered by any real life
> problem. Can you actually trigger it intentionally?
>
> > > > > Besides that I have requested to have an explanation of why blocking on
> > > > > the WQ is safe and that hasn't happened.
> > > >
> > > > I have seen all the caller of dissolve_free_huge_page, some caller is under
> > > > page lock (via lock_page). Others are also under a sleep context.
> > > >
> > > > So I think that blocking on the WQ is safe. Right?
> > >
> > > I have requested to explicitly write your thinking why this is safe so
> > > that we can double check it. Dependency on a work queue progress is much
> > > more complex than any other locks because there is no guarantee that WQ
> > > will make forward progress (all workers might be stuck, new workers not
> > > able to be created etc.).
> >
> > OK. I know about your concern. How about setting the page as temporary
> > when hitting this race?
> >
> >  int dissolve_free_huge_page(struct page *page)
> >  {
> > @@ -1793,8 +1794,10 @@ int dissolve_free_huge_page(struct page *page)
> >                  * We should make sure that the page is already on the free list
> >                  * when it is dissolved.
> >                  */
> > -               if (unlikely(!PageHugeFreed(head)))
> > +               if (unlikely(!PageHugeFreed(head))) {
> > +                       SetPageHugeTemporary(page)
> >                         goto out;
> > +               }
> >
> > Setting the page as temporary and just return -EBUSY (do not flush
> > the work). __free_huge_page() will free it to the buddy allocator later.
>
> Can we stop these subtle hacks please? Temporary page is meant to
> represent unaccounted temporary page for migration. This has nothing to
> do with it.

Sure. Can drop this patch.

> --
> Michal Hocko
> SUSE Labs
