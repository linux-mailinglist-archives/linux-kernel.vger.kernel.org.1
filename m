Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B239D270BC6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgISIRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 04:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISIRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 04:17:13 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BD921481;
        Sat, 19 Sep 2020 08:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600503433;
        bh=T3vHD+t2wwh+JRDOjD6PywHEwj3QURdLWr2DXDdJ9Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oq1HgnGLpd/kJhUyal09FR8c6/MJma3nfq0mW9Sav1TAbwGIap2bn5F+ldxCKBWSH
         TgdlCVi+a7xtDsYOjH18OgegqpQCN7OObO/ttl6jzq6yGIwxT2PBTt2s0N8GH0v5zD
         TsDy9a6iTV3m8lbvthtBa4MM0gMNYi1AnleUGgH4=
Date:   Sat, 19 Sep 2020 11:17:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v2] RISC-V: Remove any memblock representing unusable
 memory area
Message-ID: <20200919081706.GP2142832@kernel.org>
References: <20200917234055.2321977-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917234055.2321977-1-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:40:55PM -0700, Atish Patra wrote:
> RISC-V limits the physical memory size by -PAGE_OFFSET. Any memory beyond
> that size from DRAM start is unusable. Just remove any memblock pointing
> to those memory region without worrying about computing the maximum size.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

With one nit below

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> Changes from v1->v2:
> Used memblock_enforce_memory_limit instead of memblock_remove without
> computing the maximum memory size.
> ---
>  arch/riscv/mm/init.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 787c75f751a5..ed6e83871112 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -146,8 +146,6 @@ static phys_addr_t dtb_early_pa __initdata;
>  void __init setup_bootmem(void)
>  {
>  	struct memblock_region *reg;
> -	phys_addr_t mem_size = 0;
> -	phys_addr_t total_mem = 0;
>  	phys_addr_t mem_start, end = 0;
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
>  	phys_addr_t vmlinux_start = __pa_symbol(&_start);
> @@ -155,21 +153,18 @@ void __init setup_bootmem(void)
>  	/* Find the memory region containing the kernel */
>  	for_each_memblock(memory, reg) {
>  		end = reg->base + reg->size;
> -		if (!total_mem)
> +		if (!mem_start)
>  			mem_start = reg->base;
>  		if (reg->base <= vmlinux_start && vmlinux_end <= end)
>  			BUG_ON(reg->size == 0);
> -		total_mem = total_mem + reg->size;
>  	}
>  
>  	/*
> -	 * Remove memblock from the end of usable area to the
> -	 * end of region
> +	 * The maximum physical memory supported is -PAGE_OFFSET.

Maybe

	The maximal supported physical memory size is -PAGE_OFFSET


> +	 * Make sure that any memory beyond mem_start + (-PAGE_OFFSET) is removed
> +	 * as it is unusable by kernel.
>  	 */
> -	mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> -	if (mem_start + mem_size < end)
> -		memblock_remove(mem_start + mem_size,
> -				end - mem_start - mem_size);
> +	memblock_enforce_memory_limit(mem_start - PAGE_OFFSET);
>  
>  	/* Reserve from the start of the kernel to the end of the kernel */
>  	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
