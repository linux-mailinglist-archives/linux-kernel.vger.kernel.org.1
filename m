Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893B22DD1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 13:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgLQMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 07:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgLQMoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:44:08 -0500
Date:   Thu, 17 Dec 2020 12:43:23 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: Kconfig: select ZONE_DMA
Message-ID: <20201217124323.GB15336@gaia>
References: <20201217080802.29023-1-peng.fan@oss.nxp.com>
 <93832374535cb46419e921f5ee02ecabfe2cc83d.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93832374535cb46419e921f5ee02ecabfe2cc83d.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 09:44:31AM +0100, Nicolas Saenz Julienne wrote:
> On Thu, 2020-12-17 at 16:08 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > ZONE_DMA should not be disabled, otherwise arm64_dma_phys_limit is
> > left uninitialized and cause swiotlb have IO TLB above 4GB which
> > might crash some platforms

Actually, arm64_dma_phys_limit would be zero-initialised. The
ARCH_LOW_ADDRESS_LIMIT becomes ~0UL, hence it covers the whole address
space.

> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > Not sure whether need to address code to initialize the variables or
> > force select ZONE_DMA
> 
> What is the cause for the swiotlb related crashes? I assume it's DMA into an
> address too high for the bus, but it might be something else.

I think that's the case, swiotlb is not within the low 32-bit of the
address space.

> I figure you have a setup with ZONE_DMA32, ZONE_NORMAL and !ZONE_DMA.
> 
> First of all, I'd suggest you try arm64's defaults (all zones enabled), the
> series I mention above should fix most of the issues we've had with
> ZONE_DMA/ZONE_DMA32 in the past. We now parse DT/ACPI and only create two
> distinct DMA zones if really needed. Otherwise ZONE_DMA spans the whole 32 bit
> address space.
> 
> That said, IMO we're not doing the right thing in the !ZONE_DMA && ZONE_DMA32
> case, and this should fix it (I didn't test it):
> 
> - #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
> + #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit ? : arm64_dma32_phys_limit)

Does this limit need to be inclusive?

-- 
Catalin
