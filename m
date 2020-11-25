Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272182C4B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 23:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgKYWv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 17:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgKYWv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:51:29 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC07C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:51:28 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t21so30853pgl.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IdH7TWjWbi5QdZ7NXo5aR6u+Q2zXh+GO9Yj+ORgSPoY=;
        b=MQ5Xh/PGhwHXhRhZhdNCxder7xSTQ9c8XILgpk60HKNuW8sNh+UTaqxTpHppOOlVWQ
         LEk5KNshPoI19tYCSjMMkpYh8IxFwqlRSbF7uG4tFoHUCZlILjLHH19JlRqcqVt5U9to
         r3YgaI2G9fvEGBj5D/6hKThlXZkWyM6HcpyA3AUVHPdvfDzIUdIuwfg5m6VeF8BrXap4
         IFiwRQHhgLeiZYuT9Em307w5xlOGeCQMhJarZRfB/PCHv/iE3IPgZov+7Vuo8j8644GA
         NSKx8d2/AHLcc/Qq6HqYA+TLffx7tlNMv6uaxXZLTLnQW5EzYbUrUHqyi842+5cJ3aRr
         0n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IdH7TWjWbi5QdZ7NXo5aR6u+Q2zXh+GO9Yj+ORgSPoY=;
        b=GPziDF1d1LXUuagpWq8a7iA/+r7JlX2s0kIPFMff0qHyF6GKgw7X2oijYR83l0O25G
         o5Gv+JJPiFjhCLvT50qXWyVDup36jhQQOMYCVAF7UR/2naA+TLxSJZ9dHmZ2eY7wCSxK
         ydPX08+slg+JaFcmA9/WjmmjQc3NEpW+SNDTVuo+Y7UoNIxWM9mGi3QqHtPncYC859VZ
         ujhxrJUufyCORP6ZciU+31riOoYit0Zy9zfy9d+RbOywN2pYUolf+VbZQMuzn/1kt5sb
         OIj6xs8PuJGOh+Xv+eqmoYnPURG4RBx2BFfj5xx9P9noWoDHlDxyqg4Dnd1MP8i6TEba
         htmQ==
X-Gm-Message-State: AOAM533kMISc7E4qDdQ6RDkNP0Grb29Q0Q+OYGM3d0PDFVIT+9NH/fEL
        KYhGmBkMSxxfYDoWHj+biwQ=
X-Google-Smtp-Source: ABdhPJxsXWrFiRFquDGdwhYbPpoLwY1x6gikdnoflq4amxZ0nT7ZkLwmnkYhG2jA5kMJdJ0EZF4WkQ==
X-Received: by 2002:a17:90a:f0cd:: with SMTP id fa13mr14046pjb.118.1606344688500;
        Wed, 25 Nov 2020 14:51:28 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id v3sm2759284pfn.215.2020.11.25.14.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:51:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Nov 2020 14:51:25 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201125225125.GE1484898@google.com>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120150023.GH3040@hirez.programming.kicks-ass.net>
 <20201120155514.GA3377168@google.com>
 <20201123184113.GD11688@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123184113.GD11688@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 06:41:14PM +0000, Will Deacon wrote:
> On Fri, Nov 20, 2020 at 07:55:14AM -0800, Minchan Kim wrote:
> > On Fri, Nov 20, 2020 at 04:00:23PM +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> > > > Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> > > > TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> > > > via the tlb_remove_*() functions. Consequently, the page-table modifications
> > > > performed by clear_refs_write() in response to a write to
> > > > /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> > > > fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> > > > state we can end up with entries where pte_write() is false, yet a
> > > > writable mapping remains in the TLB.
> > > > 
> > > > Fix this by calling tlb_remove_tlb_entry() for each entry being
> > > > write-protected when cleating soft-dirty.
> > > > 
> > > 
> > > > @@ -1053,6 +1054,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
> > > >  		ptent = pte_wrprotect(old_pte);
> > > >  		ptent = pte_clear_soft_dirty(ptent);
> > > >  		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> > > > +		tlb_remove_tlb_entry(tlb, pte, addr);
> > > >  	} else if (is_swap_pte(ptent)) {
> > > >  		ptent = pte_swp_clear_soft_dirty(ptent);
> > > >  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> > > 
> > > Oh!
> > > 
> > > Yesterday when you had me look at this code; I figured the sane thing
> > > to do was to make it look more like mprotect().
> > > 
> > > Why did you chose to make it work with mmu_gather instead? I'll grant
> > > you that it's probably the smaller patch, but I still think it's weird
> > > to use mmu_gather here.
> > 
> > I agree. The reason why clear_refs_write used the gather API was [1] and
> > seems like to overkill to me.
> 
> I don't see why it's overkill. Prior to that commit, it called
> flush_tlb_mm() directly.

The TLB gather was added for increasing tlb flush pending count for
stability bug, not for performance optimiataion(The commit never had
any number to support it and didn't have the logic to handle each pte
with tlb gather) and then it introduced a bug now so I take it as overkill
since it made complication from the beginning *unnecessary*.

> 
> > We could just do like [inc|dec]_tlb_flush_pending with flush_tlb_mm at
> > right before dec_tlb_flush_pending instead of gather.
> > 
> > thought?
> 
> I'm not sure why this is better; it's different to the madvise() path, and
> will need special logic to avoid the flush in the case where we're just
> doing aging.

I thought it's better to fix the bug first as *simple* patch and then
do optimization based on it.
Anyway, following to Yu's comment, we don't need gather API and 
even the flush if we give up the accuarcy(but I want to have it).
