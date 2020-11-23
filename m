Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76BA2C1471
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgKWTVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgKWTVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:21:21 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2936C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:21:21 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id t13so16974839ilp.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oz8metO46QbXJuy4PHB2Bj1tfr/+9gTKVTZ9NXLvTQM=;
        b=vaFqnXwZPjEvSJisaMdQytWcRMZg/6lN0E2LnGCrAWsIQ5+/uU8gOj1v5k/JebeKXc
         hYW6s6iiCXe1PLt2zd+4r7HgKnNE+9Ptsyw1iN3uZMBBIeAFZJ1/Kt31Us7a8NkTcxna
         wyIiYb0i5tbg1fveKnK6z5tLz2vJHpGkNRAhprU2BgmEwtAI8mHkeu3bUldOS05iVZP5
         LK+62kXbfePdrvCtf79iyUHb26mo+NB9Jull4XcxfAhlEQhU5Ux8MYK68yX8rOLZNqJg
         VS3QMTmh4WninUhXp5/2/52Fjx/D26yuHLT3xAtJ6QeGQYnmCiAgg0LSG5fYnaMpcOaa
         A2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oz8metO46QbXJuy4PHB2Bj1tfr/+9gTKVTZ9NXLvTQM=;
        b=AxXii48DX+foFuOEQN3GT76htgiwaXUfH9P/TNwKFHPmNJBZ/ZTvqIX62y5gHLwEuJ
         SR7Ycc1xtbQ6gng9PkalrCrlXh/xEQJJTkSUOaX4OFFPRyHzbR1GCx4t3q7Ieo19gJmH
         uxzEcEgcq3VLkK+p/x91+V5IRslmkxL5dohNlD5OQAofMM4DdXV2Plub/3VVLYiWmgeK
         amLo1GDLDGvyB6J9UFdJz+FF9WIYAtJu9BArM9eczeWpoebwJrK8/5KPxjBJOYJRC21v
         aB9rnE5JWbom85gicI6z2sWVjTAxiVjaZFk4HmZPA7rtGP5meahII2NYoiIj9ol3G+OD
         iyBQ==
X-Gm-Message-State: AOAM531OVv5DwBssMfmnRIu/OoRgPBvcM2QIuiGegi0waK3axXd+feO9
        64wO32ndZc8qf7tF3pJm0AHJA8ycoa8VDQ==
X-Google-Smtp-Source: ABdhPJz181WGW4bS4/y2PxtjF4Dx7I880U/pEY0+FDVndB4ydb0G4uW8ikXwCWoVTBQ3EDl1IRZlwg==
X-Received: by 2002:a92:d588:: with SMTP id a8mr1210329iln.79.1606159280803;
        Mon, 23 Nov 2020 11:21:20 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id c7sm5956947ilk.36.2020.11.23.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 11:21:20 -0800 (PST)
Date:   Mon, 23 Nov 2020 12:21:16 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201123192116.GA3883038@google.com>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120202253.GB1303870@google.com>
 <20201121024922.GA1363491@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121024922.GA1363491@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 07:49:22PM -0700, Yu Zhao wrote:
> On Fri, Nov 20, 2020 at 01:22:53PM -0700, Yu Zhao wrote:
> > On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> > > Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> > > TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> > > via the tlb_remove_*() functions. Consequently, the page-table modifications
> > > performed by clear_refs_write() in response to a write to
> > > /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> > > fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> > > state we can end up with entries where pte_write() is false, yet a
> > > writable mapping remains in the TLB.

I double checked my conclusion and I think it holds. But let me
correct some typos and add a summary.

> > I don't think we need a TLB flush in this context, same reason as we
                                ^^^^^ gather

> > don't have one in copy_present_pte() which uses ptep_set_wrprotect()
> > to write-protect a src PTE.
> > 
> > ptep_modify_prot_start/commit() and ptep_set_wrprotect() guarantee
> > either the dirty bit is set (when a PTE is still writable) or a PF
> > happens (when a PTE has become r/o) when h/w page table walker races
> > with kernel that modifies a PTE using the two APIs.
> 
> After we remove the writable bit, if we end up with a clean PTE, any
> subsequent write will trigger a page fault. We can't have a stale
> writable tlb entry. The architecture-specific APIs guarantee this.
> 
> If we end up with a dirty PTE, then yes, there will be a stale
> writable tlb entry. But this won't be a problem because when we
> write-protect a page (not PTE), we always check both pte_dirty()
> and pte_write(), i.e., write_protect_page() and page_mkclean_one().
> When they see this dirty PTE, they will flush. And generally, only
> callers of pte_mkclean() should flush tlb; otherwise we end up one
> extra if callers of pte_mkclean() and pte_wrprotect() both flush.
> 
> Now let's take a step back and see why we got
> tlb_gather/finish_mmu() here in the first place. Commit b3a81d0841a95
> ("mm: fix KSM data corruption") explains the problem clearly. But
> to fix a problem created by two threads clearing pte_write() and
> pte_dirty() independently, we only need one of them to set
> mm_tlb_flush_pending(). Given only removing the writable bit requires
                                                  ^^^^^^^^ dirty

> tlb flush, that thread should be the one, as I just explained. Adding
> tlb_gather/finish_mmu() is unnecessary in that fix. And there is no
> point in having the original flush_tlb_mm() either, given data
> integrity is already guaranteed.
(i.e., writable tlb entries are flushed when removing the dirty bit.)

> Of course, with it we have more accurate access tracking.
> 
> Does a similar problem exist for page_mkclean_one()? Possibly. It
> checks pte_dirty() and pte_write() but not mm_tlb_flush_pending().
> At the moment, madvise_free_pte_range() only supports anonymous
> memory, which doesn't do writeback. But the missing
> mm_tlb_flush_pending() just seems to be an accident waiting to happen.
> E.g., clean_record_pte() calls pte_mkclean() and does batched flush.
> I don't know what it's for, but if it's called on file VMAs, a similar
> race involving 4 CPUs can happen. This time CPU 1 runs
> clean_record_pte() and CPU 3 runs page_mkclean_one().

To summarize, IMO, we should 1) remove tlb_gather/finish_mmu() here;
2) check mm_tlb_flush_pending() in page_mkclean_one() and
dax_entry_mkclean().
