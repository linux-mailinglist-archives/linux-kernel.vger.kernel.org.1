Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9312F249F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404797AbhALAZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403999AbhAKXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:19:13 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16CFC06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:18:32 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id n9so1084582ili.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aUUZwHzjsRYlgS0NeBcgamHcfmVNx8VRCg6rcyz29Ew=;
        b=JOmh6HLIkJ9lOpv74pzfRyhuDr03MiEHvX/RCjvThgjrpvgVp90RYHFCR0sOTKeKmv
         MSRmnPa/jurKPJIrVi4fb848glclEjyoe2BO7biC7i7YPd1X8RpkyM34x73w8bZwShEi
         V6UB+/qGpJZah5ihPnoY8Fb8Vh3/VS+OXhLM717MlZSBhP6inNdXxWv0b8CjVCO79KN0
         Sk1zjoxY9JuEWTOYq3HRJjeFNFllzS2Il7GtRgp+Aid/FtZktKXZTA3cOEHRgLV/xTMq
         y9w3fu7p/h2uCD92au2hdM52RfXuQz//UtEr87He/JM9lBVXSXEG+SS/YJO5kKGPrHkj
         SjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aUUZwHzjsRYlgS0NeBcgamHcfmVNx8VRCg6rcyz29Ew=;
        b=SRVqe9uaJcOFKZQ8llw5xKPf5eO9I/EU8cc3SJZay6Dh2JGJOgVGOmYpq+KloMCYBc
         HOZpxPp5cFpdO0huz8Zs4C9eWcj1/AdiY62SM9VSHTZyusq6X97iXB9uutmddWaMIjBd
         lYXlMoKvcJRym0YzN2TtJ6ukbGlgzeEcskQztNZdHMM7XCKAwZLNYArQXhuZHNIqEF6h
         GvBuYNPNmB/iHZtLiSqonralcrjddMmejpAav9ta6r8mQfIkp8+5jRX+1flUUIA2yyK4
         oor7lYBH0wL0zAl10eH2czjlOFZp5VnvznCkGF/sYPkZaj13pPZfN077vcMFVJfhT/S3
         l6FA==
X-Gm-Message-State: AOAM5314UmGhTNTyfh9MXIKOb/EeQAI+bOjoYb9K8ZUTBTlXrXF4bpHC
        ANonp80FyTUUfyrzRwBQoTBJ77Z0A1MrtA==
X-Google-Smtp-Source: ABdhPJyU/ftyqly4VUye4FW0Xp/hyN7hsyGsYakMBkzkvhlCZo4F7n22Hmjf2SP0tboQmAEvWTPo2w==
X-Received: by 2002:a05:6e02:f93:: with SMTP id v19mr1305913ilo.154.1610407112352;
        Mon, 11 Jan 2021 15:18:32 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id p19sm835661ili.84.2021.01.11.15.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:18:31 -0800 (PST)
Subject: Re: [PATCH 5/6] thermal/core: Remove THERMAL_TRIPS_NONE test
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-5-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <6d1a9bc5-e124-b6ee-41f8-b7042c093c1a@linaro.org>
Date:   Mon, 11 Jan 2021 18:18:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214233811.485669-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/20 6:38 PM, Daniel Lezcano wrote:
> The last site calling the thermal_zone_bind_cooling_device() function
> with the THERMAL_TRIPS_NONE parameter was removed.
> 
> We can get rid of this test as no user of this function is calling
> this function with this parameter.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

>   drivers/thermal/thermal_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index a0f0c33c8d9c..bcc2ea4f5482 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -710,7 +710,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>   	unsigned long max_state;
>   	int result, ret;
>   
> -	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
> +	if (trip >= tz->trips || trip < 0)
>   		return -EINVAL;
>   
>   	list_for_each_entry(pos1, &thermal_tz_list, node) {
> 

-- 
Warm Regards
Thara
