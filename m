Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20014287C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgJHTnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgJHTnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:43:31 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23BF622202;
        Thu,  8 Oct 2020 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602186210;
        bh=abWUHRGLWMGmX/Tv6KKz6D0f3Jzr7DwwCLBGA7BTaK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IgDpgsISz/i/U6v23X6I0LY3rtH1P6r4x4kEd+A/bMj9jQK5p8HbFb8pktCVq8ZHq
         Y+AWR2mZYCgGiXPou9EwU1cXkNg8Jl/HBTvar4UnXrVth71btDMQb8i8Y4HlMopcKx
         m/T1/icTQfdMN6jfMNyvxig3wbmzxxgbffR6vWyE=
Received: by mail-ot1-f41.google.com with SMTP id q21so6677681ota.8;
        Thu, 08 Oct 2020 12:43:30 -0700 (PDT)
X-Gm-Message-State: AOAM532Ge1L6Df+qzRLWP1aFEbABsdBfI33eSOyVOXerpqB263I5cvd8
        YaNwcfHFJe0Wn/eV+Q8SYEIWAhNiw68kn0ehazA=
X-Google-Smtp-Source: ABdhPJxiXR12+R6StUgzqZLHBQ2OD2DN3gcO9/Bj3pCTbxT+SfYwTB2taOKJTWOAiJJf2sTaK+rb1sZ0PzCY7OValUA=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr6658185otq.77.1602186209247;
 Thu, 08 Oct 2020 12:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de> <20201001171500.GN21544@gaia>
 <20201001172320.GQ21544@gaia> <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia> <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201008101353.GE7661@gaia>
In-Reply-To: <20201008101353.GE7661@gaia>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Oct 2020 21:43:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFDEdEJ_eaB=jb1m=tKBpVdskrC0fW67NvGNZFS5PVL=Q@mail.gmail.com>
Message-ID: <CAMj1kXFDEdEJ_eaB=jb1m=tKBpVdskrC0fW67NvGNZFS5PVL=Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Lorenzo)

On Thu, 8 Oct 2020 at 12:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> > On Fri, 2020-10-02 at 12:55 +0100, Catalin Marinas wrote:
> > > On Thu, Oct 01, 2020 at 07:31:19PM +0200, Nicolas Saenz Julienne wrote:
> > > > On Thu, 2020-10-01 at 18:23 +0100, Catalin Marinas wrote:
> > > > > On Thu, Oct 01, 2020 at 06:15:01PM +0100, Catalin Marinas wrote:
> > > > > > On Thu, Oct 01, 2020 at 06:17:37PM +0200, Nicolas Saenz Julienne wrote:
> > > > > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > > > > index 4602e467ca8b..cd0d115ef329 100644
> > > > > > > --- a/drivers/of/fdt.c
> > > > > > > +++ b/drivers/of/fdt.c
> > > > > > > @@ -25,6 +25,7 @@
> > > > > > >  #include <linux/serial_core.h>
> > > > > > >  #include <linux/sysfs.h>
> > > > > > >  #include <linux/random.h>
> > > > > > > +#include <linux/dma-direct.h>      /* for zone_dma_bits */
> > > > > > >
> > > > > > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > > > > > >  #include <asm/page.h>
> > > > > > > @@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nodes(void)
> > > > > > >     of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> > > > > > >  }
> > > > > > >
> > > > > > > +void __init early_init_dt_update_zone_dma_bits(void)
> > > > > > > +{
> > > > > > > +   unsigned long dt_root = of_get_flat_dt_root();
> > > > > > > +
> > > > > > > +   if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711"))
> > > > > > > +           zone_dma_bits = 30;
> > > > > > > +}
> > > > > >
> > > > > > I think we could keep this entirely in the arm64 setup_machine_fdt() and
> > > > > > not pollute the core code with RPi4-specific code.
> > > > >
> > > > > Actually, even better, could we not move the check to
> > > > > arm64_memblock_init() when we initialise zone_dma_bits?
> > > >
> > > > I did it this way as I vaguely remembered Rob saying he wanted to centralise
> > > > all early boot fdt code in one place. But I'll be happy to move it there.
> > >
> > > I can see Rob replied and I'm fine if that's his preference. However,
> > > what I don't particularly like is that in the arm64 code, if
> > > zone_dma_bits == 24, we set it to 32 assuming that it wasn't touched by
> > > the early_init_dt_update_zone_dma_bits(). What if at some point we'll
> > > get a platform that actually needs 24 here (I truly hope not, but just
> > > the principle of relying on magic values)?
> > >
> > > So rather than guessing, I'd prefer if the arch code can override
> > > ZONE_DMA_BITS_DEFAULT. Then, in arm64, we'll just set it to 32 and no
> > > need to explicitly touch the zone_dma_bits variable.
> >
> > Yes, sonds like the way to go. TBH I wasn't happy with that solution either,
> > but couldn't think of a nicer alternative.
> >
> > Sadly I just realised that the series is incomplete, we have RPi4 users that
> > want to boot unsing ACPI, and this series would break things for them. I'll
> > have a word with them to see what we can do for their use-case.
>
> Is there a way to get some SoC information from ACPI?
>

This is unfortunate. We used ACPI _DMA methods as they were designed
to communicate the DMA limit of the XHCI controller to the OS.

It shouldn't be too hard to match the OEM id field in the DSDT, and
switch to the smaller mask. But it sucks to have to add a quirk like
that.
