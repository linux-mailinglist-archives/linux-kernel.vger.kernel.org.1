Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1F526CA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgIPTt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgIPTsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600285663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ba2/kaos7l9gOkIXtd4tarUx1cdK2Ap9kcUdp3sMuhI=;
        b=Jftrzuj72njg0ku3fM//dupHJ0BH3iFCjY5vWrur/EkgUXrgso3HScDYT821AAx5TFFWxu
        ImSN6Mr9vLEDuRbZDFpIN9hANDXOprIS3Sl/xysccjNE58+gcW/Tb1wV5dnuLL6+fhn8UA
        wvwS8ePi+wIPzG49Bt7X5uXn4MHZZ48=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-VPsnXx9wOdyOSfIbXoN8Xw-1; Wed, 16 Sep 2020 15:47:41 -0400
X-MC-Unique: VPsnXx9wOdyOSfIbXoN8Xw-1
Received: by mail-qt1-f199.google.com with SMTP id j35so7037760qtk.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ba2/kaos7l9gOkIXtd4tarUx1cdK2Ap9kcUdp3sMuhI=;
        b=MR8Qzz1jnPb9e+jN83ggjfSNdyzebQuH1fuF1ryRfgoFxs8Zh+8E8mi1pr2Qw2CQFk
         yfJblbXxFaPOyyl2ygXbwjeJ4JBRJ4fJHN09irl5Um4MT9MFx2+n95dKeolyZXYiroGz
         PELuNLTTgmU8SbEFvipYYXMleD0u5Ann66mdLhPx+OOQ+IRRwAPYRtO/iZMHVgnPuaWe
         wSOcAbwOgHFONxDe68bZADFt4KnYNPLicV1P6X+6vRvhXg8xfBM8Farb8e/tSbsz1h+d
         asgVW1kH63GoKrAPVVNTe87d3un/wRnQQJ/TXi5Alo9bZBiD/Tab/S9YiiOpAZM1nrW5
         iapA==
X-Gm-Message-State: AOAM531/rSUpDn36Mt72PgBwtMLdtKGjL/qkn4z0X/kojeyugaXwIGUu
        4x5O1vV77uXTIAWt6hwTcsEm7m+69g0u2T38s6Xec34v2Wn7dy2wp3vZSdga/k7Io3UKtwsUZEB
        ZbWTA2sUd1eGZ5itSEgKqSA5j
X-Received: by 2002:a0c:f48e:: with SMTP id i14mr25358474qvm.9.1600285660755;
        Wed, 16 Sep 2020 12:47:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyyu4ioO4oDdT1Jh/9uW7XXfk64J8Fl/ZVcLwY9T8RS9qxEScpRVTmnXaoNb+lbJHsgoRWSw==
X-Received: by 2002:a0c:f48e:: with SMTP id i14mr25358455qvm.9.1600285660479;
        Wed, 16 Sep 2020 12:47:40 -0700 (PDT)
Received: from dev.jcline.org.com ([136.56.20.95])
        by smtp.gmail.com with ESMTPSA id g4sm18683447qth.30.2020.09.16.12.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:47:39 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH v2 2/2] drm/nouveau: Add fine-grain temperature reporting
Date:   Wed, 16 Sep 2020 15:47:11 -0400
Message-Id: <20200916194711.999602-3-jcline@redhat.com>
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

