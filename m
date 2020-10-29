Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83329E86F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgJ2KIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:08:05 -0400
Received: from foss.arm.com ([217.140.110.172]:58836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgJ2KIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:08:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC7B139F;
        Thu, 29 Oct 2020 03:08:04 -0700 (PDT)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95AE73F66E;
        Thu, 29 Oct 2020 03:08:02 -0700 (PDT)
Subject: Re: [PATCH] iommu/rockchip: check return value of
 of_find_device_by_node() in rk_iommu_of_xlate()
To:     Yu Kuai <yukuai3@huawei.com>, joro@8bytes.org, heiko@sntech.de,
        jeffy.chen@rock-chips.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20201029092202.900218-1-yukuai3@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <98dec09e-08a1-6550-fa4e-85a8104b90e1@arm.com>
Date:   Thu, 29 Oct 2020 10:08:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029092202.900218-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-29 09:22, Yu Kuai wrote:
> If of_find_device_by_node() failed in rk_iommu_of_xlate(), null pointer
> dereference will be triggered. Thus return error code if
> of_find_device_by_node() failed.

How can that happen? (Given that ".suppress_bind_attrs = true")

Robin.

> Fixes: 5fd577c3eac3("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index e5d86b7177de..090d149ef8e9 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1099,6 +1099,9 @@ static int rk_iommu_of_xlate(struct device *dev,
>   
>   	iommu_dev = of_find_device_by_node(args->np);
>   
> +	if (!iommu_dev)
> +		return -ENODEV;
> +
>   	data->iommu = platform_get_drvdata(iommu_dev);
>   	dev_iommu_priv_set(dev, data);
>   
> 
