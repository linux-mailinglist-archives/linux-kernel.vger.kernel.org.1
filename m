Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEC27BE02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgI2HaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:30:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbgI2HaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:30:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 74A5FFD013689A496091;
        Tue, 29 Sep 2020 15:30:04 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 15:29:57 +0800
Subject: Re: [PATCH] drm/hisilicon: Delete the unused macro
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
References: <1601340326-14049-1-git-send-email-tiantao6@hisilicon.com>
 <b2e756df-a434-f60c-c5f5-0cbb43f00d5c@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <e528f881-05bb-3ec0-c0cc-a254288c8c96@huawei.com>
Date:   Tue, 29 Sep 2020 15:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b2e756df-a434-f60c-c5f5-0cbb43f00d5c@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/29 15:24, Thomas Zimmermann 写道:
> 
> 
> Am 29.09.20 um 02:45 schrieb Tian Tao:
>> The macro PADDING is no longer used. Delete it.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
Thanks a lot for the timely help with the review code!
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> index 4d57ec6..b3a81da 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> @@ -52,8 +52,6 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
>>   	{1920, 1200, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
>>   };
>>   
>> -#define PADDING(align, data) (((data) + (align) - 1) & (~((align) - 1)))
>> -
>>   static int hibmc_plane_atomic_check(struct drm_plane *plane,
>>   				    struct drm_plane_state *state)
>>   {
>>
> 

