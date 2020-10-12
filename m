Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2A28AE50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgJLGrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:47:47 -0400
Received: from verein.lst.de ([213.95.11.211]:48733 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgJLGrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:47:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B4B967373; Mon, 12 Oct 2020 08:47:16 +0200 (CEST)
Date:   Mon, 12 Oct 2020 08:47:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in
 bcm2711
Message-ID: <20201012064715.GA2548@lst.de>
References: <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de> <20201002115541.GC7034@gaia> <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de> <20201009071013.GA12208@lst.de> <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com> <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de> <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com> <20201009152433.GA19953@e121166-lin.cambridge.arm.com> <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com> <20201009171051.GL23638@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009171051.GL23638@gaia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 06:10:52PM +0100, Catalin Marinas wrote:
> kdump wants DMA-able memory and,

DMAable by whom?  The only way to guranteed DMAable memory is to use
the DMA memory allocator(s) and pass a specific device to them.  Everyting
else is just fundamentally broken.  Note that even when device is not
DMAable we can still use swiotlb to access it.
