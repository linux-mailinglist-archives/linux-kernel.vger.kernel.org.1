Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE672A909E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKFHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgKFHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:44:10 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:44:10 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id h6so312602pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7al+1KQqygBh8yCBrLUsOyumU9ROiq9Kbq3Xdf1DwkI=;
        b=Ri+pKNwiEc4VOv9Umm81GO4nHRH7HLV5YiyZ1xQkLUsqSMUimOj9rj7rjtFs//oSwZ
         6EsJPly3lYAoTT5HxSk1I5b1K8mXIYjF8o6MeTnWhlC39CSzjx8lBiKzhbehWp/RnXeo
         Z4Hp2ReIrx4CkRSzRU3NcrxXRtw5wFiYI4/rGHNo5tX9QfOMwYvdVqM/DtR8EnPqX8CQ
         oXiK6CaaRWuDbrj5FQ+iOUBBFpNL8/GY/w7xVoXg/nFl7SpXNyqaUU3gMx2EWJGg5FAG
         Y0N684pi4u72xegcHFxrw0CBwH3+8prRy33JphiUFFE8vylR7EsF7Rsx5KendNfL6gQO
         i8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7al+1KQqygBh8yCBrLUsOyumU9ROiq9Kbq3Xdf1DwkI=;
        b=IM2bdQusvYePY6GPUCm5NmY5Sl1ommsBvFApNnuhE7a5zyDvasLacMkRkuV2KYGwMp
         Yezh2VdU+QUyhK6fakK8tLA9sN70NQNToW8DJGP+O3efx6pKy9c+T5u8Twwax/Bw8wMj
         phJNhZ3SItw3mPqqxs3GQYyJl5H5ktKvLayJwn+UGj8bvSMk9vMpcA6JDpWL3v2AOj5S
         OBzYNpvyC0IzcnWcj9bHYskEaFjqQE6GoPpPIChUCFjmPMH5RkwTlmmvd0F+EeYhTqi8
         GYDFLWALUTK9ZcGnwRLOHI9De8ELymdvK/Fs53HMTMje2np7pedbRTGX0h+SjBMVOZe6
         nTaw==
X-Gm-Message-State: AOAM533oe3klkSjT3zDv2pK8WmOTyH6rDG11R3UF8CrMO89EoYNR/aWI
        h3jPDbmTowfU+1fVciSc275Ug+ldrL+wMA==
X-Google-Smtp-Source: ABdhPJzetVB2Ryqy60ff9qy7r8GiFsYJPhXFNO7OS/cEP4u2veL2hZrIuWB6ZmT8IfQRHQGqzlYr0g==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr1095994pjx.93.1604648649876;
        Thu, 05 Nov 2020 23:44:09 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id m23sm679169pgk.84.2020.11.05.23.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:44:08 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:14:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhuguangqing83@gmail.com
Cc:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        javi.merino@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Update cpufreq_state
 only if state has changed
Message-ID: <20201106074406.vykfapy7xstmqk4h@vireshk-i7>
References: <20201105111914.9324-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105111914.9324-1-zhuguangqing83@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-20, 19:19, zhuguangqing83@gmail.com wrote:
> From: zhuguangqing <zhuguangqing@xiaomi.com>

Maybe fix your name in your email client or git config? It should be
Zhuguangqing (with first letter in CAPITAL) and maybe add a second
name also (surname) in case you want/have it.

> If state has not changed successfully and we updated cpufreq_state,
> next time when the new state is equal to cpufreq_state (not changed
> successfully last time), we will return directly and miss a
> freq_qos_update_request() that should have been.
> 
> Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>

Please find and add below details as well, they are helpful in fixing
the stable kernels.

Fixes: 5130802ddbb1 ("thermal: cpu_cooling: Switch to QoS requests for freq limits")
Cc: v5.4+ <stable@vger.kernel.org> # v5.4+

> ---
>  drivers/thermal/cpufreq_cooling.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index cc2959f22f01..00dc26c33899 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -438,13 +438,12 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  	if (cpufreq_cdev->cpufreq_state == state)
>  		return 0;
>  
> -	cpufreq_cdev->cpufreq_state = state;
> -
>  	frequency = get_state_freq(cpufreq_cdev, state);
>  
>  	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
>  

Now that you are going to resend it anyways, drop this blank line as
well and mention that in the commit log.

>  	if (ret > 0) {
> +		cpufreq_cdev->cpufreq_state = state;
>  		cpus = cpufreq_cdev->policy->cpus;
>  		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
>  		capacity = frequency * max_capacity;

Good catch Zhuguangqing. Thanks.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
