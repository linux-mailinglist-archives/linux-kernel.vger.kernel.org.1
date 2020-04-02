Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2419C406
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbgDBO2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:28:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45360 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbgDBO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:28:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id t7so4413917wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cAqM51urPQH/KGVpDrDDGTX7A8RMdIYAdBQd4Qg1cUo=;
        b=cBHPzWrCl3S6nf81q0Gq80qpuL0WYm8VOVhXa7dVe0u034S7szfEBvG8AgEcEAO+Eb
         PYq6DO8mmAzef1Iynzre7r3KAnQ1pLKIEO5LtQxM6sB8DfXTrnL2PBgurc8UJuMXZQwf
         CQ6W6UvNpkWQ0kX6DLhZTTAnBVEnziY8tbivi2U4RskoEeWO99xYOjvbSC0EcVLaU+JS
         xaJ1554F6wFf4GtLknM7GMQ9+fqYceoCDqsBLKHkXsXErnTg5nkMEuV1Uxhklf9YeZ07
         VCFBBp28ceLCrZs0Du669LeHJ2ycol1OHXmhs3CV1usurSJUItt8Vz8n3fUTeRb8YYwF
         TfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cAqM51urPQH/KGVpDrDDGTX7A8RMdIYAdBQd4Qg1cUo=;
        b=uevb6QJYUHMD+pXCdeZc2E4bD43pYn7mdxPvTLagcX5f42g9qQCTwP2J2xWBFqsKt6
         Q+s7L0ogDH4Fx9AH4AkhbeIc5rrsRVfyBAeNXq+EyMlxrhgycdWgXm9aLgjt0fd0qXPi
         SHdk/1ANNjAv6FzNub10mnHiSSXjqKGes3ZVg5EErrgtV0Ov6oC/VP3QeEGiFPDexakJ
         sivQnBh/YEjDGWsDRvfC0ohVYJ1KiR34AKNdtlLJgOm2wCdQT/GYJYlHVtJrn1P9VI1Y
         0kqHarzQE9gRz03xIw1gc9IWOiAoVCB84oabzdFxubfmYQo1A84DMZDCC5FXMucS2IaA
         O5wQ==
X-Gm-Message-State: AGi0PuaLKIOrXoYVP/3oypVYmHAP1KV5ARhrutwZRud5bCtVHk3LRiay
        aeG2HXcnmUs+rKADk2M3Et+H/g==
X-Google-Smtp-Source: APiQypJrhkdppOAfeYwt75q3M1txyOfRNnUBV8CVefJWvgVCYiEw+yNbBcxAWxJNX2PQgP1DWn0BVg==
X-Received: by 2002:adf:ee12:: with SMTP id y18mr3637699wrn.289.1585837685916;
        Thu, 02 Apr 2020 07:28:05 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 4/9] thermal: Move trip point structure definition to private header
Date:   Thu,  2 Apr 2020 16:27:42 +0200
Message-Id: <20200402142747.8307-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct thermal_trip is only used by the thermal internals, it is
pointless to export the definition in the global header.

Move the structure to the thermal_core.h internal header.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 13 +++++++++++++
 include/linux/thermal.h        | 15 ---------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index f99551ce9838..d37de708c28a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -58,6 +58,19 @@ int power_actor_get_min_power(struct thermal_cooling_device *cdev,
 			      struct thermal_zone_device *tz, u32 *min_power);
 int power_actor_set_power(struct thermal_cooling_device *cdev,
 			  struct thermal_instance *ti, u32 power);
+/**
+ * struct thermal_trip - representation of a point in temperature domain
+ * @np: pointer to struct device_node that this trip point was created from
+ * @temperature: temperature value in miliCelsius
+ * @hysteresis: relative hysteresis in miliCelsius
+ * @type: trip point type
+ */
+struct thermal_trip {
+	struct device_node *np;
+	int temperature;
+	int hysteresis;
+	enum thermal_trip_type type;
+};
 
 /*
  * This structure is used to describe the behavior of
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e0279f7b43f4..7adbfe092281 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -332,21 +332,6 @@ struct thermal_zone_of_device_ops {
 	int (*set_trip_temp)(void *, int, int);
 };
 
-/**
- * struct thermal_trip - representation of a point in temperature domain
- * @np: pointer to struct device_node that this trip point was created from
- * @temperature: temperature value in miliCelsius
- * @hysteresis: relative hysteresis in miliCelsius
- * @type: trip point type
- */
-
-struct thermal_trip {
-	struct device_node *np;
-	int temperature;
-	int hysteresis;
-	enum thermal_trip_type type;
-};
-
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
 int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
-- 
2.17.1

