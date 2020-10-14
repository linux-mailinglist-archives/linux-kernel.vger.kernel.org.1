Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A928E077
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgJNMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgJNMYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:24:05 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8E12222A;
        Wed, 14 Oct 2020 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602678245;
        bh=t0IBPBNo+yYO11jhv9fM4cJG+wfMTFGo8MY5tqsXG5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TMTgWqc23Fp8S68g+EvPHtyVYNZmNP+z9x9jAytDBLk4QMUzqVyPKEIwZja6i1w/V
         ybqg/7GHRaA/08pwv902eetV+9kH5fhw/n5TFlL5PPESAYu1KwG0J/AEdYl6TPgSYb
         anMWS3fr1jbXFcPH9vs8yiRtnplOtBuDc621PUqI=
Received: by mail-ot1-f50.google.com with SMTP id f37so3180771otf.12;
        Wed, 14 Oct 2020 05:24:04 -0700 (PDT)
X-Gm-Message-State: AOAM5314dnij2y7ClmZMfBfCnU3H0Ej6J9RI3/5ypa1/jjmDw0X1949U
        OMK39btaZloBuimwJB08pHZ6CMELi0ORKcuikw==
X-Google-Smtp-Source: ABdhPJy9xd9p7AIQ89atOIFtAtTvVkcZBoUqHoM2d76WPGxs9lK5Ru8GlYDbiDS8fYIzTNRaOfPecpecUgbDqkGL+7A=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr3002538oti.107.1602678244026;
 Wed, 14 Oct 2020 05:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-3-nsaenzjulienne@suse.de> <CAL_JsqL2cs+cko-UuTd37fnBKO_=3jQeyjB49USvm_VTBwcS8g@mail.gmail.com>
 <6740c49b73b11aaf1d74d216dc6e055e0a0ceac3.camel@suse.de>
In-Reply-To: <6740c49b73b11aaf1d74d216dc6e055e0a0ceac3.camel@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Oct 2020 07:23:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+cPQS7836YqVos=n-TFOvc8kXa8ZXGq5_=rZAzz8RLLQ@mail.gmail.com>
Message-ID: <CAL_Jsq+cPQS7836YqVos=n-TFOvc8kXa8ZXGq5_=rZAzz8RLLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 6:52 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Rob,
>
> On Mon, 2020-10-12 at 10:25 -0500, Rob Herring wrote:
> > On Sat, Oct 10, 2020 at 10:12 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > The function provides the CPU physical address addressable by the most
> > > constrained bus in the system. It might be useful in order to
> > > dynamically set up memory zones during boot.
> > >
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >  drivers/of/address.c | 34 ++++++++++++++++++++++++++++++++++
> > >  include/linux/of.h   |  7 +++++++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > index eb9ab4f1e80b..755e97b65096 100644
> > > --- a/drivers/of/address.c
> > > +++ b/drivers/of/address.c
> > > @@ -1024,6 +1024,40 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
> > >  }
> > >  #endif /* CONFIG_HAS_DMA */
> > >
> > > +/**
> > > + * of_dma_safe_phys_limit - Get system wide DMA safe address space
> > > + *
> > > + * Gets the CPU physical address limit for safe DMA addressing system wide by
> > > + * searching for the most constraining dma-range. Otherwise it returns ~0ULL.
> > > + */
> > > +u64 __init of_dma_safe_phys_limit(void)
> > > +{
> > > +       struct device_node *np = NULL;
> > > +       struct of_range_parser parser;
> > > +       const __be32 *ranges = NULL;
> > > +       u64 phys_dma_limit = ~0ULL;
> > > +       struct of_range range;
> > > +       int len;
> > > +
> > > +       for_each_of_allnodes(np) {
> > > +               dma_addr_t cpu_end = 0;
> > > +
> > > +               ranges = of_get_property(np, "dma-ranges", &len);
> > > +               if (!ranges || !len)
> > > +                       continue;
> > > +
> > > +               of_dma_range_parser_init(&parser, np);
> > > +               for_each_of_range(&parser, &range)
> > > +                       if (range.cpu_addr + range.size > cpu_end)
> > > +                               cpu_end = range.cpu_addr + range.size;
> >
> > This doesn't work if you have more than one level of dma-ranges. The
> > address has to be translated first. It should be okay to do that on
> > the start or end address (if not, your DT is broken).
>
> for_each_of_range() calls of_pci_range_parser_one() which utimately populates
> range.cpu_addr with of_translate_dma_address() results. Isn't that good enough?

Indeed. I guess I was remembering the cases not using
for_each_of_range which forgot to do that...

Rob
