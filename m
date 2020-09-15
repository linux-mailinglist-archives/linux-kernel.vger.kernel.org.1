Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82AA26B143
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgIOW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgIOQTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:19:54 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A0920936;
        Tue, 15 Sep 2020 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600186696;
        bh=kNS2VFYnEd/KPhRHtnmjYC2U0lgvccEpIWWRdZorjVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuLTJKI/2BDlkCzhAdZXdO7Phze+fU6p3ap+8i/sd3vdr/I5Hi5U4yp9o6PB13lH0
         ZuDFlAbkp3tgU9RFrayVzFqYW4WJCxXIWagM397axnyN9OCpPbLSgg6bdhU9c5PFF/
         sRar6wzjO68M3MXjSEmVY0h5IDBQ7UJv15+bCkLU=
Date:   Tue, 15 Sep 2020 19:18:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] [PATCH] ARM64: Setup DMA32 zone size by bootargs
Message-ID: <20200915161808.GH2142832@kernel.org>
References: <20200915150855.24825-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915150855.24825-1-phil.chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:08:55PM +0800, Phil Chang wrote:
> Allowing the DMA32 zone be configurable in ARM64 but at most 4Gb.

Please add more details why would you like to limit the DMA32 zone.

> Signed-off-by: Alix Wu <alix.wu@mediatek.com>
> Signed-off-by: YJ Chiang <yj.chiang@mediatek.com>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
> 
>  .../admin-guide/kernel-parameters.txt         |  3 ++
>  arch/arm64/include/asm/memory.h               |  2 +
>  arch/arm64/mm/init.c                          | 39 +++++++++++++++++--
>  3 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdc1f33fd3d1..5be6259e9ba8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -980,6 +980,9 @@
>  			The filter can be disabled or changed to another
>  			driver later using sysfs.
>  
> +	dma32_size=nn[MG]  [KNL,BOOT,ARM64]
> +			Forces the DMA32 zone size of <nn> in MB.

Most of the kernel parameters that deal with memory sizes allow either
of [KMG] suffixes.

> +
>  	driver_async_probe=  [KNL]
>  			List of driver names to be probed asynchronously.
>  			Format: <driver_name1>,<driver_name2>...
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index afa722504bfd..710de08ae8ae 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -175,6 +175,8 @@ extern u64			kimage_vaddr;
>  /* the offset between the kernel virtual and physical mappings */
>  extern u64			kimage_voffset;
>  
> +extern phys_addr_t		dma32_zone_size;
> +
>  static inline unsigned long kaslr_offset(void)
>  {
>  	return kimage_vaddr - KIMAGE_VADDR;
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 481d22c32a2e..c8af53680d46 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -60,6 +60,9 @@ EXPORT_SYMBOL(physvirt_offset);
>  struct page *vmemmap __ro_after_init;
>  EXPORT_SYMBOL(vmemmap);
>  
> +phys_addr_t dma32_zone_size __ro_after_init;
> +EXPORT_SYMBOL(dma32_zone_size);
> +
>  /*
>   * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA covers the first 1G of
>   * memory as some devices, namely the Raspberry Pi 4, have peripherals with
> @@ -242,6 +245,29 @@ static int __init early_mem(char *p)
>  }
>  early_param("mem", early_mem);
>  
> +static int __init setup_dma32_zone(char *p)
> +{
> +	u64 size;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	if (kstrtoull(p, 0, &size))
> +		return -EINVAL;

Better to use memparse() here.

> +
> +	/* DMA32 zone size should never grater than 4G */
> +	if (size > max_zone_phys(32) / SZ_1M)
> +		return -EINVAL;
> +
> +	pr_notice("Setup dma32 zone size to %llu Mb\n", size);
> +
> +	dma32_zone_size = size * SZ_1M;
> +
> +	return 0;
> +}
> +
> +early_param("dma32_size", setup_dma32_zone);
> +
>  static int __init early_init_dt_scan_usablemem(unsigned long node,
>  		const char *uname, int depth, void *data)
>  {
> @@ -392,10 +418,17 @@ void __init arm64_memblock_init(void)
>  		arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
>  	}
>  
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> -		arm64_dma32_phys_limit = max_zone_phys(32);
> -	else
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
> +		if (dma32_zone_size) {
> +			arm64_dma32_phys_limit = min(max_zone_phys(32),
> +				dma32_zone_size + memblock_start_of_DRAM());
> +		} else {
> +			arm64_dma32_phys_limit = max_zone_phys(32);
> +			dma32_zone_size = arm64_dma32_phys_limit;
> +		}

I think this calculations can be hidden in max_zone_phys(), e.g.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 481d22c32a2e..be3fdfb35a56 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -189,7 +189,12 @@ static void __init reserve_elfcorehdr(void)
 static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 {
 	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
-	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
+	phys_addr_t zone_size = (1ULL << zone_bits);
+
+	if (IS_ENABLED(CONFIG_ZONE_DMA32) && zone_bits == 32 && dma32_zone_size)
+		zone_bits = min(zone_size,dma32_zone_size);
+
+	return min(offset + zone_size, memblock_end_of_DRAM());
 }
 
 static void __init zone_sizes_init(unsigned long min, unsigned long max)

> +	} else {
>  		arm64_dma32_phys_limit = PHYS_MASK + 1;
> +	}
>  
>  	reserve_crashkernel();
>  
> -- 
> 2.18.0

-- 
Sincerely yours,
Mike.
