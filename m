Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EAE2804FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbgJART1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJART1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:19:27 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 069D92085B;
        Thu,  1 Oct 2020 17:19:24 +0000 (UTC)
Date:   Thu, 1 Oct 2020 18:19:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, hch@lst.de, robin.murphy@arm.com,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: Default to 32-bit ZONE_DMA
Message-ID: <20201001171922.GO21544@gaia>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001161740.29064-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 06:17:39PM +0200, Nicolas Saenz Julienne wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e1a69a618832..3c3f462466eb 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -43,8 +43,6 @@
>  #include <asm/tlb.h>
>  #include <asm/alternative.h>
>  
> -#define ARM64_ZONE_DMA_BITS	30
> -
>  /*
>   * We need to be able to catch inadvertent references to memstart_addr
>   * that occur (potentially in generic code) before arm64_memblock_init()
> @@ -388,8 +386,14 @@ void __init arm64_memblock_init(void)
>  	early_init_fdt_scan_reserved_mem();
>  
>  	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> -		zone_dma_bits = ARM64_ZONE_DMA_BITS;
> -		arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
> +		/*
> +		 * early_init_dt_scan() might alter zone_dma_bits based on the
> +		 * device's DT. Otherwise, have it cover the 32-bit address
> +		 * space.
> +		 */
> +		if (zone_dma_bits == ZONE_DMA_BITS_DEFAULT)
> +			zone_dma_bits = 32;
> +		arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);

So here we assume that if zone_dma_bits is 24, it wasn't initialised. I
think it may be simpler if we just set it in setup_machine_fdt() to 32
or 30 if RPi4. This way we don't have to depend on what the core kernel
sets.

-- 
Catalin
