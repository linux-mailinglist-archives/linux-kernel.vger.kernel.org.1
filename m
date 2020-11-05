Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509722A8326
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgKEQL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:11:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgKEQL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:11:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F66514BF;
        Thu,  5 Nov 2020 08:11:25 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0BB3F718;
        Thu,  5 Nov 2020 08:11:17 -0800 (PST)
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        will@kernel.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
Date:   Thu, 5 Nov 2020 16:11:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103173159.27570-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 03/11/2020 17:31, Nicolas Saenz Julienne wrote:
> crashkernel might reserve memory located in ZONE_DMA. We plan to delay
> ZONE_DMA's initialization after unflattening the devicetree and ACPI's
> boot table initialization, so move it later in the boot process.
> Specifically into mem_init(), this is the last place crashkernel will be
> able to reserve the memory before the page allocator kicks in.

> There
> isn't any apparent reason for doing this earlier.

It's so that map_mem() can carve it out of the linear/direct map.
This is so that stray writes from a crashing kernel can't accidentally corrupt the kdump
kernel. We depend on this if we continue with kdump, but failed to offline all the other
CPUs. We also depend on this when skipping the checksum code in purgatory, which can be
exceedingly slow.

Grepping around, the current order is:

start_kernel()
-> setup_arch()
	-> arm64_memblock_init()	/* reserve */
	-> paging_init()
		-> map_mem()		/* carve out reservation */
[...]
	-> mm_init()
		-> mem_init()


I agree we should add comments to make this apparent!


Thanks,

James


> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 095540667f0f..fc4ab0d6d5d2 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -386,8 +386,6 @@ void __init arm64_memblock_init(void)
>  	else
>  		arm64_dma32_phys_limit = PHYS_MASK + 1;
>  
> -	reserve_crashkernel();
> -
>  	reserve_elfcorehdr();
>  
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> @@ -508,6 +506,8 @@ void __init mem_init(void)
>  	else
>  		swiotlb_force = SWIOTLB_NO_FORCE;
>  
> +	reserve_crashkernel();
> +
>  	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
>  
>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
> 

