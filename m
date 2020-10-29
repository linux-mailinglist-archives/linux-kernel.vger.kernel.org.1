Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9B29E8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgJ2KVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:21:22 -0400
Received: from foss.arm.com ([217.140.110.172]:59352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgJ2KVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:21:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1579D139F;
        Thu, 29 Oct 2020 03:21:22 -0700 (PDT)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D42E63F66E;
        Thu, 29 Oct 2020 03:21:20 -0700 (PDT)
Subject: Re: [PATCH] iommu/sun50i: check return value of
 of_find_device_by_node() in sun50i_iommu_of_xlate()
To:     Yu Kuai <yukuai3@huawei.com>, joro@8bytes.org, mripard@kernel.org,
        wens@csie.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, yi.zhang@huawei.com
References: <20201029092244.900564-1-yukuai3@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2c2669d1-7f19-5be4-b6df-7cf896015336@arm.com>
Date:   Thu, 29 Oct 2020 10:21:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029092244.900564-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-29 09:22, Yu Kuai wrote:
> If of_find_device_by_node() failed in sun50i_iommu_of_xlate(), null
> pointer dereference will be triggered. Thus return error code if
> of_find_device_by_node() failed.

Again, by what means can that ever actually happen?

Robin.

> Fixes: 4100b8c229b3("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/iommu/sun50i-iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index ea6db1341916..ce94ffa15215 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -764,6 +764,9 @@ static int sun50i_iommu_of_xlate(struct device *dev,
>   	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
>   	unsigned id = args->args[0];
>   
> +	if (!iommu_pdev)
> +		return -ENODEV;
> +
>   	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
>   
>   	return iommu_fwspec_add_ids(dev, &id, 1);
> 
