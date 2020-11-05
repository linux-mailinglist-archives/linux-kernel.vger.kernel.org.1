Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71A2A7D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgKELhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgKELez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:34:55 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236FEC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:34:54 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w1so1361733wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cmA911j1PA5rQEtu+2qgyW5r4PKGKN0v18j0iAtPX8A=;
        b=dksTi42d3P5XqRJKwuAYbMySrRQ2rsJhcDSLN1KEag0O3OScl72x+N37GM6rKQ+QSG
         RbGpklDb8WtY5jqFtV9DyH5BONe+6QPSyTPd+dy49JjsGiSVe0eC6jBj+DEx5MIpUiGC
         VBTmk/FO06W9gmACoB1le/pm8UO+4WkN+8vH5rIedPYb6IbeO6SNo65sYuUsgchxlvzH
         WFzvSWzRLKT1hZJHe82M8VNLbOQJItfE1keyyz6HDICxkYCN6c1oO+fz3UuBxyGduGvk
         n+QWB4wjcB9XpEXgauVK7q5DilZhmx8UHQ56LCVvPMTsVmUrVnIAcsHHkqh5/cTm3/9B
         KtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmA911j1PA5rQEtu+2qgyW5r4PKGKN0v18j0iAtPX8A=;
        b=M4qa85Jf7ixX4bUHP3ZYi7d3efWfDMOmpCq8XXuNIlaxJ+wnSDvvHwZFwtLg4gsqrs
         KHLGXjYzsGfqNhurARjtLOqJd8PWMdmVXM9Dspakm2H4HBitNxdbiYAqVnlRQ53n4mkI
         DE9NdDSUS6/+cxtvqBKOcaSH8PkfFHHXVspeE8rit/hu54B9gLCXp1QL2OElHJlU7QDW
         JGTrDGAbBEDQdEhS5CTFO7/bfxMad+ZolGLGGs/rod8TR287bJB28Lwi660n6ouykpsK
         m/HZZfbKvAujr1H69SEdmjuQa9UhqY15SNbAaIDlIWI7/nhMlVbJ2fkSIvk+TmVGPfjd
         7C3Q==
X-Gm-Message-State: AOAM5331qqvgNoSFlsmvCwHmXc/UREiXNkQSSGUJFK8fj7M0aU3UHZRe
        i550kxw0scxpwkc2fFr87bdQ2qjX8vYRDQ==
X-Google-Smtp-Source: ABdhPJyqCVI2yT0sKA5lcM5jmRQT5Pg3GVU37ZdR7ozNbZ2aBXkXolrWJ9Pq+KaAMiJyA2wRwVYU+Q==
X-Received: by 2002:adf:e388:: with SMTP id e8mr2371381wrm.65.1604576092286;
        Thu, 05 Nov 2020 03:34:52 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-142-252.adsl.proxad.net. [82.252.142.252])
        by smtp.googlemail.com with ESMTPSA id v123sm2271907wme.7.2020.11.05.03.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 03:34:51 -0800 (PST)
Subject: Re: [PATCH] thermal: Rearrange thermal_zone_device_set_polling()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c024f35421c67d7b1a3a20bc280fb5131ce6db43.1604567599.git.viresh.kumar@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ce85bf38-c77c-c8f9-0bd6-f7c598078e7a@linaro.org>
Date:   Thu, 5 Nov 2020 12:32:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c024f35421c67d7b1a3a20bc280fb5131ce6db43.1604567599.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 10:13, Viresh Kumar wrote:
> Rearrange thermal_zone_device_set_polling() to make it more readable and
> reduce duplicate code.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Hi Viresh,

I have a series where this function is reworked and conflicts with your
changes. The delay is converted into jiffies at init time and no
conversion happen in this function anymore.

Do you mind if we discard this patch ?


>  drivers/thermal/thermal_core.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index c6d74bc1c90b..7dfab370a369 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -291,16 +291,17 @@ static int __init thermal_register_governors(void)
>  static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>  					    int delay)
>  {
> -	if (delay > 1000)
> -		mod_delayed_work(system_freezable_power_efficient_wq,
> -				 &tz->poll_queue,
> -				 round_jiffies(msecs_to_jiffies(delay)));
> -	else if (delay)
> +	if (delay) {
> +		int time = msecs_to_jiffies(delay);
> +
> +		if (delay > 1000)
> +			time = round_jiffies(time);
> +
>  		mod_delayed_work(system_freezable_power_efficient_wq,
> -				 &tz->poll_queue,
> -				 msecs_to_jiffies(delay));
> -	else
> +				 &tz->poll_queue, time);
> +	} else {
>  		cancel_delayed_work(&tz->poll_queue);
> +	}
>  }
>  
>  static inline bool should_stop_polling(struct thermal_zone_device *tz)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
