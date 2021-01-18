Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380B92FA6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406704AbhARQ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406442AbhARQ7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:59:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76036222BB;
        Mon, 18 Jan 2021 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610989120;
        bh=0bKhzEZ2HOSFbpgHtimXEvYRPGe1qXAb+1JtaEmfCiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcT4LSccNgfsfftGAHO5+Er6JQxGKpLFfMWLD3u67HN3Hb7QO1fgXikzrpRuhhyef
         SVvft3JrmCeoJ3MssTo5V1t/EzaDxb4sYYE0or7cH49o+cPsNcBf/Al+gn4ye32RKA
         KXUP3ece7Osqhubt3XL/nmZoHnj+7Wnnss7nyT5yr73omdai3VYGdOo2o/8JHSACF3
         kUDbm1ifuQK80OJv8fOnub3scEU0caBV1uUaqAwRpojx5ux/rmovbCibhpDYxUvYyQ
         ze0rfzkgHbUvtXvlR/o8kCO6nL8UHghEYaQmC9TLa9rswXCoPx6nhPNSfLE3jGpc3h
         2/bFjkFJKQxCg==
Date:   Mon, 18 Jan 2021 16:58:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
Message-ID: <20210118165833.GA17722@willie-the-truck>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-7-yong.wu@mediatek.com>
 <e1e17782-a9f3-6b64-1630-bf29af5241cf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e17782-a9f3-6b64-1630-bf29af5241cf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 04:35:22PM +0000, Robin Murphy wrote:
> On 2020-12-16 10:36, Yong Wu wrote:
> > In current iommu_unmap, this code is:
> > 
> > 	iommu_iotlb_gather_init(&iotlb_gather);
> > 	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
> > 	iommu_iotlb_sync(domain, &iotlb_gather);
> > 
> > We could gather the whole iova range in __iommu_unmap, and then do tlb
> > synchronization in the iommu_iotlb_sync.
> > 
> > This patch implement this, Gather the range in mtk_iommu_unmap.
> > then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
> > we don't call iommu_iotlb_gather_add_page since our tlb synchronization
> > could be regardless of granule size.
> > 
> > In this way, gather->start is impossible ULONG_MAX, remove the checking.
> > 
> > This patch aims to do tlb synchronization *once* in the iommu_unmap.
> 
> Assuming the update to patch #4 simply results in "unsigned long end = iova
> + size - 1;" here,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

There's a v4 here:

https://lore.kernel.org/r/20210107122909.16317-1-yong.wu@mediatek.com

Will
