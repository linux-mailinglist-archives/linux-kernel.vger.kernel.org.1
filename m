Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE632A2AC1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgKBMcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:32:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6733 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbgKBMca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:32:30 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPskK2kPRzkdkY;
        Mon,  2 Nov 2020 20:32:25 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 20:32:18 +0800
Subject: Re: [PATCH] drm/irq: Add irq as false detection
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <1604315990-56787-1-git-send-email-tiantao6@hisilicon.com>
 <8a76d144-f8ba-bbbc-9177-53088f6dc73a@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <d67b75bd-205b-262b-db07-36497c941731@huawei.com>
Date:   Mon, 2 Nov 2020 20:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8a76d144-f8ba-bbbc-9177-53088f6dc73a@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/2 20:09, Thomas Zimmermann 写道:
> Hi
> 
> Am 02.11.20 um 12:19 schrieb Tian Tao:
>> Add the detection of false for irq, so that the EINVAL is not
>> returned when dev->irq_enabled is false.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   drivers/gpu/drm/drm_irq.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
>> index 09d6e9e..7537a3d 100644
>> --- a/drivers/gpu/drm/drm_irq.c
>> +++ b/drivers/gpu/drm/drm_irq.c
>> @@ -172,6 +172,9 @@ int drm_irq_uninstall(struct drm_device *dev)
>>   	bool irq_enabled;
>>   	int i;
>>   
>> +	if (!dev->irq_enabled || !dev)
>> +		return 0;
>> +
> 
> Dereferencing a pointer before NULL-checking it, is Yoda programming. :)
> I'd just drop the test for !dev and assume that dev is always valid.
> 
> I suggest to change the int return value to void and return nothing.
> 
> Re-reading the actual implementation of this function, this location
> might be too early. Further below there already is a test for
> irq_enabled. Put a drm_WARN_ON around it and it should be fine. This way
> the vblank handlers will be disabled and erroneous callers will see a
> warning in the kernel's log.
> 
thank you，I will send a new patch to fix that.
> Best regards
> Thomas
> 
>>   	irq_enabled = dev->irq_enabled;
>>   	dev->irq_enabled = false;
>>   
>>
> 

