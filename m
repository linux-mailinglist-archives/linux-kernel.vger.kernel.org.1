Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F722A265B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgKBIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:47:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6689 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgKBIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:47:12 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPmkK15Jgz15PVx;
        Mon,  2 Nov 2020 16:47:05 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 16:46:58 +0800
Subject: Re: [PATCH] drm/hisilicon: Remove redundant null check
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <1604050046-64539-1-git-send-email-tiantao6@hisilicon.com>
 <2dbbbad0-53cf-52cc-3b6b-0d1547f7e085@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <f41cbcb3-d08a-7d3f-530c-a0cb3f9e3801@huawei.com>
Date:   Mon, 2 Nov 2020 16:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2dbbbad0-53cf-52cc-3b6b-0d1547f7e085@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/2 16:32, Thomas Zimmermann 写道:
> Hi
> 
> Am 30.10.20 um 10:27 schrieb Tian Tao:
>> drm_irq_uninstall can handle the case where dev->irq_enable is false,
>> so Remove redundant null check.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index 0c1b40d..b71589b1 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -246,13 +246,13 @@ static int hibmc_unload(struct drm_device *dev)
>>   
>>   	drm_atomic_helper_shutdown(dev);
>>   
>> -	if (dev->irq_enabled)
>> -		drm_irq_uninstall(dev);
>> -
>> +	drm_irq_uninstall(dev);
> 
> Removing this check would at least result in an error, [1] so rather
> leave it in for now.
> 
Now there seems to be no driver to check the return value of 
drm_irq_uninstall
> Instead, we could discuss if drm_irq_install() should become a managed
> interface.

Codes like the following
diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
index 09d6e9e..572357c 100644
--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -172,6 +172,9 @@ int drm_irq_uninstall(struct drm_device *dev)
         bool irq_enabled;
         int i;

+       if(!dev->irq_enabled || !dev)
+               return 0;

> 
> Best regards
> Thomas
> 
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_irq.c#L201
> 
>>   	pci_disable_msi(dev->pdev);
>> +
>>   	hibmc_kms_fini(priv);
>>   	hibmc_mm_fini(priv);
>>   	dev->dev_private = NULL;
>> +
>>   	return 0;
>>   }
>>   
>>
> 

