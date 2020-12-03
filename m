Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33332CD663
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbgLCNKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbgLCNKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:10:20 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F57C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 05:09:40 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so1821537wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 05:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkrWWgy/zAJu0GV6hLcEd4kiWgcX7eH0p2FvB1NfSaM=;
        b=GnT4MwE0rexDgVy9iVAB+xaJVO2aSitrLemSfO3X0m/uHDffUgDe99WVZ7CmIyHEgE
         ySVZiyXirmMf99StbP7Z1KdhL2NRzx2ls+pHaZNWF0Tzny41rYvPjmd2mkQsHvSbHOr+
         iNmpyrX8GjO8eRdX5dR4LkLqp1KX3fUk+RrSZhoqgS2OAzHGfJwkfeY1N4qlGqpmx2C5
         4i0gAUIDx+sfRyWHJWfCSFRXGJIB3clsDFb9xH/bUDNgKpPECzXMjyx5Rx/b1kfq0ImY
         YlXYuXLA7hTAPuUQZuE2xpPQqsXk4reC5W0ntOFl5QToPjLrTl0CSQMTgPYDsMKLKmQU
         Zu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkrWWgy/zAJu0GV6hLcEd4kiWgcX7eH0p2FvB1NfSaM=;
        b=eSWXvV2bQCe+08e0ROqLbpCOpvUNyWuXB8IjfyZT3eS2R9K64gzxYXIP8C0U73q4ko
         rRhyHryBEjNMeaMm7Fofwr4kO1C9Do6j9d5R2rLeGNtgg5t9+ucKNpZiWEsNUTiwnMV5
         MzkXo3vgZhyQgJj8MqxkfQlZMpIpkJaVceu2+rycVRHY0YlQpiHRFZNwtyhHnHyPv+an
         HPQQTkNYa6WRsqvgDhHgiQhTHEMR4RHp6/37kf+1t0wDmC5E/vC16Wief1BqQLEQjdt6
         qnavCGyS4LGuUxQL5NwGLMDm6DmAHYN+swJ3NGicnxn1u2/DQ51B5HxBPzpjF3Hbyuua
         H3gA==
X-Gm-Message-State: AOAM531UilxyJot8hd3V6Z9Oj+V1ltGfewH7cH4E8yn9BYazkcLS3cSm
        ebqELG9EHy9WKxGI3LkQsB2kAWxJedinMA==
X-Google-Smtp-Source: ABdhPJz8FWWXiz2Jj8ehlbzz4IZAsN6vLYDaoQyFJcPRXYhvTfUYcQJ7n9arDiqpba2Wmv2W4Vsyig==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr3772346wrn.114.1607000978486;
        Thu, 03 Dec 2020 05:09:38 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2? ([2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2])
        by smtp.googlemail.com with ESMTPSA id d17sm1861139wro.62.2020.12.03.05.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 05:09:37 -0800 (PST)
Subject: Re: [PATCH v2 2/5] thermal: devfreq_cooling: get a copy of device
 status
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, ionela.voinescu@arm.com
References: <20201118120358.17150-1-lukasz.luba@arm.com>
 <20201118120358.17150-3-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5d4743b9-5b2f-8494-8d10-6a5fd2c0fdfd@linaro.org>
