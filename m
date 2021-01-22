Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4900A2FFE13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbhAVIWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:22:53 -0500
Received: from foss.arm.com ([217.140.110.172]:35674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbhAVIWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:22:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC4411B3;
        Fri, 22 Jan 2021 00:21:31 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 762483F719;
        Fri, 22 Jan 2021 00:21:30 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Add governor data with pre-defined
 thresholds
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     robh@kernel.org, tomeu.vizoso@collabora.com,
        alyssa.rosenzweig@collabora.com, dri-devel@lists.freedesktop.org,
        daniel.lezcano@linaro.org
References: <20210121170445.19761-1-lukasz.luba@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <c5ad1148-0494-aaed-581a-c13ed94e42e8@arm.com>
Date:   Fri, 22 Jan 2021 08:21:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121170445.19761-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 17:04, Lukasz Luba wrote:
> The simple_ondemand devfreq governor uses two thresholds to decide about
> the frequency change: upthreshold, downdifferential. These two tunable
> change the behavior of the governor decision, e.g. how fast to increase
> the frequency or how rapidly limit the frequency. This patch adds needed
> governor data with thresholds values gathered experimentally in different
> workloads.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi all,
> 
> This patch aims to improve the panfrost performance in various workloads,
> (benchmarks, games). The simple_ondemand devfreq governor supports
> tunables to tweak the behaviour of the internal algorithm. The default
> values for these two thresholds (90 and 5) do not work well with panfrost.
> These new settings should provide good performance, short latency for
> rising the frequency due to rapid workload change and decent freq slow
> down when the load is decaying. Based on frequency change statistics,
> gathered during experiments, all frequencies are used, depending on
> the load. This provides some power savings (statistically). The highest
> frequency is also used when needed.
> 
> Example glmark2 results:
> 1. freq fixed to max: 153
> 2. these new thresholds values (w/ patch): 151
> 3. default governor values (w/o patch): 114

It would be good to state which platform this is on as this obviously 
can vary depending on the OPPs available.

Of course the real fix here would be to improve the utilisation of the 
GPU[1] so we actually hit the 90% threshold more easily (AFAICT kbase 
uses the default 90/5 thresholds), but this seems like a reasonable 
change for now.

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

[1] When I get some time I need to rework the "queue jobs on the 
hardware"[2] patch I posted ages ago. Last time it actually caused a 
performance regression though...

[2] https://lore.kernel.org/r/20190816093107.30518-2-steven.price%40arm.com

> In future the devfreq framework would expose via sysfs these two
> tunables, so they can be adjusted by the middleware based on currently
> running workload (game, desktop, web browser, etc). These new values
> should be good enough, though.
> 
> Regards,
> Lukasz Luba
> 
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 10 +++++++++-
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 56b3f5935703..7c5ffc81dce1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -130,8 +130,16 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	panfrost_devfreq_profile.initial_freq = cur_freq;
>   	dev_pm_opp_put(opp);
>   
> +	/*
> +	 * Setup default thresholds for the simple_ondemand governor.
> +	 * The values are chosen based on experiments.
> +	 */
> +	pfdevfreq->gov_data.upthreshold = 45;
> +	pfdevfreq->gov_data.downdifferential = 5;
> +
>   	devfreq = devm_devfreq_add_device(dev, &panfrost_devfreq_profile,
> -					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
> +					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
> +					  &pfdevfreq->gov_data);
>   	if (IS_ERR(devfreq)) {
>   		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
>   		ret = PTR_ERR(devfreq);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> index db6ea48e21f9..1e2a4de941aa 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -4,6 +4,7 @@
>   #ifndef __PANFROST_DEVFREQ_H__
>   #define __PANFROST_DEVFREQ_H__
>   
> +#include <linux/devfreq.h>
>   #include <linux/spinlock.h>
>   #include <linux/ktime.h>
>   
> @@ -17,6 +18,7 @@ struct panfrost_devfreq {
>   	struct devfreq *devfreq;
>   	struct opp_table *regulators_opp_table;
>   	struct thermal_cooling_device *cooling;
> +	struct devfreq_simple_ondemand_data gov_data;
>   	bool opp_of_table_added;
>   
>   	ktime_t busy_time;
> 

