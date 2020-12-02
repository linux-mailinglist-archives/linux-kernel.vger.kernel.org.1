Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4352CB8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgLBJ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:28:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8918 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgLBJ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:28:41 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmDC86Vksz6vf8;
        Wed,  2 Dec 2020 17:27:32 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Dec 2020
 17:27:51 +0800
Subject: Re: [PATCH drm/hisilicon 1/3] drm/hisilicon: Code refactoring for
 hibmc_drm_drv
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1606898835-40775-1-git-send-email-tiantao6@hisilicon.com>
 <1606898835-40775-2-git-send-email-tiantao6@hisilicon.com>
 <f6c14465-53a5-1cd3-df8a-d1895ca20656@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <e986552d-eb52-0e0c-15d6-ac83f303c205@huawei.com>
Date:   Wed, 2 Dec 2020 17:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f6c14465-53a5-1cd3-df8a-d1895ca20656@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

在 2020/12/2 17:02, Thomas Zimmermann 写道:
> 
> 
> Am 02.12.20 um 09:47 schrieb Tian Tao:
>> Use the devm_drm_dev_alloc provided by the drm framework to alloc
>> a structure hibmc_drm_private.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> This looks good now. Thanks for sticking to it.
> 

Thank you for your continued patience and guidance.

> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   |  2 +-
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 46 
>> +++++++++++-------------
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  4 +--
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 +-
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  8 +++--
>>   5 files changed, 30 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c 
>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> index ea962ac..096eea9 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> @@ -499,7 +499,7 @@ static const struct drm_crtc_helper_funcs 
>> hibmc_crtc_helper_funcs = {
>>   int hibmc_de_init(struct hibmc_drm_private *priv)
>>   {
>> -    struct drm_device *dev = priv->dev;
>> +    struct drm_device *dev = &priv->dev;
>>       struct drm_crtc *crtc = &priv->crtc;
>>       struct drm_plane *plane = &priv->primary_plane;
>>       int ret;
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c 
>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index d845657..13e8a28 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -79,31 +79,32 @@ static const struct dev_pm_ops hibmc_pm_ops = {
>>   static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>   {
>> +    struct drm_device *dev = &priv->dev;
>>       int ret;
>> -    drm_mode_config_init(priv->dev);
>> +    drm_mode_config_init(dev);
>>       priv->mode_config_initialized = true;
>> -    priv->dev->mode_config.min_width = 0;
>> -    priv->dev->mode_config.min_height = 0;
>> -    priv->dev->mode_config.max_width = 1920;
>> -    priv->dev->mode_config.max_height = 1200;
>> +    dev->mode_config.min_width = 0;
>> +    dev->mode_config.min_height = 0;
>> +    dev->mode_config.max_width = 1920;
>> +    dev->mode_config.max_height = 1200;
>> -    priv->dev->mode_config.fb_base = priv->fb_base;
>> -    priv->dev->mode_config.preferred_depth = 32;
>> -    priv->dev->mode_config.prefer_shadow = 1;
>> +    dev->mode_config.fb_base = priv->fb_base;
>> +    dev->mode_config.preferred_depth = 32;
>> +    dev->mode_config.prefer_shadow = 1;
>> -    priv->dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
>> +    dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
>>       ret = hibmc_de_init(priv);
>>       if (ret) {
>> -        drm_err(priv->dev, "failed to init de: %d\n", ret);
>> +        drm_err(dev, "failed to init de: %d\n", ret);
>>           return ret;
>>       }
>>       ret = hibmc_vdac_init(priv);
>>       if (ret) {
>> -        drm_err(priv->dev, "failed to init vdac: %d\n", ret);
>> +        drm_err(dev, "failed to init vdac: %d\n", ret);
>>           return ret;
>>       }
>> @@ -113,7 +114,7 @@ static int hibmc_kms_init(struct hibmc_drm_private 
>> *priv)
>>   static void hibmc_kms_fini(struct hibmc_drm_private *priv)
>>   {
>>       if (priv->mode_config_initialized) {
>> -        drm_mode_config_cleanup(priv->dev);
>> +        drm_mode_config_cleanup(&priv->dev);
>>           priv->mode_config_initialized = false;
>>       }
>>   }
>> @@ -202,7 +203,7 @@ static void hibmc_hw_config(struct 
>> hibmc_drm_private *priv)
>>   static int hibmc_hw_map(struct hibmc_drm_private *priv)
>>   {
>> -    struct drm_device *dev = priv->dev;
>> +    struct drm_device *dev = &priv->dev;
>>       struct pci_dev *pdev = dev->pdev;
>>       resource_size_t addr, size, ioaddr, iosize;
>> @@ -258,17 +259,9 @@ static int hibmc_unload(struct drm_device *dev)
>>   static int hibmc_load(struct drm_device *dev)
>>   {
>> -    struct hibmc_drm_private *priv;
>> +    struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>>       int ret;
>> -    priv = drmm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> -    if (!priv) {
>> -        drm_err(dev, "no memory to allocate for hibmc_drm_private\n");
>> -        return -ENOMEM;
>> -    }
>> -    dev->dev_private = priv;
>> -    priv->dev = dev;
>> -
>>       ret = hibmc_hw_init(priv);
>>       if (ret)
>>           goto err;
>> @@ -310,6 +303,7 @@ static int hibmc_load(struct drm_device *dev)
>>   static int hibmc_pci_probe(struct pci_dev *pdev,
>>                  const struct pci_device_id *ent)
>>   {
>> +    struct hibmc_drm_private *priv;
>>       struct drm_device *dev;
>>       int ret;
>> @@ -318,12 +312,14 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>>       if (ret)
>>           return ret;
>> -    dev = drm_dev_alloc(&hibmc_driver, &pdev->dev);
>> -    if (IS_ERR(dev)) {
>> +    priv = devm_drm_dev_alloc(&pdev->dev, &hibmc_driver,
>> +                  struct hibmc_drm_private, dev);
>> +    if (IS_ERR(priv)) {
>>           DRM_ERROR("failed to allocate drm_device\n");
>> -        return PTR_ERR(dev);
>> +        return PTR_ERR(priv);
>>       }
>> +    dev = &priv->dev;
>>       dev->pdev = pdev;
>>       pci_set_drvdata(pdev, dev);
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h 
>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index f310a83..7e0c756 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -37,7 +37,7 @@ struct hibmc_drm_private {
>>       resource_size_t  fb_size;
>>       /* drm */
>> -    struct drm_device  *dev;
>> +    struct drm_device dev;
>>       struct drm_plane primary_plane;
>>       struct drm_crtc crtc;
>>       struct drm_encoder encoder;
>> @@ -52,7 +52,7 @@ static inline struct hibmc_connector 
>> *to_hibmc_connector(struct drm_connector *c
>>   static inline struct hibmc_drm_private *to_hibmc_drm_private(struct 
>> drm_device *dev)
>>   {
>> -    return dev->dev_private;
>> +    return container_of(dev, struct hibmc_drm_private, dev);
>>   }
>>   void hibmc_set_power_mode(struct hibmc_drm_private *priv,
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c 
>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> index 74e26c2..d35548d 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> @@ -96,7 +96,7 @@ static const struct drm_encoder_funcs 
>> hibmc_encoder_funcs = {
>>   int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>   {
>> -    struct drm_device *dev = priv->dev;
>> +    struct drm_device *dev = &priv->dev;
>>       struct hibmc_connector *hibmc_connector = &priv->connector;
>>       struct drm_encoder *encoder = &priv->encoder;
>>       struct drm_connector *connector = &hibmc_connector->base;
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c 
>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>> index 602ece1..e84fb81 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>> @@ -25,7 +25,7 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc)
>>   {
>>       struct drm_vram_mm *vmm;
>>       int ret;
>> -    struct drm_device *dev = hibmc->dev;
>> +    struct drm_device *dev = &hibmc->dev;
>>       vmm = drm_vram_helper_alloc_mm(dev,
>>                          pci_resource_start(dev->pdev, 0),
>> @@ -41,10 +41,12 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc)
>>   void hibmc_mm_fini(struct hibmc_drm_private *hibmc)
>>   {
>> -    if (!hibmc->dev->vram_mm)
>> +    struct drm_device *dev = &hibmc->dev;
>> +
>> +    if (!dev->vram_mm)
>>           return;
>> -    drm_vram_helper_release_mm(hibmc->dev);
>> +    drm_vram_helper_release_mm(dev);
>>   }
>>   int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
>>
> 

