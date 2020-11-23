Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB882C151D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgKWUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKWUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:04:08 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE529C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:04:08 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id r17so5144794ilo.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1ygwv1gDIx6pzCn/7wXhIf2aYwGwGDOEeQihtM1ZpM=;
        b=uwgO8z8YqcFkWNQxVIuvsoydACvsVlnlATNCoZSeBJcltJiVeSO2y4JBJOSWwrUKj4
         8W63pN/7SYMqHP5rOFduWxX4EiINNzzmvsj+mtsj9+QzYcGzFFOsuTw2wXvy/N0ve3NZ
         UJNjlZ/AGRf1/VayKKB0hd9AXnsPEyFp63IqZgAZX8AIjLPHkAVI6LJ7d9i0epincBhr
         rI9DjlVygqGa+yxanvSvBIEipQ1TgN0SoLMFLG8DaFxyzvx273STtzy4RsiFnQB6/aTE
         FOORfKAXZ32B1tZljN7scdXJ93KSRT7hPQrww3dGr+AwuCLWVUFI1IgSxDOIgvxlWlTa
         WItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1ygwv1gDIx6pzCn/7wXhIf2aYwGwGDOEeQihtM1ZpM=;
        b=k19A8cx+iIReoeJawxSPVx9g3qcpc2prQm0PxlGbjE06gwOxv8vgnWpF8yk+UyjAbY
         XicF6PIo6zJh8pKrEMuLkPz6AG8k2inRPOi/hQWMhEPfcAB6UVZo1nVR8QzuHhXQHb6S
         Umj3bI8k8A28GnCRGDPSzqvW9Bqak2ylsw0EsArKvVvTY9/hinxHU8hJVioSlhn0A+Nj
         li9/tsIzIFO8BE39/jegG6YAW/HJh6Q6zPm8+AQtgHurxHu8kWrSB/1qAgwT22o74eNY
         30lZe86ROFGCm2JKpMpqV5FbZodGZQ2W96jjahBeUFh/I0DusvV3ZQq2GOMBJlWToMp+
         nzKw==
X-Gm-Message-State: AOAM533nFEu7T5h8jzuA1JjdCJXuTtlS24GbtX35q+aY8mFzGIBDw1LV
        iZeYMx+Aah+od4HxRR5jZTiPkw==
X-Google-Smtp-Source: ABdhPJyF3e/HkFOMrkX4Eg9o/jcmrwba0hxJNECcugCw6HtB3Dj0vb40Sr4WT6r3PwNGx/Axq0zDyw==
X-Received: by 2002:a92:d591:: with SMTP id a17mr1290615iln.51.1606161847863;
        Mon, 23 Nov 2020 12:04:07 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id h16sm8105392ile.14.2020.11.23.12.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 12:04:07 -0800 (PST)
Date:   Mon, 23 Nov 2020 13:04:03 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] mm: proc: Avoid fullmm flush for young/dirty bit
 toggling
Message-ID: <20201123200403.GA3888699@google.com>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-7-will@kernel.org>
 <20201120204005.GC1303870@google.com>
 <20201123183554.GC11688@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123183554.GC11688@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 06:35:55PM +0000, Will Deacon wrote:
> On Fri, Nov 20, 2020 at 01:40:05PM -0700, Yu Zhao wrote:
> > On Fri, Nov 20, 2020 at 02:35:57PM +0000, Will Deacon wrote:
> > > clear_refs_write() uses the 'fullmm' API for invalidating TLBs after
> > > updating the page-tables for the current mm. However, since the mm is not
> > > being freed, this can result in stale TLB entries on architectures which
> > > elide 'fullmm' invalidation.
> > > 
> > > Ensure that TLB invalidation is performed after updating soft-dirty
> > > entries via clear_refs_write() by using the non-fullmm API to MMU gather.
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  fs/proc/task_mmu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index a76d339b5754..316af047f1aa 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -1238,7 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
> > >  			count = -EINTR;
> > >  			goto out_mm;
> > >  		}
> > > -		tlb_gather_mmu_fullmm(&tlb, mm);
> > > +		tlb_gather_mmu(&tlb, mm, 0, TASK_SIZE);
> > 
> > Let's assume my reply to patch 4 is wrong, and therefore we still need
> > tlb_gather/finish_mmu() here. But then wouldn't this change deprive
> > architectures other than ARM the opportunity to optimize based on the
> > fact it's a full-mm flush?

I double checked my conclusion on patch 4, and aside from a couple
of typos, it still seems correct after the weekend.

> Only for the soft-dirty case, but I think TLB invalidation is required
> there because we are write-protecting the entries and I don't see any
> mechanism to handle lazy invalidation for that (compared with the aging
> case, which is handled via pte_accessible()).

The lazy invalidation for that is done when we write-protect a page,
not an individual PTE. When we do so, our decision is based on both
the dirty bit and the writable bit on each PTE mapping this page. So
we only need to make sure we don't lose both on a PTE. And we don't
here.

> Furthermore, If we decide that we can relax the TLB invalidation
> requirements here, then I'd much rather than was done deliberately, rather
> than as an accidental side-effect of another commit (since I think the
> current behaviour was a consequence of 7a30df49f63a).

Nope. tlb_gather/finish_mmu() should be added by b3a81d0841a9
("mm: fix KSM data corruption") in the first place.

> > It seems to me ARM's interpretation of tlb->fullmm is a special case,
> > not the other way around.
> 
> Although I agree that this is subtle and error-prone (which is why I'm
> trying to make the API more explicit here), it _is_ documented clearly
> in asm-generic/tlb.h:
> 
>  *  - mmu_gather::fullmm
>  *
>  *    A flag set by tlb_gather_mmu() to indicate we're going to free
>  *    the entire mm; this allows a number of optimizations.
>  *
>  *    - We can ignore tlb_{start,end}_vma(); because we don't
>  *      care about ranges. Everything will be shot down.
>  *
>  *    - (RISC) architectures that use ASIDs can cycle to a new ASID
>  *      and delay the invalidation until ASID space runs out.

I'd leave the original tlb_gather/finish_mmu() for the first case and
add a new API for the second case, the special case that only applies
to exit_mmap()). This way we won't change any existing behaviors on
other architectures, which seems important to me.

Additional cleanups to tlb_gather/finish_mmu() come thereafter.
