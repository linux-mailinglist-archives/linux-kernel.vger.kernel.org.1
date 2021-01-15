Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD02F70A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbhAOCdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbhAOCdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:33:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:33:04 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v3so3919904plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=JnaSGfJtOIit6mn8j+tKksOhMgr8XbO/qeaO1rbIlgE=;
        b=M3D3RdZnIWZhoP2FbSU7H4kzbubXSTwUj7R1cMqL9BXmmI/Ept7l28Q24Um/pHR23/
         fD/CnGScG1y2nK7FEPNAeRBTIIuaBX7OkNM0tsO3noAh3GApP/O3Bq3HfjxeiFfD+ZDD
         i+2+0t6ZtT4bdqW0+/lSAek2vsRZO2cH1nVrLOGFTokdxY47MpRZQ55WEIOrCrApu2OM
         WOlLqJmnZZQEY8/618JXF9IEPRkgmvqU5114S/qF+nNrNxgFnGQ7hF///8wbzaCztnsd
         reKATUCJAmtZo8DLg9ypBBTZXJdvvLSMpp745Ldi5HmYxvL5+rRNfNH/vVRJtHwbRacJ
         1Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=JnaSGfJtOIit6mn8j+tKksOhMgr8XbO/qeaO1rbIlgE=;
        b=MxcXNfQ7Gu3epqlYoW7NgsY7oQMSwnwzePb0ZZdOTDadlRR8PUNSaPacqkX+Qamu25
         g3lDnTlfd4PewnPzx8Ru0Kp//RVwQJtHayvMUpeBT1JDZ1b0OmfHy53OmUb05s88MZag
         IEIU9/jhg4Fhj9QCUSmxmCVnoLVDqhz27HTzJBhEaZ7M7E7gV2XsOspF7lbbaJcRMNjV
         PSRVvK3ESKtvnYfSyKPl+8etXBPgtI18H44h/xk7MfjLJ+GgDbp6ytL+QeospoKfvlXT
         l10Kufw23VH0aOriCQemYUg53VQNrThfeu6aD5pUz7DrYkivqwEjMjuuH3q6DhUWR+yr
         b8zw==
X-Gm-Message-State: AOAM53365l9+gVziAz2xQscrv/huTM+9Dl5nLfDRQBWGtPp6GxN8mKap
        ajNfimRRLh+fFZ/TOPf4k68J2Q==
X-Google-Smtp-Source: ABdhPJx9CtB/nQ1G0zSjSjhXt54hVd39Ky3Aowjgi42BadbWjyuDLQs7tkSofuYj7FHX2m4I6g61aQ==
X-Received: by 2002:a17:902:a5cb:b029:dc:2706:4cc8 with SMTP id t11-20020a170902a5cbb02900dc27064cc8mr10497550plq.62.1610677983962;
        Thu, 14 Jan 2021 18:33:03 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e3sm178929pgs.60.2021.01.14.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 18:33:03 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:33:03 -0800 (PST)
X-Google-Original-Date: Thu, 14 Jan 2021 18:31:24 PST (-0800)
Subject:     Re: [PATCH v2] initramfs: Provide a common initrd reserve function
In-Reply-To: <20210114023358.176459-1-wangkefeng.wang@huawei.com>
Message-ID: <mhng-68a3f8a1-02f5-4487-ae17-fc06c81f072c@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@armlinux.org.uk,
        Atish Patra <Atish.Patra@wdc.com>, guoren@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        wangkefeng.wang@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 18:33:58 PST (-0800), wangkefeng.wang@huawei.com wrote:
> The ARM and riscv have same logic to check and reserve
> the memory of initrd, let's provide a common function to
> reduce duplicated code.
>
> Add __LINUX_INITRD_H define in initrd.h to prevent build error
> (found by kernel test robot <lkp@intel.com>) from the multiple
> inclusion of same header file multiple time.

This is doing a bunch of different things:

* Fixing the lack of a preprocessor guard in initrd.h
* Adding some generic code.
* Converting two architectures over to that generic code.

It needs to be split into four patches.  I'm happy to take them via the RISC-V 
tree (with an Ack from for the arch/arm/ stuff), but not all together.

