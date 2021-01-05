Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4F2EADED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAEPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAEPJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:09:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A56C522B51;
        Tue,  5 Jan 2021 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609859327;
        bh=pKCTXl5rA7B82z3XM4ZKa/ZmmuwzyM8wYnCCwVLvojw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cn5usqMTaCHxA8sDPPq/1U63uauMLXbRCOD3prvJvl2sbZHU9miQ81uH9xY/rhcep
         axbPstN+dfHpeQvNv2G5/JYkLyG5Ny54+logaSITqsnb/nvfQLg0XtSYyA9uVL24Qg
         AaOZALojoPmuuHJdvTTvKPx1WtUXWPmNKhPg5zacRlFg2EoHOhBiPpOCSgX97zeK0p
         0J8eq+l++9iSAUaoRDX0Zh8jB7RgXVgLP/ehcBNHI2FlF62M3BU5h70G3k2PoFhlr3
         QyynFxWBMGm0C4RqpU+Gq8Y9S9uzBcmhkzgarIJjl4m39dUUCIk5kxb78NyGBtkgxw
         Q3rRngwRQ44ew==
Date:   Tue, 5 Jan 2021 15:08:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on
 soft-dirty cleanup
Message-ID: <20210105150841.GA11745@willie-the-truck>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225092529.3228466-3-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 01:25:29AM -0800, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Clearing soft-dirty through /proc/[pid]/clear_refs can cause memory
> corruption as it clears the dirty-bit without acquiring the mmap_lock
> for write and defers TLB flushes.
> 
> As a result of this behavior, it is possible that one of the CPUs would
> have the stale PTE cached in its TLB and keep updating the page while
> another thread triggers a page-fault, and the page-fault handler would
> copy the old page into a new one.

[...]

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 217aa2705d5d..39b2bd27af79 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1189,6 +1189,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  	struct mm_struct *mm;
>  	struct vm_area_struct *vma;
>  	enum clear_refs_types type;
> +	bool write_lock = false;
>  	struct mmu_gather tlb;
>  	int itype;
>  	int rv;
> @@ -1236,21 +1237,16 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  		}
>  		tlb_gather_mmu(&tlb, mm, 0, -1);
>  		if (type == CLEAR_REFS_SOFT_DIRTY) {
> +			mmap_read_unlock(mm);
> +			if (mmap_write_lock_killable(mm)) {
> +				count = -EINTR;
> +				goto out_mm;
> +			}
>  			for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -				if (!(vma->vm_flags & VM_SOFTDIRTY))
> -					continue;
> -				mmap_read_unlock(mm);
> -				if (mmap_write_lock_killable(mm)) {
> -					count = -EINTR;
> -					goto out_mm;
> -				}
> -				for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -					vma->vm_flags &= ~VM_SOFTDIRTY;
> -					vma_set_page_prot(vma);
> -				}
> -				mmap_write_downgrade(mm);
> -				break;
> +				vma->vm_flags &= ~VM_SOFTDIRTY;
> +				vma_set_page_prot(vma);
>  			}
> +			write_lock = true;
>  
>  			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
>  						0, NULL, mm, 0, -1UL);
> @@ -1261,7 +1257,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  		if (type == CLEAR_REFS_SOFT_DIRTY)
>  			mmu_notifier_invalidate_range_end(&range);
>  		tlb_finish_mmu(&tlb, 0, -1);
> -		mmap_read_unlock(mm);
> +		if (write_lock)
> +			mmap_write_unlock(mm);
> +		else
> +			mmap_read_unlock(mm);
>  out_mm:
>  		mmput(mm);

I probably wouldn't bother with the 'write_lock' variable, and just check
'type == CLEAR_REFS_SOFT_DIRTY' instead.

But that's trivial and I don't have strong opinions, so:

Acked-by: Will Deacon <will@kernel.org>

Are you intending to land this for 5.11? If so, I can just rebase my other
series on top of this.

Will
