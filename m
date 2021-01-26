Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD3304DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbhAZX0O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 18:26:14 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2878 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389172AbhAZQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:58:51 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DQC9x6499z5JF7;
        Wed, 27 Jan 2021 00:39:17 +0800 (CST)
Received: from dggemm753-chm.china.huawei.com (10.1.198.59) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 27 Jan 2021 00:40:48 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemm753-chm.china.huawei.com (10.1.198.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 00:40:47 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.006; Tue, 26 Jan 2021 16:40:45 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Topic: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Index: AQHW8+RNdZVLOLYLIk+ZoY3uV2Gpc6o57K4AgAAuUAA=
Date:   Tue, 26 Jan 2021 16:40:45 +0000
Message-ID: <8654e506fa26443f8f4413ec8fd96bf7@huawei.com>
References: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
 <20210126135039.000039a0@arm.com>
In-Reply-To: <20210126135039.000039a0@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.74]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 26 January 2021 13:51
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> jean-philippe@linaro.org; will@kernel.org; linuxarm@openeuler.org; Zengtao
> (B) <prime.zeng@hisilicon.com>
> Subject: Re: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
> 
> On Tue, 26 Jan 2021 13:06:29 +0000
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> 
> > The device iommu probe/attach might have failed leaving dev->iommu to
> > NULL and device drivers may still invoke these functions resulting a
> > crash in iommu vendor driver code. Hence make sure we check that.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/iommu/iommu.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> > ffeebda8d6de..cb68153c5cc0 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2867,7 +2867,7 @@ bool iommu_dev_has_feature(struct device *dev,
> > enum iommu_dev_features feat) {
> >  	const struct iommu_ops *ops = dev->bus->iommu_ops;
> >
> > -	if (ops && ops->dev_has_feat)
> > +	if (dev->iommu && ops && ops->dev_has_feat)
> >  		return ops->dev_has_feat(dev, feat);
> 
> Might make sense to make these more self-contained, e.g.:
> 
> 	if (dev->iommu && dev->iommu->ops->foo)
> 		dev->iommu->ops->foo()

Right. Does that mean adding ops to "struct dev_iommu" or retrieve ops like
below,

if (dev->iommu && dev->iommu->iommu_dev->ops->foo)
 		dev->iommu->iommu_dev->ops->foo()
 
Sorry, not clear to me.

Thanks,
Shameer
 

