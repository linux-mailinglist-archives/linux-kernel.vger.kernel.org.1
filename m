Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56D2E8413
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 16:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbhAAP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 10:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbhAAP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 10:28:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB0C061575
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jan 2021 07:27:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id l11so49500234lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 07:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFODUIma3EDbIRqIpTnQ57GoUf+uy/YA2BkZQQikmd0=;
        b=nUC88GxRfSaOwyj/uFtLr9vSQ+zRNFbqMLVdy7KOoz5Pe5sXWFbc53vpKDbxPsmAaf
         ZijHDHKIi65hxKHZcQ3vqwiGz0Oz52d79k5gQRqG5aKWKERiRk9MCx4ftBEAnIAnKy/M
         rX3aESJbTVjzbVlK2OURpXr5JI5ILqZPpCfVu6b33lXjkcPhlNfBhJTDPsTg4xj2of0Q
         bG3K8igzvfOXeWFieNB7hMlN6Ra5Vmdg1bEutq6tk8EZkIwL/mBmKzp/wHmMCLhF+Zwz
         ku6SRsElMRD3AXxCgTt5J2IKNsk+MOiYWJf+MutYECX0l/4OEPap/3iy6aMp3/yh3vxB
         M5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFODUIma3EDbIRqIpTnQ57GoUf+uy/YA2BkZQQikmd0=;
        b=iLeQL54yNfo2Ae5bQvHzohH1GS9gHXeE3/H3h2LsZaCGrOQtElXEF5aaxw9Kp2N4pm
         V1luNl8p0asYgHt7CLterJMqRohIiCEEAOmvOrdVsekOkCBGFRFwe3YNC6b64PAIVIj6
         /NTDrUx2BazN3RdBTkXvCemBL4b52RzQ/syXJjFDj7O/xZCQKSxnkavElpaSTxHvvii7
         MQcppITteZ1VwBDeJkvbOsP3HblG8Y9fICpbxiQfCNgXQQX4I4e511XTvvYvEPKZNWNU
         WflU8n9ckczQoVtU75BU3u2b9NjXDr3VuzgFu3ZxPd6l/QcyS3j/CVhKy+BUVk7l+6HH
         jBpQ==
X-Gm-Message-State: AOAM533k6V753TkBU76bE6x2wuba8qdEgFmIKEpjvNtyUGvonInDExUx
        GqFkKQcJloLYj3l6/v3InCUjCxXYhDeBY1RjFOPO21t+9C9fVA==
X-Google-Smtp-Source: ABdhPJx3bGnuobGT4zwh1rbnnaaQarkVpenAIfZhq2v0f5/++oyGZrTGjbyibQkW/PkKrYhyG44vW6fx38JiU1SPPcY=
X-Received: by 2002:a05:6512:3222:: with SMTP id f2mr25942710lfe.25.1609514861521;
 Fri, 01 Jan 2021 07:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20201226163037.43691-1-vitaly.wool@konsulko.com>
 <CAAhSdy1M5pMjYHNWdOicb3N3fjTfQLEgE8tFb74sqGbPE_9eyQ@mail.gmail.com>
 <CAM4kBBJ3Vbytx=dFK7+DMByV3zK=FVLATSwjyuuygkDK1MCQjA@mail.gmail.com>
 <CAAhSdy0E8xspb3epBdrTmjg7vSQanG9zwyMY19eeDDL8z=WJFg@mail.gmail.com>
 <CAM4kBBJLnrp8XB1OZnv2FEuKdEQuQfDWdgwsV--9mZYB=JmJPQ@mail.gmail.com>
 <CAAhSdy1VMujreaaWCDjO9BPa0P2As7c0Hh3riZsY3ncU3NnsGg@mail.gmail.com> <CAM4kBB+fAOhN6dodf8nz2qqTJbXhKQ-EF+jHrBu2OA9wtBv-7w@mail.gmail.com>
In-Reply-To: <CAM4kBB+fAOhN6dodf8nz2qqTJbXhKQ-EF+jHrBu2OA9wtBv-7w@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 1 Jan 2021 20:57:29 +0530
Message-ID: <CAAhSdy32+n5WcEYJZ5rB70=v1P=aG3haT1j_NGnUENQhqH54BA@mail.gmail.com>
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

