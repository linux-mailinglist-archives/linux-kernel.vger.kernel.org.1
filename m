Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05F72E9907
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhADPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADPmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:42:24 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199A4C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:41:44 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id q5so25636302ilc.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 07:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2MrtbHZcuRPK1fpB0wiajIVgldcxrY0YhhP9f9CIbQ=;
        b=mEe5zpAjdIms724rg9fZSdAADOlGX2e3ggNqQ0sRDXOD1ycd+abEgZayOD6MSchQku
         lWvsveqwGQZ6wJ0+wYMNhHmrs2DqZUyf67T6KvH3LtC3YxNJ/oejL4H7N6aZjcYqLrjd
         uQQNTj2GWafNkSrQEamnrW1sqyV/4GjpLV0EeQHa0vlkv/O4BI9Wpt4SxiuM+Us80niU
         EbVFwt9KkmMH5vcXfG/D1OJDYLkJo/y1LNM0L95ufik5Z1NXWOgquPn+obl4bsPzJpGg
         h0wShuskcmshc8lkV5ZSRN47MHumRhAHPiIL+M80hiG25e+NmaiwQtfDYHQli3E/EyHV
         XkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2MrtbHZcuRPK1fpB0wiajIVgldcxrY0YhhP9f9CIbQ=;
        b=s3iuaQX9zqZzEep4sxHqxN3XRwZf6/zI/1Qq0TE7fx/v1zmq5sAA6RXGy4bpKe4VTU
         vawXb/hO/epi2tFC9+ZqpPCBwscRTPONv3X08l08EHg+gJEfX6HSqWhIlJD39/Uh0LdH
         RhE+i5+8vd08Oos54UwqX6kXJy/MaP+dSiTOjzqvn0XeWhmVbRECzEW1+TAbEW6ebIju
         NkZZx6Qzi3DaVIFGEJ16R7Af8o9Vl0EdE0s7F5a1FUVfQQPBr3iNpG4ad9nOyR6Xtk/n
         izkHOdcEdkGdKcdnLkpW4Xt79nlCg5J1x2MvHpgfjKD9DFAf9iAipaJJZamZnY5zBTtK
         WB1w==
X-Gm-Message-State: AOAM532Apu5024GOvz+UADpPGlTXb782QRgmfhnUFNtSiaxhaGgGx9oi
        88HBpuveojT12xepXAGJ9KDxrI4u3rX5vqFpFWCn+Q==
X-Google-Smtp-Source: ABdhPJyavzWV83uhkF+Smp4GknMNxLlA2JPz9p0hu3m7Ye9tvuVbfWqxWEaUlvTqcP9q8/XFtdm9dPJv7yu7BX/aSPs=
X-Received: by 2002:a05:6e02:929:: with SMTP id o9mr68874659ilt.42.1609774903444;
 Mon, 04 Jan 2021 07:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20201227141638.GA11393@athena.kudzu.us> <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
 <20210104082948.GR2831@kadam>
