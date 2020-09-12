Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1026799A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgILKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 06:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgILKpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 06:45:09 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E727421548;
        Sat, 12 Sep 2020 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599907509;
        bh=JlaG0VihU/kpNynKTFEbZN+fiVclrSFZQ7o5lYSLsCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxwNZ3DR4pd+Et17gzUK/aZwG6cHSOwhCuo5WvAt83UKFrpsgCeTfsR3fzflwbVXS
         bvbjd9Xh5RzjmKMl8sjHJhCIuZtc/VlON3F/iJxiwNWoxovf9oBrzZeVM3M263wQQL
         J3d3mZE2F/hRn4VlAXoWKb4o7NCbh1xdTj57Dk3A=
Date:   Sat, 12 Sep 2020 13:45:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH] RISC-V: Consider sparse memory while removing unusable
 memory
Message-ID: <20200912104502.GF2142832@kernel.org>
References: <20200912002341.4869-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912002341.4869-1-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish,

On Fri, Sep 11, 2020 at 05:23:41PM -0700, Atish Patra wrote:
> Currently, any usable memory area beyond page_offset is removed by adding the
> memory sizes from each memblock. That may not work for sparse memory
> as memory regions can be very far apart resulting incorrect removal of some
> usable memory.

If I understand correctly, the memory with physical addresses larger
than (-PAGE_OFFSET) cannot be used. Since it was aready
memblock_add()'ed during device tree parsing, you need to remove it from
memblock.

For that you can use memblock_enforce_memory_limit(-PAGE_OFFSET).

> Just use the start of the first memory block and the end of the last memory
> block to compute the size of the total memory that can be used.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/init.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 787c75f751a5..188281fc2816 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -147,7 +147,6 @@ void __init setup_bootmem(void)
>  {
>  	struct memblock_region *reg;
>  	phys_addr_t mem_size = 0;
> -	phys_addr_t total_mem = 0;
>  	phys_addr_t mem_start, end = 0;
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
>  	phys_addr_t vmlinux_start = __pa_symbol(&_start);
> @@ -155,18 +154,17 @@ void __init setup_bootmem(void)
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
>  	 * Remove memblock from the end of usable area to the
>  	 * end of region
>  	 */
> -	mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> +	mem_size = min(end - mem_start, (phys_addr_t)-PAGE_OFFSET);
>  	if (mem_start + mem_size < end)
>  		memblock_remove(mem_start + mem_size,
>  				end - mem_start - mem_size);
> -- 
> 2.24.0
> 

-- 
Sincerely yours,
Mike.
