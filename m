Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6C2AE61A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbgKKB7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732086AbgKKB7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605059980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mt6jzWX3XwZDGmynY5Ud1T770jYqAon6q0lnQtrZS3s=;
        b=OjQnW3HbMVCJyMN8G+LgT9JYWbC79cveLNGp5jgLmboUc02mPEYQKCDC4wjMpD8GjhyAX0
        kuQ35pcFzrWAc6gt2beJPk5Sjp3iHzdtLhRvfc3/5Ow3qkxdmRIfYgm0l2nQgGzUVPhf0L
        btb2rGQfKrGrKJ3wvd+ejQ48wQi+YC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-rWtl0_CbOlGHYNxDYCqh3w-1; Tue, 10 Nov 2020 20:59:36 -0500
X-MC-Unique: rWtl0_CbOlGHYNxDYCqh3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C4411007487;
        Wed, 11 Nov 2020 01:59:34 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F9B5DA6A;
        Wed, 11 Nov 2020 01:59:28 +0000 (UTC)
Date:   Wed, 11 Nov 2020 09:59:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
        John.P.donnelly@oracle.com, bhsharma@redhat.com,
        prabhakar.pkin@gmail.com, wangkefeng.wang@huawei.com,
        arnd@arndb.de, linux-doc@vger.kernel.org, xiexiuqi@huawei.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, horms@verge.net.au, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com,
        guohanjun@huawei.com, nsaenzjulienne@suse.de