In-Reply-To: <20210104082948.GR2831@kadam>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Mon, 4 Jan 2021 10:41:32 -0500
Message-ID: <CAPoiz9zqKsOD8ywxgEjy5t9FB0Mv5uWgfJJCaqCyKxdb5E4wLw@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v5.11
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 3:31 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sun, Dec 27, 2020 at 09:38:23AM -0800, Linus Torvalds wrote:
> > On Sun, Dec 27, 2020 at 6:16 AM Jon Mason <jdmason@kudzu.us> wrote:
> > >
> > > Wang Qing (1):
> > >       ntb: idt: fix error check in ntb_hw_idt.c
> >
> > So this patch seems to be at least partially triggered by a smatch
> > warning that is a bit questionable.
> >
> > This part:
> >
> >      if (IS_ERR_OR_NULL(dbgfs_topdir)) {
> >          dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
> > -        return PTR_ERR(dbgfs_topdir);
> > +        return PTR_ERR_OR_ZERO(dbgfs_topdir);
> >      }
> >
> > works, but is very non-optimal and unnecessary.
> >
> > The thing is, "PTR_ERR()" works just fine on a IS_ERR_OR_NULL pointer.
> > It doesn't work on a _regular_ non-NULL and non-ERR pointer, and will
> > return random garbage for those. But if you've tested for
> > IS_ERR_OR_NULL(), then a regular PTR_ERR() is already fine.
> >
> > And PTR_ERR_OR_ZERO() potentially generates an extraneous pointless
> > tests against zero (to check for the ERR case).
> >
> > A compiler may be able to notice that the PTR_ERR_OR_ZERO() is
> > unnecessary and remove it (because of the IS_ERR_OR_NULL() checks),
> > but in general we should assume compilers are "not stupid" rather than
> > "really smart".
> >
> > So while this patch isn't _wrong_, and I've already pulled it, the
> > fact that apparently some smatch test triggers these pointless and
> > potentially expensive patches is not a good idea.
> >
> > I'm not sure what the smatch tests should be (NULL turns to 0, which
> > may be confusing), but I'm cc'ing Dan in case he has ideas.
> >
>
> The most common bug that this check finds is the other part of that same
> commit 91b8246de859 ("ntb: idt: fix error check in ntb_hw_idt.c"):
>
>         /* Allocate the memory for IDT NTB device data */
>         ndev = idt_create_dev(pdev, id);
> -       if (IS_ERR_OR_NULL(ndev))
> +       if (IS_ERR(ndev))
>                 return PTR_ERR(ndev);
>
> idt_create_dev() never returns NULL, but if it did then we don't want
> to return success.
>
> For the debugfs stuff, the caller doesn't check the return value anyway.
> Just make it a void function.  A lot of this debugfs code could be
> simplified.  It's not a bug to pass an error pointer or a NULL dbgfs_topdir
> pointer to debugfs_create_file().  There isn't any benefit in checking
> debugfs_initialized().
>
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index e7a4c2aa8baa..710c17b2a923 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2504,28 +2504,14 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
>   *
>   * Return: zero on success, otherwise a negative error number.
>   */
> -static int idt_init_dbgfs(struct idt_ntb_dev *ndev)
> +static void idt_init_dbgfs(struct idt_ntb_dev *ndev)
>  {
>         char devname[64];
>
> -       /* If the top directory is not created then do nothing */
> -       if (IS_ERR_OR_NULL(dbgfs_topdir)) {
> -               dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
> -               return PTR_ERR_OR_ZERO(dbgfs_topdir);
> -       }
> -
>         /* Create the info file node */
>         snprintf(devname, 64, "info:%s", pci_name(ndev->ntb.pdev));
>         ndev->dbgfs_info = debugfs_create_file(devname, 0400, dbgfs_topdir,
> -               ndev, &idt_dbgfs_info_ops);
> -       if (IS_ERR(ndev->dbgfs_info)) {
> -               dev_dbg(&ndev->ntb.pdev->dev, "Failed to create DebugFS node");
> -               return PTR_ERR(ndev->dbgfs_info);
> -       }
> -
> -       dev_dbg(&ndev->ntb.pdev->dev, "NTB device DebugFS node created");
> -
> -       return 0;
> +                                              ndev, &idt_dbgfs_info_ops);
>  }
>
>  /*
> @@ -2792,7 +2778,7 @@ static int idt_pci_probe(struct pci_dev *pdev,
>                 goto err_deinit_isr;
>
>         /* Initialize DebugFS info node */
> -       (void)idt_init_dbgfs(ndev);
> +       idt_init_dbgfs(ndev);
>
>         /* IDT PCIe-switch NTB driver is finally initialized */
>         dev_info(&pdev->dev, "IDT NTB device is ready");
> @@ -2904,9 +2890,7 @@ static int __init idt_pci_driver_init(void)
>  {
>         pr_info("%s %s\n", NTB_DESC, NTB_VER);
>
> -       /* Create the top DebugFS directory if the FS is initialized */
> -       if (debugfs_initialized())
> -               dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +       dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
>
>         /* Register the NTB hardware driver to handle the PCI device */
>         return pci_register_driver(&idt_pci_driver);
> --
> 2.29.2

This seems logical and the patch looks fine to me.  If you send it as
a patch, I'll happily pull it in.

Thanks,
Jon

>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20210104082948.GR2831%40kadam.
