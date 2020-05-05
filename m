Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF521C530C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 12:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgEEKWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 06:22:38 -0400
Received: from verein.lst.de ([213.95.11.211]:34498 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEEKWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:22:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC3CE68C4E; Tue,  5 May 2020 12:22:34 +0200 (CEST)
Date:   Tue, 5 May 2020 12:22:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 01/25] dma-mapping: add generic helpers for mapping
 sgtable objects
Message-ID: <20200505102234.GA15038@lst.de>
References: <20200505083926.28503-1-m.szyprowski@samsung.com> <CGME20200505084624eucas1p2a9a5c4d2aece2c1555a5480c19c2e050@eucas1p2.samsung.com> <20200505084614.30424-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline int dma_map_sgtable_attrs(struct device *dev,
> +	struct sg_table *sgt, enum dma_data_direction dir, unsigned long attrs)

Two tab indents for parameter continuation, please.

Can we also skip the separate _attrs version?  The existing ones have the
separate _attrs variant as there were pre-existing versions without the
attrs argument and lots of users, but that doesn't really apply here as
an extra 0 argument isn't really an issue.

> +static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
> +			unsigned long iova, struct sg_table *sgt, int prot)
> +{
> +	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
> +}

Should this be a separate patch due to the different subsystems?

FYI, I'll happily pick up the prep patches in an immutable branch of
the dma-mapping tree one we have settled on the details.
