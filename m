Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD826CA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgIPTuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727293AbgIPTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600285662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiG3kc7gEhmO71MoPpGUZlQpCpSsiSWNhXMpznaW1Dg=;
        b=S2fwdOGFbbJgASh07yqWaIULrlwgWnTCZfzKuL+pH9AOQI7PkNfV0T9YqRBA8apbV6J8o0
        jfYPCfOCZo41C044Nos7Wz/Eag0/dYC5qrOuPTl3NP3M3M+/kUWuCtul6J8l+0/BBVLK32
        V5QGljU1C50flERgwi0ljf7BiyVttw4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-CAi6oWRYM-ildSvb7daoGg-1; Wed, 16 Sep 2020 15:47:40 -0400
X-MC-Unique: CAi6oWRYM-ildSvb7daoGg-1
Received: by mail-qt1-f198.google.com with SMTP id j35so7037733qtk.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HiG3kc7gEhmO71MoPpGUZlQpCpSsiSWNhXMpznaW1Dg=;
        b=BzH/klTErapOymUdu1TeXliEq+PHAWB7l9ZTP0okua682zn6ScGzb11HVFeDjri/iw
         Ner8ubX2zKJo5a3PBbh4RETaUeDXUtP3YRMdoKCTHnRA0mXddaM0zqYVFqC3VWKF2sqs
         RpKAeAXc1nWjG2HyRg3vRdBHW9GLNNhJV7CP4+PAyuIekN/1uxkj4gTim0fcoGo32kMe
         gaH/mw8OIO0castqSiFsrfZhPAfGlAyvsfdmNBMECo8bsT/OIpqklIeFxRKR8vDyc3rN
         KcK/lmU6OhH5IPXBaWxWcNxN9T4V4aFnnJd5Xeick9zjQygS3qGyqJ9+InI8UNAgT7Ug
         CG5g==
X-Gm-Message-State: AOAM533gKVI5Yt4j5pwWV/JYR1ZbFgqCGUBkMb5hIwyh4ohtpGYGVJwb
        6Oy29p0/Y8LjMOfwCWfd2qo4rL60Dujgc2FTg5JUJO4ws2Bft6B2UlEF26GNr6tz6HrcrOp7Ll3
        mWhpHOKv+oW1nQJBl5VVUZTau
X-Received: by 2002:a37:2715:: with SMTP id n21mr24993967qkn.401.1600285659856;
        Wed, 16 Sep 2020 12:47:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF4NFw/4NWNOZaig6vU4juipv+s4gA2fSrSNZS3Ijw1sEGKyDLrP+M4jHuvlRdFqDFcTb88w==
X-Received: by 2002:a37:2715:: with SMTP id n21mr24993944qkn.401.1600285659574;
        Wed, 16 Sep 2020 12:47:39 -0700 (PDT)
Received: from dev.jcline.org.com ([136.56.20.95])
        by smtp.gmail.com with ESMTPSA id g4sm18683447qth.30.2020.09.16.12.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:47:39 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH v2 1/2] drm/nouveau: return temperatures in temp_get() via parameter
Date:   Wed, 16 Sep 2020 15:47:10 -0400
Message-Id: <20200916194711.999602-2-jcline@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916194711.999602-1-jcline@redhat.com>
References: <20200812204952.1921587-1-jcline@redhat.com>
 <20200916194711.999602-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temp_get() function currently returns negative error numbers or a
temperature. However, the thermal sensors can (in theory) measure
negative temperatures. Some implementations of temp_get() correctly
clamp negative temperature readings to 0 so that users do not mistake
them for errors, but some, like gp100_temp_get(), do not.

Rather than relying on implementations remembering to clamp values,
dedicate the function return value to error codes and accept a pointer
to an integer where the temperature reading should be stored.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 .../drm/nouveau/include/nvkm/subdev/therm.h   |  2 +-
 drivers/gpu/drm/nouveau/nouveau_hwmon.c       | 12 ++++++------
 .../gpu/drm/nouveau/nvkm/subdev/therm/base.c  | 19 ++++++++++++++-----
 .../gpu/drm/nouveau/nvkm/subdev/therm/g84.c   | 11 ++++++-----
 .../gpu/drm/nouveau/nvkm/subdev/therm/gp100.c | 11 ++++++-----
 .../gpu/drm/nouveau/nvkm/subdev/therm/nv40.c  |  9 +++------
 .../gpu/drm/nouveau/nvkm/subdev/therm/nv50.c  |  9 +++------
 .../gpu/drm/nouveau/nvkm/subdev/therm/priv.h  | 17 +++++++++++++++--
 .../gpu/drm/nouveau/nvkm/subdev/therm/temp.c  | 12 ++++++++----
 9 files changed, 62 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
