Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577B42BAF66
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgKTPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgKTPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:55:18 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D58C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:55:18 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so8212373pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mH0XWTPw1aDZdBTH/G0qziz2DLxku/Ckk+DQq/83avE=;
        b=nQ8Gix8WRyqbKUlkh4PixmhfzCCdN6Vp1oepEYKR1kSzb0c9NFHOT/nOqiemkWOXmc
         ouxU3ZBc4u58gBkwswnza3mAVLFvjxHgsX31Et3extwahWtmKpiqNIu2KKpIhCOIg/mt
         vBUXuPdJEmhSbV+yN2v5TFjxZpim0OVTR16hEkvV2Nrz3Q3igRSvZNjgrHW+CAU0zW9W
         d4h/rwZSnIPvpumibKFp/DN9gzoYRg5h65NjqUJekm18Nec8Tl4SPu4HI+p2YFQcNYV+
         UAQ9XJKpX4a4LaCSu22juQDRUm1s8tzoP4XzyhKyOqXyO6iNn/6VVDR27RzxllLrXeda
         iCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mH0XWTPw1aDZdBTH/G0qziz2DLxku/Ckk+DQq/83avE=;
        b=e5SW+/Jck6kg2DTCNxJsrAWs081Upws1wVP51eYkSMLkRnJ48aHzN0aLZoFtv1r0wB
         9nLh7OwCPoX8zCdHGgz7gyqU8rU3dPzyooqkvFbm+k5UdN/wVRCSqdXV9N5ByJx2AlR8
         xGA97ZZ85dBf6W/v1NLW20R78AXdqGYy0r6T7/Nj6qpDKgYXH+eqdUsSPoHCB03nUZSV
         R6fYS7QzbCOseERoy4+52J3+IVP9TsnD4TPdjd+7A5pKO5mC0xMWi7ZlEDVVymC206z4
         XMx/F1XIJPmC8cuHvIRv9mqdGp4oFG9yY0BOCTmuFGzgfKCXrDUbTqhXIaLWoOrLcjoB
         +mEw==
X-Gm-Message-State: AOAM532YoNfbpNudYS5dfKeI5wMhhKa8cYULbIIZUlBKWykn+cjo/vyj
        wSWiwdiD5beWKsev+2zXQ1Y=
X-Google-Smtp-Source: ABdhPJzY/UZC1PpZ/zzTDc+GgXIRIMMltQQy7bU5UOZcHAdIY6OkOzwMpFDnmqnHJ2Oa1mRfWmjHGw==
X-Received: by 2002:a63:e20:: with SMTP id d32mr5040393pgl.94.1605887717816;
        Fri, 20 Nov 2020 07:55:17 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id x12sm4088482pjr.51.2020.11.20.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:55:16 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 20 Nov 2020 07:55:14 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201120155514.GA3377168@google.com>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120150023.GH3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120150023.GH3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 04:00:23PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> > Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> > TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> > via the tlb_remove_*() functions. Consequently, the page-table modifications
> > performed by clear_refs_write() in response to a write to
> > /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> > fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> > state we can end up with entries where pte_write() is false, yet a
> > writable mapping remains in the TLB.
> > 
> > Fix this by calling tlb_remove_tlb_entry() for each entry being
> > write-protected when cleating soft-dirty.
> > 
> 
> > @@ -1053,6 +1054,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
> >  		ptent = pte_wrprotect(old_pte);
> >  		ptent = pte_clear_soft_dirty(ptent);
> >  		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> > +		tlb_remove_tlb_entry(tlb, pte, addr);
> >  	} else if (is_swap_pte(ptent)) {
> >  		ptent = pte_swp_clear_soft_dirty(ptent);
> >  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> 
> Oh!
> 
> Yesterday when you had me look at this code; I figured the sane thing
> to do was to make it look more like mprotect().
> 
> Why did you chose to make it work with mmu_gather instead? I'll grant
> you that it's probably the smaller patch, but I still think it's weird
> to use mmu_gather here.

I agree. The reason why clear_refs_write used the gather API was [1] and
seems like to overkill to me.

We could just do like [inc|dec]_tlb_flush_pending with flush_tlb_mm at
right before dec_tlb_flush_pending instead of gather.

thought?

[1] b3a81d0841a95, mm: fix KSM data corruption
