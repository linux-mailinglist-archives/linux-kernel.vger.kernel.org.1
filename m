Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DB288F99
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbgJIRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389529AbgJIRK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:10:57 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A42E22267;
        Fri,  9 Oct 2020 17:10:54 +0000 (UTC)
Date:   Fri, 9 Oct 2020 18:10:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
Message-ID: <20201009171051.GL23638@gaia>
References: <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
 <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
 <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
 <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
 <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
 <20201009152433.GA19953@e121166-lin.cambridge.arm.com>
 <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 06:23:06PM +0200, Ard Biesheuvel wrote:
> On Fri, 9 Oct 2020 at 17:24, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > We can move this check to IORT code and call it from arm64 if it
> > can be made to work.
> 
> Finding the smallest value in the IORT, and assigning it to
> zone_dma_bits if it is < 32 should be easy. But as I understand it,
> having these separate DMA and DMA32 zones is what breaks kdump, no? So
> how is this going to fix the underlying issue?

If zone_dma_bits is 32, ZONE_DMA32 disappears into ZONE_DMA (GFP_DMA32
allocations fall back to ZONE_DMA).

kdump wants DMA-able memory and, without a 30-bit ZONE_DMA, that would
be the bottom 32-bit. With the introduction of ZONE_DMA, this suddenly
became 1GB. We could change kdump to allocate ZONE_DMA32 but this one
may also be small as it lost 1GB to ZONE_DMA. However, the kdump kernel
would need to be rebuilt without ZONE_DMA since it won't have any. IIRC
(it's been a while since I looked), the kdump allocation couldn't span
multiple zones.

In a separate thread, we try to fix kdump to use allocations above 4G as
a fallback but this only fixes platforms with enough RAM (and maybe it's
only those platforms that care about kdump).

-- 
Catalin
