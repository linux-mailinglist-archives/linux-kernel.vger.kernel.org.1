Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487FE2B690C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKQPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgKQPtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:49:21 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5EF1238E6;
        Tue, 17 Nov 2020 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605628160;
        bh=V7uAi+aLeukcM7TUcb2w4CrWhvmHsv3w1Wej+B0peII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uoKSHeNZiJheXNIXJF/OS81rfr1rkxrJvMLwHzyU9mMDRA3bzwkhi3VutTwvU+cfN
         XIr8KFedg88Ld4d7aR7uAbcWpqBHjSbrdu173J0VbrSTMznrAoSJzgvVUY+wk7B/vU
         jKcs7JOVRzG0+TuT2+mbLYZR5XLR09iANcsxx1cQ=
Date:   Tue, 17 Nov 2020 17:49:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH v2] mm: memblock: drop __init from memblock functions to
 make it inline
Message-ID: <20201117154914.GI370813@kernel.org>
References: <1605526537-16166-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605526537-16166-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:05:37PM +0530, Faiyaz Mohammed wrote:
> __init is used with inline due to which memblock wraper functions are
> not getting inline.
> for example:
> [    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc+0x20/0x2c
> [    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188
> 
> Dropping __init from memblock wrapper functions to make it inline and it
> increase the debugability.
> After:
> [    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 start_kernel+0xa4/0x568
> [    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>

Applied, thanks!

I've updated memblock_alloc() to be __always_inline because some
configurations make kbuild happy without it.

>> WARNING: modpost: vmlinux.o(.text.unlikely+0xbde): Section mismatch in reference from the function memblock_alloc() to the function .init.text:memblock_alloc_try_nid()
The function memblock_alloc() references
the function __init memblock_alloc_try_nid().
This is often because memblock_alloc lacks a __init
annotation or the annotation of memblock_alloc_try_nid is wrong.

> ---
>  include/linux/memblock.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index ef13125..f78113f 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -404,13 +404,13 @@ void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
>  			     phys_addr_t min_addr, phys_addr_t max_addr,
>  			     int nid);
>  
> -static inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
> +static inline void *memblock_alloc(phys_addr_t size,  phys_addr_t align)
>  {
>  	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
>  				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
>  }
>  
> -static inline void * __init memblock_alloc_raw(phys_addr_t size,
> +static inline void *memblock_alloc_raw(phys_addr_t size,
>  					       phys_addr_t align)
>  {
>  	return memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
> @@ -418,7 +418,7 @@ static inline void * __init memblock_alloc_raw(phys_addr_t size,
>  					  NUMA_NO_NODE);
>  }
>  
> -static inline void * __init memblock_alloc_from(phys_addr_t size,
> +static inline void *memblock_alloc_from(phys_addr_t size,
>  						phys_addr_t align,
>  						phys_addr_t min_addr)
>  {
> @@ -426,33 +426,33 @@ static inline void * __init memblock_alloc_from(phys_addr_t size,
>  				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
>  }
>  
> -static inline void * __init memblock_alloc_low(phys_addr_t size,
> +static inline void *memblock_alloc_low(phys_addr_t size,
>  					       phys_addr_t align)
>  {
>  	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
>  				      ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE);
>  }
>  
> -static inline void * __init memblock_alloc_node(phys_addr_t size,
> +static inline void *memblock_alloc_node(phys_addr_t size,
>  						phys_addr_t align, int nid)
>  {
>  	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
>  				      MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>  }
>  
> -static inline void __init memblock_free_early(phys_addr_t base,
> +static inline void memblock_free_early(phys_addr_t base,
>  					      phys_addr_t size)
>  {
>  	memblock_free(base, size);
>  }
>  
> -static inline void __init memblock_free_early_nid(phys_addr_t base,
> +static inline void memblock_free_early_nid(phys_addr_t base,
>  						  phys_addr_t size, int nid)
>  {
>  	memblock_free(base, size);
>  }
>  
> -static inline void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
> +static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
>  {
>  	__memblock_free_late(base, size);
>  }
> @@ -460,7 +460,7 @@ static inline void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
>  /*
>   * Set the allocation direction to bottom-up or top-down.
>   */
> -static inline void __init memblock_set_bottom_up(bool enable)
> +static inline void memblock_set_bottom_up(bool enable)
>  {
>  	memblock.bottom_up = enable;
>  }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
Sincerely yours,
Mike.