index 62c34f98c930..bfe9779216fc 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
@@ -99,7 +99,7 @@ struct nvkm_therm {
 	bool clkgating_enabled;
 };
 
-int nvkm_therm_temp_get(struct nvkm_therm *);
+int nvkm_therm_temp_get(struct nvkm_therm *therm, int *temp);
 int nvkm_therm_fan_sense(struct nvkm_therm *);
 int nvkm_therm_cstate(struct nvkm_therm *, int, int);
 void nvkm_therm_clkgate_init(struct nvkm_therm *,
diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index 1c3104d20571..aff6aa296678 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -325,7 +325,7 @@ nouveau_temp_is_visible(const void *data, u32 attr, int channel)
 	struct nouveau_drm *drm = nouveau_drm((struct drm_device *)data);
 	struct nvkm_therm *therm = nvxx_therm(&drm->client.device);
 
-	if (!therm || !therm->attr_get || nvkm_therm_temp_get(therm) < 0)
+	if (!therm || !therm->attr_get || nvkm_therm_temp_get(therm, NULL) < 0)
 		return 0;
 
 	switch (attr) {
@@ -419,7 +419,7 @@ nouveau_temp_read(struct device *dev, u32 attr, int channel, long *val)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct nouveau_drm *drm = nouveau_drm(drm_dev);
 	struct nvkm_therm *therm = nvxx_therm(&drm->client.device);
-	int ret;
+	int ret = 0, temp;
 
 	if (!therm || !therm->attr_get)
 		return -EOPNOTSUPP;
@@ -428,8 +428,8 @@ nouveau_temp_read(struct device *dev, u32 attr, int channel, long *val)
 	case hwmon_temp_input:
 		if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
 			return -EINVAL;
-		ret = nvkm_therm_temp_get(therm);
-		*val = ret < 0 ? ret : (ret * 1000);
+		ret = nvkm_therm_temp_get(therm, &temp);
+		*val = temp * 1000;
 		break;
 	case hwmon_temp_max:
 		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK)
@@ -459,7 +459,7 @@ nouveau_temp_read(struct device *dev, u32 attr, int channel, long *val)
 		return -EOPNOTSUPP;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
@@ -735,7 +735,7 @@ nouveau_hwmon_init(struct drm_device *dev)
 	hwmon->dev = dev;
 
 	if (therm && therm->attr_get && therm->attr_set) {
-		if (nvkm_therm_temp_get(therm) >= 0)
+		if (nvkm_therm_temp_get(therm, NULL) >= 0)
 			special_groups[i++] = &temp1_auto_point_sensor_group;
 		if (therm->fan_get && therm->fan_get(therm) >= 0)
 			special_groups[i++] = &pwm_fan_sensor_group;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
index 4a4d1e224126..e7ffea1512e6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
@@ -27,10 +27,15 @@
 #include <subdev/pmu.h>
 
 int
-nvkm_therm_temp_get(struct nvkm_therm *therm)
+nvkm_therm_temp_get(struct nvkm_therm *therm, int *temp)
 {
+	int ignored_reading;
+
+	if (temp == NULL)
+		temp = &ignored_reading;
+
 	if (therm->func->temp_get)
-		return therm->func->temp_get(therm);
+		return therm->func->temp_get(therm, temp);
 	return -ENODEV;
 }
 
@@ -40,9 +45,11 @@ nvkm_therm_update_trip(struct nvkm_therm *therm)
 	struct nvbios_therm_trip_point *trip = therm->fan->bios.trip,
 				       *cur_trip = NULL,
 				       *last_trip = therm->last_trip;
-	u8  temp = therm->func->temp_get(therm);
+	int temp;
 	u16 duty, i;
 
+	WARN_ON(nvkm_therm_temp_get(therm, &temp) < 0);
+
 	/* look for the trip point corresponding to the current temperature */
 	cur_trip = NULL;
 	for (i = 0; i < therm->fan->bios.nr_fan_trip; i++) {
@@ -70,9 +77,11 @@ static int
 nvkm_therm_compute_linear_duty(struct nvkm_therm *therm, u8 linear_min_temp,
                                u8 linear_max_temp)
 {
-	u8  temp = therm->func->temp_get(therm);
+	int temp;
 	u16 duty;
 
+	WARN_ON(nvkm_therm_temp_get(therm, &temp) < 0);
+
 	/* handle the non-linear part first */
 	if (temp < linear_min_temp)
 		return therm->fan->bios.min_duty;
@@ -200,7 +209,7 @@ nvkm_therm_fan_mode(struct nvkm_therm *therm, int mode)
 	/* do not allow automatic fan management if the thermal sensor is
 	 * not available */
 	if (mode == NVKM_THERM_CTRL_AUTO &&
-	    therm->func->temp_get(therm) < 0)
+	    nvkm_therm_temp_get(therm, NULL) < 0)
 		return -EINVAL;
 
 	if (therm->mode == mode)
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c
index 96f8da40ac82..e2f891d5c7ba 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c
@@ -27,14 +27,15 @@
 #include <subdev/fuse.h>
 
 int
-g84_temp_get(struct nvkm_therm *therm)
+g84_temp_get(struct nvkm_therm *therm, int *temp)
 {
 	struct nvkm_device *device = therm->subdev.device;
 
-	if (nvkm_fuse_read(device->fuse, 0x1a8) == 1)
-		return nvkm_rd32(device, 0x20400);
-	else
+	if (nvkm_fuse_read(device->fuse, 0x1a8) != 1)
 		return -ENODEV;
+
+	*temp = nvkm_rd32(device, 0x20400);
+	return 0;
 }
 
 void
@@ -115,7 +116,7 @@ g84_therm_threshold_hyst_emulation(struct nvkm_therm *therm,
 	}
 
 	/* fix the state (in case someone reprogrammed the alarms) */
-	cur = therm->func->temp_get(therm);
+	WARN_ON(nvkm_therm_temp_get(therm, &cur) < 0);
 	if (new_state == NVKM_THERM_THRS_LOWER && cur > thrs->temp)
 		new_state = NVKM_THERM_THRS_HIGHER;
 	else if (new_state == NVKM_THERM_THRS_HIGHER &&
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
index 9f0dea3f61dc..4c32e4f21bec 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
@@ -24,7 +24,7 @@
 #include "priv.h"
 
 static int
-gp100_temp_get(struct nvkm_therm *therm)
+gp100_temp_get(struct nvkm_therm *therm, int *temp)
 {
 	struct nvkm_device *device = therm->subdev.device;
 	struct nvkm_subdev *subdev = &therm->subdev;
@@ -35,11 +35,12 @@ gp100_temp_get(struct nvkm_therm *therm)
 	if (tsensor & 0x40000000)
 		nvkm_trace(subdev, "reading temperature from SHADOWed sensor\n");
 
-	/* device valid */
-	if (tsensor & 0x20000000)
-		return (inttemp >> 8);
-	else
+	/* device invalid */
+	if (!(tsensor & 0x20000000))
 		return -ENODEV;
+
+	*temp = inttemp >> 8;
+	return 0;
 }
 
 static const struct nvkm_therm_func
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
index 2c92ffb5f9d0..9753ad4bee4a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
@@ -70,7 +70,7 @@ nv40_sensor_setup(struct nvkm_therm *therm)
 }
 
 static int
-nv40_temp_get(struct nvkm_therm *therm)
+nv40_temp_get(struct nvkm_therm *therm, int *temp)
 {
 	struct nvkm_device *device = therm->subdev.device;
 	struct nvbios_therm_sensor *sensor = &therm->bios_sensor;
@@ -95,11 +95,8 @@ nv40_temp_get(struct nvkm_therm *therm)
 	core_temp = core_temp + sensor->offset_num / sensor->offset_den;
 	core_temp = core_temp + sensor->offset_constant - 8;
 
-	/* reserve negative temperatures for errors */
-	if (core_temp < 0)
-		core_temp = 0;
-
-	return core_temp;
+	*temp = core_temp;
+	return 0;
 }
 
 static int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
index 9b57b433d4cf..38fa6777c129 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
@@ -126,7 +126,7 @@ nv50_sensor_setup(struct nvkm_therm *therm)
 }
 
 static int
-nv50_temp_get(struct nvkm_therm *therm)
+nv50_temp_get(struct nvkm_therm *therm, int *temp)
 {
 	struct nvkm_device *device = therm->subdev.device;
 	struct nvbios_therm_sensor *sensor = &therm->bios_sensor;
@@ -143,11 +143,8 @@ nv50_temp_get(struct nvkm_therm *therm)
 	core_temp = core_temp + sensor->offset_num / sensor->offset_den;
 	core_temp = core_temp + sensor->offset_constant - 8;
 
-	/* reserve negative temperatures for errors */
-	if (core_temp < 0)
-		core_temp = 0;
-
-	return core_temp;
+	*temp = core_temp;
+	return 0;
 }
 
 static void
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
index 21659daf1864..04607d8b1755 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
@@ -91,7 +91,15 @@ struct nvkm_therm_func {
 	int (*pwm_set)(struct nvkm_therm *, int line, u32, u32);
 	int (*pwm_clock)(struct nvkm_therm *, int line);
 
-	int (*temp_get)(struct nvkm_therm *);
+	/**
+	 * @temp_get: Get the temperature reading from a thermal device
+	 *
+	 * @therm: The thermal device instance.
+	 * @temp: A pointer to write the temperature reading to.
+	 *
+	 * Returns: Zero on success, or a negative error code on failure.
+	 */
+	int (*temp_get)(struct nvkm_therm *therm, int *temp);
 
 	int (*fan_sense)(struct nvkm_therm *);
 
@@ -110,7 +118,12 @@ int  nv50_fan_pwm_get(struct nvkm_therm *, int, u32 *, u32 *);
 int  nv50_fan_pwm_set(struct nvkm_therm *, int, u32, u32);
 int  nv50_fan_pwm_clock(struct nvkm_therm *, int);
 
-int  g84_temp_get(struct nvkm_therm *);
+/**
+ * g84_temp_get() - An implementation of the &struct nvkm_therm_func temp_get()
+ * @therm: The thermal device instance.
+ * @temp: A pointer to write the temperature reading to.
+ */
+int  g84_temp_get(struct nvkm_therm *therm, int *temp);
 void g84_sensor_setup(struct nvkm_therm *);
 void g84_therm_fini(struct nvkm_therm *);
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/temp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/temp.c
index ddb2b2c600ca..1e8803901abc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/temp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/temp.c
@@ -86,7 +86,9 @@ nvkm_therm_sensor_event(struct nvkm_therm *therm, enum nvkm_therm_thrs thrs,
 	static const char * const thresholds[] = {
 		"fanboost", "downclock", "critical", "shutdown"
 	};
-	int temperature = therm->func->temp_get(therm);
+	int temperature;
+
+	WARN_ON(nvkm_therm_temp_get(therm, &temperature) < 0);
 
 	if (thrs < 0 || thrs > 3)
 		return;
@@ -140,7 +142,9 @@ nvkm_therm_threshold_hyst_polling(struct nvkm_therm *therm,
 {
 	enum nvkm_therm_thrs_direction direction;
 	enum nvkm_therm_thrs_state prev_state, new_state;
-	int temp = therm->func->temp_get(therm);
+	int temp;
+
+	WARN_ON(nvkm_therm_temp_get(therm, &temp) < 0);
 
 	prev_state = nvkm_therm_sensor_get_threshold_state(therm, thrs_name);
 
@@ -185,7 +189,7 @@ alarm_timer_callback(struct nvkm_alarm *alarm)
 	spin_unlock_irqrestore(&therm->sensor.alarm_program_lock, flags);
 
 	/* schedule the next poll in one second */
-	if (therm->func->temp_get(therm) >= 0)
+	if (nvkm_therm_temp_get(therm, NULL) >= 0)
 		nvkm_timer_alarm(tmr, 1000000000ULL, alarm);
 }
 
@@ -229,7 +233,7 @@ nvkm_therm_sensor_preinit(struct nvkm_therm *therm)
 {
 	const char *sensor_avail = "yes";
 
-	if (therm->func->temp_get(therm) < 0)
+	if (nvkm_therm_temp_get(therm, NULL) < 0)
 		sensor_avail = "no";
 
 	nvkm_debug(&therm->subdev, "internal sensor: %s\n", sensor_avail);
-- 
2.26.2

