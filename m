Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6D280834
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgJAUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbgJAUCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:02:18 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D05321481;
        Thu,  1 Oct 2020 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601582537;
        bh=X4GALR0/qFK5SmDexVvDnxfl0R4yatvYbaVfr1S5mhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fv2G+gwnjbVlRGYvDBilOq2DE7yzKzzO8czOj6nHOIlOG/mHWnM7eMS0UnhsKFGj6
         5AGtaofc2zEU0GXPaYgpbm0rXI6BhjbEqKIFlupL502zynstjccnTSOGevRhvnrbja
         rxmA+KojicON0YDUGZ3jAjfkhYmrmY3culfbV5qQ=
Received: by mail-ot1-f45.google.com with SMTP id u25so6749278otq.6;
        Thu, 01 Oct 2020 13:02:17 -0700 (PDT)
X-Gm-Message-State: AOAM532KQtpRCGmRJrlR1a1+ElEqlL769hAHS5bhTbMtTdjo+X6uucFZ
        W09QRypX9mA8x4m7Bibyjgw0bPcTxLYg7+kFJQ==
X-Google-Smtp-Source: ABdhPJxiEDxZ0FgXOi5cEGTxp8JWRcCOqobBw1qQ2DkZLAGugxsEI/6ZnBC1AlXUEf9at/4YzkBjFq5m7bNvdiq3ow4=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr5715034otp.107.1601582536474;
 Thu, 01 Oct 2020 13:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de> <20201001171500.GN21544@gaia>
 <20201001172320.GQ21544@gaia> <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
In-Reply-To: <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Oct 2020 15:02:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKS8-QTDEMmAahbOG6hay5kAYAUwhH04-U2hycxhFc6yw@mail.gmail.com>
Message-ID: <CAL_JsqKS8-QTDEMmAahbOG6hay5kAYAUwhH04-U2hycxhFc6yw@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 12:31 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Thu, 2020-10-01 at 18:23 +0100, Catalin Marinas wrote:
> > On Thu, Oct 01, 2020 at 06:15:01PM +0100, Catalin Marinas wrote:
> > > Hi Nicolas,
> > >
> > > Thanks for putting this together.
> > >
> > > On Thu, Oct 01, 2020 at 06:17:37PM +0200, Nicolas Saenz Julienne wrote:
> > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > index 4602e467ca8b..cd0d115ef329 100644
> > > > --- a/drivers/of/fdt.c
> > > > +++ b/drivers/of/fdt.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <linux/serial_core.h>
> > > >  #include <linux/sysfs.h>
> > > >  #include <linux/random.h>
> > > > +#include <linux/dma-direct.h>    /* for zone_dma_bits */
> > > >
> > > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > > >  #include <asm/page.h>
> > > > @@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nodes(void)
> > > >   of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> > > >  }
> > > >
> > > > +void __init early_init_dt_update_zone_dma_bits(void)
> > > > +{
> > > > + unsigned long dt_root = of_get_flat_dt_root();
> > > > +
> > > > + if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711"))
> > > > +         zone_dma_bits = 30;
> > > > +}
> > >
> > > I think we could keep this entirely in the arm64 setup_machine_fdt() and
> > > not pollute the core code with RPi4-specific code.
> >
> > Actually, even better, could we not move the check to
> > arm64_memblock_init() when we initialise zone_dma_bits?
>
> I did it this way as I vaguely remembered Rob saying he wanted to centralise
> all early boot fdt code in one place. But I'll be happy to move it there.

Right, unless zone_dma_bits is only an arm64 thing, then this doesn't
really have anything arch specific.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
