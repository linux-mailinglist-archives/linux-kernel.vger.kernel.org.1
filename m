Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0042C29B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbgKXObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730879AbgKXObX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:31:23 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A5420674;
        Tue, 24 Nov 2020 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606228282;
        bh=WaWppMIG8NAiAq7V+qNADnCdiZIDrftoIXt08JUDQtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0c8lBz+GXRBOkcNd0w3+6jEYH95WPuRaV6bjCmFiHj7Nun/UbRVFL3bi7+MH1oQz
         RXoNMAawD++gt5Hx7nc3O1fHR+a2ORou8kfcrYUXquz4390R8dTwkEQxAzj4btKT1l
         NeBMl7beDYNyFi1CuA6IzyPDq5hfegmU+EQ9STKA=
Date:   Tue, 24 Nov 2020 14:31:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] mm: proc: Avoid fullmm flush for young/dirty bit
 toggling
Message-ID: <20201124143116.GA13352@willie-the-truck>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-7-will@kernel.org>
 <20201120204005.GC1303870@google.com>
 <20201123183554.GC11688@willie-the-truck>
 <20201123200403.GA3888699@google.com>
 <20201123211750.GA12069@willie-the-truck>
 <20201124011334.GA140483@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124011334.GA140483@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 06:13:34PM -0700, Yu Zhao wrote:
