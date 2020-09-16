Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DB26BCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIPGUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:20:03 -0400
Received: from verein.lst.de ([213.95.11.211]:51054 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgIPGTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:19:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 209C268B05; Wed, 16 Sep 2020 08:19:50 +0200 (CEST)
Date:   Wed, 16 Sep 2020 08:19:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, konrad.wilk@oracle.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
Message-ID: <20200916061949.GA8599@lst.de>
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com> <20200915140719.GA14831@lst.de> <f5cba632-421a-f375-3697-51a182a53a32@oracle.com> <20200915142624.GA16005@lst.de> <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com> <20200915150929.GA19770@lst.de> <5136ed8d-d37d-8144-a6f3-c23f272d8926@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5136ed8d-d37d-8144-a6f3-c23f272d8926@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 04:46:17PM -0400, Thomas Tai wrote:
> I tried out the suggested changes, and it successfully warned the null 
> pointer without panic. I notice that there are some places outside the 
> dma-direct, which calls dma_capable().
>
> https://elixir.bootlin.com/linux/v5.9-rc5/source/arch/x86/kernel/amd_gart_64.c#L187
>
> https://elixir.bootlin.com/linux/v5.9-rc5/source/drivers/xen/swiotlb-xen.c#L387

All of these still come in throught the wrappers in kernel/dma/mapping.c.

> Given that the WARN_ON_ONCE already did the intended warning, would you be 
> ok that I keep the null checking in dma_capable()?

No, the generic dma mapping layer is the right place.