It looks like csky copied this as well, they at least have exactly the same 
message.

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: fix build err
>
>  arch/arm/mm/init.c     | 43 +---------------------------------
>  arch/riscv/mm/init.c   | 53 +-----------------------------------------
>  include/linux/initrd.h | 11 +++++++++
>  init/initramfs.c       | 45 +++++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 94 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 828a2561b229..a29e14cd626c 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -153,47 +153,6 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
>  	return phys;
>  }
>
> -static void __init arm_initrd_init(void)
> -{
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	phys_addr_t start;
> -	unsigned long size;
> -
> -	initrd_start = initrd_end = 0;
> -
> -	if (!phys_initrd_size)
> -		return;
> -
> -	/*
> -	 * Round the memory region to page boundaries as per free_initrd_mem()
> -	 * This allows us to detect whether the pages overlapping the initrd
> -	 * are in use, but more importantly, reserves the entire set of pages
> -	 * as we don't want these pages allocated for other purposes.
> -	 */
> -	start = round_down(phys_initrd_start, PAGE_SIZE);
> -	size = phys_initrd_size + (phys_initrd_start - start);
> -	size = round_up(size, PAGE_SIZE);
> -
> -	if (!memblock_is_region_memory(start, size)) {
> -		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
> -		       (u64)start, size);
> -		return;
> -	}
> -
> -	if (memblock_is_region_reserved(start, size)) {
> -		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
> -		       (u64)start, size);
> -		return;
> -	}
> -
> -	memblock_reserve(start, size);
> -
> -	/* Now convert initrd to virtual addresses */
> -	initrd_start = __phys_to_virt(phys_initrd_start);
> -	initrd_end = initrd_start + phys_initrd_size;
> -#endif
> -}
> -
>  #ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
>  void check_cpu_icache_size(int cpuid)
>  {
> @@ -215,7 +174,7 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
>  	/* Register the kernel text, kernel data and initrd with memblock. */
>  	memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
>
> -	arm_initrd_init();
> +	reserve_initrd_mem();
>
>  	arm_mm_memblock_reserve();
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index da53902ef0fc..93cba0d3f43f 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -105,55 +105,6 @@ void __init mem_init(void)
>  	print_vm_layout();
>  }
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -static void __init setup_initrd(void)
> -{
> -	phys_addr_t start;
> -	unsigned long size;
> -
> -	/* Ignore the virtul address computed during device tree parsing */
> -	initrd_start = initrd_end = 0;
> -
> -	if (!phys_initrd_size)
> -		return;
> -	/*
> -	 * Round the memory region to page boundaries as per free_initrd_mem()
> -	 * This allows us to detect whether the pages overlapping the initrd
> -	 * are in use, but more importantly, reserves the entire set of pages
> -	 * as we don't want these pages allocated for other purposes.
> -	 */
> -	start = round_down(phys_initrd_start, PAGE_SIZE);
> -	size = phys_initrd_size + (phys_initrd_start - start);
> -	size = round_up(size, PAGE_SIZE);
> -
> -	if (!memblock_is_region_memory(start, size)) {
> -		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region",
> -		       (u64)start, size);
> -		goto disable;
> -	}
> -
> -	if (memblock_is_region_reserved(start, size)) {
> -		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region\n",
> -		       (u64)start, size);
> -		goto disable;
> -	}
> -
> -	memblock_reserve(start, size);
> -	/* Now convert initrd to virtual addresses */
> -	initrd_start = (unsigned long)__va(phys_initrd_start);
> -	initrd_end = initrd_start + phys_initrd_size;
> -	initrd_below_start_ok = 1;
> -
> -	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
> -		(void *)(initrd_start), size);
> -	return;
> -disable:
> -	pr_cont(" - disabling initrd\n");
> -	initrd_start = 0;
> -	initrd_end = 0;
> -}
> -#endif /* CONFIG_BLK_DEV_INITRD */
> -
>  void __init setup_bootmem(void)
>  {
>  	phys_addr_t mem_start = 0;
> @@ -198,9 +149,7 @@ void __init setup_bootmem(void)
>  	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
>  	set_max_mapnr(max_low_pfn);
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	setup_initrd();
> -#endif /* CONFIG_BLK_DEV_INITRD */
> +	reserve_initrd_mem();
>
>  	/*
>  	 * Avoid using early_init_fdt_reserve_self() since __pa() does
> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
> index 8db6f8c8030b..85c15717af34 100644
> --- a/include/linux/initrd.h
> +++ b/include/linux/initrd.h
> @@ -1,5 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>
> +#ifndef __LINUX_INITRD_H
> +#define __LINUX_INITRD_H
> +
>  #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
>
>  /* starting block # of image */
> @@ -15,6 +18,12 @@ extern int initrd_below_start_ok;
>  extern unsigned long initrd_start, initrd_end;
>  extern void free_initrd_mem(unsigned long, unsigned long);
>
> +#ifdef CONFIG_BLK_DEV_INITRD
> +extern void __init reserve_initrd_mem(void);
> +#else
> +static inline void __init reserve_initrd_mem(void) {}
> +#endif
> +
>  extern phys_addr_t phys_initrd_start;
>  extern unsigned long phys_initrd_size;
>
> @@ -24,3 +33,5 @@ extern char __initramfs_start[];
>  extern unsigned long __initramfs_size;
>
>  void console_on_rootfs(void);
> +
> +#endif /* __LINUX_INITRD_H */
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 55b74d7e5260..f75c89e9d602 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -535,6 +535,51 @@ extern unsigned long __initramfs_size;
>  #include <linux/initrd.h>
>  #include <linux/kexec.h>
>
> +void __init reserve_initrd_mem(void)
> +{
> +	phys_addr_t start;
> +	unsigned long size;
> +
> +	/* Ignore the virtul address computed during device tree parsing */
> +	initrd_start = initrd_end = 0;
> +
> +	if (!phys_initrd_size)
> +		return;
> +	/*
> +	 * Round the memory region to page boundaries as per free_initrd_mem()
> +	 * This allows us to detect whether the pages overlapping the initrd
> +	 * are in use, but more importantly, reserves the entire set of pages
> +	 * as we don't want these pages allocated for other purposes.
> +	 */
> +	start = round_down(phys_initrd_start, PAGE_SIZE);
> +	size = phys_initrd_size + (phys_initrd_start - start);
> +	size = round_up(size, PAGE_SIZE);
> +
> +	if (!memblock_is_region_memory(start, size)) {
> +		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region",
> +		       (u64)start, size);
> +		goto disable;
> +	}
> +
> +	if (memblock_is_region_reserved(start, size)) {
> +		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region\n",
> +		       (u64)start, size);
> +		goto disable;
> +	}
> +
> +	memblock_reserve(start, size);
> +	/* Now convert initrd to virtual addresses */
> +	initrd_start = (unsigned long)__va(phys_initrd_start);
> +	initrd_end = initrd_start + phys_initrd_size;
> +	initrd_below_start_ok = 1;
> +
> +	return;
> +disable:
> +	pr_cont(" - disabling initrd\n");
> +	initrd_start = 0;
> +	initrd_end = 0;
> +}
> +
>  void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
>  {
>  #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
