Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ECB28ECC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 07:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgJOFju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 01:39:50 -0400
Received: from verein.lst.de ([213.95.11.211]:59145 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbgJOFju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 01:39:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CEEC168AFE; Thu, 15 Oct 2020 07:39:48 +0200 (CEST)
Date:   Thu, 15 Oct 2020 07:39:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 6/8] arm64: mm: Set ZONE_DMA size based on
 devicetree's dma-ranges
Message-ID: <20201015053948.GB12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de> <20201014191211.27029-7-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014191211.27029-7-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:12:08PM +0200, Nicolas Saenz Julienne wrote:
> +	zone_dma_bits = min(zone_dma_bits,
> +			    (unsigned int)ilog2(of_dma_get_max_cpu_address(NULL)));

Plase avoid pointlessly long lines.  Especially if it is completely trivial
by using either min_t or not overindenting like here.
