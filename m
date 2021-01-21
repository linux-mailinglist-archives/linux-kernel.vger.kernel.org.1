Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C972FF198
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbhAURRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388593AbhAURQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:16:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B8BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:15:11 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m4so2492580wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0TKhKPuBzsSJvz0KdGxXyIe+kX565AKHFZhYCfR4ox8=;
        b=JJGQfRgB3uol4wYfhWAdmfh9iKCW4G5pIWkEb5ZWwA5fcf8FPbq2Yl+gx/0p3T0ptT
         BOou/MlnOpbtUE3dUdLhJ9svl4rsVaTIQblXQd58kzVgELSQ/Nvt6EAmNfhIWYn15ISP
         3eZEfM9dSHFR8GpJWFRcSyKsmRRSx7Hn3lPhGDfLr1FF0WGoC/4Fea/cDjHB0HiCiDbj
         2sg4QOOfDtru+zWNUXDf1tiQi1YanI3Uv4i95L4LaiZUqeVWOLVrpUUoBk7mMTWxU3yo
         2qNkg40odFV2YK0USx4akJQpTLZzVfs5x5j4OyaLafCkWBoCWcmMPdCp4B7d+DnwHpgz
         98iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0TKhKPuBzsSJvz0KdGxXyIe+kX565AKHFZhYCfR4ox8=;
        b=JNYEtwTTTPrXwNVRbbou5+K3fIgXPlPDASnXLLU/JUwquK+GiMkMmCqIQ7cah+CLe9
         OXgohQaD6d1LetRTjRHi5I5W87szhfRx/XU1w6oClq9PLhHwwURWuvSKxAcuitGupPGl
         2mygT+Vml9KNjEEp+17kAjr5xym+5t+HyoKz67SMbg+U3CdcKLEgBx6LRnI7mJrBu9C2
         SuLknRYwFFk23Q3hzvZUntMzWGd9WBxRcsDlCgAw5mYrBRRwSxEuPB/1SKK/JUBSQRKR
         xoT7/nOVNXCYVYBHnqNdAfTnkZ2Lbrv9kiSt/Zh64C0Ii+XQDTqKamVXFNJ0XdT3s9nZ
         KR+Q==
X-Gm-Message-State: AOAM530SL6cJU5zT5yNhQxQ6XtJn7po0yc7ZBkPPyq1PL6oP3tCiFrHh
        7FrQP41vm2MUmttlULUWi2bqdA==
X-Google-Smtp-Source: ABdhPJxYnXDtESnsaNb8tZ4oUAX6YVitugqmT9sOgQbBTWyqi1DwFBO8wmWd1Kb9eNCJt/62ftK96A==
X-Received: by 2002:a05:6000:1088:: with SMTP id y8mr480057wrw.380.1611249310245;
        Thu, 21 Jan 2021 09:15:10 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1539:1c19:f5a3:71b8? ([2a01:e34:ed2f:f020:1539:1c19:f5a3:71b8])
        by smtp.googlemail.com with ESMTPSA id s4sm8862226wme.38.2021.01.21.09.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 09:15:09 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Add governor data with pre-defined
 thresholds
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        steven.price@arm.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     robh@kernel.org, tomeu.vizoso@collabora.com,
        alyssa.rosenzweig@collabora.com, dri-devel@lists.freedesktop.org
References: <20210121170445.19761-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f1b5c801-71f9-c3b9-2017-d9ee5c6fd3d2@linaro.org>
Date:   Thu, 21 Jan 2021 18:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121170445.19761-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 18:04, Lukasz Luba wrote:
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
> 
> In future the devfreq framework would expose via sysfs these two
> tunables, so they can be adjusted by the middleware based on currently
> running workload (game, desktop, web browser, etc). These new values
> should be good enough, though.
> 
> Regards,
> Lukasz Luba
> 
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 10 +++++++++-
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 56b3f5935703..7c5ffc81dce1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -130,8 +130,16 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>  	panfrost_devfreq_profile.initial_freq = cur_freq;
>  	dev_pm_opp_put(opp);
>  
> +	/*
> +	 * Setup default thresholds for the simple_ondemand governor.
> +	 * The values are chosen based on experiments.
> +	 */
> +	pfdevfreq->gov_data.upthreshold = 45;
> +	pfdevfreq->gov_data.downdifferential = 5;
> +
>  	devfreq = devm_devfreq_add_device(dev, &panfrost_devfreq_profile,
> -					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
> +					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
> +					  &pfdevfreq->gov_data);
>  	if (IS_ERR(devfreq)) {
>  		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
>  		ret = PTR_ERR(devfreq);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> index db6ea48e21f9..1e2a4de941aa 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -4,6 +4,7 @@
>  #ifndef __PANFROST_DEVFREQ_H__
>  #define __PANFROST_DEVFREQ_H__
>  
> +#include <linux/devfreq.h>
>  #include <linux/spinlock.h>
>  #include <linux/ktime.h>
>  
> @@ -17,6 +18,7 @@ struct panfrost_devfreq {
>  	struct devfreq *devfreq;
>  	struct opp_table *regulators_opp_table;
>  	struct thermal_cooling_device *cooling;
> +	struct devfreq_simple_ondemand_data gov_data;
>  	bool opp_of_table_added;
>  
>  	ktime_t busy_time;

I think it is simpler to do:

+static struct devfreq_simple_ondemand_data panfrost_ondemand_data = {
+       .upthreshold = 45,
+       .downdifferential = 5,
+};

[ ... ]

       devfreq = devm_devfreq_add_device(dev, &panfrost_devfreq_profile,
-                                         DEVFREQ_GOV_SIMPLE_ONDEMAND,
NULL);
+                                         DEVFREQ_GOV_SIMPLE_ONDEMAND,
+                                         &panfrost_ondemand_data);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
