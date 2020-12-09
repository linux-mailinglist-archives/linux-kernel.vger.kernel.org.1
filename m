Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7EB2D4585
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgLIPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgLIPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:35:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0773BC061794
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 07:34:59 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so2228516wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uZgB0leTvg1UsktdCSGjVr/1XPMUvecMHEZ3uvN+Jrs=;
        b=F1tBk6wprLcmk00DtZQ6R59rv3L46LFPHO/2ciwFjtLCuYm5PJP0BjZN4ZOJbYJgfk
         H+jHuOwBy7yYnV/eHCtyHzb5MNgnKRgRypI7xtZw7QyBVbpKHa3/v/cEneGshwiT4ORO
         jiwS1ZCM+oriLm2b/XBhvEd5T9UeaPSUYY3Sl8UpbziFCxn7v4vWvfG8he27OrfNlrX+
         cm3Ow40123cgL/PEMHbD1hTWhHs1BdQHdjX9eVmJ/Aa7MKFTvQHMpP9V4konws4JGJ56
         oZASkqVYSa1HrFWDsawVvObROGi7fH+VBAVuuDAgruicHOBx3gfcuVrP4KMSLxXH9v7N
         MCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uZgB0leTvg1UsktdCSGjVr/1XPMUvecMHEZ3uvN+Jrs=;
        b=MUxQFjj1QhiVveLA5raChhf7VCMvfmCLkFSvnSp2bj8lRVyzCPzHcRfZHwJg4M3kH0
         E4hcz12HI9/X2tWtpBM/XdR7ZAuQDb/ibJ+DNpybhKExwV3mRfUjrDAdxNqCKS+90cUu
         D+Tm1Kml7JLZc94Lo5UPX4DKA5R08vwMU/yaeroUIdtB6HQ93Hfm0y97/ZxWo2SgLrAe
         rZeXOw6dA0QvLXuu/wK8nUlyk0os7YyXyzLIXT202XEu2UG+dntQ3LXNN4f3gNv9As6h
         nNW329gRQSx24YWuvLfOXRxiri/Jn3n5bV8g/pa+iqzd7CCaatjDFYWT8fDHrmPsslUK
         rb2g==
X-Gm-Message-State: AOAM533MqEs1q7OVC2bP0eSj9QJf6Yz6CyvsjloqND11A0+8xvLNMOTD
        wyFCmPnD6Ho3JgukPfM53ndjtw==
X-Google-Smtp-Source: ABdhPJwts5nMbUNGzsJ4nNFs5CfRAK9GZpqy5qdJinoGxWkaHiPg4d2b8UZAC1Puq1n0+v0elCrLoQ==
X-Received: by 2002:adf:dd04:: with SMTP id a4mr3364031wrm.77.1607528097603;
        Wed, 09 Dec 2020 07:34:57 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id l8sm4208382wmf.35.2020.12.09.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:34:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, srinivas.pandruvada@linux.intel.com,
        kai.heng.feng@canonical.com
Subject: [PATCH RFC 2/4] thermal/core: Add critical and hot ops
Date:   Wed,  9 Dec 2020 16:34:38 +0100
Message-Id: <20201209153440.27643-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209153440.27643-1-daniel.lezcano@linaro.org>
References: <20201209153440.27643-1-daniel.lezcano@linaro.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 42 +++++++++++++++++++++-------------
 include/linux/thermal.h        |  3 +++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index afc02e7d1045..0366f3f076cc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -375,6 +375,24 @@ static void thermal_emergency_poweroff(void)
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
+
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  int trip, enum thermal_trip_type trip_type)
 {
@@ -391,22 +409,10 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
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
@@ -1331,6 +1337,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
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

