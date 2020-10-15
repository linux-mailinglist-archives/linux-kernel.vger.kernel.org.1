Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A028ED48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgJOG4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgJOG4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:56:54 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E792225F;
        Thu, 15 Oct 2020 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602745013;
        bh=/YKH5meqhXiqGDEIZGNk409R+bLKhqPfgct/XJl5aDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AUs/FhoJZlItQFqRuO1nTUOMcl9QvtPo72UGIFzwMxZpOAXti098/bPoSUY+HmXn4
         N0ICGnyxftp0A1vE4KN3DIvTpmgIhv6jyF5lx3BSoh1LjQ1E4I9dk8rSe0B9bwvQMV
         Vf+HMaEVlVZNhLmsvJYipWvKfNM0GIIScn9CSXk4=
Received: by mail-ot1-f46.google.com with SMTP id 32so2010725otm.3;
        Wed, 14 Oct 2020 23:56:52 -0700 (PDT)
X-Gm-Message-State: AOAM530hwB98/nWXgvFeaS6V8iT/bXhFJOE4ifl55QTcF4AtaNAfrHq6
        JkwqLw26xtp23pLbaTHpk9OKJ5OElhWRdRb+Ab0=
X-Google-Smtp-Source: ABdhPJybOoY+mO/nEnFh3limcLTJvKxYdzD3nOrYwJKYP1LxI1gvd68IyrTKREOBe2vGTnarzIy1mGtBNPNgzjzm/u4=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr1614345ots.90.1602745011933;
 Wed, 14 Oct 2020 23:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de> <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 15 Oct 2020 08:56:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFnLEpNTZVq16YgBomkZwwdGsH89OSELsYeiee4P+GLPg@mail.gmail.com>
Message-ID: <CAMj1kXFnLEpNTZVq16YgBomkZwwdGsH89OSELsYeiee4P+GLPg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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

On Thu, 15 Oct 2020 at 00:03, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >
> > Introduce of_dma_get_max_cpu_address(), which provides the highest CPU
> > physical address addressable by all DMA masters in the system. It's
> > specially useful for setting memory zones sizes at early boot time.
> >
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >
> > ---
> >
> > Changes since v2:
> >  - Use PHYS_ADDR_MAX
> >  - return phys_dma_t
> >  - Rename function
> >  - Correct subject
> >  - Add support to start parsing from an arbitrary device node in order
> >    for the function to work with unit tests
> >
> >  drivers/of/address.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of.h   |  7 +++++++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index eb9ab4f1e80b..b5a9695aaf82 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -1024,6 +1024,48 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
> >  }
> >  #endif /* CONFIG_HAS_DMA */
> >
> > +/**
> > + * of_dma_get_max_cpu_address - Gets highest CPU address suitable for DMA
> > + * @np: The node to start searching from or NULL to start from the root
> > + *
> > + * Gets the highest CPU physical address that is addressable by all DMA masters
> > + * in the system (or subtree when np is non-NULL). If no DMA constrained device
> > + * is found, it returns PHYS_ADDR_MAX.
> > + */
> > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > +{
> > +       phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
>
> One issue with using phys_addr_t is it may be 32-bit even though the
> DT is 64-bit addresses. LPAE capable system with LPAE disabled. Maybe
> the truncation is fine here? Maybe not.
>

PHYS_ADDR_MAX is the max addressable CPU address on the system, and so
it makes sense to use it for the return type, and for the preliminary
return value: this is actually what /prevents/ truncation, because we
will only overwrite max_cpu_addr if the new u64 value is lower.


> > +       struct of_range_parser parser;
> > +       phys_addr_t subtree_max_addr;
> > +       struct device_node *child;
> > +       phys_addr_t cpu_end = 0;
> > +       struct of_range range;
> > +       const __be32 *ranges;
> > +       int len;
> > +
> > +       if (!np)
> > +               np = of_root;
> > +
> > +       ranges = of_get_property(np, "dma-ranges", &len);
>
> I'm not really following why you changed the algorithm here. You're
> skipping disabled nodes which is good. Was there some other reason?
>
> > +       if (ranges && len) {
> > +               of_dma_range_parser_init(&parser, np);
> > +               for_each_of_range(&parser, &range)
> > +                       if (range.cpu_addr + range.size > cpu_end)
> > +                               cpu_end = range.cpu_addr + range.size;
> > +
> > +               if (max_cpu_addr > cpu_end)
> > +                       max_cpu_addr = cpu_end;
> > +       }
> > +
> > +       for_each_available_child_of_node(np, child) {
> > +               subtree_max_addr = of_dma_get_max_cpu_address(child);
> > +               if (max_cpu_addr > subtree_max_addr)
> > +                       max_cpu_addr = subtree_max_addr;
> > +       }
> > +
> > +       return max_cpu_addr;
> > +}
> > +
> >  /**
> >   * of_dma_is_coherent - Check if device is coherent
> >   * @np:        device node
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 481ec0467285..db8db8f2c967 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -558,6 +558,8 @@ int of_map_id(struct device_node *np, u32 id,
> >                const char *map_name, const char *map_mask_name,
> >                struct device_node **target, u32 *id_out);
> >
> > +phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
> > +
> >  #else /* CONFIG_OF */
> >
> >  static inline void of_core_init(void)
> > @@ -995,6 +997,11 @@ static inline int of_map_id(struct device_node *np, u32 id,
> >         return -EINVAL;
> >  }
> >
> > +static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
> > +{
> > +       return PHYS_ADDR_MAX;
> > +}
> > +
> >  #define of_match_ptr(_ptr)     NULL
> >  #define of_match_node(_matches, _node) NULL
> >  #endif /* CONFIG_OF */
> > --
> > 2.28.0
> >
