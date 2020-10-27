Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6429CB92
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374541AbgJ0VyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2902368AbgJ0VyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:54:00 -0400
Received: from sstabellini-ThinkPad-T480s (c-24-130-65-46.hsd1.ca.comcast.net [24.130.65.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7224220759;
        Tue, 27 Oct 2020 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835639;
        bh=hLuBGmvknLJruJYQUNZGkX4EVqyzQJamlMv7F6lFoho=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=vOuhydjw9vlxiSuYbstg3MW2oGhlejZ8GriRzNfLn4RdkjVwbV2wc643qtmaqkPBj
         fxNpyuRws07osa8Ikr3w7OWn6YN3ZIzLEsVSiqxn0xhx/2Ll93BusC3uRUEkjfDNRi
         Ln94Z4m4p0cL6QbfhDQL50xIrZkIz0HWmJIOUVkM=
Date:   Tue, 27 Oct 2020 14:53:58 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
cc:     Elliott Mitchell <ehem+undef@m5p.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, hch@lst.de
Subject: Re: [PATCH] fix swiotlb panic on Xen
In-Reply-To: <20201027192726.GA13396@char.us.oracle.com>
Message-ID: <alpine.DEB.2.21.2010271453480.12247@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2010261653320.12247@sstabellini-ThinkPad-T480s> <20201027175114.GA32110@mattapan.m5p.com> <20201027192726.GA13396@char.us.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020, Konrad Rzeszutek Wilk wrote:
> > As the person who first found this and then confirmed this fixes a bug:
> > 
> > Tested-by: Elliott Mitchell <ehem+xen@m5p.com>
> 
> Thank you!!
> 
> I changed the title and added the various tags and will put it in
> linux-next later this week.

Looks fine, thank you


> >From a1eb2768bf5954d25aa0f0136b38f0aa5d92d984 Mon Sep 17 00:00:00 2001
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Date: Mon, 26 Oct 2020 17:02:14 -0700
> Subject: [PATCH] swiotlb: fix "x86: Don't panic if can not alloc buffer for
>  swiotlb"
> 
> kernel/dma/swiotlb.c:swiotlb_init gets called first and tries to
> allocate a buffer for the swiotlb. It does so by calling
> 
>   memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
> 
> If the allocation must fail, no_iotlb_memory is set.
> 
> Later during initialization swiotlb-xen comes in
> (drivers/xen/swiotlb-xen.c:xen_swiotlb_init) and given that io_tlb_start
> is != 0, it thinks the memory is ready to use when actually it is not.
> 
> When the swiotlb is actually needed, swiotlb_tbl_map_single gets called
> and since no_iotlb_memory is set the kernel panics.
> 
> Instead, if swiotlb-xen.c:xen_swiotlb_init knew the swiotlb hadn't been
> initialized, it would do the initialization itself, which might still
> succeed.
> 
> Fix the panic by setting io_tlb_start to 0 on swiotlb initialization
> failure, and also by setting no_iotlb_memory to false on swiotlb
> initialization success.
> 
> Fixes: ac2cbab21f31 ("x86: Don't panic if can not alloc buffer for swiotlb")
> 
> Reported-by: Elliott Mitchell <ehem+xen@m5p.com>
> Tested-by: Elliott Mitchell <ehem+xen@m5p.com>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> CC: stable@vger.kernel.org
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 465a567678d9..e08cac39c0ba 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -229,6 +229,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	io_tlb_index = 0;
> +	no_iotlb_memory = false;
>  
>  	if (verbose)
>  		swiotlb_print_info();
> @@ -260,9 +261,11 @@ swiotlb_init(int verbose)
>  	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
>  		return;
>  
> -	if (io_tlb_start)
> +	if (io_tlb_start) {
>  		memblock_free_early(io_tlb_start,
>  				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
> +		io_tlb_start = 0;
> +	}
>  	pr_warn("Cannot allocate buffer");
>  	no_iotlb_memory = true;
>  }
> @@ -360,6 +363,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	io_tlb_index = 0;
> +	no_iotlb_memory = false;
>  
>  	swiotlb_print_info();
>  
> -- 
> 2.13.6
> 
