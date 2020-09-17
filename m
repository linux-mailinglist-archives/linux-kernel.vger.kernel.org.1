Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7374026D432
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIQHGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgIQHFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:05:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16D8C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:05:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so852312wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lWWYwFEJdlsj3P23LfFOjyoT1SaVdGZj4iXJfGwnMqE=;
        b=jXo8gyXs0EsvrL9UUHQW0PEwyvI40Z9dhYF2NKmEYlhnZ6rBzuNtSYjMZwzPv59koM
         SvD5m/gZCUU+UhByyffqKA6p1faPwy8lUVpFka2LI06Jy7B8RUffW+iZjwiFa/11b1dN
         pqVJe3nuLWn+f7Z7ezVlt1JGUk6gh7OdOUBLx+MoPwAM7z51AsFwKGWVDa9t712kyNYn
         cyo25lXeVT/8iE/GW2ct1MHu53BuMfJIPKP0HNz2a8sO1nZCtIZVyuH7Jp9T71p2x8tw
         xm6/fFY2po8pm3TYGmVPOZyZpTkg6OL9RYNY2thWB+qlTmLAotYsnWkPS3hi38XzFe1u
         Lt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lWWYwFEJdlsj3P23LfFOjyoT1SaVdGZj4iXJfGwnMqE=;
        b=ZxcbiPEDCFY4Z13rGKVJljZQTSwbY3f8eg2T3tGjR+eECSBwm55WZAi9AVnlB8+u8R
         G0/HQYprwggkhQ+gVgs0eXsEHjAonTiKBVn3v+WxUHfU7fHGX2j8edPedFSEqaiPBR4i
         RZcNTgclQXyJIUFih+qM1KCGWKhMeI5RDt6tA/AMn9Th0wG/GEkIVIKsnKOh+tNdZV+k
         0wU1LZ2a4wvmwxfZrf6ZHIvG1EfQQa9Z8uh6OaHrcHfFIwxVaNKcyBHnbXb3f7a62/5O
         bgb4yrdgLLy0Z3Bchfu9LfpEEOoy3VE1sfC7wevJMxJEfjW/JkVYibejaK6EdMrFjPc4
         iL/Q==
X-Gm-Message-State: AOAM532jlC7NLFfvWWCO5LLdXe2MtyTUWG2rXrKV+DuWQ5kX7e0N1Xqf
        PLw3eN6S8WFs4qF+T50MQN6XqzVAnijrzf51
X-Google-Smtp-Source: ABdhPJww5pkMLl/HlZqN0QZzWsU+BDIPqCp7mPcGBAdQQG53/A1JOh4lzZJAHV5aita8sA+1qJMMvA==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr8035673wmk.125.1600326332159;
        Thu, 17 Sep 2020 00:05:32 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9934:ad8d:e364:de32? ([2a01:e34:ed2f:f020:9934:ad8d:e364:de32])
        by smtp.googlemail.com with ESMTPSA id h8sm36632684wrw.68.2020.09.17.00.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:05:31 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Change the set_cur_state
 function
To:     zhuguangqing83@gmail.com, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, zhuguangqing@xiaomi.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200917060031.6566-1-zhuguangqing83@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ff6e6aaa-3707-b320-0afe-d34118be4a2b@linaro.org>
Date:   Thu, 17 Sep 2020 09:05:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917060031.6566-1-zhuguangqing83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2020 08:00, zhuguangqing83@gmail.com wrote:
> From: zhuguangqing <zhuguangqing@xiaomi.com>
> 
> In the function cpuidle_cooling_set_cur_state(), if current_state is
> not equal to state and both current_state and state are greater than
> 0(scene 4 as follows), then maybe it should stop->start or restart
> idle_inject.

Sorry, I don't get it.

It is an update of the state, why do we need to restart the idle
injection ? The state change will be automatically take into account by
the idle injection code at the new injection cycle.

> The scenes changed is as follows,
> 
> scene    current_state    state    action
>  1              0          >0       start
>  2              0          0        do nothing
>  3              >0         0        stop
>  4        >0 && !=state    >0       stop->start or restart
>  5        >0 && ==state    >0       do nothing
> 
> Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> ---
>  drivers/thermal/cpuidle_cooling.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> index 78e3e8238116..868919ad3dda 100644
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -113,7 +113,7 @@ static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
>  /**
>   * cpuidle_cooling_set_cur_state - Set the current cooling state
>   * @cdev: the thermal cooling device
> - * @state: the target state
> + * @state: the target state, max value is 100
>   *
>   * The function checks first if we are initiating the mitigation which
>   * in turn wakes up all the idle injection tasks belonging to the idle
> @@ -130,6 +130,9 @@ static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>  	unsigned long current_state = idle_cdev->state;
>  	unsigned int runtime_us, idle_duration_us;
>  
> +	if (state > 100 || current_state == state)
> +		return 0;
> +
>  	idle_cdev->state = state;
>  
>  	idle_inject_get_duration(ii_dev, &runtime_us, &idle_duration_us);
> @@ -140,8 +143,11 @@ static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>  
>  	if (current_state == 0 && state > 0) {
>  		idle_inject_start(ii_dev);
> -	} else if (current_state > 0 && !state)  {
> +	} else if (current_state > 0 && !state) {
>  		idle_inject_stop(ii_dev);
> +	} else {
> +		idle_inject_stop(ii_dev);
> +		idle_inject_start(ii_dev);
>  	}
>  
>  	return 0;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
