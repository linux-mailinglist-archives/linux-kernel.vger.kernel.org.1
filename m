Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C16275E72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIWRR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:17:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AAAC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:17:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d20so443031qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wl0emuuFRwoMzXPU5qqXsiLAXTaoY16tfftIB0J40yc=;
        b=Ys6gPy1Opv7AG5/OZGbTnnJ4aTIMUptrJ823f9T2F0WoCv9W8/JCX+id1o3hVRzwpC
         gjc1Zz8Mb2st11gJuWOjOv3XpS3MP6aine2VKPdv56KIHPaxpgGedieMqguS6p5lphQP
         +7m1GFiHq7pJaN0Oio5vWW+QdOcxZ+7XJEu766Kc1lwYQRH/b2xLdQSkaXjoD6+dV6bo
         vCC5v9HFcbzjHQZeFxQAYugNp6d1GmouVdMuaKvFMvfX8NobD9tMbCsbUmUEZ5pTJ7Cp
         nlqa+aA5Ayy9SE/N1DqOc/Nzzv44UWtrfKjcE1zYdMgsLwTdjh9Jp3FhJe+X4xTPjQVJ
         gkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wl0emuuFRwoMzXPU5qqXsiLAXTaoY16tfftIB0J40yc=;
        b=jpONkVAtvTCtpinhH1eCuIQwtKvvAhcFJs+040ow/1RFOl5slrxIS+bCcMUCDJaGl6
         xHutf0QpWbRJ0czUBhe/QwsLzUQWSV+/OS8xWcpL74Nou1sHwxwSINZ1U9PP0ZZNKW+7
         rpf8O93hS8wnmUpxQyaME3KBoSKhDY6s6rwJ6mQ5OQDTU2nFe/XQBwGAfL9OVo2TF1wp
         KT9lZdpUfMpP1mP6D0vbOxa9PSarZcIziQ8fPbeqmMzemduQh3pk1jD/Bpgts7qQD8G7
         JlfOK0HpXL8qikKPyRE8sHFPNot9B5W+kBCmS1Q5n2/Imla7swtyysog0KDZTEHhpnFu
         DliQ==
X-Gm-Message-State: AOAM5338BtXXgXx8LI309G3O5ypEsrigPOBIBnwP2nhptFbLd1bbB4F6
        0PKbP8UGT1b46UCJNB64llP/Bw==
X-Google-Smtp-Source: ABdhPJyI1/lwDDielu1D4kgmt6C4Q19oPeKwKlpkm8/fdeNQjqvcEC8zn1HFA9gxbcoYMabTg/mRTg==
X-Received: by 2002:a37:4711:: with SMTP id u17mr885282qka.54.1600881478432;
        Wed, 23 Sep 2020 10:17:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k20sm290184qtb.34.2020.09.23.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 10:17:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kL8Oy-0006Rh-T9; Wed, 23 Sep 2020 14:17:56 -0300
Date:   Wed, 23 Sep 2020 14:17:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200923171756.GC9916@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <20200922120505.GH8409@ziepe.ca>
 <20200923152409.GC59978@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923152409.GC59978@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:24:09AM -0400, Peter Xu wrote:
> On Tue, Sep 22, 2020 at 09:05:05AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 21, 2020 at 05:20:31PM -0400, Peter Xu wrote:
> > > Pinned pages shouldn't be write-protected when fork() happens, because follow
> > > up copy-on-write on these pages could cause the pinned pages to be replaced by
> > > random newly allocated pages.
> > > 
> > > For huge PMDs, we split the huge pmd if pinning is detected.  So that future
> > > handling will be done by the PTE level (with our latest changes, each of the
> > > small pages will be copied).  We can achieve this by let copy_huge_pmd() return
> > > -EAGAIN for pinned pages, so that we'll fallthrough in copy_pmd_range() and
> > > finally land the next copy_pte_range() call.
> > > 
> > > Huge PUDs will be even more special - so far it does not support anonymous
> > > pages.  But it can actually be done the same as the huge PMDs even if the split
> > > huge PUDs means to erase the PUD entries.  It'll guarantee the follow up fault
> > > ins will remap the same pages in either parent/child later.
> > > 
> > > This might not be the most efficient way, but it should be easy and clean
> > > enough.  It should be fine, since we're tackling with a very rare case just to
> > > make sure userspaces that pinned some thps will still work even without
> > > MADV_DONTFORK and after they fork()ed.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > >  mm/huge_memory.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 7ff29cc3d55c..c40aac0ad87e 100644
> > > +++ b/mm/huge_memory.c
> > > @@ -1074,6 +1074,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > >  
> > >  	src_page = pmd_page(pmd);
> > >  	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
> > > +
> > > +	/*
> > > +	 * If this page is a potentially pinned page, split and retry the fault
> > > +	 * with smaller page size.  Normally this should not happen because the
> > > +	 * userspace should use MADV_DONTFORK upon pinned regions.  This is a
> > > +	 * best effort that the pinned pages won't be replaced by another
> > > +	 * random page during the coming copy-on-write.
> > > +	 */
> > > +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > > +		     page_maybe_dma_pinned(src_page))) {
> > > +		pte_free(dst_mm, pgtable);
> > > +		spin_unlock(src_ptl);
> > > +		spin_unlock(dst_ptl);
> > > +		__split_huge_pmd(vma, src_pmd, addr, false, NULL);
> > > +		return -EAGAIN;
> > > +	}
> > 
> > Not sure why, but the PMD stuff here is not calling is_cow_mapping()
> > before doing the write protect. Seems like it might be an existing
> > bug?
> 
> IMHO it's not a bug, because splitting a huge pmd should always be safe.

Sur splitting is safe, but testing has_pinned without checking COW is
not, for what Jann explained.

The 'maybe' in page_maybe_dma_pinned() means it can return true when
the correct answer is false. It can never return false when the
correct answer is true.

It is the same when has_pinned is involved, the combined expression
must never return false when true is correct. Which means it can only
be applied for COW cases.

Jason
