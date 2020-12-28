Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E632E64F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgL1Ng0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391400AbgL1NgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:36:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C68C061795
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 05:35:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x20so23848503lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnlocphoctX4r6uKPUYm4iHsqJYYWrO7RnR7sqTcTMQ=;
        b=DdXN+SIqlIxijQhfqX1KanDmg13RIXZawO+UXnE2GnWP6WUQA7qLK01tybwDacK6iT
         h9liV046J29RuS5Zo7EOoAUQXF2kmtjRWi7TLj0vlg/kmog2D6lwCNkbM3zfTiw0/Gnt
         2A7ihf1wx1d8wlrQdJbC9WjqiuVOgoEiAoSPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnlocphoctX4r6uKPUYm4iHsqJYYWrO7RnR7sqTcTMQ=;
        b=ugnli7t9xPL60GrvjXyTHqfxwOTT9Ms3uy3pyTLW1TkeO749p1/Dk1yn4O0KGzNqK7
         alFHli6EEnMGmMGoIAFKRJ0ONLQ11tq4NRf/3GwnT54B0Pe+VkIsgMobHE7gbpc7mjYv
         ED6j11So83sgJuQikuVM4nUsG9T1gA8rBdhJDBzKxa4Z+BvFSOr3j/qSHnioIVsz1Sg5
         6rcpKfkdbg5gWvjZKJ9694/5x8jLio9IY3+Sn/ARxwzT1YLaZAM/WS8ohfanMyB8Yo1+
         Wu/4XW4rASZWFORGI0m5GDElSPuLfojDhK4GmsxpI6kyzCbstkQu4T/i2sQ1ubfKJxVh
         n3vg==
X-Gm-Message-State: AOAM531YXW6UniEDY5+U+8NF2+fU9Fqio+KJwj1iF0EPF+oU2b+wL4fm
        Dy0XQZ50GEWkoAVGWngMx5RRO7CTx2LZMJRIiF3kWw==
X-Google-Smtp-Source: ABdhPJyiqupZuDE0Vxp4Jp2VXGNRbz8ArOYKPHzS+2ZWvcmC136bVxjhF83SmGCPsFzZ1cANTCZzpN6YjAEuwCAW2d0=
X-Received: by 2002:a05:6512:2009:: with SMTP id a9mr18356183lfb.575.1609162526880;
 Mon, 28 Dec 2020 05:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20201226163037.43691-1-vitaly.wool@konsulko.com> <CAAhSdy1M5pMjYHNWdOicb3N3fjTfQLEgE8tFb74sqGbPE_9eyQ@mail.gmail.com>
In-Reply-To: <CAAhSdy1M5pMjYHNWdOicb3N3fjTfQLEgE8tFb74sqGbPE_9eyQ@mail.gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 28 Dec 2020 14:35:16 +0100
Message-ID: <CAM4kBBJ3Vbytx=dFK7+DMByV3zK=FVLATSwjyuuygkDK1MCQjA@mail.gmail.com>
Subject: Re: [PATCH] riscv: add BUILTIN_DTB support for MMU-enabled targets
To:     Anup Patel <anup@brainfault.org>
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

On Mon, Dec 28, 2020 at 12:59 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sat, Dec 26, 2020 at 10:03 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> >
> > Sometimes, especially in a production system we may not want to
> > use a "smart bootloader" like u-boot to load kernel, ramdisk and
> > device tree from a filesystem on eMMC, but rather load the kernel
> > from a NAND partition and just run it as soon as we can, and in
> > this case it is convenient to have device tree compiled into the
> > kernel binary. Since this case is not limited to MMU-less systems,
> > let's support it for these which have MMU enabled too.
> >
> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > ---
> >  arch/riscv/Kconfig   |  1 -
> >  arch/riscv/mm/init.c | 12 ++++++++++--
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 2b41f6d8e458..9464b4e3a71a 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -419,7 +419,6 @@ endmenu
> >
> >  config BUILTIN_DTB
> >         def_bool n
> > -       depends on RISCV_M_MODE
> >         depends on OF
> >
> >  menu "Power management options"
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 87c305c566ac..5d1c7a3ec01c 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -194,12 +194,20 @@ void __init setup_bootmem(void)
> >         setup_initrd();
> >  #endif /* CONFIG_BLK_DEV_INITRD */
> >
> > +       /*
> > +        * If DTB is built in, no need to reserve its memblock.
> > +        * OTOH, initial_boot_params has to be set to properly copy DTB
> > +        * before unflattening later on.
> > +        */
> > +       if (IS_ENABLED(CONFIG_BUILTIN_DTB))
> > +               initial_boot_params = __va(dtb_early_pa);
>
> Don't assign initial_boot_params directly here because the
> early_init_dt_scan() will do it.

early_init_dt_scan will set initial_boot_params to dtb_early_va from
the early mapping which will be gone by the time
unflatten_and_copy_device_tree() is called.

> The setup_vm() is supposed to setup dtb_early_va and dtb_early_pa
> for MMU-enabled case so please add a "#ifdef" over there for the
> built-in DTB case.
>
> > +       else
> > +               memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > +
> >         /*
> >          * Avoid using early_init_fdt_reserve_self() since __pa() does
> >          * not work for DTB pointers that are fixmap addresses
> >          */
>
> This comment needs to be updated and moved along the memblock_reserve()
> statement.
>
> > -       memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > -
> >         early_init_fdt_scan_reserved_mem();
> >         dma_contiguous_reserve(dma32_phys_limit);
> >         memblock_allow_resize();
> > --
> > 2.29.2
> >
>
> This patch should be based upon Damiens builtin DTB patch.
> Refer, https://www.spinics.net/lists/linux-gpio/msg56616.html

Thanks for the pointer, however I don't think our patches have
intersections. Besides, Damien is dealing with the MMU-less case
there.

Best regards,
   Vitaly
