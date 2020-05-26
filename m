Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F11A4E51
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 08:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDKGND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 02:13:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgDKGNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:13:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C8EB85205F380D36F76;
        Sat, 11 Apr 2020 14:12:58 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 11 Apr 2020
 14:12:48 +0800
Subject: Re: [PATCH] drm/hisilicon: Code refactoring for hibmc_drv_vdac
To:     Joe Perches <joe@perches.com>, Tian Tao <tiantao6@hisilicon.com>,
        <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
References: <1586573387-42003-1-git-send-email-tiantao6@hisilicon.com>
 <78e966cacffbab8c43be6a02aa3f5af2478917d0.camel@perches.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <e2b9f9f1-693e-57bc-6b0b-a6a5f095be16@huawei.com>
Date:   Sat, 11 Apr 2020 14:12:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <78e966cacffbab8c43be6a02aa3f5af2478917d0.camel@perches.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you, your suggestion is accepted and I will issue v2

�� 2020/4/11 11:43, Joe Perches д��:
> On Sat, 2020-04-11 at 10:49 +0800, Tian Tao wrote:
>> code refactoring for hibmc_drv_vdac.c, no actual function changes.
> 
> Seems sensible.
> 
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> []
>> @@ -109,13 +83,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>   	struct drm_connector *connector;
>>   	int ret;
>>   
>> -	connector = hibmc_connector_init(priv);
>> -	if (IS_ERR(connector)) {
>> -		DRM_ERROR("failed to create connector: %ld\n",
>> -			  PTR_ERR(connector));
>> -		return PTR_ERR(connector);
>> -	}
>> -
>>   	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
>>   	if (!encoder) {
>>   		DRM_ERROR("failed to alloc memory when init encoder\n");
> 
> The alloc error messages could be removed.
> 
>> @@ -131,6 +98,21 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>   	}
>>   
>>   	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
>> +
>> +	connector = devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL);
>> +	if (!connector) {
>> +		DRM_ERROR("failed to alloc memory when init connector\n");
> 
> and here.
> 
> 
> 
> .
> 

