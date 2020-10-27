Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20E529C6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827250AbgJ0SWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:22:33 -0400
Received: from mailhost.m5p.com ([74.104.188.4]:29455 "EHLO mailhost.m5p.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1826543AbgJ0SUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:20:22 -0400
X-Greylist: delayed 1721 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 14:20:22 EDT
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
        by mailhost.m5p.com (8.15.2/8.15.2) with ESMTPS id 09RHpF0L032137
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 27 Oct 2020 13:51:20 -0400 (EDT)
        (envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
        by m5p.com (8.15.2/8.15.2/Submit) id 09RHpEQr032136;
        Tue, 27 Oct 2020 10:51:14 -0700 (PDT)
        (envelope-from ehem)
Date:   Tue, 27 Oct 2020 10:51:14 -0700
From:   Elliott Mitchell <ehem+undef@m5p.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, konrad.wilk@oracle.com, hch@lst.de
Subject: Re: [PATCH] fix swiotlb panic on Xen
Message-ID: <20201027175114.GA32110@mattapan.m5p.com>
References: <alpine.DEB.2.21.2010261653320.12247@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010261653320.12247@sstabellini-ThinkPad-T480s>
X-Spam-Status: No, score=0.0 required=10.0 tests=KHOP_HELO_FCRDNS
        autolearn=unavailable autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mattapan.m5p.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:02:14PM -0700, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> kernel/dma/swiotlb.c:swiotlb_init gets called first and tries to
> allocate a buffer for the swiotlb. It does so by calling
> 
>   memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
> 
> If the allocation must fail, no_iotlb_memory is set.
> 
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
> 
> Fix the panic by setting io_tlb_start to 0 on swiotlb initialization
> failure, and also by setting no_iotlb_memory to false on swiotlb
> initialization success.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19379fabd20..9924214df60a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -231,6 +231,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	io_tlb_index = 0;
> +	no_iotlb_memory = false;
>  
>  	if (verbose)
>  		swiotlb_print_info();
> @@ -262,9 +263,11 @@ swiotlb_init(int verbose)
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
> @@ -362,6 +365,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	io_tlb_index = 0;
> +	no_iotlb_memory = false;
>  
>  	swiotlb_print_info();
>  

As the person who first found this and then confirmed this fixes a bug:

Tested-by: Elliott Mitchell <ehem+xen@m5p.com>


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


