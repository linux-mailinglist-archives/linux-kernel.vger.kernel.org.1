Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50F3299573
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789996AbgJZSf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:35:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33163 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789987AbgJZSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:35:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id b8so13882651wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZTAjMvfod7ewJgUU88VnAYnkHNLP0aO1LjJ6WPSC438=;
        b=f159GZ1aM9LetMD6tVp8c5C85PYhLQXIj/ivc9gTSLVrT0SegocnaY/rBk3CYsPmw0
         neJHTBmOhcZl6bphnTPpJKJ8HOmoOMobl6zjUS9Hvm+lKBlQynwVi+qyyUuAhSMwklDP
         /4zGM3kcl5XdJzmYOmW2th6Dmvz63E/DowZzzuXntaVkxiBQQ3IfmJlSWCv2qPbLIRpE
         g7xdosTDJbMrWP0AG2L8fmaHk4R9l+zdVEBEErRiMffs1ysicHAieEkL6NbBGpSu65j/
         v0dPnVLpeI/BcvE+9XN8E3owc+YUN76uGfyEjMgNTbHSfrJIfjzhh7YWVdqc3dO/pTND
         +5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZTAjMvfod7ewJgUU88VnAYnkHNLP0aO1LjJ6WPSC438=;
        b=Gk0zOUXqYsq/STS1pbZOfdQjwtn7hEyiOupYZztDP0rFMmBk+/N+O8ELO7Bo6mUDkw
         E9D6oMeWiJV3BnnszPMQCDiWc2U2JfsjE3VRS494AAdBG6xO5Q07HLKvjiwltMIdXFsD
         Zxc+WmW2Xj4/zAiVBjxQezhFTz7k5SSch8DDl5MhMMxnqTchfkShxwXEJ+i9Cytbq0Rf
         /P0i7O2FUmxh3bBs2E/c5vDx5SGnxulON65eLUObRw8O7MywDUggZ2EtBy3bV3NqXaT7
         dbYvcMtuvbmsmW23DCJZwnDsH4dv3ez6XUtWmVKDqL6Lr0tV9gQ4sL+gmLyXjP5uVsKQ
         csDg==
X-Gm-Message-State: AOAM532PBOs6SunPbisI8srWz5DqWcfxPJulL82/EygCb8lF6yULuHxF
        WMasVtsHUvZb/Z/YRcW5wbYsJw==
X-Google-Smtp-Source: ABdhPJyfWjG0icwvJv/3VDZ69/hcIWJ80BKgWfajSd1Cv8WfkPbzL5aDoxuLsabskQEuuiv84HDNFA==
X-Received: by 2002:adf:b353:: with SMTP id k19mr19044956wrd.216.1603737322624;
        Mon, 26 Oct 2020 11:35:22 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id d142sm5003727wmd.11.2020.10.26.11.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:35:21 -0700 (PDT)
Subject: Re: [Resend][PATCH] drivers/thermal: optimize the for circle to run a
 bit fast
To:     Bernard <bernard@vivo.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <ANAAuADPDd5Q*8KfRTwcp4ps.1.1603676964376.Hmail.bernard@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <33587c80-d273-acf3-2d95-65d757b188df@linaro.org>
Date:   Mon, 26 Oct 2020 19:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ANAAuADPDd5Q*8KfRTwcp4ps.1.1603676964376.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2020 02:49, Bernard wrote:
> Function thermal_zone_device_register, in the for circle, if the
> first if branch set the count bit in tz->trips_disabled, there is
> no need to set in the other if branch again.
> This change is to make the code run a bit fast and readable.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/thermal/thermal_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index c6d74bc1c90b..03577794eea3 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1446,10 +1446,14 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  		goto release_device;
>  
>  	for (count = 0; count < trips; count++) {
> -		if (tz->ops->get_trip_type(tz, count, &trip_type))
> +		if (tz->ops->get_trip_type(tz, count, &trip_type)) {
>  			set_bit(count, &tz->trips_disabled);
> -		if (tz->ops->get_trip_temp(tz, count, &trip_temp))
> +			continue;
> +		}
> +		if (tz->ops->get_trip_temp(tz, count, &trip_temp)) {
>  			set_bit(count, &tz->trips_disabled);
> +			continue;
> +		}
>  		/* Check for bogus trip points */
>  		if (trip_temp == 0)
>  			set_bit(count, &tz->trips_disabled);


What about ?

	if (tz->ops->get_trip_type(tz, count, &trip_type) ||
		tz->ops->get_trip_temp(tz, count, &trip_temp) ||
		!trip_temp)
		set_bit(count, &tz->trips_disabled);




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
