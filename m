Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630D22885CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgJIJOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbgJIJOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:14:12 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F4D22277;
        Fri,  9 Oct 2020 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602234851;
        bh=0xH+3LrVqUAaaEwCGyYfsfSUdLpvBCZVWsK1tE5NulE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b/486wn4gBcqVkVots0e1b2L+moNIL/1+BXGuO/KVA2c1nU2ZuC88JGlLNaWjJ6sd
         py5WNrCgwnoTKUq8xBFyxcU6bjegoWARdpvc4j6Ilu9NPWQK7AMjzPbr5odMlJ3zZN
         vhbojmUv+g+eO3hAsRhMY4BtupcVeNyroVyw9cJU=
Received: by mail-oi1-f172.google.com with SMTP id q136so8338220oic.8;
        Fri, 09 Oct 2020 02:14:11 -0700 (PDT)
X-Gm-Message-State: AOAM533TwPINpg9F89BmCVHY39Selj3Vgg/vsG1NhHUnZ0sKBC2tMRWk
        faDpz7KMyFm3656R2pSICcIXxbUc5iFWtujrrnw=
X-Google-Smtp-Source: ABdhPJyR9YP0v5UuAP6vU7yHLB6OtKX/56Pzuzvc/9hj/0kWVSLN+YUS2NmoZGSpJCDKUxf48Uz5elkd4zugoHvx1CE=
X-Received: by 2002:aca:d845:: with SMTP id p66mr1705863oig.47.1602234850502;
 Fri, 09 Oct 2020 02:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de> <20201001171500.GN21544@gaia>
 <20201001172320.GQ21544@gaia> <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia> <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de> <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
 <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
In-Reply-To: <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Oct 2020 11:13:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
Message-ID: <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 10:36, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Fri, 2020-10-09 at 09:37 +0200, Ard Biesheuvel wrote:
> > On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
> > > On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> > > > Sadly I just realised that the series is incomplete, we have RPi4 users that
> > > > want to boot unsing ACPI, and this series would break things for them. I'll
> > > > have a word with them to see what we can do for their use-case.
> > >
> > > Stupid question:  why do these users insist on a totally unsuitable
> > > interface? And why would we as Linux developers care to support such
> > > a aims?
> >
> > The point is really whether we want to revert changes in Linux that
> > made both DT and ACPI boot work without quirks on RPi4.
>
> Well, and broke a big amount of devices that were otherwise fine.
>

Yeah that was unfortunate.

> > Having to check the RPi4 compatible string or OEM id in core init code is
> > awful, regardless of whether you boot via ACPI or via DT.
> >
> > The problem with this hardware is that it uses a DMA mask which is
> > narrower than 32, and the arm64 kernel is simply not set up to deal
> > with that at all. On DT, we have DMA ranges properties and the likes
> > to describe such limitations, on ACPI we have _DMA methods as well as
> > DMA range attributes in the IORT, both of which are now handled
> > correctly. So all the information is there, we just have to figure out
> > how to consume it early on.
>
> Is it worth the effort just for a single board? I don't know about ACPI but
> parsing dma-ranges that early at boot time is not trivial. My intuition tells
> me that it'd be even harder for ACPI, being a more complex data structure.
>

Yes, it will be harder, especially for the _DMA methods.

> > Interestingly, this limitation always existed in the SoC, but it
> > wasn't until they started shipping it with more than 1 GB of DRAM that
> > it became a problem. This means issues like this could resurface in
> > the future with existing SoCs when they get shipped with more memory,
> > and so I would prefer fixing this in a generic way.
>
> Actually what I proposed here is pretty generic. Specially from arm64's
> perspective. We call early_init_dt_scan(), which sets up zone_dma_bits based on
> whatever it finds in DT. Both those operations are architecture independent.
> arm64 arch code doesn't care about the logic involved in ascertaining
> zone_dma_bits. I get that the last step isn't generic. But it's all setup so as
> to make it as such whenever it's worth the effort.
>

The problem is that, while we are providing a full description of the
SoC's capabilities, we short circuit this by inserting knowledge into
the code (that is shared between all DT architectures) that
"brcm,bcm2711" is special, and needs a DMA zone override.

I think for ACPI boot, we might be able to work around this by cold
plugging the memory above 1 GB, but I have to double check whether it
won't get pulled into ZONE_DMA32 anyway (unless anyone can answer that
for me here from the top of their head)
