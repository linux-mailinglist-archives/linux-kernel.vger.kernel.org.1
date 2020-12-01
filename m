Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC62CAD4F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392495AbgLAU20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388350AbgLAU2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:28:25 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA39C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:27:39 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so5264570ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xW31zfOrhabWlu5deT3c2Y+pb/DW1jxAoipejrSHzyI=;
        b=DbcESuPRp2oUA7x9x7VPnM8MvfK9HQHLV88Em1fhaC5OF6D13CIetPYecBdhmGTzs+
         B39nNIvFGxV3ISEpNYo0SAObRZNqR9LXuXUV9w4Il8eVnVltzGc+obCKb6BCJlPwh4c2
         iSiUcdLLNksFX/tSU1Bzr1xb6whrWhRFfeaNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xW31zfOrhabWlu5deT3c2Y+pb/DW1jxAoipejrSHzyI=;
        b=G29YtpWGkgFrSRKLTakcrpnXvI/225brE8EGz9X4hfFTK2hbcJ1Ldq+k5QIDFAezlz
         1dU/TMFMVBvvvdBgbEC69Eg35eMjDshHcmt9xIWJIEZY9dgM05aIFnfTjUZr9gLKOa06
         buFvq3uAYhT9f3VBV3tR1HynV3G24LgA8UYUCsj0WaQeGWoZLO45TYT9XlltALmpqW4h
         CgEYsYQHhAqgtTutD49yAsh7eb04jT4vOFXXsps9JLA51A4JzouXMnfmsn5+mW0wh5Uv
         3VQeAr1vZuyuU8v0RInafyezNI1+9mOXWFx586AkcSGJ3xJzpcTcB+bNJNVIY9OnhLLS
         RHoQ==
X-Gm-Message-State: AOAM532AvqcV7WxbAjlJWHp0xYAeX6iZnU62f3HlhinaDTmlMVEzQw9o
        sBY4ImQn2cYaTyyb15CMSPBqoIFP2np3QNoHuFCXAQ==
X-Google-Smtp-Source: ABdhPJw7wUToVTctgGd745M5/vh3LFJOKnnoxoGPvYtN/SRvMwK36jGijc0UQN6zz8inoAl+mNntTPJPmugzl2wzrBk=
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr2013178ljn.15.1606854458295;
 Tue, 01 Dec 2020 12:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20201201090023.2852-1-vitaly.wool@konsulko.com> <CAOnJCU+=UX4t1peZVymzuSvFS+xJFYVFJMX5ZB1-azDxyvrJsw@mail.gmail.com>
In-Reply-To: <CAOnJCU+=UX4t1peZVymzuSvFS+xJFYVFJMX5ZB1-azDxyvrJsw@mail.gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Tue, 1 Dec 2020 21:27:27 +0100
Message-ID: <CAM4kBBLP2gSzwOEgYxJkrarE2_39Afu9-p8fQ2U_YVcq6WRh+Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: toggle mmu_enabled flag in a precise manner
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:40 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Tue, Dec 1, 2020 at 1:01 AM <vitaly.wool@konsulko.com> wrote:
> >
> > From: Vitaly Wool <vitaly.wool@konsulko.com>
> >
> > Cuurently mmu_enabled flag is set to true way later than the actual
> > MMU enablement takes place. This leads to hard-to-track races in
> > e. g. SBI earlycon initialization taking wrong path configuring
> > fixmap.
> >
>
> This code path is significantly changed in 5.10-rcX with UEFI series.
> https://patchwork.kernel.org/project/linux-riscv/patch/20200917223716.2300238-4-atish.patra@wdc.com/
>
> Can you check if you can still reproduce the issue you were seeing
> with the latest upstream kernel ?
> If yes, please share the steps to reproduce the issue.

No, I don't think I can reproduce it now, thanks!

~Vitaly

> > To fix that, move mmu_enabled toggling to head.S and rename it to
> > _mmu_enabled to avoid possible name clashes since it's not a static
> > variable any more.
> >
> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > ---
> >  arch/riscv/kernel/head.S |  9 +++++++++
> >  arch/riscv/mm/init.c     | 13 +++++--------
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 0a4e81b8dc79..33cd57285be3 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -248,6 +248,10 @@ clear_bss_done:
> >         call relocate
> >  #endif /* CONFIG_MMU */
> >
> > +       la a0, _mmu_enabled
> > +       li a1, 1
> > +       sw a1, (a0)
> > +
> >         call setup_trap_vector
> >         /* Restore C environment */
> >         la tp, init_task
> > @@ -370,6 +374,11 @@ ENTRY(reset_regs)
> >  END(reset_regs)
> >  #endif /* CONFIG_RISCV_M_MODE */
> >
> > +.section ".data"
> > +       .global _mmu_enabled
> > +_mmu_enabled:
> > +       .word 0
> > +
> >  __PAGE_ALIGNED_BSS
> >         /* Empty zero page */
> >         .balign PAGE_SIZE
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 787c75f751a5..4038be635e25 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -211,7 +211,7 @@ EXPORT_SYMBOL(pfn_base);
> >  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >  pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> > -static bool mmu_enabled;
> > +extern bool _mmu_enabled;
> >
> >  #define MAX_EARLY_MAPPING_SIZE SZ_128M
> >
> > @@ -236,7 +236,7 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
> >
> >  static pte_t *__init get_pte_virt(phys_addr_t pa)
> >  {
> > -       if (mmu_enabled) {
> > +       if (_mmu_enabled) {
> >                 clear_fixmap(FIX_PTE);
> >                 return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
> >         } else {
> > @@ -250,7 +250,7 @@ static phys_addr_t __init alloc_pte(uintptr_t va)
> >          * We only create PMD or PGD early mappings so we
> >          * should never reach here with MMU disabled.
> >          */
> > -       BUG_ON(!mmu_enabled);
> > +       BUG_ON(!_mmu_enabled);
> >
> >         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> >  }
> > @@ -281,7 +281,7 @@ pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> >
> >  static pmd_t *__init get_pmd_virt(phys_addr_t pa)
> >  {
> > -       if (mmu_enabled) {
> > +       if (_mmu_enabled) {
> >                 clear_fixmap(FIX_PMD);
> >                 return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
> >         } else {
> > @@ -293,7 +293,7 @@ static phys_addr_t __init alloc_pmd(uintptr_t va)
> >  {
> >         uintptr_t pmd_num;
> >
> > -       if (mmu_enabled)
> > +       if (_mmu_enabled)
> >                 return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> >
> >         pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
> > @@ -467,9 +467,6 @@ static void __init setup_vm_final(void)
> >         phys_addr_t pa, start, end;
> >         struct memblock_region *reg;
> >
> > -       /* Set mmu_enabled flag */
> > -       mmu_enabled = true;
> > -
> >         /* Setup swapper PGD for fixmap */
> >         create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
> >                            __pa_symbol(fixmap_pgd_next),
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish
