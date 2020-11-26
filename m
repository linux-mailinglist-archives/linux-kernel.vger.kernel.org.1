Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0B2C5644
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390691AbgKZNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390655AbgKZNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:24 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88A4C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:22 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so2193402wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vd4FfIpLZd0vMeRpec4AlI8lNTFUtrKLQ6GMMme39yM=;
        b=w1mzgqSt756ZauAhQ+5zmWtutj9JrZq9R1I7NSGxXNPYszT1fDP2TYxKUVQR9xN5S3
         wT3ly2HYN02sQIuqE5SxiM/Ei0+xzrcieEQiRhgClmTn2/2Odm+XEb6VOMUsxMkkGb8s
         9GB//ICphpYFuv3ghiSvds7CZFl6zKTcvF0BPrOavLUojDTlgidbjuK16TU5P9t1738Q
         4gFEkaIduj2orSFmdMsFgcr4l7p2IBnzNaJODDnoYw8Zd1xb7rd67YuOdYkA01PiNInp
         qtuA3DtYqFEXzpWn+EwcqrZrGxiXfsfVobXwFLM/md7/9oEUgP7dJWfR9OuQTBG0inTz
         gDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vd4FfIpLZd0vMeRpec4AlI8lNTFUtrKLQ6GMMme39yM=;
        b=j2BshgHX/sZw/yymplaf/fkFozWbszxDIr/+0FKzS8gspEcqtZ/QUncaGWSTLPQQKt
         brJczAUyJBPFKBXnxwjI0k9TLQfUmuhHjB8aR7MjY8HUoSuMKtISCTVJa6OE28KbSQoc
         aogW/R9FTNZzl/TrJsBS75V5JzeMz6DUDV3CV/yFf/cavAE27RUNXqUaysRZqMBCh4wG
         dqerJJmH8VeNoSvvYii23NvIvxhlDDyXH8SvyskyfrDBLKAL7LB3v2JFoO4g/zSONr7V
         m/fcmvIiZZEQ3XcTAaJjHZHmYirCJB0qsHjwViryPMpPE8r28zNGJ0cX9offhtJ2Umrs
         2QAQ==
X-Gm-Message-State: AOAM530YZe1G30ZQCyT5qUV0RQjKBmMu5Xkva2FlthL2V06KfWDRhZe3
        tTD5jeP0jYLIrR2NpuOK7eClQw==
X-Google-Smtp-Source: ABdhPJzhltPtjyIy1lfgqgQsmQ4F2Cz4rdWdrX6CCt9iDlu7pvpS0dSrlInEWEhr1EVL01U4m54ieA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr4052254wrp.72.1606398201414;
        Thu, 26 Nov 2020 05:43:21 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 24/40] drm/amd/pm/powerplay/hwmgr/vega10_thermal: Fix a bunch of dated function doc formatting
Date:   Thu, 26 Nov 2020 13:42:24 +0000
Message-Id: <20201126134240.3214176-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:128: warning: Function parameter or member 'hwmgr' not described in 'vega10_fan_ctrl_set_static_mode'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:128: warning: Function parameter or member 'mode' not described in 'vega10_fan_ctrl_set_static_mode'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:157: warning: Function parameter or member 'hwmgr' not described in 'vega10_fan_ctrl_set_default_mode'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:176: warning: Cannot understand  * @fn vega10_enable_fan_control_feature
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:252: warning: Function parameter or member 'hwmgr' not described in 'vega10_fan_ctrl_set_fan_speed_percent'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:252: warning: Function parameter or member 'speed' not described in 'vega10_fan_ctrl_set_fan_speed_percent'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:290: warning: Function parameter or member 'hwmgr' not described in 'vega10_fan_ctrl_reset_fan_speed_to_default'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:307: warning: Function parameter or member 'hwmgr' not described in 'vega10_fan_ctrl_set_fan_speed_rpm'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:307: warning: Function parameter or member 'speed' not described in 'vega10_fan_ctrl_set_fan_speed_rpm'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:339: warning: Function parameter or member 'hwmgr' not described in 'vega10_thermal_get_temperature'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:365: warning: Function parameter or member 'hwmgr' not described in 'vega10_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:365: warning: Function parameter or member 'range' not described in 'vega10_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:414: warning: Function parameter or member 'hwmgr' not described in 'vega10_thermal_initialize'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:437: warning: Function parameter or member 'hwmgr' not described in 'vega10_thermal_enable_alert'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:468: warning: Function parameter or member 'hwmgr' not described in 'vega10_thermal_disable_alert'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:496: warning: Function parameter or member 'hwmgr' not described in 'vega10_thermal_stop_thermal_controller'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:515: warning: Function parameter or member 'hwmgr' not described in 'vega10_thermal_setup_fan_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:618: warning: Function parameter or member 'hwmgr' not described in 'vega10_thermal_start_smc_fan_control'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 131 ++++++++----------
 1 file changed, 61 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 952cd3d7240e3..9b46b27bd30c4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -118,12 +118,12 @@ int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
 }
 
 /**
-* Set Fan Speed Control to static mode,
-* so that the user can decide what speed to use.
-* @param    hwmgr  the address of the powerplay hardware manager.
-*           mode the fan control mode, 0 default, 1 by percent, 5, by RPM
-* @exception Should always succeed.
-*/
+ * vega10_fan_ctrl_set_static_mode - Set Fan Speed Control to static mode,
+ * so that the user can decide what speed to use.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * @mode: the fan control mode, 0 default, 1 by percent, 5, by RPM
+ * Exception: Should always succeed.
+ */
 int vega10_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -149,10 +149,10 @@ int vega10_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 }
 
 /**
-* Reset Fan Speed Control to default mode.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @exception Should always succeed.
-*/
+ * vega10_fan_ctrl_set_default_mode - Reset Fan Speed Control to default mode.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * Exception: Should always succeed.
+ */
 int vega10_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -173,11 +173,10 @@ int vega10_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * @fn vega10_enable_fan_control_feature
