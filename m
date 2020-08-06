Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1B23D660
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 07:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHFFSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 01:18:18 -0400
Received: from verein.lst.de ([213.95.11.211]:48641 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgHFFSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:18:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB10868CFE; Thu,  6 Aug 2020 07:18:14 +0200 (CEST)
Date:   Thu, 6 Aug 2020 07:18:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, amit.pundir@linaro.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200806051814.GA10143@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de> <20200803160956.19235-3-nsaenzjulienne@suse.de> <20200804060633.GA7368@lst.de> <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 11:43:15AM +0200, Nicolas Saenz Julienne wrote:
> > Second I don't see the need (and actually some harm) in preventing GFP_KERNEL
> > allocations from dipping into lower CMA areas - something that we did support
> > before 5.8 with the single pool.
> 
> My thinking is the least we pressure CMA the better, it's generally scarse, and
> it'll not grow as the atomic pools grow. As far as harm is concerned, we now
> check addresses for correctness, so we shouldn't run into problems.
> 
> There is a potential case for architectures defining a default CMA but not
> defining DMA zones where this could be problematic. But isn't that just plain
> abusing CMA? If you need low memory allocations, you should be defining DMA
> zones.

The latter is pretty much what I expect, as we only support the default and
per-device DMA CMAs.
