Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D164A2D5A50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgLJMSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733267AbgLJMQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:16:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BDC0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:15:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r14so5245063wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sIEMz7Oh+NWa+Qwh/WPljIwoa+Kn6l6xd1Uhgr069Qo=;
        b=h+9IWBD0VCOj0c+WRowkqukSHO6NNcODBxCwwcCLw+o947GXqI8T58UrtbqQDr69tj
         eX1ApUWPCVwnah1uWIVdb0RpPROdeLKUw9j9++JB1YjkKDWfcjD7Fvv1d1FCnmvmHZx1
         MH7WI6Qfmg1Gc1RRntSDA6yqyzOPJPlqZN9Mq3fsFH0K2USK3SXrCadcxTl7NuNvcQWn
         KJRWmAhAaZJm0paD6PzpuVUDEKTyNecD/Rm01g6GrjBln2Ik2AAelJHyg8SHXau4XrGr
         fpN1lz8PWdWSG91Qy3o1lgkA8tV3mAdTkQy6WlRlE0j1TVcZmNgcxCpMzeOQVNYaq8wK
         11tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sIEMz7Oh+NWa+Qwh/WPljIwoa+Kn6l6xd1Uhgr069Qo=;
        b=ArK6GOBhXF8HjPndA2cNsQMSqrzmXFBLGoXxq+5f60XwSD2ol4x2eAhsSBoKf34624
         i1p9HzKTbH0mzb2WNiplb2CIXOEvRkYBy9dgMSUfwBjYC9eHKKyD2p17DzfAWsAMq3xJ
         NbFnrtrHm68DwpVQLm6dGDi2yf6dh7VWTdQY6oMjE8SbkAcxn6z0k8bFPXfvV7rqr/J1
         tEAUDGvf0gcMpr4QRwvxBt6rTiXd+4Vp/KiWVxqvLdhjiMMk//y8DKpOrE9GbQ2uptc5
         0h1+UqfFvTBfxa+ub+oJZD68+MVpww4lhWfgTwT/49cNiMuKUgzis1PiEe2JZZEANoU+
         hsww==
X-Gm-Message-State: AOAM532PdefVt7kkl1CwUD43qRWN8cYWZIHDZkI+7sT7ug9z8HOd9J8U
        +NTP64Tv5zxExUL4/6ezJ2bvMw==
X-Google-Smtp-Source: ABdhPJx0WaDdMpfnpvxatzMJXBDciCscYAyVwr57xOGT7nVe0Cs/Dw/N00So+OJ7Od9bg1EY7RHzAg==
X-Received: by 2002:a5d:4209:: with SMTP id n9mr7787886wrq.128.1607602524017;
        Thu, 10 Dec 2020 04:15:24 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id k6sm8412863wmf.25.2020.12.10.04.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:15:23 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, lukasz.luba@arm.com,
        srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 2/5] thermal/core: Add critical and hot ops
Date:   Thu, 10 Dec 2020 13:15:11 +0100
Message-Id: <20201210121514.25760-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210121514.25760-1-daniel.lezcano@linaro.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no way to the sensors to directly call an ops in
interrupt mode without calling thermal_zone_device_update assuming all
the trip points are defined.

A sensor may want to do something special if a trip point is hot or
critical.

This patch adds the critical and hot ops to the thermal zone device,
so a sensor can directly invoke them or let the thermal framework to
call the sensor specific ones.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 43 +++++++++++++++++++++-------------
 include/linux/thermal.h        |  3 +++
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e6771e5aeedb..cee0b31b5cd7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -375,6 +375,25 @@ static void thermal_emergency_poweroff(void)
 			      msecs_to_jiffies(poweroff_delay_ms));
 }
 
+void thermal_zone_device_critical(struct thermal_zone_device *tz)
+{
+	dev_emerg(&tz->device, "%s: critical temperature reached, "
+		  "shutting down\n", tz->type);
+
+	mutex_lock(&poweroff_lock);
+	if (!power_off_triggered) {
+		/*
+		 * Queue a backup emergency shutdown in the event of
+		 * orderly_poweroff failure
+		 */
+		thermal_emergency_poweroff();
+		orderly_poweroff(true);
+		power_off_triggered = true;
+	}
+	mutex_unlock(&poweroff_lock);
+}
+EXPORT_SYMBOL(thermal_zone_device_critical);
+
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  int trip, enum thermal_trip_type trip_type)
 {
@@ -391,22 +410,10 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	if (tz->ops->notify)
 		tz->ops->notify(tz, trip, trip_type);
 
-	if (trip_type == THERMAL_TRIP_CRITICAL) {
-		dev_emerg(&tz->device,
-			  "critical temperature reached (%d C), shutting down\n",
-			  tz->temperature / 1000);
-		mutex_lock(&poweroff_lock);
-		if (!power_off_triggered) {
-			/*
-			 * Queue a backup emergency shutdown in the event of
-			 * orderly_poweroff failure
-			 */
-			thermal_emergency_poweroff();
-			orderly_poweroff(true);
-			power_off_triggered = true;
-		}
-		mutex_unlock(&poweroff_lock);
-	}
+	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
+		tz->ops->hot(tz);
+	else if (trip_type == THERMAL_TRIP_CRITICAL)
+		tz->ops->critical(tz);
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
@@ -1331,6 +1338,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	tz->id = id;
 	strlcpy(tz->type, type, sizeof(tz->type));
+
+	if (!ops->critical)
+		ops->critical = thermal_zone_device_critical;
+
 	tz->ops = ops;
 	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f23a388ded15..125c8a4d52e6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -79,6 +79,8 @@ struct thermal_zone_device_ops {
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
+	void (*hot)(struct thermal_zone_device *);
+	void (*critical)(struct thermal_zone_device *);
 };
 
 struct thermal_cooling_device_ops {
@@ -399,6 +401,7 @@ void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
+void thermal_zone_device_critical(struct thermal_zone_device *tz);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
-- 
2.17.1

