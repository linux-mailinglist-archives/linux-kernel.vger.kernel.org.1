Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271712C4A50
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 23:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbgKYWBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 17:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgKYWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:01:55 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC52C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:01:55 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id s2so75816plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yGIPQTaXyAHiU0vxDa9ieVvOQr3snRO+p4P/RnwP99g=;
        b=W4ZqfEx6uzy5q/3HDQXpKs66PdntoPiyn1nRIllpyq42zQNVtxQayzZuEZgRKhUYCO
         6ghQvG5YKksYLIxZs78E+Xq+5dubpih66eclLM5UXX/H59QfcEZ8TNa36flqhfQXhSeq
         D0aYuJ112Imz2pHRUzFAgx1tibwRHm8UCuE+V9fz0f1Wlq5/jqRtFMMUori4B2/ML9FZ
         msyaxYlRWEcBDjcEB/M3FqJq5AWG3G0iE9etqolWgf/GkwsZ0vhwamgJJHQZASKwz0SA
         XxBJ4UDeWaRZP50Y+jjMDmjpc2m7kKSd3tGvtFpFi5HV6J46gozIImldkqxxBmqFa/F9
         UYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yGIPQTaXyAHiU0vxDa9ieVvOQr3snRO+p4P/RnwP99g=;
        b=TfSdhj6H+O4qysnGnWVCMOyVSzJt9G2ME7qYSR16q1iBxPyHNFKnkzwWx5wckP5g0f
         /Q8+67RKBsAuTN08bqasJK6+Qk9T4Y3HouK+iS4JB2F6IDZdhJJcXONkyJoH6B+TEz9/
         j3P66GY3AzqNnfrlrZN1g1el1XKmbIrXVGFdWWVlLsQ6gijeZLautZlLLJboQyiaebjl
         d79aWMdOu63L4PeRp5L3FyuXeHtTb5/yrkdU5MyAh5Q0zcegM2moF4nwBFYbNq03/4ks
         Z1ltivOhUq5fAmcxauyy31xOYYsDImO4gBLgX8Bp858U2kTPaE5I8QWrldBHrIAYWIgS
         I0fQ==
X-Gm-Message-State: AOAM532AQFr2BFfYz00QUtvXY0/qEu3saHHrIlHUGlcqaKPp1R+SjrJo
        EYUtZHpV2TwQDlk9W6FfV8M=
X-Google-Smtp-Source: ABdhPJxya/JcJs7fwmNvNg95KzHhRLhPxOeu8cyCicQohGOo5DGGu6Y8Bgm+UBFUCRT6clUhEy04dQ==
X-Received: by 2002:a17:902:d34d:b029:da:3681:cf18 with SMTP id l13-20020a170902d34db02900da3681cf18mr1784380plk.79.1606341714502;
        Wed, 25 Nov 2020 14:01:54 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id l3sm3964177pju.44.2020.11.25.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:01:52 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Nov 2020 14:01:50 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 6/6] mm: proc: Avoid fullmm flush for young/dirty bit
 toggling
Message-ID: <20201125220150.GD1484898@google.com>
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
> 
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
> 
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
> 
> Example 2: why no flush when write-protecting is not a problem (after
> we fix the problem correctly by adding mm_tlb_flush_pending()).
> 
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
> 
>                           drop clean page
>                           [data integrity guaranteed]
> 
> Case c:
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
>               [pte_dirty() is true]
> 
>                           page_mkclean_one()
>                           !pte_dirty() && !pte_write() &&
>                           !mm_tlb_flush_pending()
>                           [false: flush]
> 
>                           write page to disk
> 
>   Write to page
>   [page fault]
> 
>                           drop clean page
>                           [data integrity guaranteed]
> 
> > > > Furthermore, If we decide that we can relax the TLB invalidation
> > > > requirements here, then I'd much rather than was done deliberately, rather
> > > > than as an accidental side-effect of another commit (since I think the
> > > > current behaviour was a consequence of 7a30df49f63a).
> > > 
> > > Nope. tlb_gather/finish_mmu() should be added by b3a81d0841a9
>                                   ^^^^^^ shouldn't

I read all examples Yu mentioned and think they are all correct. Furthermore,
I agree with Yu we don't need the tlb gathering in clear_refs_writes from the
beginning to just increase the tlb flush pending count since MADV_FREE already
have it. However, I'd like to keep the last flushing logic in clear_refs_writes
to avoid relying on the luck for better accuracy as well as guarantees.

So, IMHO, technically, Yu's points are all valid to me - we need to fix page
writeback path. About this clear_refs_writes, Will's chages are still
improvement(based on assumption if Yu agree on that we need the TLB flush for
accuracy, not correctness) so still worth to have it.

Then, Wu, could you send the writeback path fix? Please Ccing Hugh, Mel, 
Adnrea and Nadav in next patchset since they all are experts in this
domain - referenced in https://lkml.org/lkml/2015/4/15/565

> 
> Another typo, I apologize.
> 
> > > ("mm: fix KSM data corruption") in the first place.
> > 
> > Sure, but if you check out b3a81d0841a9 then you have a fullmm TLB
> > invalidation in tlb_finish_mmu(). 7a30df49f63a is what removed that, no?
> > 
> > Will
