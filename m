Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D52C178D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgKWVR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgKWVR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:17:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4BE206B5;
        Mon, 23 Nov 2020 21:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606166276;
        bh=zbTKH20VVZucoaew5ZXWATj6gCGP2JnDyZG1DT3kGTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XY4IMJzjKhC2/RYHNdBmKxgJiiRAean7wQCa7lewSt3Xm56dKXrzNeJcNRGYORfpG
         YqWohL+HmE81nh3gpZWmE/tS9caSMs5+NeN2M6LFWR5uWAUH60m0S+dbgAPeckdjqG
         CGmFjwEV6GKCUIpGsgTkQzcW4hHbCAoSvVGmS5ms=
Date:   Mon, 23 Nov 2020 21:17:51 +0000
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
Message-ID: <20201123211750.GA12069@willie-the-truck>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-7-will@kernel.org>
 <20201120204005.GC1303870@google.com>
 <20201123183554.GC11688@willie-the-truck>
 <20201123200403.GA3888699@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123200403.GA3888699@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 01:04:03PM -0700, Yu Zhao wrote:
> On Mon, Nov 23, 2020 at 06:35:55PM +0000, Will Deacon wrote:
> > On Fri, Nov 20, 2020 at 01:40:05PM -0700, Yu Zhao wrote:
> > > On Fri, Nov 20, 2020 at 02:35:57PM +0000, Will Deacon wrote:
> > > > clear_refs_write() uses the 'fullmm' API for invalidating TLBs after
> > > > updating the page-tables for the current mm. However, since the mm is not
> > > > being freed, this can result in stale TLB entries on architectures which
> > > > elide 'fullmm' invalidation.
> > > > 
> > > > Ensure that TLB invalidation is performed after updating soft-dirty
> > > > entries via clear_refs_write() by using the non-fullmm API to MMU gather.
> > > > 
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > ---
> > > >  fs/proc/task_mmu.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index a76d339b5754..316af047f1aa 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -1238,7 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
> > > >  			count = -EINTR;
> > > >  			goto out_mm;
> > > >  		}
> > > > -		tlb_gather_mmu_fullmm(&tlb, mm);
> > > > +		tlb_gather_mmu(&tlb, mm, 0, TASK_SIZE);
> > > 
> > > Let's assume my reply to patch 4 is wrong, and therefore we still need
> > > tlb_gather/finish_mmu() here. But then wouldn't this change deprive
> > > architectures other than ARM the opportunity to optimize based on the
> > > fact it's a full-mm flush?
> 
> I double checked my conclusion on patch 4, and aside from a couple
> of typos, it still seems correct after the weekend.

I still need to digest that, but I would prefer that we restore the
invalidation first, and then have a subsequent commit to relax it. I find
it hard to believe that the behaviour in mainline at the moment is deliberate.

That is, I'm not against optimising this, but I'd rather get it "obviously
correct" first and the current code is definitely not that.

> > Only for the soft-dirty case, but I think TLB invalidation is required
> > there because we are write-protecting the entries and I don't see any
> > mechanism to handle lazy invalidation for that (compared with the aging
> > case, which is handled via pte_accessible()).
> 
> The lazy invalidation for that is done when we write-protect a page,
> not an individual PTE. When we do so, our decision is based on both
> the dirty bit and the writable bit on each PTE mapping this page. So
> we only need to make sure we don't lose both on a PTE. And we don't
> here.

Sorry, I don't follow what you're getting at here (page vs pte). Please can
you point me to the code you're referring to? The case I'm worried about is
code that holds sufficient locks (e.g. mmap_sem + ptl) finding an entry
where !pte_write() and assuming (despite pte_dirty()) that there can't be
any concurrent modifications to the mapped page. Granted, I haven't found
anything doing that, but I could not convince myself that it would be a bug
to write such code, either.

> > Furthermore, If we decide that we can relax the TLB invalidation
> > requirements here, then I'd much rather than was done deliberately, rather
> > than as an accidental side-effect of another commit (since I think the
> > current behaviour was a consequence of 7a30df49f63a).
> 
> Nope. tlb_gather/finish_mmu() should be added by b3a81d0841a9
> ("mm: fix KSM data corruption") in the first place.

Sure, but if you check out b3a81d0841a9 then you have a fullmm TLB
invalidation in tlb_finish_mmu(). 7a30df49f63a is what removed that, no?

Will
