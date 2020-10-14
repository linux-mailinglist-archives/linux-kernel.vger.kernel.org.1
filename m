Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45828E091
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgJNMbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgJNMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:31:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39999C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 05:31:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so1584233wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KB+6ySlou+IcHZkYe/oZLqhmhPrZ63cakyZUaPhIhKQ=;
        b=tqHCgT+MHAIxE1zGDU9Pz2T6plzgk5iUrPvBhSNhN/pKhIF/+aSyLxHKYyGM4CTm3q
         YBcfQLcNpjxp2s1QCd3mf/o4RbwrSOUF5ISmK85RNICvsSlUAObXtB15cSL0NtKrWxVA
         OXbY07xU8YCp66Y8DMxLK309KNhDSkeK4q7r6/z2iSJ9fN7Lyr8TvcbeSjjRHiGHHpw+
         LeQD+v6bm+8/gNtMdXNieDF9F2Ee8fSnr7saEwMKroB4T0f039zjLPNz8zmP1Qo2CzZd
         A5IZnW4fBTHpXDcvYKxL5msmi9vtg5XeNh+bRdzE2f+ITnY7yFm3hItx2HegUR0oMkZl
         B13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KB+6ySlou+IcHZkYe/oZLqhmhPrZ63cakyZUaPhIhKQ=;
        b=DR4oS76QimLiLAw7MIbTTHErf3ooqAQ7t9viHn47YIM2A5216QRlyuSKw94bQhUoxj
         hcdVpc//NrXEopF/ahVlqTbwI8A4NBS50zDP+lvDCpaH58URfA0M4yvstOFv+Uw1TA4v
         MrAOCr1VS6wZK1Y8/arF7vccDF1iFvyTV0jf65z2GiUPRaNVLGtptVziGWj+Fwh209A/
         yJ2V3e8MyCtx+3B2BUsrOgomNJwqc8jm3IoUsj8c5iF89eM/H/zjwXlYULl1xUg0USn8
         VIUq0fHB9r0AmvyBsiMeD5FqD5kz4qJVB5wuLEX1qTsh5/mtN8pY271xRxO2ZV/Y9666
         r5Wg==
X-Gm-Message-State: AOAM530Q2NNCe8j3WdMJ5/vVodegoL2vHvNry6sQtfu5q8VgTV3hLxmn
        Z2/jw7EWFCupxukSr8tQjiaFgg==
X-Google-Smtp-Source: ABdhPJy2mGCEWq3jczFkkMFcp3+jlolWpVrs+69RCmmuZCWegGfFZi4F7SPdxpLjSDS+HPTuMGIdWA==
X-Received: by 2002:a1c:dd0b:: with SMTP id u11mr3182291wmg.186.1602678678588;
        Wed, 14 Oct 2020 05:31:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f? ([2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f])
        by smtp.googlemail.com with ESMTPSA id a82sm3823504wmc.44.2020.10.14.05.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 05:31:17 -0700 (PDT)
Subject: Re: [PATCH 1/3] thermal: power_allocator: respect upper and lower
 bounds for cooling device
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, Dietmar.Eggemann@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
References: <20201007122256.28080-1-lukasz.luba@arm.com>
 <20201007122256.28080-2-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <64ac12ca-9d7a-11f1-f935-0eb96dc6355b@linaro.org>
Date:   Wed, 14 Oct 2020 14:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007122256.28080-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2020 14:22, Lukasz Luba wrote:
> The thermal cooling device specified in DT might be instantiated for
> a thermal zone trip point with a limited set of OPPs to operate on. This
> configuration should be supported by Intelligent Power Allocation (IPA),
> since it is a standard for other governors. Change the code and allow IPA
> to get power value of lower and upper bound set for a given cooling
> device.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index dd59085f38f5..f9ee7787b325 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -96,7 +96,8 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
>  		if (instance->trip != params->trip_max_desired_temperature)
>  			continue;
>  
> -		if (power_actor_get_min_power(cdev, tz, &min_power))
> +		if (cdev->ops->state2power(cdev, tz, instance->upper,
> +					   &min_power))

	if (cdev->ops->state2power && cdev->ops->state2power(cdev, tz,
							instance->upper,
							&min_power))

?

>  			continue;
>  
>  		sustainable_power += min_power;
> @@ -404,7 +405,8 @@ static int allocate_power(struct thermal_zone_device *tz,
>  
>  		weighted_req_power[i] = frac_to_int(weight * req_power[i]);
>  
> -		if (power_actor_get_max_power(cdev, tz, &max_power[i]))
> +		if (cdev->ops->state2power(cdev, tz, instance->lower,
> +					   &max_power[i]))
>  			continue;

Same here ?

>  		total_req_power += req_power[i];
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
