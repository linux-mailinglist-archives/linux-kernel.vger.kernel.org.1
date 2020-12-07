Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A622D0D09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgLGJau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:30:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8713 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLGJat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:30:49 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CqJ145c80zkmXL;
        Mon,  7 Dec 2020 17:29:28 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Dec 2020
 17:29:56 +0800
Subject: Re: [PATCH drm/hisilicon v2 1/2] drm/hisilicon: Use managed
 mode-config init
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <1607331906-19005-1-git-send-email-tiantao6@hisilicon.com>
 <1607331906-19005-2-git-send-email-tiantao6@hisilicon.com>
 <cf28147b-a506-3d72-fb71-bb30a801fd8d@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <0d60eccc-907d-6fc2-e1c2-c7fe0facd21e@huawei.com>
Date:   Mon, 7 Dec 2020 17:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cf28147b-a506-3d72-fb71-bb30a801fd8d@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/12/7 17:22, Thomas Zimmermann 写道:
> Hi
> 
> Am 07.12.20 um 10:05 schrieb Tian Tao:
>> Using drmm_mode_config_init() sets up managed release of modesetting
>> resources.
>>
> 
> Individual patches usually contain a changelog to highlight the 
> difference to previous versions. Please add one before committing the 

Just to be sure: I don't need to add a changlog to this individual 
patch, right?

> patch.  Your cover letter for the series already does this correctly.
> 
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Thanks for all these updates.

Thank you for your constant help with the review code and your careful 
guidance!

> 
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 14 +++-----------
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
>>   2 files changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c 
>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index 3687753..7f01213 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -96,8 +96,9 @@ static int hibmc_kms_init(struct hibmc_drm_private 
>> *priv)
>>       struct drm_device *dev = &priv->dev;
>>       int ret;
>> -    drm_mode_config_init(dev);
>> -    priv->mode_config_initialized = true;
>> +    ret = drmm_mode_config_init(dev);
>> +    if (ret)
>> +        return ret;
>>       dev->mode_config.min_width = 0;
>>       dev->mode_config.min_height = 0;
>> @@ -125,14 +126,6 @@ static int hibmc_kms_init(struct 
>> hibmc_drm_private *priv)
>>       return 0;
>>   }
>> -static void hibmc_kms_fini(struct hibmc_drm_private *priv)
>> -{
>> -    if (priv->mode_config_initialized) {
>> -        drm_mode_config_cleanup(&priv->dev);
>> -        priv->mode_config_initialized = false;
>> -    }
>> -}
>> -
>>   /*
>>    * It can operate in one of three modes: 0, 1 or Sleep.
>>    */
>> @@ -262,7 +255,6 @@ static int hibmc_unload(struct drm_device *dev)
>>       drm_atomic_helper_shutdown(dev);
>>       pci_disable_msi(dev->pdev);
>> -    hibmc_kms_fini(priv);
>>       dev->dev_private = NULL;
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h 
>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index a49c10e..7d263f4 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -42,7 +42,6 @@ struct hibmc_drm_private {
>>       struct drm_crtc crtc;
>>       struct drm_encoder encoder;
>>       struct hibmc_connector connector;
>> -    bool mode_config_initialized;
>>   };
>>   static inline struct hibmc_connector *to_hibmc_connector(struct 
>> drm_connector *connector)
>>
> 

