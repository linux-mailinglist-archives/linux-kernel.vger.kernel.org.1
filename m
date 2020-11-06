Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E742A95EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgKFMIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:08:39 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B74C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 04:08:39 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id s8so916429yba.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1L3r2RzlBzHKsTDF0OeXHNQaTpvxkyyv5MNmEuctLA=;
        b=W39lchB7KaskjvlWPuz2Z2/2Qm81h5G56Ka6fkFGkRCfaVxQLXijhZYB8rn3yUUii6
         ri1bDJ4HY+hDpJ6ZVwORHMkIcfUYLrcB8OcMmPImYDYJouNgXhZXVRnlAnN9gc/Pnc97
         L3LSNoqhHqhVxbMrkc+vAjSmnz4sClZ0wlbtdyvRxVXtESppmJGkIEVBY+ON0OPHx0Y5
         M86Kqn3VM3K48rxGTLZJlZFoANfWjB8jYD2kSEwwL+7Rr9KXY20CDf58LITDSjTfErfo
         zYQEas0x4MOKvTnx5TrpwYsVyJBN37nqF3AeA3oFS5ygqSotKVEjR6i1W/L8vX6ikUc3
         Yo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1L3r2RzlBzHKsTDF0OeXHNQaTpvxkyyv5MNmEuctLA=;
        b=ATNnlOeOchj2aVSj58n1EvZlIsfeAGhZNJ9rOegrHIPDsmReMlJQLcfCTSlTQ9hpf2
         5jFYHnd9xajVVALx3u0woIlbTuGnc7ZXgRTJboze5V0ynoBdd7dY29HLEq6Fjgdwg1zs
         rq0ggYGiL1cix8TiqHI5lz5GZJsFMV2PH6wPcYpecQpePK5XJq43YwlJSelVwhSa4vNa
         QxhYYD6hhg7siBCZpNm87+56788LAg+PHigJiMYxpbI9iSwXkDJ4UUpES6HzPqbRwVmo
         +waOU/mbwjcnk2zGlXiPj16stfJvL543pzaVfa8I6nN0uy+udp+G2RsZu/TRHYi+VkKO
         Bc7Q==
X-Gm-Message-State: AOAM532NHVswlI4UFd7a33CTDmNp0ik1tsl91aZ7Bcizom2UtBm7h6E0
        WcLS9+9+p86k9k6VKfLjt/XC4wuibMF+6mLCy3Q=
X-Google-Smtp-Source: ABdhPJwZy4f8gEDVDbX+sRxJ7kIPXekWsFS7OZHG7TzIBRrgcqiLbHCoAeDglqbUHNUqniLRaj2jOAl/x5cOz/40NIU=
X-Received: by 2002:a25:9c87:: with SMTP id y7mr2316878ybo.314.1604664517927;
 Fri, 06 Nov 2020 04:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20201104063713.3039035-1-anup.patel@wdc.com> <mhng-78d4f2c3-0a0a-4264-9578-72ed0babbf1b@palmerdabbelt-glaptop1>
 <CAAhSdy3k-uhaE_tFQbd6UXpY-DaujG1jrmLjs0QmzdNQ7EoQuw@mail.gmail.com>
