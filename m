Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434BE2FFB06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAVD0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbhAVD0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:26:40 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F6C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:25:59 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p18so2744853pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Gsjy534BQS56SU6SeFB/WjmC/NWzmnXhGpzGJe7xB60=;
        b=SG2JTRlpXpM4jYWnQLSpXSQqE1+M9/S0sKrdBaso1OszGUCKVrQPawHx1rQXdi28e/
         QvnG3RO7Y6iSNHtt7uaomykbpXiMdzyQJuvCqTRaj1qwFwwbcM/eMz2Q6pSeJmWeEna8
         LGe8DTS2wY1zx8ShTQSiqiJYutZx42G2Jo9R0WrJynYvRfrfTtIAIQrx/x9NVCJ9FrAZ
         p3COnS7W/dv8Y6AIxI2qybJGS3SM0C3lM6JOGNHG/JVTZBEr6LI1zdMjPqAKvgSKsjYg
         +nNccJ4jfcIyegU+I8KMgRhIx2B7LkAQPvWcy4t26jkVv8jPrdmrmtpcj6KKH0dQ0DUS
         UbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Gsjy534BQS56SU6SeFB/WjmC/NWzmnXhGpzGJe7xB60=;
        b=SW1ZNXLDiMv2s4cUuAfywJ3wONZpaAo59ZOPzgickfHZmiNGa4s0ZUCtkVfTsbZ0SS
         YcWBtM6qUMaXugbkFYhD8j4fxAZhKdfgF1YV8a3SbLyuezol90pb7nuTo8geAJ8etnka
         IxEgm9/sob8nY8n5sGBcuKdoNJ6WDP++Xtkvhd+1ZYzBWC8hVKkh3JvPkm9uOcVG8+ZE
         gizCC9/SjXYG3ZKXuDfL6AgRXe2nvWCiPlzFqufeaRLZJaZMYRLIBcJePTpYdKcFckgK
         Du+6gzC1P0N/WqGKv2G2tkYYFxswMN2NGar+Qke+zg0jN52qIHy8ayYSyr3Z8e9q1bCf
         oVdQ==
X-Gm-Message-State: AOAM5318mpq61ImJELmK3nKHsV2TCBJorci65kNjOLViuemGtoRvvucx
        QnXdTg2UiWAqf9t3GHijL/P5LlqLEzXPBw==
X-Google-Smtp-Source: ABdhPJzv+pZUIoh5eVCAREqwtrXilW4g0JNeb6u7OH+Lq191AYyMZ4OmtpuMycM9Wqk4ungdHbcaxw==
X-Received: by 2002:a62:ddcf:0:b029:1b7:baca:6c71 with SMTP id w198-20020a62ddcf0000b02901b7baca6c71mr2734869pff.43.1611285958914;
        Thu, 21 Jan 2021 19:25:58 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c11sm7153264pjv.3.2021.01.21.19.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:25:58 -0800 (PST)
Date:   Thu, 21 Jan 2021 19:25:58 -0800 (PST)
X-Google-Original-Date: Thu, 21 Jan 2021 19:23:53 PST (-0800)
Subject:     Re: [PATCH v3] riscv: add BUILTIN_DTB support for MMU-enabled targets
In-Reply-To: <20210115234947.44014-1-vitaly.wool@konsulko.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        devicetree@vger.kernel.org, vitaly.wool@konsulko.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     vitaly.wool@konsulko.com
Message-ID: <mhng-44310bfb-e106-449b-830c-78b5e140fadb@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 15:49:48 PST (-0800), vitaly.wool@konsulko.com wrote:
> Sometimes, especially in a production system we may not want to
> use a "smart bootloader" like u-boot to load kernel, ramdisk and
> device tree from a filesystem on eMMC, but rather load the kernel
> from a NAND partition and just run it as soon as we can, and in
> this case it is convenient to have device tree compiled into the
> kernel binary. Since this case is not limited to MMU-less systems,
> let's support it for these which have MMU enabled too.
>
> While at it, provide __dtb_start as a parameter to setup_vm() in
> BUILTIN_DTB case, so we don't have to duplicate BUILTIN_DTB specific
> processing in MMU-enabled and MMU-disabled versions of setup_vm().
>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---
> Changes from v2:
> * folded "RISC-V: simplify BUILTIN_DTB processing" patch
> [http://lists.infradead.org/pipermail/linux-riscv/2021-January/004153.html]
> Changes from v1:
> * no direct initial_boot_params assignment
> * skips the temporary mapping for DT if BUILTIN_DTB=y
>
>  arch/riscv/Kconfig       |  1 -
>  arch/riscv/kernel/head.S |  4 ++++
>  arch/riscv/mm/init.c     | 19 +++++++++++++------
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2ef05ef921b5..444a1ed1e847 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -445,7 +445,6 @@ endmenu
>
>  config BUILTIN_DTB
>  	def_bool n
> -	depends on RISCV_M_MODE
>  	depends on OF
>
>  menu "Power management options"
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 16e9941900c4..f5a9bad86e58 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -260,7 +260,11 @@ clear_bss_done:
>
>  	/* Initialize page tables and relocate to virtual addresses */
>  	la sp, init_thread_union + THREAD_SIZE
> +#ifdef CONFIG_BUILTIN_DTB
> +	la a0, __dtb_start
> +#else
>  	mv a0, s1
> +#endif /* CONFIG_BUILTIN_DTB */
>  	call setup_vm
>  #ifdef CONFIG_MMU
>  	la a0, early_pg_dir
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 30b61f2c6b87..45faad7c4291 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -192,10 +192,13 @@ void __init setup_bootmem(void)
>  #endif /* CONFIG_BLK_DEV_INITRD */
>
>  	/*
> -	 * Avoid using early_init_fdt_reserve_self() since __pa() does
> +	 * If DTB is built in, no need to reserve its memblock.
> +	 * Otherwise, do reserve it but avoid using
> +	 * early_init_fdt_reserve_self() since __pa() does
>  	 * not work for DTB pointers that are fixmap addresses
>  	 */
> -	memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> +		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>
>  	early_init_fdt_scan_reserved_mem();
>  	dma_contiguous_reserve(dma32_phys_limit);
> @@ -499,6 +502,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	/* Setup early PMD for DTB */
>  	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
>  			   (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
> +#ifndef CONFIG_BUILTIN_DTB
>  	/* Create two consecutive PMD mappings for FDT early scan */
>  	pa = dtb_pa & ~(PMD_SIZE - 1);
>  	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
> @@ -506,7 +510,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
>  			   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
>  	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
> +#else /* CONFIG_BUILTIN_DTB */
> +	dtb_early_va = __va(dtb_pa);
> +#endif /* CONFIG_BUILTIN_DTB */
>  #else
> +#ifndef CONFIG_BUILTIN_DTB
>  	/* Create two consecutive PGD mappings for FDT early scan */
>  	pa = dtb_pa & ~(PGDIR_SIZE - 1);
>  	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> @@ -514,6 +522,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
>  			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
>  	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
> +#else /* CONFIG_BUILTIN_DTB */
> +	dtb_early_va = __va(dtb_pa);
> +#endif /* CONFIG_BUILTIN_DTB */
>  #endif
>  	dtb_early_pa = dtb_pa;
>
> @@ -604,11 +615,7 @@ static void __init setup_vm_final(void)
>  #else
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
> -#ifdef CONFIG_BUILTIN_DTB
> -	dtb_early_va = (void *) __dtb_start;
> -#else
>  	dtb_early_va = (void *)dtb_pa;
> -#endif
>  	dtb_early_pa = dtb_pa;
>  }

Thanks, this is on for-next.
