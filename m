Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E11B2C4018
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgKYM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgKYM10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:27:26 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9A9206E5;
        Wed, 25 Nov 2020 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606307245;
        bh=evEwLaFL1TOZnnmN2k1Ii9RUrk1eDitE23z2suTvQ6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYtQ0Ok0TCUzNBLXPdRIrDidqt/+lGu4bC88noEHv4ZMCgWO/rJgzP+yJkNy7Oa90
         l9N+Vo+HlQF+Xwy2MM/kcLk3cTL83wXG64ym2wPiLcJMKvrogdozHwhQjRstglhPfG
         kBPeDf+3nYbBXC3BUX7o89t6jAJIpzXJZPE5pgAs=
Date:   Wed, 25 Nov 2020 12:27:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>, robin.murphy@arm.com
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, jun.wen@mediatek.com
Subject: Re: [PATCH v2 0/6] MediaTek IOMMU improve tlb flush performance in
 map/unmap
Message-ID: <20201125122719.GB15697@willie-the-truck>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119061836.15238-1-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 02:18:30PM +0800, Yong Wu wrote:
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
> don't care about granule size. thus I add a flag(granule_ignore) for this
> case.
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
> patch [1/6][2/6][3/6] are for map while the others are for unmap.
> 
> change note:
> v2: Refactor all the code.
>     base on v5.10-rc1.

Robin -- please can you take a look at this series? I'm not sure I'll
have time to get to it at the moment and you understand how this stuff
is supposed to work.

Cheers,

Will
