Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB482A3F79
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgKCI5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:57:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7410 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:57:53 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQNwF6ySjz71qv;
        Tue,  3 Nov 2020 16:57:49 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 16:57:45 +0800
Subject: Re: [PATCH v2] drm: Add the new api to install irq
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <1604369441-65254-1-git-send-email-tiantao6@hisilicon.com>
 <8af4223a-037e-7093-cac3-0061aa7b8025@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <29e7eeb5-de7b-89bd-b710-38c00e3c7b54@huawei.com>
Date:   Tue, 3 Nov 2020 16:57:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8af4223a-037e-7093-cac3-0061aa7b8025@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/3 15:56, Thomas Zimmermann 写道:
> Hi
> 
> Thanks, the code looks good already. There just are a few nits below.
> 
Thanks for the help with the review code.
Add the new api devm_drm_irq_install and himbc use the new interface as 
one patch or two?

> Am 03.11.20 um 03:10 schrieb Tian Tao:
>> Add new api devm_drm_irq_install() to register interrupts,
>> no need to call drm_irq_uninstall() when the drm module is removed.
>>
>> v2:
>> fixed the wrong parameter.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   drivers/gpu/drm/drm_drv.c | 23 +++++++++++++++++++++++
>>   include/drm/drm_drv.h     |  3 ++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index cd162d4..0fe5243 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
> 
> The implementation should rather go to drm_irq.c
> 
>> @@ -39,6 +39,7 @@
>>   #include <drm/drm_color_mgmt.h>
>>   #include <drm/drm_drv.h>
>>   #include <drm/drm_file.h>
>> +#include <drm/drm_irq.h>
>>   #include <drm/drm_managed.h>
>>   #include <drm/drm_mode_object.h>
>>   #include <drm/drm_print.h>
>> @@ -678,6 +679,28 @@ static int devm_drm_dev_init(struct device *parent,
>>   	return ret;
>>   }
>>   
>> +static void devm_drm_dev_irq_uninstall(void *data)
>> +{
>> +	drm_irq_uninstall(data);
>> +}
>> +
>> +int devm_drm_irq_install(struct device *parent,
>> +			 struct drm_device *dev, int irq)
>> +{
>> +	int ret;
>> +
>> +	ret = drm_irq_install(dev, irq);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action(parent, devm_drm_dev_irq_uninstall, dev);
>> +	if (ret)
>> +		devm_drm_dev_irq_uninstall(dev);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(devm_drm_irq_install);
>> +
>>   void *__devm_drm_dev_alloc(struct device *parent, struct drm_driver *driver,
>>   			   size_t size, size_t offset)
>>   {
>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>> index 0230762..fec1776 100644
>> --- a/include/drm/drm_drv.h
>> +++ b/include/drm/drm_drv.h
> 
> And the declaration should go to drm_irq.h
> 
> We generally don't merge unused code, so you should convert at least one
> KMS driver, say hibmc, to use the new interface.
> 
> Best regards
> Thomas
> 
>> @@ -513,7 +513,8 @@ struct drm_driver {
>>   
>>   void *__devm_drm_dev_alloc(struct device *parent, struct drm_driver *driver,
>>   			   size_t size, size_t offset);
>> -
>> +int devm_drm_irq_install(struct device *parent, struct drm_device *dev,
>> +			 int irq);
>>   /**
>>    * devm_drm_dev_alloc - Resource managed allocation of a &drm_device instance
>>    * @parent: Parent device object
>>
> 

