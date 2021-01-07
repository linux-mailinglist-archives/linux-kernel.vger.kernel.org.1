Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7194D2ECFF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbhAGMjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:39:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:49672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbhAGMjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:39:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610023137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GdQbHRgcTrLV+s8tOSTC0+gnYeXTLWNKeVshW9e36g=;
        b=qRlD/V3pYymE7Ir2MN6n6pHPjjRXoFR/SmTK5fttR+0xONeLyIjjFSPWIMO4eicsAgVydR
        iOaoGidjwCIFtVYNMLQzoWiVFOlQZH6AbzQpXxX1A5ylZDG4KMQLGRYniWx8NbnJt60s8l
        ooSWv/M8BlvbEunl5nIQUEVGzdoEc18=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 491FDACAF;
        Thu,  7 Jan 2021 12:38:57 +0000 (UTC)
Date:   Thu, 7 Jan 2021 13:38:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
Message-ID: <20210107123854.GJ13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com>
 <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz>
 <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz>
 <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-01-21 19:38:00, Muchun Song wrote:
> On Thu, Jan 7, 2021 at 7:18 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 07-01-21 16:53:13, Muchun Song wrote:
> > > On Thu, Jan 7, 2021 at 4:41 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 07-01-21 13:39:38, Muchun Song wrote:
> > > > > On Thu, Jan 7, 2021 at 12:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Wed 06-01-21 16:47:36, Muchun Song wrote:
> > > > > > > There is a race condition between __free_huge_page()
> > > > > > > and dissolve_free_huge_page().
> > > > > > >
> > > > > > > CPU0:                         CPU1:
> > > > > > >
> > > > > > > // page_count(page) == 1
> > > > > > > put_page(page)
> > > > > > >   __free_huge_page(page)
> > > > > > >                               dissolve_free_huge_page(page)
> > > > > > >                                 spin_lock(&hugetlb_lock)
> > > > > > >                                 // PageHuge(page) && !page_count(page)
> > > > > > >                                 update_and_free_page(page)
> > > > > > >                                 // page is freed to the buddy
> > > > > > >                                 spin_unlock(&hugetlb_lock)
> > > > > > >     spin_lock(&hugetlb_lock)
> > > > > > >     clear_page_huge_active(page)
> > > > > > >     enqueue_huge_page(page)
> > > > > > >     // It is wrong, the page is already freed
> > > > > > >     spin_unlock(&hugetlb_lock)
> > > > > > >
> > > > > > > The race windows is between put_page() and spin_lock() which
> > > > > > > is in the __free_huge_page().
> > > > > >
> > > > > > The race window reall is between put_page and dissolve_free_huge_page.
> > > > > > And the result is that the put_page path would clobber an unrelated page
> > > > > > (either free or already reused page) which is quite serious.
> > > > > > Fortunatelly pages are dissolved very rarely. I believe that user would
> > > > > > require to be privileged to hit this by intention.
> > > > > >
> > > > > > > We should make sure that the page is already on the free list
> > > > > > > when it is dissolved.
> > > > > >
> > > > > > Another option would be to check for PageHuge in __free_huge_page. Have
> > > > > > you considered that rather than add yet another state? The scope of the
> > > > > > spinlock would have to be extended. If that sounds more tricky then can
> > > > > > we check the page->lru in the dissolve path? If the page is still
> > > > > > PageHuge and reference count 0 then there shouldn't be many options
> > > > > > where it can be queued, right?
> > > > >
> > > > > Did you mean that we iterate over the free list to check whether
> > > > > the page is on the free list?
> > > >
> > > > No I meant to check that the page is enqueued which along with ref count
> > > > = 0 should mean it has been released to the pool unless I am missing
> > > > something.
> > >
> > > The page can be on the free list or active list or empty when it
> > > is freed to the pool. How to check whether it is on the free list?
> >
> > As I've said, I might be missing something here. But if the page is
> > freed why does it matter whether it is on a active list or free list
> > from the dissolve operation POV?
> 
> As you said "check the page->lru". I have a question.
> How to check the page->lru in the dissolve path?

list_empty?
 
> BTW, dissolve_free_huge_page aims to free the page
> to buddy allocator. put_page (for HugeTLB page) aims
> to free the page to the hugepage pool.

Right. Can we simply back off in the dissolving path when ref count is
0 && PageHuge() if list_empty(page->lru)? Is there any other scenario
when the all above is true and the page is not being freed?
-- 
Michal Hocko
SUSE Labs
