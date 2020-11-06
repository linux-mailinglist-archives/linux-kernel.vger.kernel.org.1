Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E836A2A90DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKFIAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgKFIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:00:54 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA60C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:00:54 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 72so577261pfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mXeLUnql0ZAHlwxfedR6V6JITpiJkpyK91YsFFWk1zo=;
        b=u0xJczYU1FnZOue8y5WE6Fjzr1YBmmSh08FLHnknlmv6Hh9VdFUkRJFtHJdeFvWGht
         iOqHOdhuxM/9pC2wVoIykUFsasxA89vUF/WomsFeS6qCNaZxdYg6CFEaw9/KlXheuCeV
         IIUNVH9ThhU+FUN3mIzVp452Kq1DAOFjrThC2ilEj6ihU4s9uQXniz5sTkub1G+AegOi
         XgnqD3QQ0Co9R1z0iw2cthC/7HXvYKr6TMvPrPCsNoDLph1PW4Gh8NuieatPHqGrOkF4
         Ck336IUEHVPFibsKqmge/qkuDjGDKxjy74WSItMld7+HbuwjjJK+Sz56EDLRN0Ye30WA
         ic7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mXeLUnql0ZAHlwxfedR6V6JITpiJkpyK91YsFFWk1zo=;
        b=m9pzorLhTNNzLKyPFosE/8b0PpicA8SxgHPsNUntEIV7i4gPtMpYCRjRMlfS3mP3wN
         78s53UEYnH4W7Ztd+bx3wBFTp/RPoVYEZWCtFKiKchunStUnUFeuDn8DxFU8xWe3xZU0
         8Vai5IZaOEJ8Mc2a0g3w0T69Hd2pQnw87o/yfPHIspCVqusx++AEzrP900yBHE0kqzx+
         ZozFpokNNlyEGN6BWZPs08pz/Yg0jtikYcfSxEbmL2bemZYLKbCBaEQRwSqN1NoC7NEk
         fmNqWrdMiAm/P836efowMi1MAEv5HKePgyqAY1bDNtZmXgVODiD8o4MN26ben/kELKxx
         tNNA==
X-Gm-Message-State: AOAM530u9o2Z4UTcwrMnkPnj/avvHrsjDkW/WOe7gqOOuMAK3w+Qg2bB
        ZoqjXDNi4QmOSw8TmpywHN1iBw==
X-Google-Smtp-Source: ABdhPJw2jK5zQpZpSMduu0uslivHEYxwN4qwvLP8XRn/fbP7T1NuycqzFnrGc5htmCqhn0HKR7cdMg==
X-Received: by 2002:a63:e208:: with SMTP id q8mr749210pgh.181.1604649653735;
        Fri, 06 Nov 2020 00:00:53 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y8sm782655pge.22.2020.11.06.00.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 00:00:52 -0800 (PST)
Date:   Fri, 06 Nov 2020 00:00:52 -0800 (PST)
X-Google-Original-Date: Fri, 06 Nov 2020 00:00:50 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Use non-PGD mappings for early DTB access
In-Reply-To: <20201104063713.3039035-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-78d4f2c3-0a0a-4264-9578-72ed0babbf1b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020 22:37:13 PST (-0800), Anup Patel wrote:
> Currently, we use PGD mappings for early DTB mapping in early_pgd
> but this breaks Linux kernel on SiFive Unleashed because on SiFive
> Unleashed PMP checks don't work correctly for PGD mappings.
>
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
>  #define NUM_EARLY_PMDS		(1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
>  #endif
>  pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> +pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
>  static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
>  {
> @@ -494,6 +495,18 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  				   load_pa + (va - PAGE_OFFSET),
>  				   map_size, PAGE_KERNEL_EXEC);
>
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	/* Setup early PMD for DTB */
> +	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> +			   (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
> +	/* Create two consecutive PMD mappings for FDT early scan */
> +	pa = dtb_pa & ~(PMD_SIZE - 1);
> +	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
> +			   pa, PMD_SIZE, PAGE_KERNEL);
> +	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
> +			   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
> +	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
> +#else
>  	/* Create two consecutive PGD mappings for FDT early scan */
>  	pa = dtb_pa & ~(PGDIR_SIZE - 1);
>  	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> @@ -501,6 +514,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
>  			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
>  	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
> +#endif
>  	dtb_early_pa = dtb_pa;
>
>  	/*

We're starting to build up a handful of workarounds for these sorts of things.
The PMP trap vs WARL one was the last I could remember, but that's a bit
different as both of those behaviors were allowed by specifications at some
point.  IIRC there were also some TLB shootdown issues floating

The best I can come up with is to add both some sort of "minimum support
specification version" Kconfig entry and an "quirks" set of Kconfig entries.
That would allow us to gradually jettison old ISAs as well as more cleanly add
support for broken hardware like this.

Do you have a pointer to some datasheet type document that describes the issue?
That'd probably be the line I'd like to draw for adding workarounds like this,
as otherwise we can't really be sure something is a hardware issue.

That said, it's better to have the fix so this is on fixes.  I'll try to
remember it for the list of workarounds.

Thanks!
