Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969632EF1BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbhAHMFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:05:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:35210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbhAHMFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:05:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610107462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cxt4elwiduxYGwhS5P7rMAog2VRT9vUyx01asODV6c=;
        b=Xr0nQSIXNNiSaOOzj3iFonNGtiCnASx4aursLYuELx2gm7kL62QjX9P9yImQx8l3Zw4l9z
        Q+oN7UBQfhRo4uBuG6SSWyAPKFsVEem5sM2f5ThTe+0CeR3B0jKNgvd0Vd45GRtd9K7rC2
        sfsOkjQIIjMNTaKAzx5b6S5ItJ07pg8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9C5DACAF;
        Fri,  8 Jan 2021 12:04:22 +0000 (UTC)
Date:   Fri, 8 Jan 2021 13:04:21 +0100
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
Message-ID: <20210108120421.GC13207@dhcp22.suse.cz>
References: <20210107123854.GJ13207@dhcp22.suse.cz>
 <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz>
 <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
 <20210108084330.GW13207@dhcp22.suse.cz>
 <CAMZfGtUy740SbsCW_h1NaP5O=ahSZniezkC+62pxZ5bW+vZpBg@mail.gmail.com>
 <20210108093136.GY13207@dhcp22.suse.cz>
 <CAMZfGtXhMDjw=C8XBUwsQLD7ZLv5osoLWy+RJzqY11WFm07GwQ@mail.gmail.com>
 <20210108114411.GZ13207@dhcp22.suse.cz>
 <CAMZfGtVc5dAYY_sPywi=BzfA92erqNn6O0X=0_k7sX2Xh1NC=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVc5dAYY_sPywi=BzfA92erqNn6O0X=0_k7sX2Xh1NC=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-01-21 19:52:54, Muchun Song wrote:
> On Fri, Jan 8, 2021 at 7:44 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 08-01-21 18:08:57, Muchun Song wrote:
> > > On Fri, Jan 8, 2021 at 5:31 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 08-01-21 17:01:03, Muchun Song wrote:
> > > > > On Fri, Jan 8, 2021 at 4:43 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Thu 07-01-21 23:11:22, Muchun Song wrote:
> > > > [..]
> > > > > > > But I find a tricky problem to solve. See free_huge_page().
> > > > > > > If we are in non-task context, we should schedule a work
> > > > > > > to free the page. We reuse the page->mapping. If the page
> > > > > > > is already freed by the dissolve path. We should not touch
> > > > > > > the page->mapping. So we need to check PageHuge().
> > > > > > > The check and llist_add() should be protected by
> > > > > > > hugetlb_lock. But we cannot do that. Right? If dissolve
> > > > > > > happens after it is linked to the list. We also should
> > > > > > > remove it from the list (hpage_freelist). It seems to make
> > > > > > > the thing more complex.
> > > > > >
> > > > > > I am not sure I follow you here but yes PageHuge under hugetlb_lock
> > > > > > should be the reliable way to check for the race. I am not sure why we
> > > > > > really need to care about mapping or other state.
> > > > >
> > > > > CPU0:                               CPU1:
> > > > > free_huge_page(page)
> > > > >   if (PageHuge(page))
> > > > >                                     dissolve_free_huge_page(page)
> > > > >                                       spin_lock(&hugetlb_lock)
> > > > >                                       update_and_free_page(page)
> > > > >                                       spin_unlock(&hugetlb_lock)
> > > > >     llist_add(page->mapping)
> > > > >     // the mapping is corrupted
> > > > >
> > > > > The PageHuge(page) and llist_add() should be protected by
> > > > > hugetlb_lock. Right? If so, we cannot hold hugetlb_lock
> > > > > in free_huge_page() path.
> > > >
> > > > OK, I see. I completely forgot about this snowflake. I thought that
> > > > free_huge_page was a typo missing initial __. Anyway you are right that
> > > > this path needs a check as well. But I don't see why we couldn't use the
> > > > lock here. The lock can be held only inside the !in_task branch.
> > >
> > > Because we hold the hugetlb_lock without disable irq. So if an interrupt
> > > occurs after we hold the lock. And we also free a HugeTLB page. Then
> > > it leads to deadlock.
> >
> > There is nothing really to prevent making hugetlb_lock irq safe, isn't
> > it?
> 
> Yeah. We can make the hugetlb_lock irq safe. But why have we not
> done this? Maybe the commit changelog can provide more information.
> 
> See https://github.com/torvalds/linux/commit/c77c0a8ac4c522638a8242fcb9de9496e3cdbb2d

Dang! Maybe it is the time to finally stack one workaround on top of the
other and put this code into the shape. The amount of hackery and subtle
details has just grown beyond healthy!
-- 
Michal Hocko
SUSE Labs