Date:   Thu, 3 Dec 2020 14:09:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118120358.17150-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2020 13:03, Lukasz Luba wrote:
> Devfreq cooling needs to now the correct status of the device in order
> to operate. Do not rely on Devfreq last_status which might be a stale data
> and get more up-to-date values of the load.
> 
> Devfreq framework can change the device status in the background. To
> mitigate this situation make a copy of the status structure and use it
> for internal calculations.
> 
> In addition this patch adds normalization function, which also makes sure
> that whatever data comes from the device, it is in a sane range.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/devfreq_cooling.c | 52 +++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 659c0143c9f0..925523694462 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -227,20 +227,46 @@ static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
>  							       voltage);
>  }
>  
> +static void _normalize_load(struct devfreq_dev_status *status)
> +{
> +	/* Make some space if needed */
> +	if (status->busy_time > 0xffff) {
> +		status->busy_time >>= 10;
> +		status->total_time >>= 10;
> +	}
> +
> +	if (status->busy_time > status->total_time)
> +		status->busy_time = status->total_time;

How the condition above is possible?

> +	status->busy_time *= 100;
> +	status->busy_time /= status->total_time ? : 1;
> +
> +	/* Avoid division by 0 */
> +	status->busy_time = status->busy_time ? : 1;
> +	status->total_time = 100;

Why not base the normalization on 1024? and use an intermediate u64.

For example:

static u32 _normalize_load(struct devfreq_dev_status *status)
{
	u64 load = 0;

	/* Prevent divison by zero */
	if (!status->busy_time)
		return 0;

	/*
	 * Assuming status->total_time is always greater or equal
	 * to status->busy_time, it can not be equal to zero because
	 * of the test above
	 */
	load = status->busy_time * 1024;
	load /= status->total_time;

	/*
	 * load is always [1..1024[, so it can not be truncated by a
	 * u64 -> u32 coercive cast
	 */
	return (u32)load;
}


> +}
>  
>  static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cdev,
>  					       u32 *power)
>  {
>  	struct devfreq_cooling_device *dfc = cdev->devdata;
>  	struct devfreq *df = dfc->devfreq;
> -	struct devfreq_dev_status *status = &df->last_status;
> +	struct devfreq_dev_status status;
>  	unsigned long state;
> -	unsigned long freq = status->current_frequency;
> +	unsigned long freq;
>  	unsigned long voltage;
>  	u32 dyn_power = 0;
>  	u32 static_power = 0;
>  	int res;
>  
> +	mutex_lock(&df->lock);
> +	res = df->profile->get_dev_status(df->dev.parent, &status);
> +	mutex_unlock(&df->lock);
> +	if (res)
> +		return res;
> +
> +	freq = status.current_frequency;
> +
>  	state = freq_get_state(dfc, freq);
>  	if (state == THERMAL_CSTATE_INVALID) {
>  		res = -EAGAIN;
> @@ -268,16 +294,18 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>  	} else {
>  		dyn_power = dfc->power_table[state];
>  
> +		_normalize_load(&status);

		load = _normalize_load(&status);

> +
>  		/* Scale dynamic power for utilization */
> -		dyn_power *= status->busy_time;
> -		dyn_power /= status->total_time;
> +		dyn_power *= status.busy_time;
> +		dyn_power /= status.total_time;

		/*
		 * May be change dyn_power to a u64 to prevent overflow
		 * when multiplied by 'load'
		 */
		dyn_power = (dyn_power * load) / 1024;

>  		/* Get static power */
>  		static_power = get_static_power(dfc, freq);
>  
>  		*power = dyn_power + static_power;
>  	}
>  
> -	trace_thermal_power_devfreq_get_power(cdev, status, freq, *power);
> +	trace_thermal_power_devfreq_get_power(cdev, &status, freq, *power);
>  
>  	return 0;
>  fail:
> @@ -309,14 +337,20 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>  {
>  	struct devfreq_cooling_device *dfc = cdev->devdata;
>  	struct devfreq *df = dfc->devfreq;
> -	struct devfreq_dev_status *status = &df->last_status;
> -	unsigned long freq = status->current_frequency;
> +	struct devfreq_dev_status status;
>  	unsigned long busy_time;
> +	unsigned long freq;
>  	s32 dyn_power;
>  	u32 static_power;
>  	s32 est_power;
>  	int i;
>  
> +	mutex_lock(&df->lock);
> +	status = df->last_status;
> +	mutex_unlock(&df->lock);
> +
> +	freq = status.current_frequency;
> +
>  	if (dfc->power_ops->get_real_power) {
>  		/* Scale for resource utilization */
>  		est_power = power * dfc->res_util;
> @@ -328,8 +362,8 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>  		dyn_power = dyn_power > 0 ? dyn_power : 0;
>  
>  		/* Scale dynamic power for utilization */
> -		busy_time = status->busy_time ?: 1;
> -		est_power = (dyn_power * status->total_time) / busy_time;
> +		busy_time = status.busy_time ?: 1;
> +		est_power = (dyn_power * status.total_time) / busy_time;
>  	}
>  
>  	/*
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