> On Mon, Nov 23, 2020 at 09:17:51PM +0000, Will Deacon wrote:
> > On Mon, Nov 23, 2020 at 01:04:03PM -0700, Yu Zhao wrote:
> > > On Mon, Nov 23, 2020 at 06:35:55PM +0000, Will Deacon wrote:
> > > > On Fri, Nov 20, 2020 at 01:40:05PM -0700, Yu Zhao wrote:
> > > > > On Fri, Nov 20, 2020 at 02:35:57PM +0000, Will Deacon wrote:
> > > > > > clear_refs_write() uses the 'fullmm' API for invalidating TLBs after
> > > > > > updating the page-tables for the current mm. However, since the mm is not
> > > > > > being freed, this can result in stale TLB entries on architectures which
> > > > > > elide 'fullmm' invalidation.
> > > > > > 
> > > > > > Ensure that TLB invalidation is performed after updating soft-dirty
> > > > > > entries via clear_refs_write() by using the non-fullmm API to MMU gather.
> > > > > > 
> > > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > > > ---
> > > > > >  fs/proc/task_mmu.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > index a76d339b5754..316af047f1aa 100644
> > > > > > --- a/fs/proc/task_mmu.c
> > > > > > +++ b/fs/proc/task_mmu.c
> > > > > > @@ -1238,7 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
> > > > > >  			count = -EINTR;
> > > > > >  			goto out_mm;
> > > > > >  		}
> > > > > > -		tlb_gather_mmu_fullmm(&tlb, mm);
> > > > > > +		tlb_gather_mmu(&tlb, mm, 0, TASK_SIZE);
> > > > > 
> > > > > Let's assume my reply to patch 4 is wrong, and therefore we still need
> > > > > tlb_gather/finish_mmu() here. But then wouldn't this change deprive
> > > > > architectures other than ARM the opportunity to optimize based on the
> > > > > fact it's a full-mm flush?
> > > 
> > > I double checked my conclusion on patch 4, and aside from a couple
> > > of typos, it still seems correct after the weekend.
> > 
> > I still need to digest that, but I would prefer that we restore the
> > invalidation first, and then have a subsequent commit to relax it. I find
> > it hard to believe that the behaviour in mainline at the moment is deliberate.
> > 
> > That is, I'm not against optimising this, but I'd rather get it "obviously
> > correct" first and the current code is definitely not that.
> 
> I wouldn't mind having this patch and patch 4 if the invalidation they
> restore were in a correct state -- b3a81d0841a9 ("mm: fix KSM data
> corruption") isn't correct to start with.
> 
> It is complicated, so please bear with me. Let's study this by looking
> at examples this time.

Thanks for putting these together. If you're right, then it looks like it's
even worse than I thought :(

> > > > Only for the soft-dirty case, but I think TLB invalidation is required
> > > > there because we are write-protecting the entries and I don't see any
> > > > mechanism to handle lazy invalidation for that (compared with the aging
> > > > case, which is handled via pte_accessible()).
> > > 
> > > The lazy invalidation for that is done when we write-protect a page,
> > > not an individual PTE. When we do so, our decision is based on both
> > > the dirty bit and the writable bit on each PTE mapping this page. So
> > > we only need to make sure we don't lose both on a PTE. And we don't
> > > here.
> > 
> > Sorry, I don't follow what you're getting at here (page vs pte). Please can
> > you point me to the code you're referring to? The case I'm worried about is
> > code that holds sufficient locks (e.g. mmap_sem + ptl) finding an entry
> > where !pte_write() and assuming (despite pte_dirty()) that there can't be
> > any concurrent modifications to the mapped page. Granted, I haven't found
> > anything doing that, but I could not convince myself that it would be a bug
> > to write such code, either.
> 
> Example 1: memory corruption is still possible with patch 4 & 6
> 
>   CPU0        CPU1        CPU2        CPU3
>   ----        ----        ----        ----
>   userspace                           page writeback
> 
>   [cache writable
>    PTE in TLB]
> 
>               inc_tlb_flush_pending()
>               clean_record_pte()
>               pte_mkclean()

This path:      ^^^^^ looks a bit weird to me and I _think_ only happens
via some vmware DRM driver (i.e. the only caller of
clean_record_shared_mapping_range()). Are you sure that's operating on
pages that can be reclaimed? I have a feeling it might all be pinned.

>                           tlb_gather_mmu()
>                           [set mm_tlb_flush_pending()]
>                           clear_refs_write()
>                           pte_wrprotect()
> 
>                                       page_mkclean_one()
>                                       !pte_dirty() && !pte_write()
>                                       [true, no flush]
> 
>                                       write page to disk
> 
>   Write to page
>   [using stale PTE]
> 
>                                       drop clean page
>                                       [data integrity compromised]
> 
>               flush_tlb_range()
> 
>                           tlb_finish_mmu()
>                           [flush (with patch 4)]

Setting my earlier comment aside, I think a useful observation here
is that even with correct TLB invalidation, there is still a window
between modifying the page-table and flushing the TLB where another CPU
could see the updated page-table and incorrectly elide a flush. In these
cases we need to rely either on locking or use of tlb_flush_pending() to
ensure the correct behaviour.

> Example 2: why no flush when write-protecting is not a problem (after
> we fix the problem correctly by adding mm_tlb_flush_pending()).

So here you add an mm_tlb_flush_pending() check to the reclaim path
to resolve the race above.

> Case a:
> 
>   CPU0        CPU1        CPU2        CPU3
>   ----        ----        ----        ----
>   userspace                           page writeback
> 
>   [cache writable
>    PTE in TLB]
> 
>               inc_tlb_flush_pending()
>               clean_record_pte()
>               pte_mkclean()
> 
>                           clear_refs_write()
>                           pte_wrprotect()
> 
>                                       page_mkclean_one()
>                                       !pte_dirty() && !pte_write() &&
>                                       !mm_tlb_flush_pending()
>                                       [false: flush]
> 
>                                       write page to disk
> 
>   Write to page
>   [page fault]
> 
>                                       drop clean page
>                                       [data integrity guaranteed]
> 
>               flush_tlb_range()
> 
> Case b:
> 
>   CPU0        CPU1        CPU2
>   ----        ----        ----
>   userspace               page writeback
> 
>   [cache writable
>    PTE in TLB]
> 
>               clear_refs_write()
>               pte_wrprotect()
>               [pte_dirty() is false]
> 
>                           page_mkclean_one()
>                           !pte_dirty() && !pte_write() &&
>                           !mm_tlb_flush_pending()
>                           [true: no flush]
> 
>                           write page to disk
> 
>   Write to page
>   [h/w tries to set
>    the dirty bit
>    but sees write-
>    protected PTE,
>    page fault]

I agree with you for this example, but I think if the page writeback ran
on CPU 1 after clear_refs_write() then we could have a problem: the updated
pte could sit in the store buffer of CPU1 and the walker on CPU0 would
be able to set the dirty bit. TLB invalidation in clear_refs_write()
would prevent that.

Will
