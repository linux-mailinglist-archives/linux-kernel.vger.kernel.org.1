Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4A303F50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405540AbhAZNvz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 08:51:55 -0500
Received: from foss.arm.com ([217.140.110.172]:40910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405443AbhAZNvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:51:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E477B31B;
        Tue, 26 Jan 2021 05:50:54 -0800 (PST)
Received: from localhost (unknown [10.57.43.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A47043F68F;
        Tue, 26 Jan 2021 05:50:53 -0800 (PST)
Date:   Tue, 26 Jan 2021 13:50:40 +0000
From:   Robin Murphy <robin.murphy@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        jean-philippe@linaro.org, will@kernel.org, linuxarm@openeuler.org,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Message-ID: <20210126135039.000039a0@arm.com>
In-Reply-To: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
References: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 13:06:29 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> The device iommu probe/attach might have failed leaving dev->iommu
> to NULL and device drivers may still invoke these functions resulting
> a crash in iommu vendor driver code. Hence make sure we check that.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ffeebda8d6de..cb68153c5cc0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2867,7 +2867,7 @@ bool iommu_dev_has_feature(struct device *dev,
> enum iommu_dev_features feat) {
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
>  
> -	if (ops && ops->dev_has_feat)
> +	if (dev->iommu && ops && ops->dev_has_feat)
>  		return ops->dev_has_feat(dev, feat);

Might make sense to make these more self-contained, e.g.:

	if (dev->iommu && dev->iommu->ops->foo)
		dev->iommu->ops->foo()

Robin.

 
>  	return false;
> @@ -2878,7 +2878,7 @@ int iommu_dev_enable_feature(struct device
> *dev, enum iommu_dev_features feat) {
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
>  
> -	if (ops && ops->dev_enable_feat)
> +	if (dev->iommu && ops && ops->dev_enable_feat)
>  		return ops->dev_enable_feat(dev, feat);
>  
>  	return -ENODEV;
> @@ -2894,7 +2894,7 @@ int iommu_dev_disable_feature(struct device
> *dev, enum iommu_dev_features feat) {
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
>  
> -	if (ops && ops->dev_disable_feat)
> +	if (dev->iommu && ops && ops->dev_disable_feat)
>  		return ops->dev_disable_feat(dev, feat);
>  
>  	return -EBUSY;
> @@ -2905,7 +2905,7 @@ bool iommu_dev_feature_enabled(struct device
> *dev, enum iommu_dev_features feat) {
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
>  
> -	if (ops && ops->dev_feat_enabled)
> +	if (dev->iommu && ops && ops->dev_feat_enabled)
>  		return ops->dev_feat_enabled(dev, feat);
>  
>  	return false;

