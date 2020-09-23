Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D421E275BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIWPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgIWPYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600874654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=THih3q8rN8IN69lQhJAECn7c4JXGJG1JCZBvWz4oPwQ=;
        b=IupRKRf6lczxuPt35SL/cVqH4uXd5K0WIlOUrb6fa2pnfFtdjSemJ4vPcBPYCCIVdRfdtp
        i1g36tDYiuTn4tpKQA66Dk01v2QIPFvx/CGhusFfd5LQaKxD3Lr34c8LAMZG8A27Vos/Pa
        3Ej9IhxgzxFEX+2VX1yxKHy1Vf5GWWI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-SOtfEq-oPVG1ggeCGF8oTQ-1; Wed, 23 Sep 2020 11:24:12 -0400
X-MC-Unique: SOtfEq-oPVG1ggeCGF8oTQ-1
Received: by mail-qv1-f69.google.com with SMTP id a13so262248qvl.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THih3q8rN8IN69lQhJAECn7c4JXGJG1JCZBvWz4oPwQ=;
        b=it4NTxZjtID4su0yzF5FWeSI/PEoPlgvi2kcb+uFGHxLaMQZcWC3oxsXBuvi5psMWM
         HtBEy38wvczjpnh0infCTEdtH/8h3MOtBZKBDxfA0gjLRVnMBp7Zdh0DzGUVFIL1tTDs
         Z/yHkYWsJip2/e8eFixMAjYeggC9UbNUsphykvDzFtTpHi7+szo9xXmKDjzw+NV/2yAc
         COuwnHUJjaveGLebz31SlwFurQEMU4lH9KBZxmOHRA5bQEBIZMIH1TEV9PLzy3Sl2Bu+
         3uj0L/IXac6oo0bBT+K67OnVOz6nKFmnC0nL4C+OEO9Y+Lln9SpCTyVS+BCBC1O4HBG+
         TEWA==
X-Gm-Message-State: AOAM531ycR7pk+JK9nJWQd0uDcR8HyEYePHCVoNdcjzXqM222c8qjLfT
        AHytmQKC/G+jF1Qdfe3XPfNariXlAv3v62NEUl9hwxr+mk5s2UeMaL7NP1mIXNxomSS3fYSflyG
        +1qjAhrjz9RSBK0jW1jT5f5m9
X-Received: by 2002:aed:2414:: with SMTP id r20mr576078qtc.304.1600874652040;
        Wed, 23 Sep 2020 08:24:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS0r92AN+fmomEBf3kneVEJMKrgIwaeAWIUoH+Uj/5g7AMC/zJGvS5RfjZMt+cw4U3k/bCLA==
X-Received: by 2002:aed:2414:: with SMTP id r20mr576035qtc.304.1600874651662;
        Wed, 23 Sep 2020 08:24:11 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id g4sm50423qth.30.2020.09.23.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:24:10 -0700 (PDT)
Date:   Wed, 23 Sep 2020 11:24:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
Message-ID: <20200923152409.GC59978@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <20200922120505.GH8409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922120505.GH8409@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:05:05AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 21, 2020 at 05:20:31PM -0400, Peter Xu wrote:
> > Pinned pages shouldn't be write-protected when fork() happens, because follow
> > up copy-on-write on these pages could cause the pinned pages to be replaced by
> > random newly allocated pages.
> > 
> > For huge PMDs, we split the huge pmd if pinning is detected.  So that future
> > handling will be done by the PTE level (with our latest changes, each of the
> > small pages will be copied).  We can achieve this by let copy_huge_pmd() return
> > -EAGAIN for pinned pages, so that we'll fallthrough in copy_pmd_range() and
> > finally land the next copy_pte_range() call.
> > 
> > Huge PUDs will be even more special - so far it does not support anonymous
> > pages.  But it can actually be done the same as the huge PMDs even if the split
> > huge PUDs means to erase the PUD entries.  It'll guarantee the follow up fault
> > ins will remap the same pages in either parent/child later.
> > 
> > This might not be the most efficient way, but it should be easy and clean
> > enough.  It should be fine, since we're tackling with a very rare case just to
> > make sure userspaces that pinned some thps will still work even without
> > MADV_DONTFORK and after they fork()ed.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >  mm/huge_memory.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 7ff29cc3d55c..c40aac0ad87e 100644
> > +++ b/mm/huge_memory.c
> > @@ -1074,6 +1074,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  
> >  	src_page = pmd_page(pmd);
> >  	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
> > +
> > +	/*
> > +	 * If this page is a potentially pinned page, split and retry the fault
> > +	 * with smaller page size.  Normally this should not happen because the
> > +	 * userspace should use MADV_DONTFORK upon pinned regions.  This is a
> > +	 * best effort that the pinned pages won't be replaced by another
> > +	 * random page during the coming copy-on-write.
> > +	 */
> > +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > +		     page_maybe_dma_pinned(src_page))) {
> > +		pte_free(dst_mm, pgtable);
> > +		spin_unlock(src_ptl);
> > +		spin_unlock(dst_ptl);
> > +		__split_huge_pmd(vma, src_pmd, addr, false, NULL);
> > +		return -EAGAIN;
> > +	}
> 
> Not sure why, but the PMD stuff here is not calling is_cow_mapping()
> before doing the write protect. Seems like it might be an existing
> bug?

IMHO it's not a bug, because splitting a huge pmd should always be safe.

One thing I can think of that might be special here is when the pmd is
anonymously mapped but also shared (shared, tmpfs thp, I think?), then here
we'll also mark it as wrprotected even if we don't need to (or maybe we need it
for some reason..).  But again I think it's safe anyways - when page fault
happens, wp_huge_pmd() should split it into smaller pages unconditionally.  I
just don't know whether it's the ideal way for the shared case.  Andrea should
definitely know it better (because it is there since the 1st day of thp).

> 
> In any event, the has_pinned logic shouldn't be used without also
> checking is_cow_mapping(), so it should be added to that test. Same
> remarks for PUD

I think the case mentioned above is also the special case here when we didn't
check is_cow_mapping().  The major difference is whether we'll split the page
right now, or postpone it until the next write to each mm.  But I think, yes,
maybe I should better still keep the is_cow_mapping() to be explicit.

Thanks,

-- 
Peter Xu

