Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC9A2DE632
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgLRPHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgLRPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:07:02 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0616BC061282
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 07:06:22 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 7so1471761qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 07:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2CcsUdMD1whnXsjk2gFq/XTzje6TrL9HXX+Dsx/aRsw=;
        b=cNicNfds/t27C2UfSITX5nGY21ceNUiFsWvRAaN8vtIER/ZYd22saTqqkr8TI87Cdr
         EU1gx64LRI+c7p7XwX7HJzmUMyQoYQbKX+ea2ssKhSzLkJ39zeb43MaJpPcdFob9/jw8
         wdEizFFEbpalBDjYY2Drx337F8elliULrgjMP0uYhsyZQAALPGH9bcxAaAJBfoY1JOpY
         37a6FoBhXGm0CeYsm6tRHedNx3OB1InPXnQN3mIlmfa1x+SsGq2srVNcTvayqqZ/R9jK
         GelgicSA4gopWGgEoxXYBQx65fZ4EXO1XI7ksAZaLc+JQWIbnt9N2M8imKWdFly0G4pr
         LZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2CcsUdMD1whnXsjk2gFq/XTzje6TrL9HXX+Dsx/aRsw=;
        b=eV4EvtIgMNmHq31sT7PjkKEtSde/zkO/owVRBNvuKDR/94lb9klZqRacj0V1Z18f2i
         DNvQjDk/QKjdltlfNbYbDBgInf6iVw8yMXRUs/wY8t0DfdhSY7FDPV1yt9UD2h+fOaUN
         68wipOhzMDvhpL8LslT8pr0nMOHJwL/f1jNcH51o99dRdvOyWAOJH46+IOh66Xpbo77c
         RGe70aJVQy/QhTHuu92QGKOaNEMQ/cTylXPazhwFpEtyHyu2ONo5pWK0qqecgQkju6VD
         Kjv1WOhUwxYcmET/Yukacixz2ZG4+/E9h1xYp8d1bTekW0ied+xUQ8H4e1rujmZ+wT6w
         2B0g==
X-Gm-Message-State: AOAM532qKTVJxCW0CgjNjtxVLNCGxhQ2bu/dsTOTLCkEGWDc4EDGBx7r
        LM6KBk1JTa19MhCFbi8OgUtquA==
X-Google-Smtp-Source: ABdhPJzCXBW2mQTgm3+2UO7aZKT5iV1xT6Slq6gnCD2iit31NZI6t/H8kIGXT3xmYmcitY6Rge/IpQ==
X-Received: by 2002:ac8:4e87:: with SMTP id 7mr4374637qtp.310.1608303981233;
        Fri, 18 Dec 2020 07:06:21 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id n188sm5995681qke.17.2020.12.18.07.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 07:06:20 -0800 (PST)
Subject: Re: [PATCH v2 2/3] thermal/core: Use precomputed jiffies for the
 polling
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>
References: <20201216220337.839878-1-daniel.lezcano@linaro.org>
 <20201216220337.839878-2-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <a342581a-e85c-b489-c00a-491812c5f6dc@linaro.org>
Date:   Fri, 18 Dec 2020 10:06:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216220337.839878-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/20 5:03 PM, Daniel Lezcano wrote:
> The delays are also stored in jiffies based unit. Use them instead of
> the ms.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/thermal/thermal_core.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 2c41d4a0923f..d96c515af3cb 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -289,16 +289,11 @@ static int __init thermal_register_governors(void)
>    * - Critical trip point will cause a system shutdown.
>    */
>   static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
> -					    int delay)
> +					    unsigned long delay)
>   {
> -	if (delay > 1000)
> +	if (delay)
>   		mod_delayed_work(system_freezable_power_efficient_wq,
> -				 &tz->poll_queue,
> -				 round_jiffies(msecs_to_jiffies(delay)));
> -	else if (delay)
> -		mod_delayed_work(system_freezable_power_efficient_wq,
> -				 &tz->poll_queue,
> -				 msecs_to_jiffies(delay));
> +				 &tz->poll_queue, delay);
>   	else
>   		cancel_delayed_work(&tz->poll_queue);
>   }
> @@ -317,9 +312,9 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>   	mutex_lock(&tz->lock);
>   
>   	if (!stop && tz->passive)
> -		thermal_zone_device_set_polling(tz, tz->passive_delay);
> +		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>   	else if (!stop && tz->polling_delay)
> -		thermal_zone_device_set_polling(tz, tz->polling_delay);
> +		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>   	else
>   		thermal_zone_device_set_polling(tz, 0);
>   
> 

-- 
Warm Regards
Thara
