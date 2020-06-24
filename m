Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6E206F34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgFXIq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 04:46:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728732AbgFXIq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:46:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D0A371B71672B0C4AD7;
        Wed, 24 Jun 2020 16:46:54 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.204) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 24 Jun 2020
 16:46:45 +0800
Subject: Re: [PATCH] ARM: at91: pm: add missing put_device() call in
 at91_pm_sram_init()
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20200604123301.3905837-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <ecfaff17-2202-989d-fb93-f18067536846@huawei.com>
Date:   Wed, 24 Jun 2020 16:46:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200604123301.3905837-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.204]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On 2020/6/4 20:33, yu kuai wrote:
> if of_find_device_by_node() succeed, at91_pm_sram_init() doesn't have
> a corresponding put_device(). Thus add a jump target to fix the exception
> handling for this function implementation.
> 
> Fixes: d2e467905596 ("ARM: at91: pm: use the mmio-sram pool to access SRAM")
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>   arch/arm/mach-at91/pm.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 074bde64064e..2aab043441e8 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -592,13 +592,13 @@ static void __init at91_pm_sram_init(void)
>   	sram_pool = gen_pool_get(&pdev->dev, NULL);
>   	if (!sram_pool) {
>   		pr_warn("%s: sram pool unavailable!\n", __func__);
> -		return;
> +		goto out_put_device;
>   	}
>   
>   	sram_base = gen_pool_alloc(sram_pool, at91_pm_suspend_in_sram_sz);
>   	if (!sram_base) {
>   		pr_warn("%s: unable to alloc sram!\n", __func__);
> -		return;
> +		goto out_put_device;
>   	}
>   
>   	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
> @@ -606,12 +606,17 @@ static void __init at91_pm_sram_init(void)
>   					at91_pm_suspend_in_sram_sz, false);
>   	if (!at91_suspend_sram_fn) {
>   		pr_warn("SRAM: Could not map\n");
> -		return;
> +		goto out_put_device;
>   	}
>   
>   	/* Copy the pm suspend handler to SRAM */
>   	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
>   			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
> +	return;
> +
> +out_put_device:
> +	put_device(&pdev->dev);
> +	return;
>   }
>   
>   static bool __init at91_is_pm_mode_active(int pm_mode)
> 

