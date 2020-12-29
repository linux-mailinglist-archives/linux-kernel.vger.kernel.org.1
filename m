Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE532E6E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgL2FGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgL2FGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:06:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EEC061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:05:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d13so13310585wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtTLYi9/z5bmG8OV/D75QNEkytkigcLic7eAluHSrCY=;
        b=t9u1IrL/S3W78GpLyJzQ8Qzl8cWPmCvKbbo7w/axT4HDhgZ+gDilMN1q1jFaIyhZdC
         OU8hAO2aNrqmYhfagLWR/bEirursfUlBkFnVpi7xAZvc6kzVshYo4/Ihpsx97UYN0+LH
         WTdMhYY4wewmrzM5dS6FE5R6fc7T+rM97v+X6llxUkakepof8dZE/AeWUJDMVJfg38ZQ
         suN9aVmt+rUx8mJQFHDuZDA5UVXHIrjyvw63R9CxXMUb47Z1Ir5FLEN9uM3j5swJohRx
         4mKBSXFf4fPfE/TBFvyCg7aGlYfMEr46AHQ3PuXVlrRIoXeG7oI9uj3VPuEfrvfbuyUP
         q4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtTLYi9/z5bmG8OV/D75QNEkytkigcLic7eAluHSrCY=;
        b=qVaVEg4nfVoSqpPPJRAHgYySUQjaE/LD19MyH4Nh116Ncg1gWxGQMDDsQ+M07LaYRY
         4vrQ+hPhHwF7txi7SLSHoDzPz8Jr20rcog+cESPIrT1ge4NsMqfd6LqQFpdI5oN2zQR8
         pLxcr2ueR27WivsUXQzyESDJtuERVcoIDG/9/m0UNybu6NT/HX9f2o4GgViwiFx3M6SD
         i5Q3zfW6y4C5FPif1ebmOlF1xK8djGtzvOltbVeIENZcuE8D8ckfbF+BmyK/lxJVdkkx
         Nr/VYdkkjemnJN8vKVPA8970jiziYwZSpavOGygkwZw6hsBVvuq4n58lXczX0b7O9aaB
         lrDg==
X-Gm-Message-State: AOAM531Dyx1L7WnYaY4Nf8/d3VvpSXoz1UUVjL74F5AcnCX22IoPpql4
        +lWP5/D6+eNCpRBfSlujog1BfMkLVUzX/KTywCaVVg==
X-Google-Smtp-Source: ABdhPJxLHZXfHgfk1GwltK7Tl1Tbo73bR6sjspJj13PwgW8mG6N0YLIxy1J5tc0rFLw9Lzv9PfemqI3Ugs9gQkLIxcM=
X-Received: by 2002:adf:e44d:: with SMTP id t13mr53677244wrm.144.1609218332256;
 Mon, 28 Dec 2020 21:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20201226163037.43691-1-vitaly.wool@konsulko.com>
 <CAAhSdy1M5pMjYHNWdOicb3N3fjTfQLEgE8tFb74sqGbPE_9eyQ@mail.gmail.com>
 <CAM4kBBJ3Vbytx=dFK7+DMByV3zK=FVLATSwjyuuygkDK1MCQjA@mail.gmail.com>
 <CAAhSdy0E8xspb3epBdrTmjg7vSQanG9zwyMY19eeDDL8z=WJFg@mail.gmail.com> <CAM4kBBJLnrp8XB1OZnv2FEuKdEQuQfDWdgwsV--9mZYB=JmJPQ@mail.gmail.com>
In-Reply-To: <CAM4kBBJLnrp8XB1OZnv2FEuKdEQuQfDWdgwsV--9mZYB=JmJPQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 29 Dec 2020 10:35:20 +0530
Message-ID: <CAAhSdy1VMujreaaWCDjO9BPa0P2As7c0Hh3riZsY3ncU3NnsGg@mail.gmail.com>
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

