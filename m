Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE42C7DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 06:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgK3FrY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Nov 2020 00:47:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58980 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgK3FrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 00:47:23 -0500
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kjc1I-0003as-O0
        for linux-kernel@vger.kernel.org; Mon, 30 Nov 2020 05:46:40 +0000
Received: by mail-pf1-f199.google.com with SMTP id v2so8372712pfi.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 21:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BKGPhw+EzzzHx8qRqnFgmCvQjOVCgUNi4jVD8AIMth0=;
        b=T9eAH5HkIjKxOKcTAzy65lbDocE7hR7RKLc7RXoM0m+OvP6gLrDylCr13QNsaB+XzD
         6xtiqugvZ82MQjquFxcLKkiGWuqrWcfDm+Q1goN+RixjffVYAU+Eet6XxCbbhYuHHMdb
         gvBdgowpZafZcc1y8pWHFxDl6BomazJGjGEWgrzGceSuIconv0SAh9SnuO7M/ldUpEa3
         SMnk1a5L7k+ItRmbJ90IdBBVJyvNxFz1G1v8gJ7t6dbCzSU8uvY8byx0L3/VZrbsO3Yj
         7fUgQzPenoTyqfIJBsc4yfsr9D2VDxjgEHgMEJ6lSme1NX2xAwopgNltfCH92aH45Xet
         KwIA==
X-Gm-Message-State: AOAM530xSuwFwIDOy9CTXEllJBdVjwmOOa3iNq68cfJCK6S57pt5LbKJ
        X3G9IgwtYtC1s25Dnlw6cRKvJ3ZxKM05TbrKqPz7oiq2fXsLzqGtbWWY+j8TtLduGvYhKGLFgCh
        /m7dK3elrOM2r+beHXMP30G+PDDNnLFmykCeP/83uXQ==
X-Received: by 2002:a63:b1c:: with SMTP id 28mr16586092pgl.206.1606715199403;
        Sun, 29 Nov 2020 21:46:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg5NIcyYrJ9jWgdcEvWrAgu8o9y3VBAp3hRdFzXkQ55bFtIke7mRBw6rLQOByruXE3eeUypg==
X-Received: by 2002:a63:b1c:: with SMTP id 28mr16586075pgl.206.1606715199057;
        Sun, 29 Nov 2020 21:46:39 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a12sm587499pjm.44.2020.11.29.21.46.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 21:46:38 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 2/3] thermal: int340x: Indicate userspace usage
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <81f0532f85b4924bad463572fd778db36613d2a8.camel@linux.intel.com>
Date:   Mon, 30 Nov 2020 13:46:33 +0800
Cc:     Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        amitk@kernel.org, Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Matthew Garrett <mjg59@google.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <08596B12-A8C2-4E2A-8827-653B0885BC48@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
 <20201128175450.12456-2-kai.heng.feng@canonical.com>
 <81f0532f85b4924bad463572fd778db36613d2a8.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 30, 2020, at 13:29, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> On Sun, 2020-11-29 at 01:54 +0800, Kai-Heng Feng wrote:
>> The device isn't present under ACPI ThermalZone, and there's a
>> dedicated
>> userspace daemon for this thermal device.
>> 
>> Let thermal core know it shouldn't handle trips to avoid surprising
>> thermal shutdown.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 1 +
>> .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 +---
>> --
>> 2 files changed, 2 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
>> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
>> index 0966551cbaaa..2002bc96eb3c 100644
>> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
>> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
>> @@ -439,6 +439,7 @@ static struct thermal_zone_device_ops
>> int3400_thermal_ops = {
>> static struct thermal_zone_params int3400_thermal_params = {
>> 	.governor_name = "user_space",
>> 	.no_hwmon = true,
>> +	.userspace = true,
> I am copied on only this patch, so I don't know what is this attribute?
> I think it is new.

Ok. The first one doesn't seem to be sent out correctly.

Series resent.

> 
>> };
>> 
>> static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
>> diff --git
>> a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
>> b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
>> index 6e479deff76b..a103eb42ef2d 100644
>> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
>> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
>> @@ -208,6 +208,7 @@ EXPORT_SYMBOL_GPL(int340x_thermal_read_trips);
>> static struct thermal_zone_params int340x_thermal_params = {
>> 	.governor_name = "user_space",
>> 	.no_hwmon = true,
>> +	.userspace = true,
>> };
>> 
>> struct int34x_thermal_zone *int340x_thermal_zone_add(struct
>> acpi_device *adev,
>> @@ -259,14 +260,9 @@ struct int34x_thermal_zone
>> *int340x_thermal_zone_add(struct acpi_device *adev,
>> 		ret = PTR_ERR(int34x_thermal_zone->zone);
>> 		goto err_thermal_zone;
>> 	}
>> -	ret = thermal_zone_device_enable(int34x_thermal_zone->zone);
>> -	if (ret)
>> -		goto err_enable;
> 
> What is the effect of this?
> The INT340X zones don't need to poll for temperature. When HW notifies
> then user space gets notified via user space governor. Not sure if the
> not enabling break that path.

thermal_zone_device_disable()
  thermal_notify_tz_disable()
    thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p)

I think it doesn't affect user_space governor.

Kai-Heng

> 
> Thanks,
> Srinivas
> 
>> 
>> 	return int34x_thermal_zone;
>> 
>> -err_enable:
>> -	thermal_zone_device_unregister(int34x_thermal_zone->zone);
>> err_thermal_zone:
>> 	acpi_lpat_free_conversion_table(int34x_thermal_zone-
>>> lpat_table);
>> 	kfree(int34x_thermal_zone->aux_trips);

