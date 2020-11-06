Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883922A91D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKFIwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKFIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:52:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF70AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:52:53 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so439716wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1SlIddTQa6YnvwCKFNoc0Zc6N2GDs/YOmt73lg/h6iM=;
        b=CMIX+ykzx4ZW4zP5Hx5PbPAkifwInBnOURHV+C70jv97Jl8yMGbM/8E5kIi+AG8/hZ
         QHPHPFmSM2stfBD58jaxUtDqBwoLloMXo8bXDz3YLFJNP7d6CEX6mRRmCb//e4MkQiNh
         sv4PKoknzxggLZ/6vKGJXczN65VuIgI3kDjHMzz2b5NQj4DkjDRBGpVg+4o3lzlaeMoV
         pjK3ZPBNUqk5TXqXaXsf+d1F4dgB3nYGdR4c5sm2qgRpiUDjEJfIgrHgHv0NFp9mZt4Q
         P8L8+P1JkF2HXC2yclg8kntyuKKsP0hH9xJ7V6CWj3IQ0ltdLrSluOdR6SM27gMkVKWy
         xLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SlIddTQa6YnvwCKFNoc0Zc6N2GDs/YOmt73lg/h6iM=;
        b=SoUpAxvskjoyaX7eNBmw3dEdfocHbxnCM5pILpvm2wqvM7tDppmvyjc/EURkM1Ih/1
         okBbBCrVCZnnIKEix/1HR64wnXm1byEGijGsFr0hmcDiXF9F6QQ/cecQneD6zE3nxE2u
         9BgYT/uIURxXRgEJMETejuKzjku6XGJkR9GF4eMs5oeyREXtMUdPhZr4u5PkP7Jd4z7k
         6lgf+X+6zmwc7O9kUI7iCAkOZCpvnmNRiNc+s6c4jONyuq8Idlh2OE7432A3Uap1FQNo
         KJqPTqNN1xzZI1mljmOlsm6nqG+Mx1t1e692ssWtfYirLmsPThDaNhSuUDrC4bTx3brO
         Lg8g==
X-Gm-Message-State: AOAM530tW8s20zuEC8CIK46QFJzF2dCp8ZZgG1FlD3F7ggt/bAKyLNov
        lr0wdVpDWgWR87M16zv7YlEA38DTyS+ilsqtf/ApeQ==
X-Google-Smtp-Source: ABdhPJz+PwltCv2d088wOAs6uZr5rRw6aOBLIBSyMVLFKyl+V0vA/PCQZU7Orrg0nyhOwZnTfA/LLwdR1S3+fQnyjvo=
X-Received: by 2002:adf:eec2:: with SMTP id a2mr1532933wrp.128.1604652772606;
 Fri, 06 Nov 2020 00:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20201104063713.3039035-1-anup.patel@wdc.com> <mhng-78d4f2c3-0a0a-4264-9578-72ed0babbf1b@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-78d4f2c3-0a0a-4264-9578-72ed0babbf1b@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 6 Nov 2020 14:22:40 +0530
Message-ID: <CAAhSdy3k-uhaE_tFQbd6UXpY-DaujG1jrmLjs0QmzdNQ7EoQuw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Use non-PGD mappings for early DTB access
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 1:30 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Tue, 03 Nov 2020 22:37:13 PST (-0800), Anup Patel wrote:
> > Currently, we use PGD mappings for early DTB mapping in early_pgd
> > but this breaks Linux kernel on SiFive Unleashed because on SiFive
> > Unleashed PMP checks don't work correctly for PGD mappings.
> >
> > To fix early DTB mappings on SiFive Unleashed, we use non-PGD
> > mappings (i.e. PMD) for early DTB access.
> >
> > Fixes: 8f3a2b4a96dc ("RISC-V: Move DT mapping outof fixmap")
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index ea933b789a88..0d13d0c36a7d 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -297,6 +297,7 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> >  #define NUM_EARLY_PMDS               (1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
> >  #endif
> >  pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> > +pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> >
> >  static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
> >  {
> > @@ -494,6 +495,18 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >                                  load_pa + (va - PAGE_OFFSET),
> >                                  map_size, PAGE_KERNEL_EXEC);
> >
> > +#ifndef __PAGETABLE_PMD_FOLDED
> > +     /* Setup early PMD for DTB */
> > +     create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> > +                        (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
> > +     /* Create two consecutive PMD mappings for FDT early scan */
> > +     pa = dtb_pa & ~(PMD_SIZE - 1);
> > +     create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
> > +                        pa, PMD_SIZE, PAGE_KERNEL);
> > +     create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
> > +                        pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
> > +     dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
> > +#else
> >       /* Create two consecutive PGD mappings for FDT early scan */
> >       pa = dtb_pa & ~(PGDIR_SIZE - 1);
> >       create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> > @@ -501,6 +514,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >       create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
> >                          pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
> >       dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
> > +#endif
> >       dtb_early_pa = dtb_pa;
> >
> >       /*
>
> We're starting to build up a handful of workarounds for these sorts of things.
> The PMP trap vs WARL one was the last I could remember, but that's a bit
> different as both of those behaviors were allowed by specifications at some
> point.  IIRC there were also some TLB shootdown issues floating
>
> The best I can come up with is to add both some sort of "minimum support
> specification version" Kconfig entry and an "quirks" set of Kconfig entries.
> That would allow us to gradually jettison old ISAs as well as more cleanly add
> support for broken hardware like this.
>
> Do you have a pointer to some datasheet type document that describes the issue?

Unfortunately, we still don't know where all SiFive erratums are documented.
Maybe you know the right person who can publish this ??

The PMP checks not working correctly for PGD-mappings was discovered
independently by Bin Meng on some other OS (almost 1.5 years back). Few
discussions about this erratum have happened on OpenSBI mailing list as well
although in a very different context. In fact, Andrew had confirmed about this
erratum in sw-dev google groups.
(Refer, https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/CfyT5Los5uA/m/yY0ES0dZBAAJ?pli=1)
(Refer, https://github.com/riscv/opensbi/issues/103)

Till now we have encountered two erratums for SiFive U54 cores:
1. SFENCE.VMA not working with "virtual address" parameter
2. PMP checks not working for PGD mappings

The Microchip ICICLE kit has U54 cores but the PMP checks issue
is only seen on SiFive Unleashed so I guess this issue is fixed
in-between but we can't be sure without detailed documentation.

> That'd probably be the line I'd like to draw for adding workarounds like this,
> as otherwise we can't really be sure something is a hardware issue.
>
> That said, it's better to have the fix so this is on fixes.  I'll try to
> remember it for the list of workarounds.

I agree. At the moment, 5.10-rc2 does not boot on SiFive Unleashed
but it boots on Microchip icicle kit and everywhere else because of
the PMP checks issue.

Regards,
Anup
