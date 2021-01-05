Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DAD2EAF27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbhAEPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbhAEPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:45:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8A6C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 07:44:30 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a6so3418739wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u8B6Jcqsj2qQHBVOgCivAszp3Mr4Z2LIctYHDfeemKo=;
        b=rdkjlnzWp+2zOi5b7d3ppqU3lIZOJ5blen0fY3s5Lownn35zv1OY5oSXisTXNXbPyC
         Ah5BTaAA34KGKm3jno6izGQnj64gA8NV4bnBGGFhoxXY1cRienDsq01Ly1HW5H5v+TQx
         RWOPXFrWoVhDadJzet0FLMTTT4lZz790d5QI/C4J4dpDywH6AsGpYvxaqVY/qSlO/BPg
         ZsWCmKKl3DTc8YgbmzfK8jhQJyf6JzeXIk/ww02n/CzBftFPbXesLu8JnbSGmtitC9xf
         E+awFJNqK1Q5XoKUMT9yHEi6NGaQRncmPO1aB1pii/ZEpU2u3J2T0L7B86U71oVchq4x
         u48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u8B6Jcqsj2qQHBVOgCivAszp3Mr4Z2LIctYHDfeemKo=;
        b=ty1zWE2gIDKxVFAhH1ktKUWOWfXKQ0nW/ZGxCcyxTW4+NVZASxLZrudTPpPZ2K/tcG
         GIC7IMe+8XChdHmejCNSXX2hBZ1V/K9W2mgOfGyFH/QPhwOZO2V2FcY5wgpn/0KFZerz
         gDvSlDfm7080XP50yGfwVUbR+Uw994WEZVkpZpn0o2bMtqqlqRiaqgtoxINKF4qHlV2D
         y/JnT5srEEkFwUvydjBEG6htzf9dvFVBsULyeUclKglvHsIgqE/es9jA0pOOrV3+H9Xr
         WNYhsp4EmN1M87RLJr2IDHxqbSVWDBCmaH/o4+pm9C2b92CjSyVB76STgw4czDMNg+b6
         6Lwg==
X-Gm-Message-State: AOAM532gThTbxcWYSpsl/XEEqijpNTgDIodL+uNyMArf5z96pt4/RDDV
        k5lhnEiOwBLqXUwEy4aYC4VyTg==
X-Google-Smtp-Source: ABdhPJwPZdpUvNf4958mHWq+C7VzsGf8VpOVbdIf0IvglN6LK/TbWfdvoLZMv0Z1Xr0zlF0zVNQlLw==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr4128150wmj.154.1609861468726;
        Tue, 05 Jan 2021 07:44:28 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-152-224.adsl.proxad.net. [82.252.152.224])
        by smtp.googlemail.com with ESMTPSA id s6sm191847wro.79.2021.01.05.07.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:44:27 -0800 (PST)
Subject: Re: [PATCH 4/6] acpi/drivers/thermal: Remove TRIPS_NONE cooling
 device binding
To:     rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-4-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1de4868e-6229-ed33-f45a-7cd82d3ee48a@linaro.org>
Date:   Tue, 5 Jan 2021 16:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214233811.485669-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,


On 15/12/2020 00:38, Daniel Lezcano wrote:
> The loop is here to create default cooling device binding on the
> THERMAL_TRIPS_NONE number which is used to be the 'forced_passive'
> feature. However, we removed all code dealing with that in the thermal
> core, thus this binding does no longer make sense.
> 
> Remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Are you fine with this change?

Thanks

  -- Daniel

> ---
>  drivers/acpi/thermal.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index b5e4bc9e3282..26a89ff80a0e 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -764,25 +764,6 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>  		}
>  	}
>  
> -	for (i = 0; i < tz->devices.count; i++) {
> -		handle = tz->devices.handles[i];
> -		status = acpi_bus_get_device(handle, &dev);
> -		if (ACPI_SUCCESS(status) && (dev == device)) {
> -			if (bind)
> -				result = thermal_zone_bind_cooling_device
> -						(thermal, THERMAL_TRIPS_NONE,
> -						 cdev, THERMAL_NO_LIMIT,
> -						 THERMAL_NO_LIMIT,
> -						 THERMAL_WEIGHT_DEFAULT);
> -			else
> -				result = thermal_zone_unbind_cooling_device
> -						(thermal, THERMAL_TRIPS_NONE,
> -						 cdev);
> -			if (result)
> -				goto failed;
> -		}
> -	}
> -
>  failed:
>  	return result;
>  }
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
