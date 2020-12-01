Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C935E2CAE79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgLAVcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgLAVcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:32:20 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:31:40 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so3142676otc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EdSEejUBnam4KyFCA2TjLSdmd0XXpVEcrnOSSkBF68Q=;
        b=sAG5xQr7qlmjSN37qADpl74MFGzcH7BABaU2IWfaLP1zLlqQT0I92iszLrSfyLkEXP
         Z7JJH1ofw05227Sq/3nWvMDOfM2yO2whvCGVTEAoen2eBzCem0Y+MEtAialnapF6MJ0b
         xs6mDoXI6tK3SqWDQDXKeQAMmq/P3s458x+ZctIl9iVQo5npYpqdWoZxoXDeAn44uw6C
         FECN3OhUZLbq0R1dGrhBpoeUbt7Cchrdattlfky+vM8MNl24wIyJxURDCMXKi5v7F76Q
         RAauinVvRsvtZkMYm9HCcFbbQEMt9BP46a92+w3xujx2YRefKe7Hn/d7QuQsuT1WXTaF
         1Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EdSEejUBnam4KyFCA2TjLSdmd0XXpVEcrnOSSkBF68Q=;
        b=iBv4Sl9f8RrglYtlWp/QKn7H1SgFh+Dz3ABERU1PB1rS1agBnD932Ou2pkKG4NjJN2
         ZXeyG7y4Nt8fEqLWbCMUYMueTXyR/KDBnChTtgADbmk9mswms7e0ldyPbECNKpd4c5qF
         5ugD5ev6s/Wmv2ny8vrEOHU0tSUSzpQqOVz7sHB18qwuMb1KtckMTKdwLiPz2jiuYYTv
         rLl5wWVvpCVWE/DkgUDTyBIS+/yEeRvcVZvCdrcVz/SYsBjlaPhb4AquArpXunTpIuw7
         iqvWOSz1fAtmeyrVZnQshXfxSnxsGc6qdn0H637tTZzZ1hSHW8Y1cOEXuta89Y3RbP+s
         KwWQ==
X-Gm-Message-State: AOAM530eG05eLJYYY9/UIj1ZKGZ3Z/iFjNEp0YnpIkR3GElQz+a6WVRt
        /ZPBY1Pfc0tdWBqglh53r4wgNQE/LYAAMw==
X-Google-Smtp-Source: ABdhPJyvi63yAw5X1ZSHmGEKe+2zyCR/Uknn5yGRuOAm60Y2Z6gxegraZ26YYoF9Mu5J/tqrphChDg==
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr3178276otn.233.1606858299045;
        Tue, 01 Dec 2020 13:31:39 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k5sm238374oot.30.2020.12.01.13.31.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2020 13:31:38 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:31:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions
 on reads
In-Reply-To: <20201128152903.GK6573@xz-x1>
Message-ID: <alpine.LSU.2.11.2012011250070.1582@eggly.anvils>
References: <20201126222359.8120-1-peterx@redhat.com> <20201127122224.GX4327@casper.infradead.org> <X8Ga44uXHmzn/vB9@redhat.com> <20201128152903.GK6573@xz-x1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Nov 2020, Peter Xu wrote:
> On Fri, Nov 27, 2020 at 07:33:39PM -0500, Andrea Arcangeli wrote:
> 
> > Now it would be ok if filemap_map_pages re-filled the ptes, after they
> > were zapped the first time by fallocate, and then the fallocate would
> > zap them again before truncating the page, but I don't see a second
> > pte zap... there's just the below single call of unmap_mapping_range:
> > 
> > 		if ((u64)unmap_end > (u64)unmap_start)
> > 			unmap_mapping_range(mapping, unmap_start,
> > 					    1 + unmap_end - unmap_start, 0);
> > 		shmem_truncate_range(inode, offset, offset + len - 1);
> 
> IMHO the 2nd pte zap is inside shmem_truncate_range(), where we will call
> truncate_inode_page() then onto truncate_cleanup_page().

Correct.

