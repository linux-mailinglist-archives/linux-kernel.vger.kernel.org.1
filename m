Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0072D5729
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbgLJJ3w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 04:29:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56094 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730489AbgLJJ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:29:43 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1knIFw-0001tp-QW
        for linux-kernel@vger.kernel.org; Thu, 10 Dec 2020 09:29:01 +0000
Received: by mail-pl1-f200.google.com with SMTP id e11so2788256pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M4AKft2S+SsZA0dV0n1eON2x/Jx1VJF3/6c+QWVatHU=;
        b=g2yI/m8Umk/7zQyeNk5NMdITMo8UByOpfVDS9+tPIj2Up2lac8P2o5J9iiXEylZ9bv
         I+a1Zx5lqnwuPKin3NZUp8sTFZXki1fd1PfKWWLyyNacxFjzvqPpvEczgZGiKeX4hEDL
         SmykjkgiW3Ftq8ZOIBdgYxzhhliwpLy0MhpzZAsDejc/O4RVb93ola/JZ+0q+wGh/sWW
         xZh1x2guUmTSPx5pO+JsCPwU1m/Asde4EeDBMAvl23s0GeY29D0XDmM46DdPLqKqRZik
         V1ZQA3egjpUue8Ic2XQ6y1+kk5OVmgCTxX+X9RrjJ8cMFaFvGgYhBbo7Emx4CTW1m9ci
         TPNQ==
X-Gm-Message-State: AOAM532mKsa8WaVivvi/OW9DNkAZMHiaY2U9CtqTTAFsaapaSau4ESVg
        lKQpdjgoGwwws8q1auaSgVDBOIc/16ZDuHN3u5rK9mda51I63R5ZN3E/dsmlK6bYYWnzVgsyS62
        23VWNPAOTcsz5wo/jGTupORuEcw6g6DzMoZsks1uOUw==
X-Received: by 2002:a17:902:70cc:b029:da:ccb4:c266 with SMTP id l12-20020a17090270ccb02900daccb4c266mr5577198plt.37.1607592539123;
        Thu, 10 Dec 2020 01:28:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLSM4AeE0f27MvDqVCZ7beS1aT45Dw4IvV085QBea4pOvoaRm6m+gUPIiGhCxpcNdGO2N6ZQ==
X-Received: by 2002:a17:902:70cc:b029:da:ccb4:c266 with SMTP id l12-20020a17090270ccb02900daccb4c266mr5577176plt.37.1607592538760;
        Thu, 10 Dec 2020 01:28:58 -0800 (PST)
Received: from [192.168.1.104] (36-229-231-79.dynamic-ip.hinet.net. [36.229.231.79])
        by smtp.gmail.com with ESMTPSA id n10sm5286372pge.92.2020.12.10.01.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 01:28:57 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH RFC 2/4] thermal/core: Add critical and hot ops
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201209153440.27643-2-daniel.lezcano@linaro.org>
Date:   Thu, 10 Dec 2020 17:28:54 +0800
Cc:     Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        lukasz.luba@arm.com, srinivas.pandruvada@linux.intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <0451A304-AD94-470E-9269-92F9209C8EC7@canonical.com>
References: <20201209153440.27643-1-daniel.lezcano@linaro.org>
 <20201209153440.27643-2-daniel.lezcano@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 9, 2020, at 23:34, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
> Currently there is no way to the sensors to directly call an ops in
> interrupt mode without calling thermal_zone_device_update assuming all
> the trip points are defined.
> 
> A sensor may want to do something special if a trip point is hot or
> critical.
> 
> This patch adds the critical and hot ops to the thermal zone device,
> so a sensor can directly invoke them or let the thermal framework to
> call the sensor specific ones.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks. This can solve my issue once .critical callbacks are added in thermal drivers.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
> drivers/thermal/thermal_core.c | 42 +++++++++++++++++++++-------------
> include/linux/thermal.h        |  3 +++
> 2 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index afc02e7d1045..0366f3f076cc 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -375,6 +375,24 @@ static void thermal_emergency_poweroff(void)
> 			      msecs_to_jiffies(poweroff_delay_ms));
> }
> 
> +void thermal_zone_device_critical(struct thermal_zone_device *tz)
> +{
> +	dev_emerg(&tz->device, "%s: critical temperature reached, "
> +		  "shutting down\n", tz->type);
> +
> +	mutex_lock(&poweroff_lock);
> +	if (!power_off_triggered) {
> +		/*
> +		 * Queue a backup emergency shutdown in the event of
> +		 * orderly_poweroff failure
> +		 */
> +		thermal_emergency_poweroff();
> +		orderly_poweroff(true);
> +		power_off_triggered = true;
> +	}
> +	mutex_unlock(&poweroff_lock);
> +}
> +
> static void handle_critical_trips(struct thermal_zone_device *tz,
> 				  int trip, enum thermal_trip_type trip_type)
> {
> @@ -391,22 +409,10 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
> 	if (tz->ops->notify)
> 		tz->ops->notify(tz, trip, trip_type);
> 
> -	if (trip_type == THERMAL_TRIP_CRITICAL) {
> -		dev_emerg(&tz->device,
> -			  "critical temperature reached (%d C), shutting down\n",
> -			  tz->temperature / 1000);
> -		mutex_lock(&poweroff_lock);
> -		if (!power_off_triggered) {
> -			/*
> -			 * Queue a backup emergency shutdown in the event of
> -			 * orderly_poweroff failure
> -			 */
> -			thermal_emergency_poweroff();
> -			orderly_poweroff(true);
> -			power_off_triggered = true;
> -		}
> -		mutex_unlock(&poweroff_lock);
> -	}
> +	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
> +		tz->ops->hot(tz);
> +	else if (trip_type == THERMAL_TRIP_CRITICAL)
> +		tz->ops->critical(tz);
> }
> 
> static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
> @@ -1331,6 +1337,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> 
> 	tz->id = id;
> 	strlcpy(tz->type, type, sizeof(tz->type));
> +
> +	if (!ops->critical)
> +		ops->critical = thermal_zone_device_critical;
> +
> 	tz->ops = ops;
> 	tz->tzp = tzp;
> 	tz->device.class = &thermal_class;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f23a388ded15..125c8a4d52e6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -79,6 +79,8 @@ struct thermal_zone_device_ops {
> 			  enum thermal_trend *);
> 	int (*notify) (struct thermal_zone_device *, int,
> 		       enum thermal_trip_type);
> +	void (*hot)(struct thermal_zone_device *);
> +	void (*critical)(struct thermal_zone_device *);
> };
> 
> struct thermal_cooling_device_ops {
> @@ -399,6 +401,7 @@ void thermal_cdev_update(struct thermal_cooling_device *);
> void thermal_notify_framework(struct thermal_zone_device *, int);
> int thermal_zone_device_enable(struct thermal_zone_device *tz);
> int thermal_zone_device_disable(struct thermal_zone_device *tz);
> +void thermal_zone_device_critical(struct thermal_zone_device *tz);
> #else
> static inline struct thermal_zone_device *thermal_zone_device_register(
> 	const char *type, int trips, int mask, void *devdata,
> -- 
> 2.17.1
> 

