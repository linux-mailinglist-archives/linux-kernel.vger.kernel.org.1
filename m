Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7A2DD875
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgLQSdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbgLQSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608229934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4H+T4/ehKqHlXqfjsULM9/21wYN2wzFe2ggxW0HinS4=;
        b=SSiwGvoZw8pRFgaJw/CybXDxONLjn85FeSUbQoRn9faiW/z7Iu8MdRWX5+e2U4TmxgRwHI
        8maglSLHz0OleQEaUXjzVhpHp9zIQhuy5ikzxjF0GFiTTKCMizFL64SJCgtDU6L4VrHPjI
        r3zT8cYSNCtHe33sP2mcfh0V6mv9+O4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-1JIT_WtRO56oDLcXw--UXQ-1; Thu, 17 Dec 2020 13:32:13 -0500
X-MC-Unique: 1JIT_WtRO56oDLcXw--UXQ-1
Received: by mail-ed1-f72.google.com with SMTP id l33so13761380ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 10:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4H+T4/ehKqHlXqfjsULM9/21wYN2wzFe2ggxW0HinS4=;
        b=Ddt3jM9dG2bwypUtZlcwxdPMCJAarXPh9GcFviiSysDh8VrenwXesfOT+Ogklgm37x
         M1GXMnxkaIQMtcbFKw7Xig3ew0cXouOwen83fOAso9UTFWw5fnmLygb1yZqhSJSo54cn
         zUvgQz7ZYGvDe0kSSvCnvfi1S6y+ldf0FD7k1zwwbJVFOVQxMUI6cQ3oYCW0+3270h+h
         AUDxvGHV1PT8GM9CT7s2PstkvbzpBrNCf8NwvKmbLUFAmMJmhSTg+7Kgs5ODbJx4UoOR
         xRoo/R7YOgZxDgNC3s5HdtFvIZC8xgXggdrL7CMrcWcpN/hkOsetG17dmPxiggC7Eeo/
         IoGw==
X-Gm-Message-State: AOAM53131N7RgYGL31VN8qhKObPOUuo1nVtYxOqnZ8FScfYm0XSwS05Y
        Rb5uuy6+pQkNL4a55s+R9CWkGQ1Vu8AerEeOVDQfKEUnuPHOq9ys7XhECU8IgNDeTpuQGu2IEVr
        sdtStb+720WcG3b0K0o9BsH8X
X-Received: by 2002:a17:906:d28f:: with SMTP id ay15mr281974ejb.327.1608229931312;
        Thu, 17 Dec 2020 10:32:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYNmNzi4ooXQlZs0+dHUSydf+1N5hkD/y0UInohgkrdZRIo0iBrrKbj1RMZ8Nu7pCC+u4qsw==
X-Received: by 2002:a17:906:d28f:: with SMTP id ay15mr281966ejb.327.1608229931158;
        Thu, 17 Dec 2020 10:32:11 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id b17sm4403946eju.76.2020.12.17.10.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:32:10 -0800 (PST)
Subject: Re: [PATCH v2 3/3] thermal/core: Remove ms based delay fields
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Peter Kaestle <peter@piie.net>,
        Mark Gross <mgross@linux.intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
References: <20201216220337.839878-1-daniel.lezcano@linaro.org>
 <20201216220337.839878-3-daniel.lezcano@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c575c7bc-cf53-bfdf-ea42-e8661d714699@redhat.com>
Date:   Thu, 17 Dec 2020 19:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201216220337.839878-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 12/16/20 11:03 PM, Daniel Lezcano wrote:
> The code does no longer use the ms unit based fields to set the
> delays as they are replaced by the jiffies.
> 
> Remove them and replace their user to use the jiffies version instead.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

