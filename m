Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3382C8415
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgK3M1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:27:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9075 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3M1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:27:07 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cl4Fs2JcjzLxpb;
        Mon, 30 Nov 2020 20:25:53 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 20:26:21 +0800
Subject: Re: [PATCH] drm/panfrost: fix reference leak in
 panfrost_job_hw_submit
To:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20201127094441.121094-1-miaoqinglang@huawei.com>
 <46d1944e-fbbe-075f-1c5b-356b5ce73ee0@arm.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <f01d1ce8-8711-f23a-0c7d-7c6870b5ba3a@huawei.com>
Date:   Mon, 30 Nov 2020 20:26:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <46d1944e-fbbe-075f-1c5b-356b5ce73ee0@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/27 18:06, Steven Price 写道:
> On 27/11/2020 09:44, Qinglang Miao wrote:
>> pm_runtime_get_sync will increment pm usage counter even it
>> failed. Forgetting to putting operation will result in a
>> reference leak here.
>>
>> A new function pm_runtime_resume_and_get is introduced in
>> [0] to keep usage counter balanced. So We fix the reference
>> leak by replacing it with new funtion.
>>
>> [0] dd8088d5a896 ("PM: runtime: Add  pm_runtime_resume_and_get to deal 
>> with usage counter")
>>
>> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_job.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c 
>> b/drivers/gpu/drm/panfrost/panfrost_job.c
>> index 30e7b7196..04cf3bb67 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>> @@ -147,7 +147,7 @@ static void panfrost_job_hw_submit(struct 
>> panfrost_job *job, int js)
>>       panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
>> -    ret = pm_runtime_get_sync(pfdev->dev);
>> +    ret = pm_runtime_resume_and_get(pfdev->dev);
> 
> Sorry, but in this case this change isn't correct. 
> panfrost_job_hw_submit() is expected to be unbalanced (the PM reference 
> count is expected to be incremented on return).
> 
> In the case where pm_runtime_get_sync() fails, the job will eventually 
> timeout, and there's a corresponding pm_runtime_put_noidle() in 
> panfrost_reset().
> 
> Potentially this could be handled better (e.g. without waiting for the 
> timeout to occur), but equally this isn't something we expect to happen 
> in normal operation).
> 
> Steve
Sorry, I didn't notice the pm_runtime_put_noidle() in 
panfrost_job_timedout() before.

Thanks for your reply.
> 
>>       if (ret < 0)
>>           return;
>>
> 
> .
