Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13932781EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgIYHtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:49:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbgIYHtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:49:00 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 845AF1FACC9B85756694;
        Fri, 25 Sep 2020 15:48:58 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 25 Sep 2020
 15:48:50 +0800
Subject: Re: [PATCH] drm/hisilicon: Deleted the drm_device declaration
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
References: <1601016580-5937-1-git-send-email-tiantao6@hisilicon.com>
 <5db712e8-d6cb-3de9-f48e-c2060442e4e0@suse.de>
 <50c87a77-ffdd-42d2-0747-69c95305a48f@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <d9243413-ae13-7eee-933a-13441ec4c151@huawei.com>
Date:   Fri, 25 Sep 2020 15:48:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <50c87a77-ffdd-42d2-0747-69c95305a48f@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/25 15:26, Thomas Zimmermann 写道:
> Hi
> 
> Am 25.09.20 um 09:02 schrieb Thomas Zimmermann:
>> Hi,
>>
>> just a few nits.
>>
>> Am 25.09.20 um 08:49 schrieb Tian Tao:
>>> drm_framebuffer.h contains drm/drm_device.h and struct drm_device is
>>
>> contains -> includes
>>
>>> already declared in this file, so there is no need to declare struct
>>
>> declared -> defined
> 
> Wait a second. drm_framebuffer.h actually declares struct drm_device,
> but does not include <drm/device.h>. So the commit messag should say
> something like
> 
>    drm_framebuffer.h already declares struct drm_device, so there's no
> need to declare it in hibm_drm_drv.h
> 
Thank you very much.I will apply this.
>>
>>> drm_device in hibm_drm_drv.h.
>>>
>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>>> ---
>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> index 87d2aad..6a63502 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> @@ -22,8 +22,6 @@
>>>   #include <drm/drm_fb_helper.h>
>>>   #include <drm/drm_framebuffer.h>
>>>   
>>> -struct drm_device;
>>> -
>>>   struct hibmc_connector {
>>>   	struct drm_connector base;
>>>   
>>>
>>
> 

