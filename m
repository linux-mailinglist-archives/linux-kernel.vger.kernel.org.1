Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1121A2E972B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbhADOY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbhADOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:24:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A5CC061794
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:23:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p22so27478468edu.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vLA6j12Zecwv0meb8C+1VRWv81U64i9hKX8vIp754Io=;
        b=I3oPAGkPZ5KcEb7llc/oZZCMHkHPeUB+icOycLamMdd2G8dd4nLxLhnjTeiL+t7Q4G
         QpEeF4OlXNjwdkPkZ7ZRj4zNcJ6wUo/2pjkf8fq1kCrLG88iL1OY25cb4qLP18XOMtBS
         k9M9QvB9FBL3oRtkEriJvzEBSCQcdcpUVtFC1O2fRQBcx4x6ArmmmqQYL7sX5WAmHdEY
         NQa544nc8DTB8G1w7XelrRKUhUs0GWbvVrTD+8iuqFEHpKLYR8qk/RnifSuqEZbgP+8Z
         mmpagbh5IT/n932FSvFndUH9pIs0wVPmZ0KlbMPXdYDEoYQYG0KAUGZ+aNLKgPUeNrz2
         JXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vLA6j12Zecwv0meb8C+1VRWv81U64i9hKX8vIp754Io=;
        b=BS4UpFsrlb7L0mJdKct5EbLmmBqq7RhrzyqOKSjKsZt2iBTFAdcbvEdBGDEH/kjRAd
         v6gaBgl1bznwjS6ZxDeQVLfpkGvyzRHKUBsCNgTs3vQkypnu/xm8pHsdjN1ebnpqy+Uh
         V6VqufqXqQSWy76AVhQiEJq7KgrqVvHM/oZpyVbexO4axs1NxIDpXURbWe+G7E50wrgJ
         nT+2TajcsNZnpoI8N4zcA1sVWddenzalV1sfpUSTYyLUbB1InDJumj9JQNQqYpNdniGw
         M33dMCNwEIi1PbCrBhKgfqCo/FXZpMFL9VNQfNsEFwU5g8/hrkbEerW0kQLUFOfHUb2l
         tm3Q==
X-Gm-Message-State: AOAM5315axLFoIpiAbwyWRYcdg4ey1M4vmJnLNka8okOhlh3HgmOAzZw
        mYCdOPul1glK4300oTzw0mjlkmnb9Dppdw==
X-Google-Smtp-Source: ABdhPJx5MKb7q0HzgWj5X1q78yPmxO1J2m4USNRI49SKOCllbZGISqYkVKgszSxpyRSppYRO0Qagog==
X-Received: by 2002:aa7:c558:: with SMTP id s24mr72138716edr.257.1609770225795;
        Mon, 04 Jan 2021 06:23:45 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-129-8.adsl.proxad.net. [82.252.129.8])
        by smtp.googlemail.com with ESMTPSA id ho34sm23260073ejc.13.2021.01.04.06.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:23:45 -0800 (PST)
Subject: Re: [PATCH][next] powercap/drivers/dtpm: Fix size of object being
 allocated
To:     Colin King <colin.king@canonical.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210104121053.33210-1-colin.king@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ea95f420-2a2e-d0f9-9b34-e329d80bbd9d@linaro.org>
Date:   Mon, 4 Jan 2021 15:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104121053.33210-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2021 13:10, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The kzalloc allocation for dtpm_cpu is currently allocating the size
> of the pointer and not the size of the structure. Fix this by using
> the correct sizeof argument.
> 
> Addresses-Coverity: ("Wrong sizeof argument")
> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Good catch, thanks for fixing this

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/powercap/dtpm_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 6933c783c6b4..51c366938acd 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -200,7 +200,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>  	if (!dtpm)
>  		return -EINVAL;
>  
> -	dtpm_cpu = kzalloc(sizeof(dtpm_cpu), GFP_KERNEL);
> +	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
>  	if (!dtpm_cpu)
>  		goto out_kfree_dtpm;
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
