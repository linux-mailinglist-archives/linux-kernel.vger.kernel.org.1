Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5C2D5A30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgLJMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgLJMQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:16:20 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367ACC061285
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:15:27 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t16so5245561wra.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yGhkI0Nvl2v1YOr6xjZSuObttiQ410GAIRH2LwhmlJc=;
        b=ZMSbcIK2yxYS9l9B2GzHVfejc6B3rHRV5UJ8q7VdYPEqRXff2fFPPNksU5fw71fG+N
         8SxBatY1FqP9r6q5mokjvTVNEIwohT1PByGJvTI+G4zF0+2HSXRdY0OvzSqzTqx9SzpJ
         qa7VGWE6IrLf01CFNxpX3TxHAUPjm/+l4ZJFpe5N7g147LMQw1O5VvhB8aEBl5mMZVx+
         /utICSCyTaGdxzTCb2V9uuc1QtwKd79tR0FZgqtXwccqAmpb7Qx/hwlXD0/0DUEoqagH
         5w9fGIncchXp+PQgeoXk5QaDKIbk8P7fojCg8mIS2Djb3DyBCvXQ0MPETTUi2jBZvrcs
         JMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yGhkI0Nvl2v1YOr6xjZSuObttiQ410GAIRH2LwhmlJc=;
        b=odU7hrfqa9siqhICA7DyutxuRfDBZZZ0CBSGV0vVHhsi9V9kmflef6/BTqIGFRhHTD
         JEHUsagGHu3w8kFlxu1wOI42jScPTSlWUkLb/j6Hbaywds/AyuVW4lzA9ZQQy2mfiqMx
         bwLfaIEdhF4x2jsaALBk4ACjmFAzjTZejurGEq+w1wD7gngOU+Lsf0yOi+fDV2Pcdb3m
         8oNKR/8ZUGcVmCLgWqLqBZtHQXhrtLJ+bxwloKfUZzZPkSdimKazA72QD4rDzdOc3K2A
         N/V1O3CnFdLcMHFmYV0AO8/IJzzqVEQP1BBoKFV2vp7bi41OA1ZX7r+6ubE3CkgW1A+X
         cMZA==
X-Gm-Message-State: AOAM533DnfQQ1KWZRRiskj8h3m5coEEj+1dAkxuaeYqq+g0nxS/6vzki
        mdDmI0iKkc713BE4eKek2Gys9w==
X-Google-Smtp-Source: ABdhPJzC6fHz0zlOfRNX6yvMC9xfzXa3iLgr9OQlhLhSpdGtJ9K+/7DPtUdbQsYL+We2Zv1Kh+3FBA==
X-Received: by 2002:a5d:5105:: with SMTP id s5mr7684847wrt.136.1607602525876;
        Thu, 10 Dec 2020 04:15:25 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id k6sm8412863wmf.25.2020.12.10.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:15:25 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, lukasz.luba@arm.com,
        srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER)
Subject: [PATCH 3/5] thermal/drivers/acpi: Use hot and critical ops
Date:   Thu, 10 Dec 2020 13:15:12 +0100
Message-Id: <20201210121514.25760-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210121514.25760-1-daniel.lezcano@linaro.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi driver wants to do a netlink notification in case of a hot or
critical trip point. Implement the corresponding ops to be used for
the thermal zone and use them instead of the notify ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 12c0ece746f0..b5e4bc9e3282 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -677,27 +677,24 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-
-static int thermal_notify(struct thermal_zone_device *thermal, int trip,
-			   enum thermal_trip_type trip_type)
+static void acpi_thermal_zone_device_hot(struct thermal_zone_device *thermal)
 {
-	u8 type = 0;
 	struct acpi_thermal *tz = thermal->devdata;
 
-	if (trip_type == THERMAL_TRIP_CRITICAL)
-		type = ACPI_THERMAL_NOTIFY_CRITICAL;
-	else if (trip_type == THERMAL_TRIP_HOT)
-		type = ACPI_THERMAL_NOTIFY_HOT;
-	else
-		return 0;
-
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
-					dev_name(&tz->device->dev), type, 1);
+					dev_name(&tz->device->dev),
+					ACPI_THERMAL_NOTIFY_HOT, 1);
+}
 
-	if (trip_type == THERMAL_TRIP_CRITICAL && nocrt)
-		return 1;
+static void acpi_thermal_zone_device_critical(struct thermal_zone_device *thermal)
+{
+	struct acpi_thermal *tz = thermal->devdata;
 
-	return 0;
+	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
+					dev_name(&tz->device->dev),
+					ACPI_THERMAL_NOTIFY_CRITICAL, 1);
+
+	thermal_zone_device_critical(thermal);
 }
 
 static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
@@ -812,7 +809,8 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.get_trip_temp = thermal_get_trip_temp,
 	.get_crit_temp = thermal_get_crit_temp,
 	.get_trend = thermal_get_trend,
-	.notify = thermal_notify,
+	.hot = acpi_thermal_zone_device_hot,
+	.critical = acpi_thermal_zone_device_critical,
 };
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
-- 
2.17.1

