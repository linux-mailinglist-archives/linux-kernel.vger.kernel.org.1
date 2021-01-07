Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2A2ECBD0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbhAGIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:39:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:42930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbhAGIju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:39:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610008743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQYJA161FO+WtN+WmtlN8WqtKfaE+baJDIobZAh3vs4=;
        b=l3e8ujeYMXJ406uKQricD3HzY6Xhvp/tozPgkpSREWLMQHgSAQrCvO4orefyNDKN7hroxY
        dT4DQXAZ91GA+FRcLyYMmxlQS+H67SWOE471gXIJRaUR+gtVKUouxD8O7bf6v1klIWfdg1
        6aOdgeTtBx5QHPiFA8pNbCB83MHDHGA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56C14ACAF;
        Thu,  7 Jan 2021 08:39:03 +0000 (UTC)
Date:   Thu, 7 Jan 2021 09:39:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2 4/6] mm: hugetlb: add return -EAGAIN
 for dissolve_free_huge_page
Message-ID: <20210107083902.GB13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-5-songmuchun@bytedance.com>
 <20210106170754.GU13207@dhcp22.suse.cz>
 <CAMZfGtWg0J5syATXMpP8RYOz=w0gJNYz_=UrT3ueMspQjNY7BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWg0J5syATXMpP8RYOz=w0gJNYz_=UrT3ueMspQjNY7BQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-01-21 11:11:41, Muchun Song wrote:
> On Thu, Jan 7, 2021 at 1:07 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 06-01-21 16:47:37, Muchun Song wrote:
> > > When dissolve_free_huge_page() races with __free_huge_page(), we can
> > > do a retry. Because the race window is small.
> >
> > Is this a bug fix or mere optimization. I have hard time to tell from
> > the description.
> 
> It is optimization. Thanks.
> 
> >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/hugetlb.c | 26 +++++++++++++++++++++-----
> > >  1 file changed, 21 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > [...]
> > > @@ -1825,6 +1828,14 @@ int dissolve_free_huge_page(struct page *page)
> > >       }
> > >  out:
> > >       spin_unlock(&hugetlb_lock);
> > > +
> > > +     /*
> > > +      * If the freeing of the HugeTLB page is put on a work queue, we should
> > > +      * flush the work before retrying.
> > > +      */
> > > +     if (unlikely(rc == -EAGAIN))
> > > +             flush_work(&free_hpage_work);
> >
> > Is it safe to wait for the work to finish from this context?
> 
> Yes. It is safe.

Please expand on why in the changelog. Same for the optimization
including some numbers showing it really helps.

-- 
Michal Hocko
SUSE Labs
