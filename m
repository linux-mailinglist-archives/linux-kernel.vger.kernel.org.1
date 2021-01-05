Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF12EA9D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbhAEL0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbhAEL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:26:11 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8126C061794
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 03:25:30 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o17so71758527lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 03:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjZ/0WcAaB7nd5drpvsqUaYdHBWyehQvrygbYW5v7xY=;
        b=dTxzWqeihvhN5HaLbEHaMANFr/Uc0Q6j7hsR6BLXMwiX43VNxsItgZXmPx/kQguS7Y
         2kGu1hQ5KjAhGGUo9tMJ8H0iXQSxbWhV/O+93uhq0aK1nxSrQY+II09z8xqu/2DafVz3
         5i9rjhEKC2Dm/PA3HjtTGA74YCWsyM+B2kXPlMjcwBPHI/29qqBq8gdzDBK0LgwLqkii
         ufpnn7DUHXIRYVISJpfZoyNBVzb3XLy7jo9U6TPL9ZTIxXwBxhLnJDck6lFcoQ+m61Ya
         s9HPihJRNKZkIWCzyAvT21ciexOpSWKSNgUoenFkAd348b5dQPZ+ojXubVPcWlHmJP0w
         nTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjZ/0WcAaB7nd5drpvsqUaYdHBWyehQvrygbYW5v7xY=;
        b=HMu+2/J2v49jV3dpvceAFjDqzrKOqKr1MuWMuNmZq8Jl4j4b2gVuPTZl8pTTdkCub7
         jj3Y8Tbk1cwDrR0pIEr75Fe2sYGQaYsx6raIv7PBqzGjpCnj/gSv2DN3qdlWXLhSU5iH
         WaOumpOAxI7oquZUJBh4hYpbZxTir90H85rPjKE1ikVsqYfZRm0xY1SNTSjhb/nT99HJ
         So5VT8wpOh8lGX5JIi7bSEm92XqQK+4OMbGSiAaJYNCJ8t+wst0fOmZyNXW3ijkel7Si
         cBkYOl/OBwiCOvDfnbV7Nyel7WvzWWK9vyv+hU5gd3CN+ZvJJTSXcBCdRRbEyEW2giVS
         FGYQ==
X-Gm-Message-State: AOAM5312gE7Zb3icXLEMfL9eY3RHnDyRSRa52V380OUsH07bWrunHss/
        whee0Hryr9derwBIlSHmAWYyWmUgKG6mIbw+lPsbiw==
X-Google-Smtp-Source: ABdhPJyAM5SLslHbDuU6oBuwZTfmdAwPNjAK+nPky/kIgx/sFvYRdz7DjTMbC66MWX9yUvElKiaR8eyQ+0wwVy0BCsA=
X-Received: by 2002:a05:6512:34c5:: with SMTP id w5mr32780407lfr.214.1609845927414;
 Tue, 05 Jan 2021 03:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20210104124314.7489-1-vitaly.wool@konsulko.com>
In-Reply-To: <20210104124314.7489-1-vitaly.wool@konsulko.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 5 Jan 2021 16:55:14 +0530
Message-ID: <CAAhSdy08ujtYCrSr-O0Me-UbqQTa9N6vjtqgUV3NZofnkOjFwg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add BUILTIN_DTB support for MMU-enabled targets
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 6:15 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
> Sometimes, especially in a production system we may not want to
> use a "smart bootloader" like u-boot to load kernel, ramdisk and
> device tree from a filesystem on eMMC, but rather load the kernel
> from a NAND partition and just run it as soon as we can, and in
> this case it is convenient to have device tree compiled into the
> kernel binary. Since this case is not limited to MMU-less systems,
> let's support it for these which have MMU enabled too.
>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---
> Changelog from v1:
> * no direct initial_boot_params assignment
> * skips the temporary mapping for DT if BUILTIN_DTB=y
>
>  arch/riscv/Kconfig   |  1 -
>  arch/riscv/mm/init.c | 15 +++++++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 81b76d44725d..07a8bdcc423f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -416,7 +416,6 @@ endmenu
>
>  config BUILTIN_DTB
>         def_bool n
> -       depends on RISCV_M_MODE
>         depends on OF
>
>  menu "Power management options"
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 13ba533f462b..04aeee276817 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -191,10 +191,13 @@ void __init setup_bootmem(void)
>  #endif /* CONFIG_BLK_DEV_INITRD */
>
>         /*
> -        * Avoid using early_init_fdt_reserve_self() since __pa() does
> +        * If DTB is built in, no need to reserve its memblock.
> +        * Otherwise, do reserve it but avoid using
> +        * early_init_fdt_reserve_self() since __pa() does
>          * not work for DTB pointers that are fixmap addresses
>          */
> -       memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +       if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> +               memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>
>         early_init_fdt_scan_reserved_mem();
>         dma_contiguous_reserve(dma32_phys_limit);
> @@ -499,6 +502,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         /* Setup early PMD for DTB */
>         create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
>                            (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
> +#ifndef CONFIG_BUILTIN_DTB
>         /* Create two consecutive PMD mappings for FDT early scan */
>         pa = dtb_pa & ~(PMD_SIZE - 1);
>         create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
> @@ -506,7 +510,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
>                            pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
>         dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
> +#else /* CONFIG_BUILTIN_DTB */
> +       dtb_early_va = __va(dtb_pa);
> +#endif /* CONFIG_BUILTIN_DTB */
>  #else
> +#ifndef CONFIG_BUILTIN_DTB
>         /* Create two consecutive PGD mappings for FDT early scan */
>         pa = dtb_pa & ~(PGDIR_SIZE - 1);
>         create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> @@ -514,6 +522,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
>                            pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
>         dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
> +#else /* CONFIG_BUILTIN_DTB */
> +       dtb_early_va = __va(dtb_pa);
> +#endif /* CONFIG_BUILTIN_DTB */
>  #endif
>         dtb_early_pa = dtb_pa;
>
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
