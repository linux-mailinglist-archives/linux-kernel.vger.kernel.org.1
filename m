Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE9C2D6C23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394441AbgLJXp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394417AbgLJXpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:45:12 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81596C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:44:32 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z136so7610645iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/4tj4AEhiYsma+hTN7k7gj8dzjyREfJk2mVKvee3TE=;
        b=XnT0pKQFWIEosZy7M8s48zG8tfLwqHRybvSoHkJVcz3o0MLUUpWNXd+lqEXPcpau7+
         Y6FewCu53HHlG+j8sQbs3sIgQEPiUZz+EbiWWXUfQZBosYApuyRAnlb6WWm3SmVGezvS
         Z1SIhiLwOZxpHurRzV4Gxm4pIt6OLBTWfdEdEEBUMreLgEV5e/0g8cpNr+gc9iZvFFBi
         784VMl2pJNUwIym2owa6ysC2C9QIX/wsehopZvY8Yfl5U4ThjPELSVusMtneqUsjlO9z
         RDgd7ghJNKO1Z+Tq5CWNYTy5RKf231kbxk6nUpiTj/RgC/02m1a/ZcR78hqsjW80XgIA
         DP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/4tj4AEhiYsma+hTN7k7gj8dzjyREfJk2mVKvee3TE=;
        b=gyjtGNrb9AwxtU5AqzZvGPdf7wtJojhwkHy7XFAvmTIIvoa1191oiMmb389i0clCyM
         dUtDuxHaQFK3Y2SRMsg9sl+VC3yuj9Vv3r3C0pBpalhhXVPIlcfvBv08z817OMBGfqcn
         BazDuPf3Z9ErYyE8ovVui0s5ZGmyvY6a7FMVICML0Bu/+Oh3ctRZn45nh92B7wdaY8BL
         ksuHSuGZexU/yatD3LIpajj6L7LcVVMWRoqdeOkyK80xTRi0Hm3Q86ZdIPasIiuHTc0u
         C3fp45DTGeMc7b/Y132zeYZZmbFWip8wHcqzKWhIyceekUg8P9hIuXrs+viG554QDTv4
         vhJw==
X-Gm-Message-State: AOAM532LW+YUs/FoI5Vtlf4pwgYAbXkuyQcvzlUkY0sr9nt5O/qc4mi6
        JZ39F1y+payl3WV4oz9zX5nE2w==
X-Google-Smtp-Source: ABdhPJx9Xh7SzDtpNi6BLGc841jg/VIKifu7TzcaXJnm1fzun2Jx8KVVLk+hnuY62U4xYFJCIrEPxw==
X-Received: by 2002:a6b:8b4c:: with SMTP id n73mr11362755iod.143.1607643871702;
        Thu, 10 Dec 2020 15:44:31 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id m8sm3289294ioh.16.2020.12.10.15.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 15:44:31 -0800 (PST)
Date:   Thu, 10 Dec 2020 16:44:26 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/6] tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
Message-ID: <X9Ky2kaowNUdyHKm@google.com>
References: <20201210121110.10094-1-will@kernel.org>
 <20201210121110.10094-4-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210121110.10094-4-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:11:07PM +0000, Will Deacon wrote:
> Passing the range '0, -1' to tlb_gather_mmu() sets the 'fullmm' flag,
> which indicates that the mm_struct being operated on is going away. In
> this case, some architectures (such as arm64) can elide TLB invalidation
> by ensuring that the TLB tag (ASID) associated with this mm is not
> immediately reclaimed. Although this behaviour is documented in
> asm-generic/tlb.h, it's subtle and easily missed.
> 
> Introduce tlb_gather_mmu_fullmm() to make it clearer that this is for the
> entire mm and WARN() if tlb_gather_mmu() is called with the 'fullmm'
> address range.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/asm-generic/tlb.h |  6 ++++--
>  include/linux/mm_types.h  |  1 +
>  mm/mmap.c                 |  2 +-
>  mm/mmu_gather.c           | 16 ++++++++++++++--
>  4 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 6661ee1cff47..2c68a545ffa7 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -46,7 +46,9 @@
>   *
>   * The mmu_gather API consists of:
>   *
> - *  - tlb_gather_mmu() / tlb_finish_mmu(); start and finish a mmu_gather
> + *  - tlb_gather_mmu() / tlb_gather_mmu_fullmm() / tlb_finish_mmu()
> + *
> + *    start and finish a mmu_gather
>   *
>   *    Finish in particular will issue a (final) TLB invalidate and free
>   *    all (remaining) queued pages.
> @@ -91,7 +93,7 @@
>   *
>   *  - mmu_gather::fullmm
>   *
> - *    A flag set by tlb_gather_mmu() to indicate we're going to free
> + *    A flag set by tlb_gather_mmu_fullmm() to indicate we're going to free
>   *    the entire mm; this allows a number of optimizations.
>   *
>   *    - We can ignore tlb_{start,end}_vma(); because we don't
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7b90058a62be..42231729affe 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -585,6 +585,7 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
>  struct mmu_gather;
>  extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>  				unsigned long start, unsigned long end);
> +extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
>  extern void tlb_finish_mmu(struct mmu_gather *tlb);
>  
>  static inline void init_tlb_flush_pending(struct mm_struct *mm)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a3e5854cd01e..cdd3dae6547c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3214,7 +3214,7 @@ void exit_mmap(struct mm_struct *mm)
>  
>  	lru_add_drain();
>  	flush_cache_mm(mm);
> -	tlb_gather_mmu(&tlb, mm, 0, -1);
> +	tlb_gather_mmu_fullmm(&tlb, mm);
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use -1 here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, vma, 0, -1);
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index b0be5a7aa08f..5f5e45d9eb50 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -261,8 +261,8 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
>   * respectively when @mm is without users and we're going to destroy
>   * the full address space (exit/execve).
>   */
> -void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
> -			unsigned long start, unsigned long end)
> +static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
> +			     unsigned long start, unsigned long end)
>  {
>  	tlb->mm = mm;
>  
> @@ -287,6 +287,18 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>  	inc_tlb_flush_pending(tlb->mm);
>  }
>  
> +void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
> +		    unsigned long start, unsigned long end)
> +{
> +	WARN_ON(!(start | (end + 1))); /* Use _fullmm() instead */
> +	__tlb_gather_mmu(tlb, mm, start, end);
> +}
> +
> +void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
> +{
> +	__tlb_gather_mmu(tlb, mm, 0, -1);
> +}
> +

IMO, there is no point adding the wrappers given you will remove
the WARN_ON in the next patch.

But if you prefer, they should be at least moved to the header for
inlining.

Consider this whole series

Reviewed-by: Yu Zhao <yuzhao@google.com>