On Mon, Dec 28, 2020 at 10:08 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
> On Mon, Dec 28, 2020 at 3:10 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Dec 28, 2020 at 7:05 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > >
> > > On Mon, Dec 28, 2020 at 12:59 PM Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > On Sat, Dec 26, 2020 at 10:03 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > > > >
> > > > > Sometimes, especially in a production system we may not want to
> > > > > use a "smart bootloader" like u-boot to load kernel, ramdisk and
> > > > > device tree from a filesystem on eMMC, but rather load the kernel
> > > > > from a NAND partition and just run it as soon as we can, and in
> > > > > this case it is convenient to have device tree compiled into the
> > > > > kernel binary. Since this case is not limited to MMU-less systems,
> > > > > let's support it for these which have MMU enabled too.
> > > > >
> > > > > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > > > > ---
> > > > >  arch/riscv/Kconfig   |  1 -
> > > > >  arch/riscv/mm/init.c | 12 ++++++++++--
> > > > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > index 2b41f6d8e458..9464b4e3a71a 100644
> > > > > --- a/arch/riscv/Kconfig
> > > > > +++ b/arch/riscv/Kconfig
> > > > > @@ -419,7 +419,6 @@ endmenu
> > > > >
> > > > >  config BUILTIN_DTB
> > > > >         def_bool n
> > > > > -       depends on RISCV_M_MODE
> > > > >         depends on OF
> > > > >
> > > > >  menu "Power management options"
> > > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > > index 87c305c566ac..5d1c7a3ec01c 100644
> > > > > --- a/arch/riscv/mm/init.c
> > > > > +++ b/arch/riscv/mm/init.c
> > > > > @@ -194,12 +194,20 @@ void __init setup_bootmem(void)
> > > > >         setup_initrd();
> > > > >  #endif /* CONFIG_BLK_DEV_INITRD */
> > > > >
> > > > > +       /*
> > > > > +        * If DTB is built in, no need to reserve its memblock.
> > > > > +        * OTOH, initial_boot_params has to be set to properly copy DTB
> > > > > +        * before unflattening later on.
> > > > > +        */
> > > > > +       if (IS_ENABLED(CONFIG_BUILTIN_DTB))
> > > > > +               initial_boot_params = __va(dtb_early_pa);
> > > >
> > > > Don't assign initial_boot_params directly here because the
> > > > early_init_dt_scan() will do it.
> > >
> > > early_init_dt_scan will set initial_boot_params to dtb_early_va from
> > > the early mapping which will be gone by the time
> > > unflatten_and_copy_device_tree() is called.
> >
> > That's why we are doing early_init_dt_verify() again for the MMU-enabled
> > case which already takes care of your concern.
>
> I might be out in the woods here but... Do you mean the call to
> early_init_dt_verify() in setup_arch() which is compiled out
> completely in the CONFIG_BUILTIN_DTB case?
> Or is there any other call that I'm overlooking?

Sorry for the confusion, what I meant was that we are calling
early_init_dt_verify() from setup_arch() for the MMU-enabled
with built-in DTB disabled case to update "initial_boot_params"
after the boot CPU has switched from early_pg_dir to swapper_pg_dir.

For MMU-enabled with built-in DTB case, if setup_vm() sets the
dtb_early_va and dtb_early_pa correctly then early_init_dt_scan()
called from setup_arch() will automatically set correct value for
"initial_boot_params".

It is strange that early_init_dt_verify() is being compiled-out for you
because the early_init_dt_scan() called from setup_arch() also uses
early_init_dt_verify(). I quickly compiled the NoMMU kernel for K210
which also uses built-in DTB and I see that early_init_dt_verify()
is not being compiled-out when built-in DTB is enabled.

Regards,
Anup

>
> Best regards,
>    Vitaly
>
> > We use early_init_dt_verify() like most architectures to set the initial DTB.
> >
> > >
> > > > The setup_vm() is supposed to setup dtb_early_va and dtb_early_pa
> > > > for MMU-enabled case so please add a "#ifdef" over there for the
> > > > built-in DTB case.
> > > >
> > > > > +       else
> > > > > +               memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > > > > +
> > > > >         /*
> > > > >          * Avoid using early_init_fdt_reserve_self() since __pa() does
> > > > >          * not work for DTB pointers that are fixmap addresses
> > > > >          */
> > > >
> > > > This comment needs to be updated and moved along the memblock_reserve()
> > > > statement.
> > > >
> > > > > -       memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > > > > -
> > > > >         early_init_fdt_scan_reserved_mem();
> > > > >         dma_contiguous_reserve(dma32_phys_limit);
> > > > >         memblock_allow_resize();
> > > > > --
> > > > > 2.29.2
> > > > >
> > > >
> > > > This patch should be based upon Damiens builtin DTB patch.
> > > > Refer, https://www.spinics.net/lists/linux-gpio/msg56616.html
> > >
> > > Thanks for the pointer, however I don't think our patches have
> > > intersections. Besides, Damien is dealing with the MMU-less case
> > > there.
> >
> > Damien's patch is also trying to move to use generic BUILTIN_DTB
> > support for the MMU-less case so it is similar work hence the chance
> > of patch conflict.
> >
> > Regards,
> > Anup
