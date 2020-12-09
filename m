Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7532D4584
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgLIPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbgLIPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:35:40 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71867C06179C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 07:35:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r14so2220520wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 07:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yGhkI0Nvl2v1YOr6xjZSuObttiQ410GAIRH2LwhmlJc=;
        b=HIV7WPtc6ODm6QVuYGg+4MlniUYOUmab4M0+KgvZTziefWPzKbXetKC6+2XxCh/QvQ
         yFFp9VMJskrFNXe9up7lz2BfTZBEFYIERLOPdASA4UmOnKc0A5GNTUeIyvINYia65JwX
         Arwx3Yw7nHDTwELwR6HndyRfHZgHrxTBDWrTgXXlxshFmzCgU6qRdiePdIMJgpVvXRY/
         PXRs7AIaJc1z4PV+2GQmLrr/++ZMZnoYqG3mO+lsvOSM+0N1x7kiuMpoa5HB9o4XzdrB
         clLbxNpZ6XGOAkwdJwnrqpPcWvVXb6q/tGhBSwLoNhjVt7OrMy95bCc9xMryxswNsUQr
         /ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yGhkI0Nvl2v1YOr6xjZSuObttiQ410GAIRH2LwhmlJc=;
        b=lWqxFzdI9bberCWKpG193CZeNSEdgz48buSXV7wvF0OSzNbcWrZsjqH32HFrkfWRCI
         NbBjwDcgkMM/DdZ7BNAnkn95//8SVJKyfPxrbVXSS1Hbf/kQNFCwIelYSQtUBcLfuNWY
         8c1dNpbeHu7Zl5pQMJfjz7ajuI6HBZv/wE/vuJcFe7dfJ0QZNoVWWhUna+jzaO2Ul+8x
         caGTS3JJ8yCK/uWB6uQHmeXkKwypFj0kMBXzY/Zt3Zv52g/as6jrzEbxlzYc8hxMAT9w
         BVmQyFTQc+Dl/Xukg0bgd6TKAxqsZowhc9R2zjC+byYhG7PM/bPQRGb6d4uWUV4aIupi
         wL8w==
X-Gm-Message-State: AOAM530NwuqJ/+JfG8nm8Q3JE2stCJ6wKAiCVQX0Ar/dRhynyvO0Kne1
        vUynpJ9saiMQcgrFpwYXwRdxew==
X-Google-Smtp-Source: ABdhPJz6gU5xD/gRysIsVm+tHKwkF8lM/5eMp/A7FEeiUsG2WSS7WGfZbSTg6zJL78GM440gEGkUqA==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr3351145wrw.157.1607528099091;
        Wed, 09 Dec 2020 07:34:59 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id l8sm4208382wmf.35.2020.12.09.07.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:34:58 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, srinivas.pandruvada@linux.intel.com,
        kai.heng.feng@canonical.com
Subject: [PATCH RFC 3/4] thermal/drivers/acpi: Use hot and critical ops
Date:   Wed,  9 Dec 2020 16:34:39 +0100
Message-Id: <20201209153440.27643-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209153440.27643-1-daniel.lezcano@linaro.org>
References: <20201209153440.27643-1-daniel.lezcano@linaro.org>
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

