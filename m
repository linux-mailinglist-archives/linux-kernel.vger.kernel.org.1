Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323929979C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgJZUHq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Oct 2020 16:07:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3652 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgJZUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:07:45 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CKm9103g5zXfvM;
        Tue, 27 Oct 2020 04:07:49 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 27 Oct 2020 04:07:43 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 27 Oct 2020 04:07:43 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 27 Oct 2020 04:07:43 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Thread-Topic: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Thread-Index: AQHWq5MUDdH3/+jmF0KiWtaQJmX8fKmqTnfw
Date:   Mon, 26 Oct 2020 20:07:43 +0000
Message-ID: <75cad228694b4f1587265a887069b241@hisilicon.com>
References: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com>
In-Reply-To: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.184]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Tuesday, October 27, 2020 1:25 AM
> To: hch@lst.de
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Song Bao
> Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Subject: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
> 
> Offering DMA_PERNUMA_CMA to non-NUMA configs is pointless.
> 

This is right.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  kernel/dma/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c99de4a21458..964b74c9b7e3 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -125,7 +125,8 @@ if  DMA_CMA
> 
>  config DMA_PERNUMA_CMA
>  	bool "Enable separate DMA Contiguous Memory Area for each NUMA
> Node"
> -	default NUMA && ARM64
> +	depends on NUMA
> +	default ARM64

On the other hand, at this moment, only ARM64 is calling the init code
to get per_numa cma. Do we need to
depends on NUMA && ARM64 ?
so that this is not enabled by non-arm64?

>  	help
>  	  Enable this option to get pernuma CMA areas so that devices like
>  	  ARM64 SMMU can get local memory by DMA coherent APIs.
> --
 
Thanks
Barry


