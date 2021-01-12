Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3F32F2DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhALLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:12:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:37492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbhALLMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:12:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610449920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SLoDNhBUdSDMcP6iU4R03aym66aFwh1Goh2QyEmwdIM=;
        b=S2UjnckBn4MijEAR4w2BIEE7fzJnESgkVgkAKfG6kkUAiAIH+sMeBLcO04n2PCuGSFlj6T
        tEKiLml2HM77D354bQKchgXu4G5oPQ6RABtYqCGoGOK8iuDG7ryol/Yo2oap2eL+QXDYhb
        wIr4guscwjoC5gQ8FBZ7rXZNapi+H1o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FAE1AD18;
        Tue, 12 Jan 2021 11:12:00 +0000 (UTC)
Date:   Tue, 12 Jan 2021 12:11:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v3 4/6] mm: hugetlb: add return -EAGAIN
 for dissolve_free_huge_page
Message-ID: <20210112111158.GM22493@dhcp22.suse.cz>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-5-songmuchun@bytedance.com>
 <c61cdf1d-2feb-ecb3-393d-ca25175c73f4@oracle.com>
 <20210112083335.GH22493@dhcp22.suse.cz>
 <CAMZfGtVCntwNM=2RHHp=qDLN3L71ouQy=9V_e=VTNHtCDHsmWA@mail.gmail.com>
 <20210112100602.GL22493@dhcp22.suse.cz>
 <CAMZfGtVvrMegtXhZbPxgX_6ryJGoU6B64coLkBBUe4yf0jG-9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVvrMegtXhZbPxgX_6ryJGoU6B64coLkBBUe4yf0jG-9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-01-21 18:49:17, Muchun Song wrote:
> On Tue, Jan 12, 2021 at 6:06 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 12-01-21 17:51:05, Muchun Song wrote:
> > > On Tue, Jan 12, 2021 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 11-01-21 17:20:51, Mike Kravetz wrote:
> > > > > On 1/10/21 4:40 AM, Muchun Song wrote:
> > > > > > There is a race between dissolve_free_huge_page() and put_page(),
> > > > > > and the race window is quite small. Theoretically, we should return
> > > > > > -EBUSY when we encounter this race. In fact, we have a chance to
> > > > > > successfully dissolve the page if we do a retry. Because the race
> > > > > > window is quite small. If we seize this opportunity, it is an
> > > > > > optimization for increasing the success rate of dissolving page.
> > > > > >
> > > > > > If we free a HugeTLB page from a non-task context, it is deferred
> > > > > > through a workqueue. In this case, we need to flush the work.
> > > > > >
> > > > > > The dissolve_free_huge_page() can be called from memory hotplug,
> > > > > > the caller aims to free the HugeTLB page to the buddy allocator
> > > > > > so that the caller can unplug the page successfully.
> > > > > >
> > > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > > ---
> > > > > >  mm/hugetlb.c | 26 +++++++++++++++++++++-----
> > > > > >  1 file changed, 21 insertions(+), 5 deletions(-)
> > > > >
> > > > > I am unsure about the need for this patch.  The code is OK, there are no
> > > > > issues with the code.
> > > > >
> > > > > As mentioned in the commit message, this is an optimization and could
> > > > > potentially cause a memory offline operation to succeed instead of fail.
> > > > > However, we are very unlikely to ever exercise this code.  Adding an
> > > > > optimization that is unlikely to be exercised is certainly questionable.
> > > > >
> > > > > Memory offline is the only code that could benefit from this optimization.
> > > > > As someone with more memory offline user experience, what is your opinion
> > > > > Michal?
> > > >
> > > > I am not a great fun of optimizations without any data to back them up.
> > > > I do not see any sign this code has been actually tested and the
> > > > condition triggered.
> > >
> > > This race is quite small. I only trigger this only once on my server.
> > > And then the kernel panic. So I sent this patch series to fix some
> > > bugs.
> >
> > Memory hotplug shouldn't panic when this race happens. Are you sure you
> > have seen a race that is directly related to this patch?
> 
> I mean the panic is fixed by:
> 
>   [PATCH v3 3/6] mm: hugetlb: fix a race between freeing and dissolving the page

OK, so the answer is that this is not really triggered by any real life
problem. Can you actually trigger it intentionally?
 
> > > > Besides that I have requested to have an explanation of why blocking on
> > > > the WQ is safe and that hasn't happened.
> > >
> > > I have seen all the caller of dissolve_free_huge_page, some caller is under
> > > page lock (via lock_page). Others are also under a sleep context.
> > >
> > > So I think that blocking on the WQ is safe. Right?
> >
> > I have requested to explicitly write your thinking why this is safe so
> > that we can double check it. Dependency on a work queue progress is much
> > more complex than any other locks because there is no guarantee that WQ
> > will make forward progress (all workers might be stuck, new workers not
> > able to be created etc.).
> 
> OK. I know about your concern. How about setting the page as temporary
> when hitting this race?
> 
>  int dissolve_free_huge_page(struct page *page)
>  {
> @@ -1793,8 +1794,10 @@ int dissolve_free_huge_page(struct page *page)
>                  * We should make sure that the page is already on the free list
>                  * when it is dissolved.
>                  */
> -               if (unlikely(!PageHugeFreed(head)))
> +               if (unlikely(!PageHugeFreed(head))) {
> +                       SetPageHugeTemporary(page)
>                         goto out;
> +               }
> 
> Setting the page as temporary and just return -EBUSY (do not flush
> the work). __free_huge_page() will free it to the buddy allocator later.

Can we stop these subtle hacks please? Temporary page is meant to
represent unaccounted temporary page for migration. This has nothing to
do with it.
-- 
Michal Hocko
SUSE Labs
