Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300722C1372
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgKWSgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:36:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbgKWSgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:36:01 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DA12078E;
        Mon, 23 Nov 2020 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606156560;
        bh=FZugMw/Hog6jEeQy+QszK3Ewi0gPdbcIiChWPVuppDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJRxc3FThC4AXXQDGd4ySKR1IZkIlI7DzUiFQldSiKAjLI2HAtTPmK5MPZKOrorz3
         x1Zh1MdqtAPgOUgE9Ho3vR7dQq6ZnDBqCFbwg77D/fnnUal1k6Max/JTL8kr9GuTdx
         Ot2iTXuZ80JCwSsItHl9ALlh1HQ7kpo2oU0A8L04=
Date:   Mon, 23 Nov 2020 18:35:55 +0000
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
Message-ID: <20201123183554.GC11688@willie-the-truck>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-7-will@kernel.org>
 <20201120204005.GC1303870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120204005.GC1303870@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:40:05PM -0700, Yu Zhao wrote:
> On Fri, Nov 20, 2020 at 02:35:57PM +0000, Will Deacon wrote:
> > clear_refs_write() uses the 'fullmm' API for invalidating TLBs after
> > updating the page-tables for the current mm. However, since the mm is not
> > being freed, this can result in stale TLB entries on architectures which
> > elide 'fullmm' invalidation.
> > 
> > Ensure that TLB invalidation is performed after updating soft-dirty
> > entries via clear_refs_write() by using the non-fullmm API to MMU gather.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  fs/proc/task_mmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index a76d339b5754..316af047f1aa 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1238,7 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
> >  			count = -EINTR;
> >  			goto out_mm;
> >  		}
> > -		tlb_gather_mmu_fullmm(&tlb, mm);
> > +		tlb_gather_mmu(&tlb, mm, 0, TASK_SIZE);
> 
> Let's assume my reply to patch 4 is wrong, and therefore we still need
> tlb_gather/finish_mmu() here. But then wouldn't this change deprive
> architectures other than ARM the opportunity to optimize based on the
> fact it's a full-mm flush?

Only for the soft-dirty case, but I think TLB invalidation is required
there because we are write-protecting the entries and I don't see any
mechanism to handle lazy invalidation for that (compared with the aging
case, which is handled via pte_accessible()).

Furthermore, If we decide that we can relax the TLB invalidation
requirements here, then I'd much rather than was done deliberately, rather
than as an accidental side-effect of another commit (since I think the
current behaviour was a consequence of 7a30df49f63a).

> It seems to me ARM's interpretation of tlb->fullmm is a special case,
> not the other way around.

Although I agree that this is subtle and error-prone (which is why I'm
trying to make the API more explicit here), it _is_ documented clearly
in asm-generic/tlb.h:

 *  - mmu_gather::fullmm
 *
 *    A flag set by tlb_gather_mmu() to indicate we're going to free
 *    the entire mm; this allows a number of optimizations.
 *
 *    - We can ignore tlb_{start,end}_vma(); because we don't
 *      care about ranges. Everything will be shot down.
 *
 *    - (RISC) architectures that use ASIDs can cycle to a new ASID
 *      and delay the invalidation until ASID space runs out.

Will