Commit d32656373857 ("drm/nouveau/therm/gp100: initial implementation of
new gp1xx temperature sensor") added support for reading finer-grain
temperatures, but continued to report temperatures in 1 degree Celsius
increments via nvkm_therm_temp_get().

This alters the temp_get() API to return millidegrees rather than
degrees, adjusts all implementations, and changes users that need integer
Celsius to use the new nvkm_therm_temp_get_c() helper function. Since
there are now two units of measurement floating around, structs that
store temperature now include documentation to make it clear what the
unit is.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 .../nouveau/include/nvkm/subdev/bios/therm.h  | 13 ++++++++++
 .../drm/nouveau/include/nvkm/subdev/therm.h   | 26 +++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_hwmon.c       |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/therm/base.c  | 14 ++++++++--
 .../gpu/drm/nouveau/nvkm/subdev/therm/g84.c   |  4 +--
 .../gpu/drm/nouveau/nvkm/subdev/therm/gp100.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/therm/nv40.c  |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/therm/nv50.c  |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/therm/temp.c  |  4 +--
 9 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/therm.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/therm.h
index 0fb8a3480871..fdf23214cc69 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/therm.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/therm.h
@@ -1,6 +1,12 @@
 /* SPDX-License-Identifier: MIT */
 #ifndef __NVBIOS_THERM_H__
 #define __NVBIOS_THERM_H__
+
+/**
+ * struct nvbios_therm_threshold - The threshold of a thermal event.
+ * @temp: The temperature, in degrees Celsius, of the thermal threshold.
+ * @hysteresis: The hysteresis of this threshold, in degrees Celsius.
+ */
 struct nvbios_therm_threshold {
 	u8 temp;
 	u8 hysteresis;
@@ -29,6 +35,13 @@ enum nvbios_therm_fan_type {
 
 /* no vbios have more than 6 */
 #define NVKM_TEMP_FAN_TRIP_MAX 10
+
+/**
+ * struct nvbios_therm_trip_point - Represents a thermal trip point.
+ * @fan_duty: The fan's duty cycle as a percentage. Valid values are 0-100.
+ * @temp: The temperature of this trip point, in degrees Celsius.
+ * @hysteresis: the hysteresis to use at this trip point, in degrees Celsius.
+ */
 struct nvbios_therm_trip_point {
 	int fan_duty;
 	int temp;
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
index bfe9779216fc..e817bb9c9505 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
@@ -99,7 +99,33 @@ struct nvkm_therm {
 	bool clkgating_enabled;
 };
 
+/**
+ * nvkm_therm_temp_get() - get the temperature in millidegrees Celsius
+ * @therm: The thermal device to read from.
+ * @temp: A pointer to write the temperature reading to. Passing NULL is
+ *	allowed, useful if you only need to check that it's possible to
+ *	read a temperature.
+ *
+ * Note that because some cards are only capable of reporting temperatures in
+ * integer degrees Celsius or, if they support fractional degrees, not support
+ * millidegree accuracy, the accuracy of this interface is hardware dependent.
+ *
+ * Returns: Zero on success, or a negative error code on failure.
+ */
 int nvkm_therm_temp_get(struct nvkm_therm *therm, int *temp);
+
+/**
+ * nvkm_therm_temp_get_c() - get the temperature in degrees Celsius
+ * @therm: The thermal device to read from.
+ * @temp: A pointer to write the temperature reading to.
+ *
+ * A convenient wrapper for nvkm_therm_temp_get() that converts to degrees
+ * Celsius.
+ *
+ * Returns: Zero on success, or a negative error code on failure.
+ */
+int nvkm_therm_temp_get_c(struct nvkm_therm *therm, int *temp);
+
 int nvkm_therm_fan_sense(struct nvkm_therm *);
 int nvkm_therm_cstate(struct nvkm_therm *, int, int);
 void nvkm_therm_clkgate_init(struct nvkm_therm *,
diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index aff6aa296678..1363068f44c1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -429,7 +429,7 @@ nouveau_temp_read(struct device *dev, u32 attr, int channel, long *val)
 		if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
 			return -EINVAL;
 		ret = nvkm_therm_temp_get(therm, &temp);
-		*val = temp * 1000;
+		*val = temp;
 		break;
 	case hwmon_temp_max:
 		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK)
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
index e7ffea1512e6..a7bb1e6b6169 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
@@ -39,6 +39,16 @@ nvkm_therm_temp_get(struct nvkm_therm *therm, int *temp)
 	return -ENODEV;
 }
 
+int
+nvkm_therm_temp_get_c(struct nvkm_therm *therm, int *temp)
+{
+	int ret = nvkm_therm_temp_get(therm, temp);
+
+	if (temp != NULL)
+		*temp /= 1000;
+	return ret;
+}
+
 static int
 nvkm_therm_update_trip(struct nvkm_therm *therm)
 {
@@ -48,7 +58,7 @@ nvkm_therm_update_trip(struct nvkm_therm *therm)
 	int temp;
 	u16 duty, i;
 
-	WARN_ON(nvkm_therm_temp_get(therm, &temp) < 0);
+	WARN_ON(nvkm_therm_temp_get_c(therm, &temp) < 0);
 
 	/* look for the trip point corresponding to the current temperature */
 	cur_trip = NULL;
@@ -80,7 +90,7 @@ nvkm_therm_compute_linear_duty(struct nvkm_therm *therm, u8 linear_min_temp,
 	int temp;
 	u16 duty;
 
-	WARN_ON(nvkm_therm_temp_get(therm, &temp) < 0);
+	WARN_ON(nvkm_therm_temp_get_c(therm, &temp) < 0);
 
 	/* handle the non-linear part first */
 	if (temp < linear_min_temp)
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c
index e2f891d5c7ba..2e563b379820 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c
@@ -34,7 +34,7 @@ g84_temp_get(struct nvkm_therm *therm, int *temp)
 	if (nvkm_fuse_read(device->fuse, 0x1a8) != 1)
 		return -ENODEV;
 
-	*temp = nvkm_rd32(device, 0x20400);
+	*temp = nvkm_rd32(device, 0x20400) * 1000;
 	return 0;
 }
 
@@ -116,7 +116,7 @@ g84_therm_threshold_hyst_emulation(struct nvkm_therm *therm,
 	}
 
 	/* fix the state (in case someone reprogrammed the alarms) */
-	WARN_ON(nvkm_therm_temp_get(therm, &cur) < 0);
+	WARN_ON(nvkm_therm_temp_get_c(therm, &cur) < 0);
 	if (new_state == NVKM_THERM_THRS_LOWER && cur > thrs->temp)
 		new_state = NVKM_THERM_THRS_HIGHER;
 	else if (new_state == NVKM_THERM_THRS_HIGHER &&
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
index 4c32e4f21bec..e7733a3eb36b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
@@ -39,7 +39,7 @@ gp100_temp_get(struct nvkm_therm *therm, int *temp)
 	if (!(tsensor & 0x20000000))
 		return -ENODEV;
 
-	*temp = inttemp >> 8;
+	*temp = inttemp * 1000 >> 8;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
index 9753ad4bee4a..500d7e2ef884 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
@@ -95,7 +95,7 @@ nv40_temp_get(struct nvkm_therm *therm, int *temp)
 	core_temp = core_temp + sensor->offset_num / sensor->offset_den;
 	core_temp = core_temp + sensor->offset_constant - 8;
 
-	*temp = core_temp;
+	*temp = core_temp * 1000;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
index 38fa6777c129..3b203e8ee406 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
@@ -143,7 +143,7 @@ nv50_temp_get(struct nvkm_therm *therm, int *temp)
 	core_temp = core_temp + sensor->offset_num / sensor->offset_den;
 	core_temp = core_temp + sensor->offset_constant - 8;
 
-	*temp = core_temp;
+	*temp = core_temp * 1000;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/temp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/temp.c
index 1e8803901abc..17d1dcb1c09c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/temp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/temp.c
@@ -88,7 +88,7 @@ nvkm_therm_sensor_event(struct nvkm_therm *therm, enum nvkm_therm_thrs thrs,
 	};
 	int temperature;
 
-	WARN_ON(nvkm_therm_temp_get(therm, &temperature) < 0);
+	WARN_ON(nvkm_therm_temp_get_c(therm, &temperature) < 0);
 
 	if (thrs < 0 || thrs > 3)
 		return;
@@ -144,7 +144,7 @@ nvkm_therm_threshold_hyst_polling(struct nvkm_therm *therm,
 	enum nvkm_therm_thrs_state prev_state, new_state;
 	int temp;
 
-	WARN_ON(nvkm_therm_temp_get(therm, &temp) < 0);
+	WARN_ON(nvkm_therm_temp_get_c(therm, &temp) < 0);
 
 	prev_state = nvkm_therm_sensor_get_threshold_state(therm, thrs_name);
 
-- 
2.26.2

