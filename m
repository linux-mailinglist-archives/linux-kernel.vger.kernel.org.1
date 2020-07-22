Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCF2299E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgGVORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 10:17:02 -0400
Received: from verein.lst.de ([213.95.11.211]:56504 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbgGVORC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:17:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96A4168B05; Wed, 22 Jul 2020 16:16:58 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:16:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        will@kernel.org, ganapatrao.kulkarni@cavium.com,
        catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200722141658.GA17658@lst.de>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com> <20200628111251.19108-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628111251.19108-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 11:12:50PM +1200, Barry Song wrote:
> This is useful for at least two scenarios:
> 1. ARM64 smmu will get memory from local numa node, it can save its
> command queues and page tables locally. Tests show it can decrease
> dma_unmap latency at lot. For example, without this patch, smmu on
> node2 will get memory from node0 by calling dma_alloc_coherent(),
> typically, it has to wait for more than 560ns for the completion of
> CMD_SYNC in an empty command queue; with this patch, it needs 240ns
> only.
> 2. when we set iommu passthrough, drivers will get memory from CMA,
> local memory means much less latency.

I really don't like the config options.  With the boot parameters
you can always hardcode that in CONFIG_CMDLINE anyway.
