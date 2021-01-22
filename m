Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2D300D94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbhAVUTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:19:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbhAVTdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:33:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CDE123AF8;
        Fri, 22 Jan 2021 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611343953;
        bh=L5V19qa5myZ1I+fNRK/LFzj6kqSe+dZ19wKMEi3vT50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdnS8TC+zFw9YNJ/pW6LGDRdoKpq/S5d109Ra8cb49KY+H+p4ydeL5L9f+QojlXFc
         cPSkQt8+FOnDV9Ndd/k9CaGhPYfu52FTI2qDdLG0Q00teV9uaaMixVXbKwYfqC9uLr
         /vu9h23Ip6AxG4R9Jy6tNrbKVQ/K6WoFN4fl26wRygT/Ey9lMxCKkgZxdsszT3qfub
         dDhigEyn7Ty9KC/S+CK9jVHjaS8jBSf6+ZIUTXj73iYsGVgcAiO9kVw/o2hCjYoTFI
         i9Pn+5f+YaEH3lp4n0lGkejkGVQav50VpTQMinh4WOSo91cVy5gki3V8xa1Wzxoye8
         dgIPntPvWYquQ==
Date:   Fri, 22 Jan 2021 19:32:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com, Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v4 0/7] MediaTek IOMMU improve tlb flush performance in
 map/unmap
Message-ID: <20210122193226.GD25471@willie-the-truck>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107122909.16317-1-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 08:29:02PM +0800, Yong Wu wrote:
> This patchset is to improve tlb flushing performance in iommu_map/unmap
> for MediaTek IOMMU.
> 
> For iommu_map, currently MediaTek IOMMU use IO_PGTABLE_QUIRK_TLBI_ON_MAP
> to do tlb_flush for each a memory chunk. this is so unnecessary. we could
> improve it by tlb flushing one time at the end of iommu_map.
> 
> For iommu_unmap, currently we have already improve this performance by
> gather. But the current gather should take care its granule size. if the
> granule size is different, it will do tlb flush and gather again. Our HW
> don't care about granule size. thus I gather the range in our file.
> 
> After this patchset, we could achieve only tlb flushing once in iommu_map
> and iommu_unmap.
> 
> Regardless of sg, for each a segment, I did a simple test:
>   
>   size = 20 * SZ_1M;
>   /* the worst case, all are 4k mapping. */
>   ret = iommu_map(domain, 0x5bb02000, 0x123f1000, size, IOMMU_READ);
>   iommu_unmap(domain, 0x5bb02000, size);
> 
> This is the comparing time(unit is us):
>               original-time  after-improve
>    map-20M    59943           2347
>    unmap-20M  264             36
> 
> This patchset also flush tlb once in the iommu_map_sg case.
> 
> patch [1/7][2/7][3/7] are for map while the others are for unmap.
> 
> change note:
> v4: a. base on v5.11-rc1.
>     b. Add a little helper _iommu_map.
>     c. Fix a build fail for tegra-gart.c. I didn't notice there is another place
>     call gart_iommu_sync_map.
>     d. Switch gather->end to the read end address("start + end - 1").
>     
> v3: https://lore.kernel.org/linux-iommu/20201216103607.23050-1-yong.wu@mediatek.com/#r
>     Refactor the unmap flow suggested by Robin.
>      
> v2: https://lore.kernel.org/linux-iommu/20201119061836.15238-1-yong.wu@mediatek.com/
>     Refactor all the code.
>     base on v5.10-rc1.
> 
> Yong Wu (7):
>   iommu: Move iotlb_sync_map out from __iommu_map
>   iommu: Add iova and size as parameters in iotlb_sync_map
>   iommu/mediatek: Add iotlb_sync_map to sync whole the iova range
>   iommu: Switch gather->end to the inclusive end
>   iommu/io-pgtable: Allow io_pgtable_tlb ops optional
>   iommu/mediatek: Gather iova in iommu_unmap to achieve tlb sync once
>   iommu/mediatek: Remove the tlb-ops for v7s

For the series:

Acked-by: Will Deacon <will@kernel.org>

Joerg -- how would you like to handle merging this? I suppose either you
could host a separate branch that I could merge if needed, or I could
include this in my pull to you, or something else.

Please let me know what you prefer,

Cheers,

Will