In-Reply-To: <CAAhSdy3k-uhaE_tFQbd6UXpY-DaujG1jrmLjs0QmzdNQ7EoQuw@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 6 Nov 2020 20:08:26 +0800
Message-ID: <CAEUhbmUQdsACKrT=smGO3H3vh_hkA-O3UWd5dOFWTWWkZBpWKg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Use non-PGD mappings for early DTB access
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 4:52 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, Nov 6, 2020 at 1:30 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> >
> > On Tue, 03 Nov 2020 22:37:13 PST (-0800), Anup Patel wrote:
> > > Currently, we use PGD mappings for early DTB mapping in early_pgd
> > > but this breaks Linux kernel on SiFive Unleashed because on SiFive
> > > Unleashed PMP checks don't work correctly for PGD mappings.
> > >
> > > To fix early DTB mappings on SiFive Unleashed, we use non-PGD
> > > mappings (i.e. PMD) for early DTB access.
> > >
> > > Fixes: 8f3a2b4a96dc ("RISC-V: Move DT mapping outof fixmap")
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > ---
> > >  arch/riscv/mm/init.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index ea933b789a88..0d13d0c36a7d 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -297,6 +297,7 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> > >  #define NUM_EARLY_PMDS               (1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
> > >  #endif
> > >  pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> > > +pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> > >
> > >  static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
> > >  {
> > > @@ -494,6 +495,18 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> > >                                  load_pa + (va - PAGE_OFFSET),
> > >                                  map_size, PAGE_KERNEL_EXEC);
> > >
> > > +#ifndef __PAGETABLE_PMD_FOLDED
> > > +     /* Setup early PMD for DTB */
> > > +     create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> > > +                        (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
> > > +     /* Create two consecutive PMD mappings for FDT early scan */
> > > +     pa = dtb_pa & ~(PMD_SIZE - 1);
> > > +     create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
> > > +                        pa, PMD_SIZE, PAGE_KERNEL);
> > > +     create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
> > > +                        pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
> > > +     dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
> > > +#else
> > >       /* Create two consecutive PGD mappings for FDT early scan */
> > >       pa = dtb_pa & ~(PGDIR_SIZE - 1);
> > >       create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> > > @@ -501,6 +514,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> > >       create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
> > >                          pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
> > >       dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
> > > +#endif
> > >       dtb_early_pa = dtb_pa;
> > >
> > >       /*
> >
> > We're starting to build up a handful of workarounds for these sorts of things.
> > The PMP trap vs WARL one was the last I could remember, but that's a bit
> > different as both of those behaviors were allowed by specifications at some
> > point.  IIRC there were also some TLB shootdown issues floating
> >
> > The best I can come up with is to add both some sort of "minimum support
> > specification version" Kconfig entry and an "quirks" set of Kconfig entries.
> > That would allow us to gradually jettison old ISAs as well as more cleanly add
> > support for broken hardware like this.
> >
> > Do you have a pointer to some datasheet type document that describes the issue?
>
> Unfortunately, we still don't know where all SiFive erratums are documented.
> Maybe you know the right person who can publish this ??

Last time Andrew said this erratum would be published but did not give
a name of whom from SiFive in charge ..

>
> The PMP checks not working correctly for PGD-mappings was discovered
> independently by Bin Meng on some other OS (almost 1.5 years back). Few

Yep, this undocumented erratum was initially discovered during our
VxWorks RISC-V port.

> discussions about this erratum have happened on OpenSBI mailing list as well
> although in a very different context. In fact, Andrew had confirmed about this
> erratum in sw-dev google groups.
> (Refer, https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/CfyT5Los5uA/m/yY0ES0dZBAAJ?pli=1)
> (Refer, https://github.com/riscv/opensbi/issues/103)

The issue is not just about gigapages. Using megapages also could
trigger this issue.

To me this erratum seems like: if any PTEs are set up to overlap with
PMP protected memory, FU540 will trigger an instruction access
exception as soon as SATP is written.

>
> Till now we have encountered two erratums for SiFive U54 cores:
> 1. SFENCE.VMA not working with "virtual address" parameter
> 2. PMP checks not working for PGD mappings
>
> The Microchip ICICLE kit has U54 cores but the PMP checks issue
> is only seen on SiFive Unleashed so I guess this issue is fixed
> in-between but we can't be sure without detailed documentation.

I believe Microchip PolarFire SoC suffers this same erratum but I did
not verify that. Currently PMP is configured to protect the eNVM range
on PolarFire, and this range is not mapped by any PTE yet in S-mode.

>
> > That'd probably be the line I'd like to draw for adding workarounds like this,
> > as otherwise we can't really be sure something is a hardware issue.
> >
> > That said, it's better to have the fix so this is on fixes.  I'll try to
> > remember it for the list of workarounds.
>
> I agree. At the moment, 5.10-rc2 does not boot on SiFive Unleashed
> but it boots on Microchip icicle kit and everywhere else because of
> the PMP checks issue.

Regards,
Bin