> 
> Since we're at it, some more context: this is actually where I started to
> notice the issue, that we'll try to pre-unmap the whole region first before
> shmem_truncate_range().  The thing is shmem_truncate_range() will zap the ptes
> too, in an even safer way (with page lock held).  So before I came up with the
> current patch, I also tried below patch, and it also fixes the data corrupt
> issue:
> 
> -----8<-----
> diff --git a/mm/shmem.c b/mm/shmem.c
> index efa19e33e470..b275f401fe1f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2777,7 +2777,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>         inode_lock(inode);
>  
>         if (mode & FALLOC_FL_PUNCH_HOLE) {
> -               struct address_space *mapping = file->f_mapping;
>                 loff_t unmap_start = round_up(offset, PAGE_SIZE);
>                 loff_t unmap_end = round_down(offset + len, PAGE_SIZE) - 1;
>                 DECLARE_WAIT_QUEUE_HEAD_ONSTACK(shmem_falloc_waitq);
> @@ -2795,9 +2794,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>                 inode->i_private = &shmem_falloc;
>                 spin_unlock(&inode->i_lock);
>  
> -               if ((u64)unmap_end > (u64)unmap_start)
> -                       unmap_mapping_range(mapping, unmap_start,
> -                                           1 + unmap_end - unmap_start, 0);
>                 shmem_truncate_range(inode, offset, offset + len - 1);
>                 /* No need to unmap again: hole-punching leaves COWed pages */
> -----8<-----
>  
> Above code existed starting from the 1st day of shmem fallocate code, so I was
> thinking why we did that.  One reason could be for performance, since this
> pre-unmap of explicit unmap_mapping_range() will try to walk the page tables
> once rather than walking for every single page, so when the hole is huge it
> could benefit us since truncate_cleanup_page() is able to avoid those per-page
> walks then because page_mapped() could be more likely to be zero:
> 
> 	if (page_mapped(page)) {
> 		pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
> 		unmap_mapping_pages(mapping, page->index, nr, false);
> 	}
> 
> It would be good if Hugh can help confirm whether my understanding is correct,
> though..

Correct.  Code duplicated from mm/truncate.c, but with more comments
over there, in truncate_pagecache() and in truncate_pagecache_range().

> 
> As a summary, that's why I didn't try to remove the optimization (which fixes
> the issue too) but instead I tried to dissable fault around instead for uffd,
> which sounds a better thing to do.
> 
> > 
> > So looking at filemap_map_pages in shmem, I'm really wondering if the
> > non-uffd case is correct or not.
> > 
> > Do we end up with ptes pointing to non pagecache, so then the virtual
> > mapping is out of sync also with read/write syscalls that will then
> > allocate another shmem page out of sync of the ptes?

No, as you point out, the second pte zap, under page lock, keeps it safe.

> > 
> > If a real page fault happened instead of filemap_map_pages, the
> > shmem_fault() would block during fallocate punch hole by checking
> > inode->i_private, as the comment says:
> > 
> > 	 * So refrain from
> > 	 * faulting pages into the hole while it's being punched.
> > 
> > It's not immediately clear where filemap_map_pages refrains from
> > faulting pages into the hole while it's being punched... given it's
> > ignoring inode->i_private.

Please don't ever rely on that i_private business for correctness: as
more of the comment around "So refrain from" explains, it was added
to avoid a livelock with the trinity fuzzer, and I'd gladly delete
it all, if I could ever be confident that enough has changed in the
intervening years that it's no longer necessary.

It tends to prevent shmem faults racing hole punches in the same area
(without quite guaranteeing no race at all).  But without the livelock
issue, I'd just have gone on letting them race.  "Punch hole" ==
"Lose data" - though I can imagine that UFFD would like more control
over that.  Since map_pages is driven by faulting, it should already
be throttled too.

But Andrea in next mail goes on to see other issues with UFFD_WP
in relation to shmem swap, so this thread is probably dead now.
If there's a bit to spare for UFFD_WP in the anonymous swap entry,
then that bit should be usable for shmem too: but a shmem page
(and its swap entry) can be shared between many different users,
so I don't know whether that will make sense.

Hugh
