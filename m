Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659D228EF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgJOJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbgJOJS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:18:29 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EC7E22261;
        Thu, 15 Oct 2020 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602753508;
        bh=LcUjDS/UxFDzhKw9Qv4zxqtM0hewtDnElII8YgYlyfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cBNJ6mVo6CxYOLvtq59I4vSYni922TnxPNEG+VJMSbZ0E4qPvh6FrhZEfZrtCDyZJ
         D/7gFjqEpcf4ggWZBhegYDphrYNCyDaO+vrNJpt1ZmqQdrZpXw+Ojj2UBuMcpF9XmV
         /pbXjLSC39JPB3x4XxzIxyVUDsskyGYY7fq09PpA=
Received: by mail-ot1-f51.google.com with SMTP id 32so2298587otm.3;
        Thu, 15 Oct 2020 02:18:28 -0700 (PDT)
X-Gm-Message-State: AOAM5309PIEnhHQvR+93Seu6xFRyCWqQIGvA2aF932KfaFj4Boyke1C9
        snvfEm6kijLZMSXZ7tdVlUMucVB7xHjEQ8NAyac=
X-Google-Smtp-Source: ABdhPJxVK5ZG5Dzh8L6dNVEJ1qz4kLfzxYZdKoh8V+gGkE12YkKWyEtd7MRDVxEdTSv8kOFxzLNhDJAd5NhWC9YsMtI=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr2110017otq.77.1602753507055;
 Thu, 15 Oct 2020 02:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de> <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
 <CAMj1kXFnLEpNTZVq16YgBomkZwwdGsH89OSELsYeiee4P+GLPg@mail.gmail.com> <607e809796bc57ee649390824c4ab2bb767b00ba.camel@suse.de>
In-Reply-To: <607e809796bc57ee649390824c4ab2bb767b00ba.camel@suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 15 Oct 2020 11:18:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHwnfHZ9pU=AENmLZ7ZOeMjK04nMHv2N_Cv5Chmb3MNeg@mail.gmail.com>
Message-ID: <CAMj1kXHwnfHZ9pU=AENmLZ7ZOeMjK04nMHv2N_Cv5Chmb3MNeg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 at 11:16, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Thu, 2020-10-15 at 08:56 +0200, Ard Biesheuvel wrote:
> > On Thu, 15 Oct 2020 at 00:03, Rob Herring <robh+dt@kernel.org> wrote:
> > > On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> > > <nsaenzjulienne@suse.de> wrote:
> > > > Introduce of_dma_get_max_cpu_address(), which provides the highest CPU
> > > > physical address addressable by all DMA masters in the system. It's
> > > > specially useful for setting memory zones sizes at early boot time.
> > > >
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > >
> > > > ---
> > > >
> > > > Changes since v2:
> > > >  - Use PHYS_ADDR_MAX
> > > >  - return phys_dma_t
> > > >  - Rename function
> > > >  - Correct subject
> > > >  - Add support to start parsing from an arbitrary device node in order
> > > >    for the function to work with unit tests
> > > >
> > > >  drivers/of/address.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/of.h   |  7 +++++++
> > > >  2 files changed, 49 insertions(+)
> > > >
> > > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > > index eb9ab4f1e80b..b5a9695aaf82 100644
> > > > --- a/drivers/of/address.c
> > > > +++ b/drivers/of/address.c
> > > > @@ -1024,6 +1024,48 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
> > > >  }
> > > >  #endif /* CONFIG_HAS_DMA */
> > > >
> > > > +/**
> > > > + * of_dma_get_max_cpu_address - Gets highest CPU address suitable for DMA
> > > > + * @np: The node to start searching from or NULL to start from the root
> > > > + *
> > > > + * Gets the highest CPU physical address that is addressable by all DMA masters
> > > > + * in the system (or subtree when np is non-NULL). If no DMA constrained device
> > > > + * is found, it returns PHYS_ADDR_MAX.
> > > > + */
> > > > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > > > +{
> > > > +       phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
> > >
> > > One issue with using phys_addr_t is it may be 32-bit even though the
> > > DT is 64-bit addresses. LPAE capable system with LPAE disabled. Maybe
> > > the truncation is fine here? Maybe not.
> > >
> >
> > PHYS_ADDR_MAX is the max addressable CPU address on the system, and so
> > it makes sense to use it for the return type, and for the preliminary
> > return value: this is actually what /prevents/ truncation, because we
> > will only overwrite max_cpu_addr if the new u64 value is lower.
> >
>
> Actually I now see how things might go south.
>
> > > > +       if (ranges && len) {
> > > > +               of_dma_range_parser_init(&parser, np);
> > > > +               for_each_of_range(&parser, &range)
> > > > +                       if (range.cpu_addr + range.size > cpu_end)
> > > > +                               cpu_end = range.cpu_addr + range.size;
>
> If cpu_end hits 0x1_00000000, it'll overflow to 0. This is possible on 32-bit
> systems (LPAE or not). And something similar might happen on LPAE disabled
> systems.
>
> I could add some extra logic, something like:
>
>         /* We overflowed */
>         if (cpu_end < range.cpu_addr)
>                 cpu_end = PHYS_ADDR_MAX;
>
> Which is not perfect but will cover most sensible cases.
>
> Or simply deal internally in u64s, and upon returning, check if "max_cpu_addr"
> falls higher than PHYS_ADDR_MAX.
>

Just use a u64 for cpu_end

> > > > +
> > > > +               if (max_cpu_addr > cpu_end)
> > > > +                       max_cpu_addr = cpu_end;

... then this comparison and assignment will work as expected.

> > > > +       }
> > > > +
> > > > +       for_each_available_child_of_node(np, child) {
> > > > +               subtree_max_addr = of_dma_get_max_cpu_address(child);
> > > > +               if (max_cpu_addr > subtree_max_addr)
> > > > +                       max_cpu_addr = subtree_max_addr;
> > > > +       }
> > > > +
> > > > +       return max_cpu_addr;
> > > > +}
>
> Regards,
> Nicolas
>
