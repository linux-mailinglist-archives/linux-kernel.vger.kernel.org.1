Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CC2A71DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbgKDXht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgKDXht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:37:49 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:37:49 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id s10so373225ioe.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0nZYDo+CB6TegF98IJWvC66Pi+L/HwyZcY9j3Daq1w=;
        b=LVGPZfXnEEe0PxuGVdeEhrmM549qsPkmNywLDOHuGXHLa9ITAjuP0e0LQcdiN2qINs
         8Wat9PYnLvO2P+CCIWwaewexubKRK04XKlsykS5EQ4lpNU4xFUvCJRp16Iaq0Uouh1/y
         bhL5ia+m/XYcqspf6hohb4I8QjY71vnEaUJ6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0nZYDo+CB6TegF98IJWvC66Pi+L/HwyZcY9j3Daq1w=;
        b=BxBJcsnD25MLg43vLpGULmaRZ9r/0GqJtvO6OlhYDfjNlFbk42kzakJIKBcvzU2GUt
         7UFHof51NBHNqxBIqHhGXArGTacNIiBib/n/rOi/FIp7JqRHUs2vWzddRu9QMeNu7XJz
         pImzCX8apNCkNoMgBru0HO4sQmrh2xdBRIqhlvfKwfY94EvoGZkpX0z/jJgeAx4/Y/pU
         LKvmVAqdR5whZBcrow+YiDSz9MNpw7USS3kwGcKv6oDPNBHOM6dWhuzDu6N0zSfmRZmj
         TooqQwpUxf8iQTS/+C469FAYMQAbyxwtsKaI1+qHWhWabMBhgWCUjmugGYdok8fbK+ns
         EDoA==
X-Gm-Message-State: AOAM530M94hLsrkexLAs8J5RkKMUEUurj9QWdOqsrAFgzx6tRSbQyB44
        +K4U8cQth2g3KK9PjumD4FLEOfazOIbfzwbPMM9W
X-Google-Smtp-Source: ABdhPJxxfSuP85Z67d1ZPevhNWGC7WnEj5kO3osENOwbpcPDMXVGob2vWq1q34QpbmRT0XgpjcRbLjzTYs+C8MLzlGc=
X-Received: by 2002:a05:6602:2d93:: with SMTP id k19mr312922iow.51.1604533068376;
 Wed, 04 Nov 2020 15:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20201104063713.3039035-1-anup.patel@wdc.com>
In-Reply-To: <20201104063713.3039035-1-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 4 Nov 2020 15:37:37 -0800
Message-ID: <CAOnJCUL0-j+rvii65y67Vkp9Th1b_msz4P3eD4DR+qGn+yMdRQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Use non-PGD mappings for early DTB access
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 10:37 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> Currently, we use PGD mappings for early DTB mapping in early_pgd
> but this breaks Linux kernel on SiFive Unleashed because on SiFive
> Unleashed PMP checks don't work correctly for PGD mappings.
>

Not sure why this is an issue with Unleashed only. Microchip Polarfire
SoC seems to work fine with early DTB pa as 0x88000000.
However, unleashed fails to boot if the DTB is loaded any address
below 0xC0000000 and it is mapped via PGD.

> To fix early DTB mappings on SiFive Unleashed, we use non-PGD
> mappings (i.e. PMD) for early DTB access.
>
> Fixes: 8f3a2b4a96dc ("RISC-V: Move DT mapping outof fixmap")
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/mm/init.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index ea933b789a88..0d13d0c36a7d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -297,6 +297,7 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  #define NUM_EARLY_PMDS         (1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
>  #endif
>  pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> +pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
>  static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
>  {
> @@ -494,6 +495,18 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>                                    load_pa + (va - PAGE_OFFSET),
>                                    map_size, PAGE_KERNEL_EXEC);
>
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       /* Setup early PMD for DTB */
> +       create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> +                          (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
> +       /* Create two consecutive PMD mappings for FDT early scan */
> +       pa = dtb_pa & ~(PMD_SIZE - 1);
> +       create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
> +                          pa, PMD_SIZE, PAGE_KERNEL);
> +       create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
> +                          pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
> +       dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
> +#else
>         /* Create two consecutive PGD mappings for FDT early scan */
>         pa = dtb_pa & ~(PGDIR_SIZE - 1);
>         create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> @@ -501,6 +514,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
>                            pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
>         dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
> +#endif
>         dtb_early_pa = dtb_pa;
>
>         /*
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

FWIW: Tested on Unleashed & Polarfire SoC.
Tested-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>

@palmer: Can you consider this patch in next rcX PR ?

-- 
Regards,
Atish
