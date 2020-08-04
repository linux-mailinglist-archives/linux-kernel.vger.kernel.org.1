Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049E823B4CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 08:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgHDGGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 02:06:37 -0400
Received: from verein.lst.de ([213.95.11.211]:41440 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbgHDGGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:06:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 852C86736F; Tue,  4 Aug 2020 08:06:33 +0200 (CEST)
Date:   Tue, 4 Aug 2020 08:06:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     amit.pundir@linaro.org, hch@lst.de, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200804060633.GA7368@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de> <20200803160956.19235-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803160956.19235-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 06:09:56PM +0200, Nicolas Saenz Julienne wrote:
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> +		return end <= DMA_BIT_MASK(zone_dma_bits);
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> +		return end <= DMA_BIT_MASK(32);
> +	if (gfp & GFP_KERNEL)
> +		return end > DMA_BIT_MASK(32);

So the GFP_KERNEL one here looks weird.  For one I don't think the if
line is needed at all, and it just confuses things.  Second I don't
see the need (and actually some harm) in preventing GFP_KERNEL
allocations from dipping into lower CMA areas - something that we did
support before 5.8 with the single pool.
