Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3987623E703
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 07:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHGFVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 01:21:20 -0400
Received: from verein.lst.de ([213.95.11.211]:52550 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGFVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:21:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6374768D0E; Fri,  7 Aug 2020 07:21:16 +0200 (CEST)
Date:   Fri, 7 Aug 2020 07:21:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     amit.pundir@linaro.org, hch@lst.de, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200807052116.GA584@lst.de>
References: <20200806184756.32075-1-nsaenzjulienne@suse.de> <20200806184756.32075-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806184756.32075-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 08:47:55PM +0200, Nicolas Saenz Julienne wrote:
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. To get around this double check CMA's placement before
> allocating from it.

As the builtbot pointed out, memblock_start_of_DRAM can't be used from
non-__init code.  But lookig at it I think throwing that in
is bogus anyway, as cma_get_base returns a proper physical address
already.
