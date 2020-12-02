Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D02CBC71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgLBMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgLBMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:08:39 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED24C061A4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so3568850wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KfWzWNO1cYwi4Mxtl+r98rc1kSAeUgl37X9y9wjblMk=;
        b=ZLYPHgLO5O71tb8yepC2YgPKRYZSYSjZE+fjbYze84gYnOSJT2b5CQQYg6VH/AxEGZ
         cWHv8dGtIE7CC2+pKVT9BqMRvLiqhhJC24o1Gh43OZG/D1AvFUc6jYH39PxY43KbQwP9
         boyXvsibBPINYL9mD2TBx4chRP3Bou38ru1S2nDnLNFz8x3pcU9fU1WBRYDRyvWAnVqN
         bhsYfCnrYCaVyCInBmjie/WLFLyXC9MmON8Ao7q364BbjhXobJpG+5fSIxmEQTaVwoM9
         ShW6CcIjtYPU7Qgw1g3hv+x1VtvVKG6qmxCkrPwiROq7Ba/BrK5WFcNP6dBAuwQlBJLU
         IeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KfWzWNO1cYwi4Mxtl+r98rc1kSAeUgl37X9y9wjblMk=;
        b=dqdnq8Jqc3Eb9JCSlPpSbbCV4WXzwSMzUjqXyEFwd8xICNV1sJvd3GwRIdzIoYqzBm
         Np8TYwIZVLvfQW8Ry+YwvSairYBP1dkDZ8Lftg8pNGBwSf9/+fmTwrFOPgZYLxw3SfbX
         8VGezLxLafk4x2JTo6Oo06UksDQ5cCZs/cSdfuVyOvzqi9L3i8f6CNr3hcBU/xKP2Kdb
         qwaWUplSFJvDTxcvZ6FtH9NK5Apo6ViflC+vxAFoAgvlBET1jdqCE6aC/rTDgTU5CyYO
         dmoKHFS1Ns6fEwIpcc1Lsm/HnqveeqGy8/SHoLFqnI2uLeDqmXCTHLcneHSTo8vP3Q1Q
         I5JQ==
X-Gm-Message-State: AOAM5329tNC+1Rt4cIMvXNLOdRmjRw2btvKHPwAjJPhrTUM+ntgMlYWk
        pzR0Rd5/jHT34jqp0438wyyIHg==
X-Google-Smtp-Source: ABdhPJz7giszMZVL+Yi+OTAotH7TKAvAwMIsuAd2yQXIzPX7xkQsA8YkzHgf2hSL4ww4wyeagQ+pEQ==
X-Received: by 2002:adf:dec8:: with SMTP id i8mr3019340wrn.86.1606910840802;
        Wed, 02 Dec 2020 04:07:20 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-140-184.adsl.proxad.net. [82.252.140.184])
        by smtp.gmail.com with ESMTPSA id c1sm1755132wml.8.2020.12.02.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 4/4] thermal/core: Remove ms based delay fields
Date:   Wed,  2 Dec 2020 13:06:57 +0100
Message-Id: <20201202120657.1969-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202120657.1969-1-daniel.lezcano@linaro.org>
References: <20201202120657.1969-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code does no longer use the ms unit based fields to set the
delays as they are replaced by the jiffies.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h  | 2 --
 drivers/thermal/thermal_sysfs.c | 2 +-
 include/linux/thermal.h         | 7 -------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 2c9551ed5ef8..5baa308ee7a5 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -131,7 +131,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz);
 static inline void thermal_zone_set_passive_delay(
 	struct thermal_zone_device *tz, int delay_ms)
 {
-	tz->passive_delay_ms = delay_ms;
 	tz->passive_delay_jiffies = msecs_to_jiffies(delay_ms);
 	if (delay_ms > 1000)
 		tz->passive_delay_jiffies = round_jiffies(tz->passive_delay_jiffies);
@@ -140,7 +139,6 @@ static inline void thermal_zone_set_passive_delay(
 static inline void thermal_zone_set_polling_delay(
 	struct thermal_zone_device *tz, int delay_ms)
 {
-	tz->polling_delay_ms = delay_ms;
 	tz->polling_delay_jiffies = msecs_to_jiffies(delay_ms);
 	if (delay_ms > 1000)
 		tz->polling_delay_jiffies = round_jiffies(tz->polling_delay_jiffies);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 9598b288a0a1..8532b1dd0608 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -233,7 +233,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (state && !tz->forced_passive) {
-		if (!tz->passive_delay_ms)
+		if (!tz->passive_delay_jiffies)
 			thermal_zone_set_passive_delay(tz, 1000);
 		thermal_zone_device_rebind_exception(tz, "Processor",
 						     sizeof("Processor"));
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5dd9bdb6c6ad..f23a388ded15 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -116,13 +116,8 @@ struct thermal_cooling_device {
  * @devdata:	private pointer for device private data
  * @trips:	number of trip points the thermal zone supports
  * @trips_disabled;	bitmap for disabled trips
- * @passive_delay_ms:	number of milliseconds to wait between polls when
- *			performing passive cooling.
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
- * @polling_delay_ms:	number of milliseconds to wait between polls when
- *			checking whether trip points have been crossed (0 for
- *			interrupt driven systems)
  * @polling_delay_jiffies: number of jiffies to wait between polls when
  *			checking whether trip points have been crossed (0 for
  *			interrupt driven systems)
@@ -164,8 +159,6 @@ struct thermal_zone_device {
 	void *devdata;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
-	int passive_delay_ms;
-	int polling_delay_ms;
 	int passive_delay_jiffies;
 	int polling_delay_jiffies;
 	int temperature;
-- 
2.17.1

