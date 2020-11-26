Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B148D2C596E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403857AbgKZQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:44:00 -0500
Received: from foss.arm.com ([217.140.110.172]:39520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbgKZQoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:44:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C5F631B;
        Thu, 26 Nov 2020 08:43:59 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 571FC3F23F;
        Thu, 26 Nov 2020 08:43:56 -0800 (PST)
Subject: Re: [PATCH v4 12/24] iommu/mediatek: Move hw_init into attach_device
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-13-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <55bb14ef-f674-e55c-0803-43d91093eccb@arm.com>
Date:   Thu, 26 Nov 2020 16:43:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201111123838.15682-13-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-11 12:38, Yong Wu wrote:
> In attach device, it will update the pagetable base address register.
> Move the hw_init function also here. Then it only need call
> pm_runtime_get/put one time here if m4u has power domain.

Doesn't that mean you'll end up writing most of the registers twice 
every time? (first from mtk_iommu_resume(), then again from 
mtk_iommu_hw_init())

It might be neater to have mtk_iommu_hw_init() simply populate the 
mtk_iommu_suspend_reg data with the initial values at probe time and 
manually call mtk_iommu_resume() if the hardware is already powered up 
at that point. Or maybe just don't bother saving those registers on 
suspend and put the initialisation directly in the resume path.

Robin.

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 55f9b329e637..cfdf5ce696fd 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -125,6 +125,8 @@ struct mtk_iommu_domain {
>   
>   static const struct iommu_ops mtk_iommu_ops;
>   
> +static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
> +
>   /*
>    * In M4U 4GB mode, the physical address is remapped as below:
>    *
> @@ -380,12 +382,16 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   {
>   	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	int ret;
>   
>   	if (!data)
>   		return -ENODEV;
>   
>   	/* Update the pgtable base address register of the M4U HW */
>   	if (!data->m4u_dom) {
> +		ret = mtk_iommu_hw_init(data);
> +		if (ret)
> +			return ret;
>   		data->m4u_dom = dom;
>   		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
>   		       data->base + REG_MMU_PT_BASE_ADDR);
> @@ -729,10 +735,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, data);
>   
> -	ret = mtk_iommu_hw_init(data);
> -	if (ret)
> -		return ret;
> -
>   	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
>   				     "mtk-iommu.%pa", &ioaddr);
>   	if (ret)
> 
