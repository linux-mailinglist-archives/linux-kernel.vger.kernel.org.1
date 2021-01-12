Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF12F2A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405581AbhALIeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:34:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:40716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731870AbhALIeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:34:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610440416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFyuOPvxyGNop7uNDLj50gfban0pju4pNlEfxYtxhP4=;
        b=uluWLvun6anFgHoBGFQfFga5gMQmABwrLQKy9vuQsoYzcnkJNsc4bJNo3uYTkW5YiyUWzu
        y3kIDb87TPls7fy9lsYeDbvtmgibb9QSNiyVk03j+AHbCKV6bkhcs3xbF0/U72/ulGJyrx
        HYzy+BlZL8ps+ZSertRXAMJgmveBuBQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5D81ADC1;
        Tue, 12 Jan 2021 08:33:36 +0000 (UTC)
Date:   Tue, 12 Jan 2021 09:33:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
Message-ID: <20210112083335.GH22493@dhcp22.suse.cz>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-5-songmuchun@bytedance.com>
 <c61cdf1d-2feb-ecb3-393d-ca25175c73f4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61cdf1d-2feb-ecb3-393d-ca25175c73f4@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-01-21 17:20:51, Mike Kravetz wrote:
> On 1/10/21 4:40 AM, Muchun Song wrote:
> > There is a race between dissolve_free_huge_page() and put_page(),
> > and the race window is quite small. Theoretically, we should return
> > -EBUSY when we encounter this race. In fact, we have a chance to
> > successfully dissolve the page if we do a retry. Because the race
> > window is quite small. If we seize this opportunity, it is an
> > optimization for increasing the success rate of dissolving page.
> > 
> > If we free a HugeTLB page from a non-task context, it is deferred
> > through a workqueue. In this case, we need to flush the work.
> > 
> > The dissolve_free_huge_page() can be called from memory hotplug,
> > the caller aims to free the HugeTLB page to the buddy allocator
> > so that the caller can unplug the page successfully.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> I am unsure about the need for this patch.  The code is OK, there are no
> issues with the code.
> 
> As mentioned in the commit message, this is an optimization and could
> potentially cause a memory offline operation to succeed instead of fail.
> However, we are very unlikely to ever exercise this code.  Adding an
> optimization that is unlikely to be exercised is certainly questionable.
> 
> Memory offline is the only code that could benefit from this optimization.
> As someone with more memory offline user experience, what is your opinion
> Michal?

I am not a great fun of optimizations without any data to back them up.
I do not see any sign this code has been actually tested and the
condition triggered.

Besides that I have requested to have an explanation of why blocking on
the WQ is safe and that hasn't happened.
-- 
Michal Hocko
SUSE Labs
