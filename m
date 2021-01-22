Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B92FFFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbhAVKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:13:09 -0500
Received: from foss.arm.com ([217.140.110.172]:39522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbhAVKMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:12:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2395411D4;
        Fri, 22 Jan 2021 02:11:33 -0800 (PST)
Received: from [10.57.9.64] (unknown [10.57.9.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11E523F719;
        Fri, 22 Jan 2021 02:11:30 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Add governor data with pre-defined
 thresholds
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        dri-devel@lists.freedesktop.org
References: <20210121170445.19761-1-lukasz.luba@arm.com>
 <f1b5c801-71f9-c3b9-2017-d9ee5c6fd3d2@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ec393a2c-2220-9ea8-db5c-7d651badc6b9@arm.com>
Date:   Fri, 22 Jan 2021 10:11:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f1b5c801-71f9-c3b9-2017-d9ee5c6fd3d2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 5:15 PM, Daniel Lezcano wrote:
> On 21/01/2021 18:04, Lukasz Luba wrote:
>> The simple_ondemand devfreq governor uses two thresholds to decide about
>> the frequency change: upthreshold, downdifferential. These two tunable
>> change the behavior of the governor decision, e.g. how fast to increase
>> the frequency or how rapidly limit the frequency. This patch adds needed
>> governor data with thresholds values gathered experimentally in different
>> workloads.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> Hi all,
>>
>> This patch aims to improve the panfrost performance in various workloads,
>> (benchmarks, games). The simple_ondemand devfreq governor supports
>> tunables to tweak the behaviour of the internal algorithm. The default
>> values for these two thresholds (90 and 5) do not work well with panfrost.
>> These new settings should provide good performance, short latency for
>> rising the frequency due to rapid workload change and decent freq slow
>> down when the load is decaying. Based on frequency change statistics,
>> gathered during experiments, all frequencies are used, depending on
>> the load. This provides some power savings (statistically). The highest
>> frequency is also used when needed.
>>
>> Example glmark2 results:
>> 1. freq fixed to max: 153
>> 2. these new thresholds values (w/ patch): 151
>> 3. default governor values (w/o patch): 114
>>
>> In future the devfreq framework would expose via sysfs these two
>> tunables, so they can be adjusted by the middleware based on currently
>> running workload (game, desktop, web browser, etc). These new values
>> should be good enough, though.
>>
>> Regards,
>> Lukasz Luba
>>
>>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 10 +++++++++-
>>   drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> index 56b3f5935703..7c5ffc81dce1 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> @@ -130,8 +130,16 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>>   	panfrost_devfreq_profile.initial_freq = cur_freq;
>>   	dev_pm_opp_put(opp);
>>   
>> +	/*
>> +	 * Setup default thresholds for the simple_ondemand governor.
>> +	 * The values are chosen based on experiments.
>> +	 */
>> +	pfdevfreq->gov_data.upthreshold = 45;
>> +	pfdevfreq->gov_data.downdifferential = 5;
>> +
>>   	devfreq = devm_devfreq_add_device(dev, &panfrost_devfreq_profile,
>> -					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
>> +					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
>> +					  &pfdevfreq->gov_data);
>>   	if (IS_ERR(devfreq)) {
>>   		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
>>   		ret = PTR_ERR(devfreq);
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
>> index db6ea48e21f9..1e2a4de941aa 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
>> @@ -4,6 +4,7 @@
>>   #ifndef __PANFROST_DEVFREQ_H__
>>   #define __PANFROST_DEVFREQ_H__
>>   
>> +#include <linux/devfreq.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/ktime.h>
>>   
>> @@ -17,6 +18,7 @@ struct panfrost_devfreq {
>>   	struct devfreq *devfreq;
>>   	struct opp_table *regulators_opp_table;
>>   	struct thermal_cooling_device *cooling;
>> +	struct devfreq_simple_ondemand_data gov_data;
>>   	bool opp_of_table_added;
>>   
>>   	ktime_t busy_time;
> 
> I think it is simpler to do:
> 
> +static struct devfreq_simple_ondemand_data panfrost_ondemand_data = {
> +       .upthreshold = 45,
> +       .downdifferential = 5,
> +};
> 
> [ ... ]
> 
>         devfreq = devm_devfreq_add_device(dev, &panfrost_devfreq_profile,
> -                                         DEVFREQ_GOV_SIMPLE_ONDEMAND,
> NULL);
> +                                         DEVFREQ_GOV_SIMPLE_ONDEMAND,
> +                                         &panfrost_ondemand_data);
> 
> 

Yes, it's simpler. The driver would probably never have to serve two
GPUs. I've tried to keep this thing inside the panfrost struct,
forgetting about it.

Steven already reviewed the patch, so it can probably stay.
I will keep it in mind. Thank you for the comments.

Regards,
Lukasz