- * @brief Enables the SMC Fan Control Feature.
+ * vega10_enable_fan_control_feature - Enables the SMC Fan Control Feature.
  *
- * @param    hwmgr - the address of the powerplay hardware manager.
- * @return   0 on success. -1 otherwise.
+ * @hwmgr: the address of the powerplay hardware manager.
+ * Return:   0 on success. -1 otherwise.
  */
 static int vega10_enable_fan_control_feature(struct pp_hwmgr *hwmgr)
 {
@@ -242,11 +241,11 @@ int vega10_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set Fan Speed in percent.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @param    speed is the percentage value (0% - 100%) to be set.
-* @exception Fails is the 100% setting appears to be 0.
-*/
+ * vega10_fan_ctrl_set_fan_speed_percent - Set Fan Speed in percent.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * @speed: is the percentage value (0% - 100%) to be set.
+ * Exception: Fails is the 100% setting appears to be 0.
+ */
 int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		uint32_t speed)
 {
@@ -282,10 +281,10 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 }
 
 /**
-* Reset Fan Speed to default.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @exception Always succeeds.
-*/
+ * vega10_fan_ctrl_reset_fan_speed_to_default - Reset Fan Speed to default.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * Exception: Always succeeds.
+ */
 int vega10_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr)
 {
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
@@ -298,11 +297,11 @@ int vega10_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set Fan Speed in RPM.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @param    speed is the percentage value (min - max) to be set.
-* @exception Fails is the speed not lie between min and max.
-*/
+ * vega10_fan_ctrl_set_fan_speed_rpm - Set Fan Speed in RPM.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * @speed: is the percentage value (min - max) to be set.
+ * Exception: Fails is the speed not lie between min and max.
+ */
 int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -331,10 +330,10 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 }
 
 /**
-* Reads the remote temperature from the SIslands thermal controller.
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega10_thermal_get_temperature - Reads the remote temperature from the SIslands thermal controller.
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega10_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -353,13 +352,13 @@ int vega10_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set the requested temperature range for high and low alert signals
-*
-* @param    hwmgr The address of the hardware manager.
-* @param    range Temperature range to be programmed for
-*           high and low alert signals
-* @exception PP_Result_BadInput if the input data is not valid.
-*/
+ * vega10_thermal_set_temperature_range - Set the requested temperature range for high and low alert signals
+ *
+ * @hwmgr: The address of the hardware manager.
+ * @range: Temperature range to be programmed for
+ *           high and low alert signals
+ * Exception: PP_Result_BadInput if the input data is not valid.
+ */
 static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
@@ -406,10 +405,10 @@ static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 }
 
 /**
-* Programs thermal controller one-time setting registers
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega10_thermal_initialize - Programs thermal controller one-time setting registers
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 static int vega10_thermal_initialize(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -429,10 +428,10 @@ static int vega10_thermal_initialize(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Enable thermal alerts on the RV770 thermal controller.
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega10_thermal_enable_alert - Enable thermal alerts on the RV770 thermal controller.
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 static int vega10_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -461,9 +460,9 @@ static int vega10_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Disable thermal alerts on the RV770 thermal controller.
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega10_thermal_disable_alert - Disable thermal alerts on the RV770 thermal controller.
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega10_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -488,10 +487,10 @@ int vega10_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Uninitialize the thermal controller.
-* Currently just disables alerts.
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega10_thermal_stop_thermal_controller - Uninitialize the thermal controller.
+ * Currently just disables alerts.
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega10_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 {
 	int result = vega10_thermal_disable_alert(hwmgr);
@@ -503,14 +502,10 @@ int vega10_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set up the fan table to control the fan using the SMC.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @param    pInput the pointer to input data
-* @param    pOutput the pointer to output data
-* @param    pStorage the pointer to temporary storage
-* @param    Result the last failure code
-* @return   result from set temperature range routine
-*/
+ * vega10_thermal_setup_fan_table - Set up the fan table to control the fan using the SMC.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * Return:   result from set temperature range routine
+ */
 static int vega10_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 {
 	int ret;
@@ -606,14 +601,10 @@ int vega10_enable_mgpu_fan_boost(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Start the fan control on the SMC.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @param    pInput the pointer to input data
-* @param    pOutput the pointer to output data
-* @param    pStorage the pointer to temporary storage
-* @param    Result the last failure code
-* @return   result from set temperature range routine
-*/
+ * vega10_thermal_start_smc_fan_control - Start the fan control on the SMC.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * Return:   result from set temperature range routine
+ */
 static int vega10_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 {
 /* If the fantable setup has failed we could have disabled
-- 
2.25.1

