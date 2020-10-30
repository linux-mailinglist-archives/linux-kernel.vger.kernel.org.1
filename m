Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0705B2A1130
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgJ3Ww4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 18:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgJ3Ww4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604098374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fxycBzU/SbTsOhTDMCX2G197w3tCiGFDNk6KNKI6/KA=;
        b=ekXHKPRBTN12+5gp17UkEUncNvjlVh8GmKL4sz8lpR/z3XOVh8zKIJR5553FOx0En1AaNT
        5yM6oEd4AtovL8rNZQGG1RmwZktOKA8FM1QXyUs19NQJqKRb2s1IgoIeEyKvcCP0/pHQLW
        iOGPU5AYlbyhlhgBNUWyUb4/zZMetD0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-pAb9-WUlPzezy3gDq_JekA-1; Fri, 30 Oct 2020 18:52:53 -0400
X-MC-Unique: pAb9-WUlPzezy3gDq_JekA-1
Received: by mail-qv1-f69.google.com with SMTP id d41so4682939qvc.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 15:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fxycBzU/SbTsOhTDMCX2G197w3tCiGFDNk6KNKI6/KA=;
        b=iWCJjXPLPf4dZQH9PE/LEF6ht2nEAU5IQGAmvWh6KzlTJV0NyxuLh/YGV8cSY7A1UT
         rYzlhDwOIVOYjhyEG1zo3AERjntf6o++gp/wvJiFABiBv2GpDknsrYGyN3PG6SGHdtAq
         ByAsweWtTrVoIsvK1bm2VzAB9iQBy7qpie9azLK8djX4qxoVIyRPJ3MkxBQwWRxEtDCx
         h9cTCHF+9biN/LWf+swy5lCyHBlGxC6RkZpr9rCkkrZaAkte2c0/LEVPSXkPU8e0O+AO
         7lc6oyOO3nQEnF8lO7gxSn3zUcutR0Cw4UFfmxeqB4E6AaBzktXUTd1jWXH8uzSITMJh
         SjqA==
X-Gm-Message-State: AOAM5322ZOI0M0+KdYXZGiJzfyFMXtB9y6ofuDMMA9w13m6EEnkDT/Ng
        XJCdPq3FRZr5PUXGZJ2OYAYwN1Sgpo5IIMki7rud6INTqfotq+5d3fU2Ky5uz8NjUeQujcHbPcm
        VCIO3eXC+Fw9TjYOWStT9fvnY
X-Received: by 2002:a37:b642:: with SMTP id g63mr4450337qkf.460.1604098372618;
        Fri, 30 Oct 2020 15:52:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXCfrderOASI/SbrdK/WvIiHp8Bbc9kF9zYpz4/Ssr4wyebZK9kh6LojNxU3ku1jcBoJTNFw==
X-Received: by 2002:a37:b642:: with SMTP id g63mr4450321qkf.460.1604098372371;
        Fri, 30 Oct 2020 15:52:52 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id k24sm353066qtp.35.2020.10.30.15.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 15:52:51 -0700 (PDT)
Date:   Fri, 30 Oct 2020 18:52:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201030225250.GB6357@xz-x1>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason,

I think majorly the patch looks good to me, but I have a few pure questions
majorly not directly related to the patch itself, but around the contexts.
Since I _feel_ like there'll be a new version to update the comments below,
maybe I can still ask aloud... Please bare with me. :)

On Fri, Oct 30, 2020 at 11:46:21AM -0300, Jason Gunthorpe wrote:
> Slow GUP is safe against this race because copy_page_range() is only
> called while holding the exclusive side of the mmap_lock on the src
> mm_struct.

Pure question: I understand that this patch requires this, but... Could anyone
remind me why read lock of mmap_sem is not enough for fork() before this one?

> 
> Fixes: f3c64eda3e50 ("mm: avoid early COW write protect games during fork()")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/x86/kernel/tboot.c    |  1 +
>  drivers/firmware/efi/efi.c |  1 +
>  include/linux/mm_types.h   |  7 +++++++
>  kernel/fork.c              |  1 +
>  mm/gup.c                   | 19 +++++++++++++++++++
>  mm/init-mm.c               |  1 +
>  mm/memory.c                | 10 +++++++++-
>  7 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index 992fb1415c0f1f..6a2f542d9588a4 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -93,6 +93,7 @@ static struct mm_struct tboot_mm = {
>  	.pgd            = swapper_pg_dir,
>  	.mm_users       = ATOMIC_INIT(2),
>  	.mm_count       = ATOMIC_INIT(1),
> +	.write_protect_seq = SEQCNT_ZERO(tboot_mm.write_protect_seq),
>  	MMAP_LOCK_INITIALIZER(init_mm)
>  	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>  	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 5e5480a0a32d7d..2520f6e05f4d44 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -57,6 +57,7 @@ struct mm_struct efi_mm = {
>  	.mm_rb			= RB_ROOT,
>  	.mm_users		= ATOMIC_INIT(2),
>  	.mm_count		= ATOMIC_INIT(1),
> +	.write_protect_seq      = SEQCNT_ZERO(efi_mm.write_protect_seq),
>  	MMAP_LOCK_INITIALIZER(efi_mm)
>  	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
>  	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),

Another pure question: I'm just curious how you find all the statically
definied mm_structs, and to make sure all of them are covered (just in case
un-initialized seqcount could fail strangely).

Actually I'm thinking whether we should have one place to keep all the init
vars for all the statically definied mm_structs, so we don't need to find them
everytime, but only change that one place.

> diff --git a/mm/memory.c b/mm/memory.c
> index c48f8df6e50268..294c2c3c4fe00d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1171,6 +1171,12 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
>  					0, src_vma, src_mm, addr, end);
>  		mmu_notifier_invalidate_range_start(&range);
> +		/*
> +		 * The read side doesn't spin, it goes to the mmap_lock, so the
> +		 * raw version is used to avoid disabling preemption here
> +		 */
> +		mmap_assert_write_locked(src_mm);
> +		raw_write_seqcount_t_begin(&src_mm->write_protect_seq);

Would raw_write_seqcount_begin() be better here?

My understanding is that we used raw_write_seqcount_t_begin() because we're
with spin lock so assuming we disabled preemption already.  However I'm
thinking whether raw_write_seqcount_begin() would be even better to guarantee
that.  I have no idea of how the rt kernel merging topic, but if rt kernel
merged into mainline then IIUC preemption is allowed here (since pgtable spin
lock should be rt_spin_lock, not raw spin locks).

An even further pure question on __seqcount_preemptible() (feel free to ignore
this question!): I saw that __seqcount_preemptible() seems to have been
constantly defined as "return false".  Not sure what happened there..

Thanks,

-- 
Peter Xu

