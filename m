Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCE2C4549
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgKYQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbgKYQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:32:53 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A86C0613D4;
        Wed, 25 Nov 2020 08:32:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y7so2802716pfq.11;
        Wed, 25 Nov 2020 08:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=6fLXoA7PiZQVIkhM/9E4bl7cs888uadju3YY2CeMd0A=;
        b=CZNpdfGRkiqMC8e51Csl4YelMAnjpLkWVSSLMCBTlPwzKE2z+5payHxO3MeT9WJkYR
         n6LSaJ/aBQ0gVPaJaI+yxRku+VBPP3eCKmLjs+spPMCAoU+SoiJTKd6+x/uCYvGWRmhm
         ECF1UxLQ7SsTPmd6DFPN+s3mU7T1BoUxfbtURXTzr3a19Ig/6tLxs6Mx0xxkYk9weLXU
         LLmvUEklvxhAkmfeorhE5c8lQrE74MhsicJKxroRdAODjaGlASjzhLxG4u1J+IwFrSZa
         vn+06JJDkYkarRJIdWmZZACw7pqfB6T6B2AUlZwDDBsPtQehhamMk8LmKS6lKEuod3ic
         V2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=6fLXoA7PiZQVIkhM/9E4bl7cs888uadju3YY2CeMd0A=;
        b=fm89dUb7kCvlo0jFFStmKpz4GW+R3KBDdQj4z4aqaPT7VFkf0BW0K/INjmIMvnN2NW
         nrq103lN41By9lRze30jNk42sZlSDFEodqovqnASS4iuRa53V7htijlSiWijxUc9tdDm
         jH8DxzH4Cog5ItOXcch00kYXGKqk3GPUa0Pp+uUnMXQ9sDEbaomGekyPNMvW+Gh7v5lm
         gk/CG+Sw1xMxmG/sgh3G77ukKwrKlav5ODV9++llHHmYB+1tAsrHAi+AcfTD5twFKb0C
         0EOonO/T2h/AseKDP9WoOvnEIEtO2LhwkpcJ0GKD+sIn3jk1wZDCEK4LSxANaHHdKTTS
         0Z2g==
X-Gm-Message-State: AOAM533pjQxk5YLB3EL7QX8f5MQfMGhkBgmKmGe2OFHtQuKwAN9emCPK
        y9SV5GO9T2LN2ClZJhv+nXs=
X-Google-Smtp-Source: ABdhPJyWrphxD+wQM8UWkGfwLi4rstYwkvd0Vgk1p55hHG3yEST4I/TkHq4Z6u6ysSe/2upnfABZxQ==
X-Received: by 2002:a17:90a:5d93:: with SMTP id t19mr5057545pji.220.1606321972544;
        Wed, 25 Nov 2020 08:32:52 -0800 (PST)
Received: from paju ([116.124.119.85])
        by smtp.gmail.com with ESMTPSA id y1sm2369925pfe.80.2020.11.25.08.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:32:51 -0800 (PST)
Date:   Thu, 26 Nov 2020 01:32:42 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (pwm-fan) add fan pwm1_enable attribute
Message-ID: <20201125163242.GA1264232@paju>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds to new attribute 'pwm1_enable' to change the fan speed
control method as documented in 'Documentation/hwmon/sysfs-interface'.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 drivers/hwmon/pwm-fan.c | 52 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 1f63807c0399..834275309421 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -39,6 +39,7 @@ struct pwm_fan_ctx {
 	unsigned int pwm_fan_max_state;
 	unsigned int *pwm_fan_cooling_levels;
 	struct thermal_cooling_device *cdev;
+	int enable;
 };
 
 /* This handler assumes self resetting edge triggered interrupt. */
@@ -76,6 +77,10 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	struct pwm_state state = { };
 
 	mutex_lock(&ctx->lock);
+
+	if (ctx->enable == 0)
+		pwm = MAX_PWM;
+
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
@@ -137,11 +142,42 @@ static ssize_t rpm_show(struct device *dev,
 	return sprintf(buf, "%u\n", ctx->rpm);
 }
 
+static ssize_t enable_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	int err;
+	unsigned long val;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	mutex_lock(&ctx->lock);
+	ctx->enable = val;
+	mutex_unlock(&ctx->lock);
+
+	err = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[ctx->pwm_fan_state]);
+
+	return err ? err : count;
+}
+
+static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", ctx->enable);
+}
+
 static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, enable, 0);
 static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
 
 static struct attribute *pwm_fan_attrs[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	NULL,
 };
@@ -153,7 +189,7 @@ static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 
 	/* Hide fan_input in case no interrupt is available  */
-	if (n == 1 && ctx->irq <= 0)
+	if (n == 2 && ctx->irq <= 0)
 		return 0;
 
 	return a->mode;
@@ -200,7 +236,7 @@ static int
 pwm_fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
 {
 	struct pwm_fan_ctx *ctx = cdev->devdata;
-	int ret;
+	int ret = 0;
 
 	if (!ctx || (state > ctx->pwm_fan_max_state))
 		return -EINVAL;
@@ -208,10 +244,12 @@ pwm_fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
 	if (state == ctx->pwm_fan_state)
 		return 0;
 
-	ret = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
-	if (ret) {
-		dev_err(&cdev->device, "Cannot set pwm!\n");
-		return ret;
+	if (ctx->enable >= 2) {
+		ret = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
+		if (ret) {
+			dev_err(&cdev->device, "Cannot set pwm!\n");
+			return ret;
+		}
 	}
 
 	ctx->pwm_fan_state = state;
@@ -298,6 +336,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	if (IS_ERR(ctx->pwm))
 		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
 
+	ctx->enable = 2;
+
 	platform_set_drvdata(pdev, ctx);
 
 	ctx->irq = platform_get_irq_optional(pdev, 0);
-- 
2.25.1

