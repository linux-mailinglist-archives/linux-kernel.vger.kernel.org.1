Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F92E7F21
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 10:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLaJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 04:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgLaJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 04:54:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC4C061575
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 01:53:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b26so43077591lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 01:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9V0ZomxWf5FI6Pzw3Hb0y0s9lG9QTEQPE+MoCBxoaw=;
        b=MyoI/oDbk1eBXNR6Q1xj1TEt28OJWIUQXMTmH9g4iQ2KI/499qhTqvkBfbV9FL6OJI
         ozYKs7ZfqDV9IoVQDG7t5WI8UfOHkyKcpnuSqazBoYZu+E+RnC6WWknVe0Z3mr3XK/xh
         TRiTJSdzopiIHuftMe95xOUGtAnFyrYaiZX/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9V0ZomxWf5FI6Pzw3Hb0y0s9lG9QTEQPE+MoCBxoaw=;
        b=rjM/Z/IhrmSC3PIWjObPBYuNuzWOcqqAxmDkJqUwg4uh5e8rWqPwo86zn05Z2T3CXi
         NZgZXQgScjRM38AjNZR9/E4mtIWo+ydAEwe3j95tNwEbo8nXkBcK0ddxh8s0Ok7KgPUs
         ZV7Ho/LGRDXB9wXRdQpiCD7za4jWc3nnXaFEq5AksNaSqrNCaMG5LJibZHc7zfZo+VCT
         ZrHYDaqWRqJVxGvMFeuBp/oFrvO3M8wqGVe82bd3tA0Dt6z3lIBKqI5kPP0SVz8BTj5V
         tMMS9rwjZsGTBfXzuLm1VVqd9rQ1HwlRJkvJV77tWbLPj98b5RsApmsTnJUjiYPeKJaJ
         MQpQ==
X-Gm-Message-State: AOAM532XOe4/VXHf5HT6zL1Pwj0dya97ruvTrbmm+TzXs72QL78cpyxn
        9NNuFhIxwstsUwg0u7r5zFCGwIZ2QPKPKJObIxhPsA==
X-Google-Smtp-Source: ABdhPJyNNZPt1wfoVD+7d/vQ025wnymJUtRR4PYDYtvCI4JzcbGJrjpUgp6diGSdnvGBTaDm2kpNOhpGX13hQ36MXKc=
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr23736548lfq.585.1609408410757;
 Thu, 31 Dec 2020 01:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20201226163037.43691-1-vitaly.wool@konsulko.com>
 <CAAhSdy1M5pMjYHNWdOicb3N3fjTfQLEgE8tFb74sqGbPE_9eyQ@mail.gmail.com>
 <CAM4kBBJ3Vbytx=dFK7+DMByV3zK=FVLATSwjyuuygkDK1MCQjA@mail.gmail.com>
 <CAAhSdy0E8xspb3epBdrTmjg7vSQanG9zwyMY19eeDDL8z=WJFg@mail.gmail.com>
 <CAM4kBBJLnrp8XB1OZnv2FEuKdEQuQfDWdgwsV--9mZYB=JmJPQ@mail.gmail.com> <CAAhSdy1VMujreaaWCDjO9BPa0P2As7c0Hh3riZsY3ncU3NnsGg@mail.gmail.com>
In-Reply-To: <CAAhSdy1VMujreaaWCDjO9BPa0P2As7c0Hh3riZsY3ncU3NnsGg@mail.gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 31 Dec 2020 10:53:36 +0100
Message-ID: <CAM4kBB+fAOhN6dodf8nz2qqTJbXhKQ-EF+jHrBu2OA9wtBv-7w@mail.gmail.com>
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

