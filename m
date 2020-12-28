Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D32E4155
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439611AbgL1OLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439202AbgL1OK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:10:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1E1C06179A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:10:18 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h205so24116871lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDrae5NlX7atsBnbOFDs+BsHNDAqH6cr7KQ2BZiRu9g=;
        b=dqHY0sUVNmDOTf+aHtGeQqT+ubwl8V7kw7gIzNrTS/0Zd7s285xIvbrMgrA93eRMAB
         /1GHwOroZP8yTdaDh+c/YPuYv6yF+l/23WK0pNPHosyN8/V+rJBncoRkWCiIxhDSuIOE
         sZq2Rs5xOn4W34uvmQXhL/gWHkBMVsxzvVHwV/phaWnNqkCZpJ/HXcjktxusJCdKGsky
         MtDEp8TBZdd1BbHpyknD+6LjUm9fdAaczpGPMbYX9r7PtCaL2c/KQxSld+s+AaIA6TbK
         JuzxMFf5+a71DwaQ2MWRs6FU8ho1Af0S6leDecn3FSRMB+NMuO5RuzBRmU1/mndvj2W0
         vjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDrae5NlX7atsBnbOFDs+BsHNDAqH6cr7KQ2BZiRu9g=;
        b=aMJmMoRTUW2CFnjbIaFKiaf6zhR2wPZpGsyM8a5wfZ7LcIinL/ED1Ad1lQSU7PhHG/
         Z9URmIgahZoX3nVscD7cqVKccT5YFfK08elpAvRzySNHCK0psF538zIw/CW+OYEetgQP
         gxjTfLc1pbMBFew8fAepvX2w8m+z174Im2pTXH9HNdH1GM92OWX4e+YDdBnYm+WOKcuk
         zGqC7JDMOM2y4nMaGdvXg9nrD7Yw36eENELKeg07ONM/VlM6VAvIJhkgIncjw4eVNqY3
         rwueoSL0AQghXS/H4lQ0rSlxJhi4nEmD4Xv0HaZEQXVH2E9U8hinrKvGxJqiGNQZtUqK
         E/ww==
X-Gm-Message-State: AOAM530Isaa6WJqvOW/ugr9eTV+ps5mir31z3YjWvzb3wEtzNP2I/vlL
        6rEtc7cHBrxgD/L/p4nDkeuJzH8nEbmc2x8Z88TE0w==
X-Google-Smtp-Source: ABdhPJxse0shOvUnwJroAasQ1isNMTLZzoRqEfI03iytFRHnoPYRsIhHIflw56KmNtLdTnzsGf7RkAiaClFzBR41C6M=
X-Received: by 2002:a05:651c:202:: with SMTP id y2mr21426940ljn.162.1609164617377;
 Mon, 28 Dec 2020 06:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20201226163037.43691-1-vitaly.wool@konsulko.com>
 <CAAhSdy1M5pMjYHNWdOicb3N3fjTfQLEgE8tFb74sqGbPE_9eyQ@mail.gmail.com> <CAM4kBBJ3Vbytx=dFK7+DMByV3zK=FVLATSwjyuuygkDK1MCQjA@mail.gmail.com>
In-Reply-To: <CAM4kBBJ3Vbytx=dFK7+DMByV3zK=FVLATSwjyuuygkDK1MCQjA@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 28 Dec 2020 19:40:05 +0530
Message-ID: <CAAhSdy0E8xspb3epBdrTmjg7vSQanG9zwyMY19eeDDL8z=WJFg@mail.gmail.com>
Subject: Re: [PATCH] riscv: add BUILTIN_DTB support for MMU-enabled targets
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

On Mon, Dec 28, 2020 at 7:05 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
> On Mon, Dec 28, 2020 at 12:59 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Sat, Dec 26, 2020 at 10:03 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > >
> > > Sometimes, especially in a production system we may not want to
> > > use a "smart bootloader" like u-boot to load kernel, ramdisk and
> > > device tree from a filesystem on eMMC, but rather load the kernel
> > > from a NAND partition and just run it as soon as we can, and in
> > > this case it is convenient to have device tree compiled into the
> > > kernel binary. Since this case is not limited to MMU-less systems,
> > > let's support it for these which have MMU enabled too.
> > >
> > > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > > ---
> > >  arch/riscv/Kconfig   |  1 -
> > >  arch/riscv/mm/init.c | 12 ++++++++++--
> > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 2b41f6d8e458..9464b4e3a71a 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -419,7 +419,6 @@ endmenu
> > >
> > >  config BUILTIN_DTB
> > >         def_bool n
> > > -       depends on RISCV_M_MODE
> > >         depends on OF
> > >
> > >  menu "Power management options"
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 87c305c566ac..5d1c7a3ec01c 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -194,12 +194,20 @@ void __init setup_bootmem(void)
> > >         setup_initrd();
> > >  #endif /* CONFIG_BLK_DEV_INITRD */
> > >
> > > +       /*
> > > +        * If DTB is built in, no need to reserve its memblock.
> > > +        * OTOH, initial_boot_params has to be set to properly copy DTB
> > > +        * before unflattening later on.
> > > +        */
> > > +       if (IS_ENABLED(CONFIG_BUILTIN_DTB))
> > > +               initial_boot_params = __va(dtb_early_pa);
> >
> > Don't assign initial_boot_params directly here because the
> > early_init_dt_scan() will do it.
>
> early_init_dt_scan will set initial_boot_params to dtb_early_va from
> the early mapping which will be gone by the time
> unflatten_and_copy_device_tree() is called.

That's why we are doing early_init_dt_verify() again for the MMU-enabled
case which already takes care of your concern.

We use early_init_dt_verify() like most architectures to set the initial DTB.

>
> > The setup_vm() is supposed to setup dtb_early_va and dtb_early_pa
> > for MMU-enabled case so please add a "#ifdef" over there for the
> > built-in DTB case.
> >
> > > +       else
> > > +               memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > > +
> > >         /*
> > >          * Avoid using early_init_fdt_reserve_self() since __pa() does
> > >          * not work for DTB pointers that are fixmap addresses
> > >          */
> >
> > This comment needs to be updated and moved along the memblock_reserve()
> > statement.
> >
> > > -       memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > > -
> > >         early_init_fdt_scan_reserved_mem();
> > >         dma_contiguous_reserve(dma32_phys_limit);
> > >         memblock_allow_resize();
> > > --
> > > 2.29.2
> > >
> >
> > This patch should be based upon Damiens builtin DTB patch.
> > Refer, https://www.spinics.net/lists/linux-gpio/msg56616.html
>
> Thanks for the pointer, however I don't think our patches have
> intersections. Besides, Damien is dealing with the MMU-less case
> there.

Damien's patch is also trying to move to use generic BUILTIN_DTB
support for the MMU-less case so it is similar work hence the chance
of patch conflict.

Regards,
Anup
