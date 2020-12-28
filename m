Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1522D2E68A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441184AbgL1Qjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbgL1Qjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:39:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5BFC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 08:38:51 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a12so25107864lfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 08:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6SS1scNjE1vPCP4wCk2BIZ3zGkp8hqDahwS2HOGBHc=;
        b=cI8VJXC1C/bDkRCEq7hbWM0zAjKz9rkUJwyt//MfgJsGxs31rPM8LDXwxR7+KO7bZT
         Sxb4blwNTPzKpjcqaNAiCVXhq2o0SvFVBjbCCU2lVaeH0O4FWkBotHzFUWtDYXUcuwZe
         tm6SULa0zv72CxkoEwKgqwMYW3JZAKNRWBBIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6SS1scNjE1vPCP4wCk2BIZ3zGkp8hqDahwS2HOGBHc=;
        b=FNWQZiITwZsX/8po/Y9lz6WnrD3iB60DGBtbB0xWMrlsFisTQ9DS5aI8ErsvZ8VIl3
         qLj88Sc+G1+ragZs/yS4US2mlOTEKKSvUAR1EQNdzfKF7w3MoNWkZZJVeRwT3E2ZP3Bn
         fIWw2nLGHjPSoB8sq9iG7HTl33aBP1Lys/wla5eO+E7eZjJAJ01H0LVNJwou4k0A3Szl
         ZZgbHHDY1WydVDurHlMUnNRijejrVxXbh+/PmUrimQSpbdbMC+bqGzCRGxIjs14NO6p4
         yXoLLg6kVN7PeCs5y2/z5crDY5ACBKQAPqn5Yy2MQ/cvwtqSHlKM8kitE0vk1ggnMBSU
         LhjA==
X-Gm-Message-State: AOAM5300G2zIuWbw5H39wWRlOOR2BbmBbsn56pj3sxISZbaiZjrwZxEN
        zATdhT26KAaKv/meGPkPXVd5l5OwY3VyqwbDsC8ZOg==
X-Google-Smtp-Source: ABdhPJwz0Fxx9LLj2z88LTe0UC1LHs48miC1FDDtUcODfBZNxv/T65x8UtIsLR6HBrIViAxHgL0KvEm8Cu74BBDBfvw=
X-Received: by 2002:ac2:5edb:: with SMTP id d27mr18240410lfq.411.1609173529728;
 Mon, 28 Dec 2020 08:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20201226163037.43691-1-vitaly.wool@konsulko.com>
 <CAAhSdy1M5pMjYHNWdOicb3N3fjTfQLEgE8tFb74sqGbPE_9eyQ@mail.gmail.com>
 <CAM4kBBJ3Vbytx=dFK7+DMByV3zK=FVLATSwjyuuygkDK1MCQjA@mail.gmail.com> <CAAhSdy0E8xspb3epBdrTmjg7vSQanG9zwyMY19eeDDL8z=WJFg@mail.gmail.com>
In-Reply-To: <CAAhSdy0E8xspb3epBdrTmjg7vSQanG9zwyMY19eeDDL8z=WJFg@mail.gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 28 Dec 2020 17:38:38 +0100
Message-ID: <CAM4kBBJLnrp8XB1OZnv2FEuKdEQuQfDWdgwsV--9mZYB=JmJPQ@mail.gmail.com>
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

On Mon, Dec 28, 2020 at 3:10 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Dec 28, 2020 at 7:05 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> >
> > On Mon, Dec 28, 2020 at 12:59 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Sat, Dec 26, 2020 at 10:03 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > > >
> > > > Sometimes, especially in a production system we may not want to
> > > > use a "smart bootloader" like u-boot to load kernel, ramdisk and
> > > > device tree from a filesystem on eMMC, but rather load the kernel
> > > > from a NAND partition and just run it as soon as we can, and in
> > > > this case it is convenient to have device tree compiled into the
> > > > kernel binary. Since this case is not limited to MMU-less systems,
> > > > let's support it for these which have MMU enabled too.
> > > >
> > > > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > > > ---
> > > >  arch/riscv/Kconfig   |  1 -
> > > >  arch/riscv/mm/init.c | 12 ++++++++++--
> > > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 2b41f6d8e458..9464b4e3a71a 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -419,7 +419,6 @@ endmenu
> > > >
> > > >  config BUILTIN_DTB
> > > >         def_bool n
> > > > -       depends on RISCV_M_MODE
> > > >         depends on OF
> > > >
> > > >  menu "Power management options"
> > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > index 87c305c566ac..5d1c7a3ec01c 100644
> > > > --- a/arch/riscv/mm/init.c
> > > > +++ b/arch/riscv/mm/init.c
> > > > @@ -194,12 +194,20 @@ void __init setup_bootmem(void)
> > > >         setup_initrd();
> > > >  #endif /* CONFIG_BLK_DEV_INITRD */
> > > >
> > > > +       /*
> > > > +        * If DTB is built in, no need to reserve its memblock.
> > > > +        * OTOH, initial_boot_params has to be set to properly copy DTB
> > > > +        * before unflattening later on.
> > > > +        */
> > > > +       if (IS_ENABLED(CONFIG_BUILTIN_DTB))
> > > > +               initial_boot_params = __va(dtb_early_pa);
> > >
> > > Don't assign initial_boot_params directly here because the
> > > early_init_dt_scan() will do it.
> >
> > early_init_dt_scan will set initial_boot_params to dtb_early_va from
> > the early mapping which will be gone by the time
> > unflatten_and_copy_device_tree() is called.
>
> That's why we are doing early_init_dt_verify() again for the MMU-enabled
> case which already takes care of your concern.

I might be out in the woods here but... Do you mean the call to
early_init_dt_verify() in setup_arch() which is compiled out
completely in the CONFIG_BUILTIN_DTB case?
Or is there any other call that I'm overlooking?

Best regards,
   Vitaly

> We use early_init_dt_verify() like most architectures to set the initial DTB.
>
> >
> > > The setup_vm() is supposed to setup dtb_early_va and dtb_early_pa
> > > for MMU-enabled case so please add a "#ifdef" over there for the
> > > built-in DTB case.
> > >
> > > > +       else
> > > > +               memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > > > +
> > > >         /*
> > > >          * Avoid using early_init_fdt_reserve_self() since __pa() does
> > > >          * not work for DTB pointers that are fixmap addresses
> > > >          */
> > >
> > > This comment needs to be updated and moved along the memblock_reserve()
> > > statement.
> > >
> > > > -       memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > > > -
> > > >         early_init_fdt_scan_reserved_mem();
> > > >         dma_contiguous_reserve(dma32_phys_limit);
> > > >         memblock_allow_resize();
> > > > --
> > > > 2.29.2
> > > >
> > >
> > > This patch should be based upon Damiens builtin DTB patch.
> > > Refer, https://www.spinics.net/lists/linux-gpio/msg56616.html
> >
> > Thanks for the pointer, however I don't think our patches have
> > intersections. Besides, Damien is dealing with the MMU-less case
> > there.
>
> Damien's patch is also trying to move to use generic BUILTIN_DTB
> support for the MMU-less case so it is similar work hence the chance
> of patch conflict.
>
> Regards,
> Anup