On Thu, Dec 31, 2020 at 3:23 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
> On Tue, Dec 29, 2020 at 6:05 AM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Dec 28, 2020 at 10:08 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > >
> > > On Mon, Dec 28, 2020 at 3:10 PM Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > On Mon, Dec 28, 2020 at 7:05 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 28, 2020 at 12:59 PM Anup Patel <anup@brainfault.org> wrote:
> > > > > >
> > > > > > On Sat, Dec 26, 2020 at 10:03 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> > > > > > >
> > > > > > > Sometimes, especially in a production system we may not want to
> > > > > > > use a "smart bootloader" like u-boot to load kernel, ramdisk and
> > > > > > > device tree from a filesystem on eMMC, but rather load the kernel
> > > > > > > from a NAND partition and just run it as soon as we can, and in
> > > > > > > this case it is convenient to have device tree compiled into the
> > > > > > > kernel binary. Since this case is not limited to MMU-less systems,
> > > > > > > let's support it for these which have MMU enabled too.
> > > > > > >
> > > > > > > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > > > > > > ---
> > > > > > >  arch/riscv/Kconfig   |  1 -
> > > > > > >  arch/riscv/mm/init.c | 12 ++++++++++--
> > > > > > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > > index 2b41f6d8e458..9464b4e3a71a 100644
> > > > > > > --- a/arch/riscv/Kconfig
> > > > > > > +++ b/arch/riscv/Kconfig
> > > > > > > @@ -419,7 +419,6 @@ endmenu
> > > > > > >
> > > > > > >  config BUILTIN_DTB
> > > > > > >         def_bool n
> > > > > > > -       depends on RISCV_M_MODE
> > > > > > >         depends on OF
> > > > > > >
> > > > > > >  menu "Power management options"
> > > > > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > > > > index 87c305c566ac..5d1c7a3ec01c 100644
> > > > > > > --- a/arch/riscv/mm/init.c
> > > > > > > +++ b/arch/riscv/mm/init.c
> > > > > > > @@ -194,12 +194,20 @@ void __init setup_bootmem(void)
> > > > > > >         setup_initrd();
> > > > > > >  #endif /* CONFIG_BLK_DEV_INITRD */
> > > > > > >
> > > > > > > +       /*
> > > > > > > +        * If DTB is built in, no need to reserve its memblock.
> > > > > > > +        * OTOH, initial_boot_params has to be set to properly copy DTB
> > > > > > > +        * before unflattening later on.
> > > > > > > +        */
> > > > > > > +       if (IS_ENABLED(CONFIG_BUILTIN_DTB))
> > > > > > > +               initial_boot_params = __va(dtb_early_pa);
> > > > > >
> > > > > > Don't assign initial_boot_params directly here because the
> > > > > > early_init_dt_scan() will do it.
> > > > >
> > > > > early_init_dt_scan will set initial_boot_params to dtb_early_va from
> > > > > the early mapping which will be gone by the time
> > > > > unflatten_and_copy_device_tree() is called.
> > > >
> > > > That's why we are doing early_init_dt_verify() again for the MMU-enabled
> > > > case which already takes care of your concern.
> > >
> > > I might be out in the woods here but... Do you mean the call to
> > > early_init_dt_verify() in setup_arch() which is compiled out
> > > completely in the CONFIG_BUILTIN_DTB case?
> > > Or is there any other call that I'm overlooking?
> >
> > Sorry for the confusion, what I meant was that we are calling
> > early_init_dt_verify() from setup_arch() for the MMU-enabled
> > with built-in DTB disabled case to update "initial_boot_params"
> > after the boot CPU has switched from early_pg_dir to swapper_pg_dir.
> >
> > For MMU-enabled with built-in DTB case, if setup_vm() sets the
> > dtb_early_va and dtb_early_pa correctly then early_init_dt_scan()
> > called from setup_arch() will automatically set correct value for
> > "initial_boot_params".
>
> Oh I think I get it now. You are suggesting to skip the temporary
> mapping for DT altogether since it is anyway in the kernel mapping
> range, aren't you?
> That does make sense indeed, thanks :)

Yes, that's what I am suggesting.

>
> > It is strange that early_init_dt_verify() is being compiled-out for you
> > because the early_init_dt_scan() called from setup_arch() also uses
> > early_init_dt_verify(). I quickly compiled the NoMMU kernel for K210
> > which also uses built-in DTB and I see that early_init_dt_verify()
> > is not being compiled-out when built-in DTB is enabled.
>
> I did not say that early_init_dt_verify() is compiled out, it's the
> call to it in setup_arch() that is compiled out if BUILTIN_DTB is
> selected. However, if I understand you correctly now, it should not
> matter if we don't set dtb_early_va to point to the temporary mapping.

Yes, dtb_early_va can point to some other location such as
built-in DTB.

For MMU-enabled with built-in DTB case, the setup_vm() should
skip the temporary mapping to DT and instead set dtb_early_va
and dtb_early_pa to point to the built-in DTB.

Regards,
Anup