On Tue, Dec 29, 2020 at 6:05 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Dec 28, 2020 at 10:08 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> >
> > On Mon, Dec 28, 2020 at 3:10 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Mon, Dec 28, 2020 at 7:05 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 28, 2020 at 12:59 PM Anup Patel <anup@brainfault.org> wrote:
> > > > >
> > > > > On Sat, Dec 26, 2020 at 10:03 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > > > > >
> > > > > > Sometimes, especially in a production system we may not want to
> > > > > > use a "smart bootloader" like u-boot to load kernel, ramdisk and
> > > > > > device tree from a filesystem on eMMC, but rather load the kernel
> > > > > > from a NAND partition and just run it as soon as we can, and in
> > > > > > this case it is convenient to have device tree compiled into the
> > > > > > kernel binary. Since this case is not limited to MMU-less systems,
> > > > > > let's support it for these which have MMU enabled too.
> > > > > >
> > > > > > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > > > > > ---
> > > > > >  arch/riscv/Kconfig   |  1 -
> > > > > >  arch/riscv/mm/init.c | 12 ++++++++++--
> > > > > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > index 2b41f6d8e458..9464b4e3a71a 100644
> > > > > > --- a/arch/riscv/Kconfig
> > > > > > +++ b/arch/riscv/Kconfig
> > > > > > @@ -419,7 +419,6 @@ endmenu
> > > > > >
> > > > > >  config BUILTIN_DTB
> > > > > >         def_bool n
> > > > > > -       depends on RISCV_M_MODE
> > > > > >         depends on OF
> > > > > >
> > > > > >  menu "Power management options"
> > > > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > > > index 87c305c566ac..5d1c7a3ec01c 100644
> > > > > > --- a/arch/riscv/mm/init.c
> > > > > > +++ b/arch/riscv/mm/init.c
> > > > > > @@ -194,12 +194,20 @@ void __init setup_bootmem(void)
> > > > > >         setup_initrd();
> > > > > >  #endif /* CONFIG_BLK_DEV_INITRD */
> > > > > >
> > > > > > +       /*
> > > > > > +        * If DTB is built in, no need to reserve its memblock.
> > > > > > +        * OTOH, initial_boot_params has to be set to properly copy DTB
> > > > > > +        * before unflattening later on.
> > > > > > +        */
> > > > > > +       if (IS_ENABLED(CONFIG_BUILTIN_DTB))
> > > > > > +               initial_boot_params = __va(dtb_early_pa);
> > > > >
> > > > > Don't assign initial_boot_params directly here because the
> > > > > early_init_dt_scan() will do it.
> > > >
> > > > early_init_dt_scan will set initial_boot_params to dtb_early_va from
> > > > the early mapping which will be gone by the time
> > > > unflatten_and_copy_device_tree() is called.
> > >
> > > That's why we are doing early_init_dt_verify() again for the MMU-enabled
> > > case which already takes care of your concern.
> >
> > I might be out in the woods here but... Do you mean the call to
> > early_init_dt_verify() in setup_arch() which is compiled out
> > completely in the CONFIG_BUILTIN_DTB case?
> > Or is there any other call that I'm overlooking?
>
> Sorry for the confusion, what I meant was that we are calling
> early_init_dt_verify() from setup_arch() for the MMU-enabled
> with built-in DTB disabled case to update "initial_boot_params"
> after the boot CPU has switched from early_pg_dir to swapper_pg_dir.
>
> For MMU-enabled with built-in DTB case, if setup_vm() sets the
> dtb_early_va and dtb_early_pa correctly then early_init_dt_scan()
> called from setup_arch() will automatically set correct value for
> "initial_boot_params".

Oh I think I get it now. You are suggesting to skip the temporary
mapping for DT altogether since it is anyway in the kernel mapping
range, aren't you?
That does make sense indeed, thanks :)

> It is strange that early_init_dt_verify() is being compiled-out for you
> because the early_init_dt_scan() called from setup_arch() also uses
> early_init_dt_verify(). I quickly compiled the NoMMU kernel for K210
> which also uses built-in DTB and I see that early_init_dt_verify()
> is not being compiled-out when built-in DTB is enabled.

I did not say that early_init_dt_verify() is compiled out, it's the
call to it in setup_arch() that is compiled out if BUILTIN_DTB is
selected. However, if I understand you correctly now, it should not
matter if we don't set dtb_early_va to point to the temporary mapping.

Best regards,
   Vitaly
>
> Regards,
> Anup
>
> >
> > Best regards,
> >    Vitaly
> >
> > > We use early_init_dt_verify() like most architectures to set the initial DTB.
> > >
> > > >
> > > > > The setup_vm() is supposed to setup dtb_early_va and dtb_early_pa
> > > > > for MMU-enabled case so please add a "#ifdef" over there for the
> > > > > built-in DTB case.
> > > > >
> > > > > > +       else
> > > > > > +               memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > > > > > +
> > > > > >         /*
> > > > > >          * Avoid using early_init_fdt_reserve_self() since __pa() does
> > > > > >          * not work for DTB pointers that are fixmap addresses
> > > > > >          */
> > > > >
> > > > > This comment needs to be updated and moved along the memblock_reserve()
> > > > > statement.
> > > > >
> > > > > > -       memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > > > > > -
> > > > > >         early_init_fdt_scan_reserved_mem();
> > > > > >         dma_contiguous_reserve(dma32_phys_limit);
> > > > > >         memblock_allow_resize();
> > > > > > --
> > > > > > 2.29.2
> > > > > >
> > > > >
> > > > > This patch should be based upon Damiens builtin DTB patch.
> > > > > Refer, https://www.spinics.net/lists/linux-gpio/msg56616.html
> > > >
> > > > Thanks for the pointer, however I don't think our patches have
> > > > intersections. Besides, Damien is dealing with the MMU-less case
> > > > there.
> > >
> > > Damien's patch is also trying to move to use generic BUILTIN_DTB
> > > support for the MMU-less case so it is similar work hence the chance
> > > of patch conflict.
> > >
> > > Regards,
> > > Anup
