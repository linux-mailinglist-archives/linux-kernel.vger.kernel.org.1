Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36B428B3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbgJLLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388239AbgJLLhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:37:53 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196EE206E5;
        Mon, 12 Oct 2020 11:37:50 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:37:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, hch@lst.de, ardb@kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/5] arm64: mm: Move zone_dma_bits initialization into
 zone_sizes_init()
Message-ID: <20201012113748.GE9844@gaia>
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010151235.20585-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 05:12:31PM +0200, Nicolas Saenz Julienne wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f6902a2b4ea6..0eca5865dcb1 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -196,14 +196,16 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>  
>  #ifdef CONFIG_ZONE_DMA
> +	zone_dma_bits = ARM64_ZONE_DMA_BITS;
> +
>  	if (IS_ENABLED(CONFIG_ACPI)) {
>  		extern unsigned int acpi_iort_get_zone_dma_size(void);
>  
>  		zone_dma_bits = min(zone_dma_bits,
>  				    acpi_iort_get_zone_dma_size());
> -		arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
>  	}
>  
> +	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32
> @@ -394,11 +396,6 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> -		zone_dma_bits = ARM64_ZONE_DMA_BITS;
> -		arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
> -	}

arm64_dma_phys_limit is used by memblock_alloc_low() (via
ARCH_LOW_ADDRESS_LIMIT). I think it's too late to leave its
initialisation to zone_sizes_init().

-- 
Catalin