Subject: Re: [PATCH v13 6/8] arm64: kdump: reimplement crashkernel=X
Message-ID: <20201111015926.GD24747@MiWiFi-R3L-srv>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-7-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031074437.168008-7-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/20 at 03:44pm, Chen Zhou wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
> the devices in crash dump kernel need to use ZONE_DMA will alloc
> fail.
> 
> To solve these issues, change the behavior of crashkernel=X and
> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
> in DMA zone or DMA32 zone if CONFIG_ZONE_DMA is disabled, and fall back
> to high allocation if it fails.
> We can also use "crashkernel=X,high" to select a region above DMA zone,
> which also tries to allocate at least 256M in DMA zone automatically
> (or the DMA32 zone if CONFIG_ZONE_DMA is disabled).
> "crashkernel=Y,low" can be used to allocate specified size low memory.
> 
> Another minor change, there may be two regions reserved for crash
> dump kernel, in order to distinct from the high region and make no
> effect to the use of existing kexec-tools, rename the low region as
> "Crash kernel (low)".
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> ---
>  arch/arm64/include/asm/kexec.h |  9 +++++
>  arch/arm64/kernel/setup.c      | 13 +++++++-
>  arch/arm64/mm/init.c           | 60 ++--------------------------------
>  arch/arm64/mm/mmu.c            |  4 +++
>  kernel/crash_core.c            |  8 +++--
>  5 files changed, 34 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 402d208265a3..79909ae5e22e 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -28,7 +28,12 @@
>  /* 2M alignment for crash kernel regions */
>  #define CRASH_ALIGN	SZ_2M
>  
> +#ifdef CONFIG_ZONE_DMA
> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> +#else
>  #define CRASH_ADDR_LOW_MAX	arm64_dma32_phys_limit
> +#endif
> +
>  #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
>  
>  #ifndef __ASSEMBLY__
> @@ -96,6 +101,10 @@ static inline void crash_prepare_suspend(void) {}
>  static inline void crash_post_resume(void) {}
>  #endif
>  
> +#ifdef CONFIG_KEXEC_CORE
> +extern void __init reserve_crashkernel(void);
> +#endif
> +
>  #ifdef CONFIG_KEXEC_FILE
>  #define ARCH_HAS_KIMAGE_ARCH
>  
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 133257ffd859..6aff30de8f47 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -238,7 +238,18 @@ static void __init request_standard_resources(void)
>  		    kernel_data.end <= res->end)
>  			request_resource(res, &kernel_data);
>  #ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> +		/*
> +		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
> +		 * region in /proc/iomem.
> +		 * In order to distinct from the high region and make no effect
> +		 * to the use of existing kexec-tools, rename the low region as
> +		 * "Crash kernel (low)".
> +		 */
> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +				crashk_low_res.end <= res->end) {
> +			crashk_low_res.name = "Crash kernel (low)";
> +			request_resource(res, &crashk_low_res);
> +		}
>  		if (crashk_res.end && crashk_res.start >= res->start &&
>  		    crashk_res.end <= res->end)
>  			request_resource(res, &crashk_res);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a07fd8e1f926..888c4f7eadc3 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -34,6 +34,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/kasan.h>
>  #include <asm/kernel-pgtable.h>
> +#include <asm/kexec.h>
>  #include <asm/memory.h>
>  #include <asm/numa.h>
>  #include <asm/sections.h>
> @@ -62,66 +63,11 @@ EXPORT_SYMBOL(memstart_addr);
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  phys_addr_t arm64_dma32_phys_limit __ro_after_init;
>  
> -#ifdef CONFIG_KEXEC_CORE
> -/*
> - * reserve_crashkernel() - reserves memory for crash kernel
> - *
> - * This function reserves memory area given in "crashkernel=" kernel command
> - * line parameter. The memory reserved is used by dump capture kernel when
> - * primary kernel is crashing.
> - */
> -static void __init reserve_crashkernel(void)
> -{
> -	unsigned long long crash_base, crash_size;
> -	int ret;
> -
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -				&crash_size, &crash_base);
> -	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> -
> -	crash_size = PAGE_ALIGN(crash_size);
> -
> -	if (crash_base == 0) {
> -		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX,
> -				crash_size, CRASH_ALIGN);
> -		if (crash_base == 0) {
> -			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -				crash_size);
> -			return;
> -		}
> -	} else {
> -		/* User specifies base address explicitly. */
> -		if (!memblock_is_region_memory(crash_base, crash_size)) {
> -			pr_warn("cannot reserve crashkernel: region is not memory\n");
> -			return;
> -		}
> -
> -		if (memblock_is_region_reserved(crash_base, crash_size)) {
> -			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
> -			return;
> -		}
> -
> -		if (!IS_ALIGNED(crash_base, CRASH_ALIGN)) {
> -			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
> -			return;
> -		}
> -	}
> -	memblock_reserve(crash_base, crash_size);
> -
> -	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> -		crash_base, crash_base + crash_size, crash_size >> 20);
> -
> -	crashk_res.start = crash_base;
> -	crashk_res.end = crash_base + crash_size - 1;
> -}
> -#else
> +#ifndef CONFIG_KEXEC_CORE
>  static void __init reserve_crashkernel(void)
>  {
>  }
> -#endif /* CONFIG_KEXEC_CORE */
> +#endif
>  
>  #ifdef CONFIG_CRASH_DUMP
>  static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1c0f3e02f731..c55cee290bbb 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -488,6 +488,10 @@ static void __init map_mem(pgd_t *pgdp)
>  	 */
>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>  #ifdef CONFIG_KEXEC_CORE
> +	if (crashk_low_res.end)
> +		memblock_mark_nomap(crashk_low_res.start,
> +				    resource_size(&crashk_low_res));
> +
>  	if (crashk_res.end)
>  		memblock_mark_nomap(crashk_res.start,
>  				    resource_size(&crashk_res));
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d39892bdb9ae..cdef7d8c91a6 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -321,7 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
>  
>  int __init reserve_crashkernel_low(void)
>  {
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)

Not very sure if a CONFIG_64BIT checking is better.

>  	unsigned long long base, low_base = 0, low_size = 0;
>  	unsigned long low_mem_limit;
>  	int ret;
> @@ -362,12 +362,14 @@ int __init reserve_crashkernel_low(void)
>  
>  	crashk_low_res.start = low_base;
>  	crashk_low_res.end   = low_base + low_size - 1;
> +#ifdef CONFIG_X86_64
>  	insert_resource(&iomem_resource, &crashk_low_res);
> +#endif
>  #endif
>  	return 0;
>  }
>  
> -#ifdef CONFIG_X86
> +#if defined(CONFIG_X86) || defined(CONFIG_ARM64)

Should we make this weak default so that we can remove the ARCH config?

>  #ifdef CONFIG_KEXEC_CORE
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
> @@ -453,7 +455,9 @@ void __init reserve_crashkernel(void)
>  
>  	crashk_res.start = crash_base;
>  	crashk_res.end   = crash_base + crash_size - 1;
> +#ifdef CONFIG_X86
>  	insert_resource(&iomem_resource, &crashk_res);
> +#endif
>  }
>  #endif /* CONFIG_KEXEC_CORE */
>  #endif
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

