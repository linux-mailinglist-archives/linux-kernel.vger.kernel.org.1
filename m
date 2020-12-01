Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E92CA372
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgLANGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:06:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8229 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgLANGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:06:54 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Clj5G26RwzkjyS;
        Tue,  1 Dec 2020 21:05:38 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Dec 2020
 21:05:38 +0800
Subject: Re: [PATCH drm/hisilicon v2 1/4] drm/hisilicon: Assgin local variable
 to drm_device
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1606823754-52451-1-git-send-email-tiantao6@hisilicon.com>
 <1606823754-52451-2-git-send-email-tiantao6@hisilicon.com>
 <fc644426-67db-7128-5f73-8630373ab0e8@suse.de>
 <3f235e08-bb58-be41-8e92-ccd2dfd68b33@huawei.com>
 <389548c9-772c-d86b-700e-032f7d7bde1f@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <51e7e774-6795-8eeb-6701-b1cccc4c6199@huawei.com>
Date:   Tue, 1 Dec 2020 21:05:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <389548c9-772c-d86b-700e-032f7d7bde1f@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/12/1 20:36, Thomas Zimmermann 写道:
> Hi
> 
> Am 01.12.20 um 13:26 schrieb tiantao (H):
>>
>>
>> 在 2020/12/1 20:17, Thomas Zimmermann 写道:
>>> Hi
>>>
>>> Am 01.12.20 um 12:55 schrieb Tian Tao:
>>>> Assign local variable to struct drm_device *dev because they are
>>>> used multiple times within a function.
>>>>
>>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>>>> ---
>>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   |  2 +-
>>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 30 
>>>> ++++++++++++------------
>>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +-
>>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 +-
>>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  8 ++++---
>>>>   5 files changed, 23 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c 
>>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>>> index ea962ac..096eea9 100644
>>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>>> @@ -499,7 +499,7 @@ static const struct drm_crtc_helper_funcs 
>>>> hibmc_crtc_helper_funcs = {
>>>>   int hibmc_de_init(struct hibmc_drm_private *priv)
>>>>   {
>>>> -    struct drm_device *dev = priv->dev;
>>>> +    struct drm_device *dev = &priv->dev;
>>>>       struct drm_crtc *crtc = &priv->crtc;
>>>>       struct drm_plane *plane = &priv->primary_plane;
>>>>       int ret;
>>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c 
>>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>>> index d845657..dd9fadc 100644
>>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>>> @@ -79,31 +79,32 @@ static const struct dev_pm_ops hibmc_pm_ops = {
>>>>   static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>>>   {
>>>> +    struct drm_device *dev = &priv->dev;
>>>>       int ret;
>>>> -    drm_mode_config_init(priv->dev);
>>>> +    drm_mode_config_init(dev);
>>>>       priv->mode_config_initialized = true;
>>>> -    priv->dev->mode_config.min_width = 0;
>>>> -    priv->dev->mode_config.min_height = 0;
>>>> -    priv->dev->mode_config.max_width = 1920;
>>>> -    priv->dev->mode_config.max_height = 1200;
>>>> +    dev->mode_config.min_width = 0;
>>>> +    dev->mode_config.min_height = 0;
>>>> +    dev->mode_config.max_width = 1920;
>>>> +    dev->mode_config.max_height = 1200;
>>>> -    priv->dev->mode_config.fb_base = priv->fb_base;
>>>> -    priv->dev->mode_config.preferred_depth = 32;
>>>> -    priv->dev->mode_config.prefer_shadow = 1;
>>>> +    dev->mode_config.fb_base = priv->fb_base;
>>>> +    dev->mode_config.preferred_depth = 32;
>>>> +    dev->mode_config.prefer_shadow = 1;
>>>> -    priv->dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
>>>> +    dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
>>>>       ret = hibmc_de_init(priv);
>>>>       if (ret) {
>>>> -        drm_err(priv->dev, "failed to init de: %d\n", ret);
>>>> +        drm_err(dev, "failed to init de: %d\n", ret);
>>>>           return ret;
>>>>       }
>>>>       ret = hibmc_vdac_init(priv);
>>>>       if (ret) {
>>>> -        drm_err(priv->dev, "failed to init vdac: %d\n", ret);
>>>> +        drm_err(dev, "failed to init vdac: %d\n", ret);
>>>>           return ret;
>>>>       }
>>>> @@ -113,7 +114,7 @@ static int hibmc_kms_init(struct 
>>>> hibmc_drm_private *priv)
>>>>   static void hibmc_kms_fini(struct hibmc_drm_private *priv)
>>>>   {
>>>>       if (priv->mode_config_initialized) {
>>>> -        drm_mode_config_cleanup(priv->dev);
>>>> +        drm_mode_config_cleanup(&priv->dev);
>>>>           priv->mode_config_initialized = false;
>>>>       }
>>>>   }
>>>> @@ -202,7 +203,7 @@ static void hibmc_hw_config(struct 
>>>> hibmc_drm_private *priv)
>>>>   static int hibmc_hw_map(struct hibmc_drm_private *priv)
>>>>   {
>>>> -    struct drm_device *dev = priv->dev;
>>>> +    struct drm_device *dev = &priv->dev;
>>>>       struct pci_dev *pdev = dev->pdev;
>>>>       resource_size_t addr, size, ioaddr, iosize;
>>>> @@ -258,7 +259,7 @@ static int hibmc_unload(struct drm_device *dev)
>>>>   static int hibmc_load(struct drm_device *dev)
>>>>   {
>>>> -    struct hibmc_drm_private *priv;
>>>> +    struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>>>>       int ret;
>>>>       priv = drmm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>> @@ -267,7 +268,6 @@ static int hibmc_load(struct drm_device *dev)
>>>>           return -ENOMEM;
>>>>       }
>>>>       dev->dev_private = priv;
>>>> -    priv->dev = dev;
>>>
>>> I'm sure this either does not build or does not work. There's a call 
>>> to drm_dev_alloc(), which initialized the DRM device. You need to 
>>> assign the returned device here. The embedding of dev only work after 
>>> you switched to devm_drm_dev_alloc() in the next patch.
>>>
>>> For the patch at hand, just keep struct hibmc_drm_private.dev as a 
>>> pointer and you should be fine.
>>>
>> Changing drm_device *dev to drm_device dev and using 
>> devm_drm_dev_alloc does not easily split into two patches.
>> The patch does not compile well on its own, but it will compile fine 
>> with patch #2.
>> Can patch #1 and patch #2 be combined into a single patch,just like V1.
> 
> Most of the code in this patch does
> 
>    struct drm_device *dev = &priv->dev;
> 
> to get dev as a local variable. Why don't you do
> 
>    struct drm_device *dev = priv->dev;
> 
> ?
> 
> That's all that's really needed.

+	priv = devm_drm_dev_alloc(&pdev->dev, &hibmc_driver,
+				  struct hibmc_drm_private, dev);
devm_drm_dev_alloc function requires parameter 4, dev must be a 
non-pointer for it to work. so had to change dev in the 
hibmc_drm_private  to non-pointer.
This is also the reason to change drm_device *dev to drm_device dev.
> 
> Best regards
> Thomas
> 
>>> Best regards
>>> Thomas
>>>
>>>>       ret = hibmc_hw_init(priv);
>>>>       if (ret)
>>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h 
>>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>>> index f310a83..e35353a 100644
>>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>>> @@ -37,7 +37,7 @@ struct hibmc_drm_private {
>>>>       resource_size_t  fb_size;
>>>>       /* drm */
>>>> -    struct drm_device  *dev;
>>>> +    struct drm_device dev;
>>>>       struct drm_plane primary_plane;
>>>>       struct drm_crtc crtc;
>>>>       struct drm_encoder encoder;
>>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c 
>>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>>>> index 74e26c2..d35548d 100644
>>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>>>> @@ -96,7 +96,7 @@ static const struct drm_encoder_funcs 
>>>> hibmc_encoder_funcs = {
>>>>   int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>>>   {
>>>> -    struct drm_device *dev = priv->dev;
>>>> +    struct drm_device *dev = &priv->dev;
>>>>       struct hibmc_connector *hibmc_connector = &priv->connector;
>>>>       struct drm_encoder *encoder = &priv->encoder;
>>>>       struct drm_connector *connector = &hibmc_connector->base;
>>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c 
>>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>>>> index 602ece1..e84fb81 100644
>>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>>>> @@ -25,7 +25,7 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc)
>>>>   {
>>>>       struct drm_vram_mm *vmm;
>>>>       int ret;
>>>> -    struct drm_device *dev = hibmc->dev;
>>>> +    struct drm_device *dev = &hibmc->dev;
>>>>       vmm = drm_vram_helper_alloc_mm(dev,
>>>>                          pci_resource_start(dev->pdev, 0),
>>>> @@ -41,10 +41,12 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc)
>>>>   void hibmc_mm_fini(struct hibmc_drm_private *hibmc)
>>>>   {
>>>> -    if (!hibmc->dev->vram_mm)
>>>> +    struct drm_device *dev = &hibmc->dev;
>>>> +
>>>> +    if (!dev->vram_mm)
>>>>           return;
>>>> -    drm_vram_helper_release_mm(hibmc->dev);
>>>> +    drm_vram_helper_release_mm(dev);
>>>>   }
>>>>   int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
>>>>
>>>
>>
> 