I assume that you will merge this through the thermal tree,
here is my ack for doing so for the pdx86 bits:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/x86/acerhdf.c                     | 3 ++-
>  drivers/thermal/da9062-thermal.c                   | 4 ++--
>  drivers/thermal/gov_power_allocator.c              | 2 +-
>  drivers/thermal/thermal_core.c                     | 4 +---
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
>  include/linux/thermal.h                            | 7 -------
>  6 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index b6aa6e5514f4..6b8b3ab8db48 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -336,7 +336,8 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
>  			pr_notice("interval changed to: %d\n", interval);
>  
>  		if (thermal)
> -			thermal->polling_delay = interval*1000;
> +			thermal->polling_delay_jiffies =
> +				round_jiffies(msecs_to_jiffies(interval * 1000));
>  
>  		prev_interval = interval;
>  	}
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> index 4d74994f160a..180edec34e07 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -95,7 +95,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
>  		thermal_zone_device_update(thermal->zone,
>  					   THERMAL_EVENT_UNSPECIFIED);
>  
> -		delay = msecs_to_jiffies(thermal->zone->passive_delay);
> +		delay = thermal->zone->passive_delay_jiffies;
>  		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
>  		return;
>  	}
> @@ -245,7 +245,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
>  
>  	dev_dbg(&pdev->dev,
>  		"TJUNC temperature polling period set at %d ms\n",
> -		thermal->zone->passive_delay);
> +		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
>  
>  	ret = platform_get_irq_byname(pdev, "THERMAL");
>  	if (ret < 0) {
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 7a4170a0b51f..f8c3d1e40b86 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -258,7 +258,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>  	 * power being applied, slowing down the controller)
>  	 */
>  	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> -	d = div_frac(d, tz->passive_delay);
> +	d = div_frac(d, jiffies_to_msecs(tz->passive_delay_jiffies));
>  	params->prev_err = err;
>  
>  	power_range = p + i + d;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d96c515af3cb..b2615449b18f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -313,7 +313,7 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>  
>  	if (!stop && tz->passive)
>  		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
> -	else if (!stop && tz->polling_delay)
> +	else if (!stop && tz->polling_delay_jiffies)
>  		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>  	else
>  		thermal_zone_device_set_polling(tz, 0);
> @@ -1307,8 +1307,6 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  	tz->device.class = &thermal_class;
>  	tz->devdata = devdata;
>  	tz->trips = trips;
> -	tz->passive_delay = passive_delay;
> -	tz->polling_delay = polling_delay;
>  
>  	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>  	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 2ce4b19f312a..f84375865c97 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -166,6 +166,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>  			     char *domain)
>  {
>  	struct ti_thermal_data *data;
> +	int interval;
>  
>  	data = ti_bandgap_get_sensor_data(bgp, id);
>  
> @@ -183,9 +184,10 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>  		return PTR_ERR(data->ti_thermal);
>  	}
>  
> +	interval = jiffies_to_msecs(data->ti_thermal->polling_delay_jiffies);
> +
>  	ti_bandgap_set_sensor_data(bgp, id, data);
> -	ti_bandgap_write_update_interval(bgp, data->sensor_id,
> -					data->ti_thermal->polling_delay);
> +	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
>  
>  	return 0;
>  }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index d1b82c70de69..1e686404951b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -115,13 +115,8 @@ struct thermal_cooling_device {
>   * @devdata:	private pointer for device private data
>   * @trips:	number of trip points the thermal zone supports
>   * @trips_disabled;	bitmap for disabled trips
> - * @passive_delay:	number of milliseconds to wait between polls when
> - *			performing passive cooling.
>   * @passive_delay_jiffies: number of jiffies to wait between polls when
>   *			performing passive cooling.
> - * @polling_delay:	number of milliseconds to wait between polls when
> - *			checking whether trip points have been crossed (0 for
> - *			interrupt driven systems)
>   * @polling_delay_jiffies: number of jiffies to wait between polls when
>   *			checking whether trip points have been crossed (0 for
>   *			interrupt driven systems)
> @@ -162,8 +157,6 @@ struct thermal_zone_device {
>  	unsigned long trips_disabled;	/* bitmap for disabled trips */
>  	unsigned long passive_delay_jiffies;
>  	unsigned long polling_delay_jiffies;
> -	int passive_delay;
> -	int polling_delay;
>  	int temperature;
>  	int last_temperature;
>  	int emul_temperature;
> 

