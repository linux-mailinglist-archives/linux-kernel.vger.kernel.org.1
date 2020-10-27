Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05C529A671
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894627AbgJ0IW4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Oct 2020 04:22:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3653 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389898AbgJ0IWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:22:55 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CL4TC5rK3zXgBg;
        Tue, 27 Oct 2020 16:22:55 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 27 Oct 2020 16:22:50 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 27 Oct 2020 16:22:50 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 27 Oct 2020 16:22:50 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "hch@lst.de" <hch@lst.de>, "will@kernel.org" <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Thread-Topic: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Thread-Index: AQHWq5MUDdH3/+jmF0KiWtaQJmX8fKmqTnfwgABBLQCAAIoLgA==
Date:   Tue, 27 Oct 2020 08:22:50 +0000
Message-ID: <767d181165f74ce78c86b20bbe09cd9b@hisilicon.com>
References: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com>
 <75cad228694b4f1587265a887069b241@hisilicon.com>
 <20201027075452.GA22487@lst.de>
In-Reply-To: <20201027075452.GA22487@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.177]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: hch@lst.de [mailto:hch@lst.de]
> Sent: Tuesday, October 27, 2020 8:55 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Robin Murphy <robin.murphy@arm.com>; hch@lst.de;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
> 
> On Mon, Oct 26, 2020 at 08:07:43PM +0000, Song Bao Hua (Barry Song)
> wrote:
> > > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > > index c99de4a21458..964b74c9b7e3 100644
> > > --- a/kernel/dma/Kconfig
> > > +++ b/kernel/dma/Kconfig
> > > @@ -125,7 +125,8 @@ if  DMA_CMA
> > >
> > >  config DMA_PERNUMA_CMA
> > >  	bool "Enable separate DMA Contiguous Memory Area for each NUMA
> > > Node"
> > > -	default NUMA && ARM64
> > > +	depends on NUMA
> > > +	default ARM64
> >
> > On the other hand, at this moment, only ARM64 is calling the init code
> > to get per_numa cma. Do we need to
> > depends on NUMA && ARM64 ?
> > so that this is not enabled by non-arm64?
> 
> I actually hate having arch symbols in common code.  A new
> ARCH_HAS_DMA_PERNUMA_CMA, only selected by arm64 for now would be
> more
> clean I think.

Sounds good to me.

BTW,  +Will.

Last time we talked about default pernuma cma size, you suggested a bootargs
in arch/arm64/Kconfig but Will seems to have different idea. Am I right, Will?

Would we let aarch64 call dma_pernuma_cma_reserve(16MB) rather than
dma_pernuma_cma_reserve()?

In this way, users will at least get a default pernuma CMA which is required
at least by IOMMU. If users set a "cma_pernuma" bootargs, it will overwrite
the default size from aarch64 code?

I mean

- void __init dma_pernuma_cma_reserve(size_t size)
+ void __init dma_pernuma_cma_reserve(size_t size)
{
	if (!pernuma_size_bytes)
+		pernuma_size_bytes = size;
	....
}

Right now, it is easy that users will forget to set cma_pernuma in bootargs.
Probably this feature is not enabled by users.

Thanks
Barry
