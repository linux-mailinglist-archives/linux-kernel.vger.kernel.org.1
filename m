Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1132F2C5655
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391016AbgKZNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390894AbgKZNnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:22 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5931C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so2194419wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ksLsRkpw8nSvnfAUMxCRA9ZKMD1k8dq6JXdPEa6WSRc=;
        b=VtiwfNtPrh27PbYTrLPPboMnok0IvMSGdd/iN7rsBt7uFkPmExfba0Tw+yNCseKUj9
         pWl+URLgEzp0KVTSVGyaR9fb5G1QETo7EQfp929dCFYGr72vUEhy2gmfpci/oP9rDbqk
         XlOgFn5IfcutiF8ZhbW6aPQZSHnojno6daJ2d/T0Aosj1SY1vOEPN+9lknysCXVAG6gR
         RV6ZT+s5jGpfZMMDvXq9SqeLYqc913mfSp0mGAhmWWrCPAORKwurPnf60KxI28A4DiH1
         kfFJEjG1tkxiUcxHtyhr8rQaN/GmwDgKrSwpVYiyK36lGq4BOvtiRyHInWBCJCvsKvdh
         m1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ksLsRkpw8nSvnfAUMxCRA9ZKMD1k8dq6JXdPEa6WSRc=;
        b=Zvn6WaXSK5tKjEBcf1ET8ss9Y8Tqgwdhi1vm9D3mPzvDKZaDVUsr5vMGpm71UcYKg+
         V4392g2WJso1PZjIEls26LL4u7vgc2+kIz1k8FvMJPeiul1YvdqhoIer/YGQu9H1IO3Q
         E2VtJzAdsP8bGCaH3zX5I4ljN553ZAtyJDnQQQwKor7Z/t20miq/tdmmu0PY49qwG0Da
         s+MQAlpopLiXb5Kc3uKy5dR+fO9+LhfATBDEx6EISTFJ7Sz4Ma3Lr1hdgaI4LVRfd5O7
         /GDbsl1ebOlEkFQnJXjhVyNM5ZZLSUm5FEsSaGtM7a8tIHeMn5bHOZR1mvPR5HijRmmA
         4jPQ==
X-Gm-Message-State: AOAM5335FTzHsKB4INRYYua3rKMzY7IrRd2Lg60k1X7ywKJrFpgmEtFb
        7uNgGy1alHBMTYwelEBvj6yDTw==
X-Google-Smtp-Source: ABdhPJx8VE2IS4NI4Spzb5z5nxxs4cXbw6YnEt6wGL4wntHjupQ4leezNXqY3LbB3KUwvuaUcl/I1A==
X-Received: by 2002:adf:f651:: with SMTP id x17mr3880693wrp.185.1606398200231;
        Thu, 26 Nov 2020 05:43:20 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 23/40] drm/amd/pm/powerplay/hwmgr/smu7_thermal: Repair formatting in a bunch of function docs
Date:   Thu, 26 Nov 2020 13:42:23 +0000
Message-Id: <20201126134240.3214176-24-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:112: warning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_set_static_mode'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:112: warning: Function parameter or member 'mode' not described in 'smu7_fan_ctrl_set_static_mode'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:137: warning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_set_default_mode'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:209: warning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_set_fan_speed_percent'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:209: warning: Function parameter or member 'speed' not described in 'smu7_fan_ctrl_set_fan_speed_percent'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:245: warning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_reset_fan_speed_to_default'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:268: warning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_set_fan_speed_rpm'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:268: warning: Function parameter or member 'speed' not described in 'smu7_fan_ctrl_set_fan_speed_rpm'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:299: warning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_get_temperature'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:325: warning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:325: warning: Function parameter or member 'low_temp' not described in 'smu7_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:325: warning: Function parameter or member 'high_temp' not described in 'smu7_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:358: warning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_initialize'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:377: warning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_enable_alert'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:395: warning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_disable_alert'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:414: warning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_stop_thermal_controller'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:433: warning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_start_smc_fan_control'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 103 +++++++++---------
 1 file changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index e3d9d969d86ac..0d38d4206848a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -103,11 +103,11 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
 }
 
 /**
-* Set Fan Speed Control to static mode, so that the user can decide what speed to use.
-* @param    hwmgr  the address of the powerplay hardware manager.
-*           mode    the fan control mode, 0 default, 1 by percent, 5, by RPM
-* @exception Should always succeed.
-*/
+ * smu7_fan_ctrl_set_static_mode - Set Fan Speed Control to static mode, so that the user can decide what speed to use.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * @mode:   the fan control mode, 0 default, 1 by percent, 5, by RPM
+ * Exception: Should always succeed.
+ */
 int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 {
 	if (hwmgr->fan_ctrl_is_in_default_mode) {
@@ -130,8 +130,8 @@ int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 
 /**
 * Reset Fan Speed Control to default mode.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @exception Should always succeed.
+* @hwmgr:  the address of the powerplay hardware manager.
+* Exception: Should always succeed.
 */
 int smu7_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
 {
@@ -199,11 +199,11 @@ int smu7_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set Fan Speed in percent.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @param    speed is the percentage value (0% - 100%) to be set.
-* @exception Fails is the 100% setting appears to be 0.
-*/
+ * smu7_fan_ctrl_set_fan_speed_percent - Set Fan Speed in percent.
+ * @hwmgr: the address of the powerplay hardware manager.
+ * @speed: is the percentage value (0% - 100%) to be set.
+ * Exception: Fails is the 100% setting appears to be 0.
+ */
 int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		uint32_t speed)
 {
@@ -237,9 +237,9 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 }
 
 /**
-* Reset Fan Speed to default.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @exception Always succeeds.
+* smu7_fan_ctrl_reset_fan_speed_to_default - Reset Fan Speed to default.
+* @hwmgr:  the address of the powerplay hardware manager.
+* Exception: Always succeeds.
 */
 int smu7_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr)
 {
@@ -259,11 +259,11 @@ int smu7_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set Fan Speed in RPM.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @param    speed is the percentage value (min - max) to be set.
-* @exception Fails is the speed not lie between min and max.
-*/
+ * smu7_fan_ctrl_set_fan_speed_rpm - Set Fan Speed in RPM.
+ * @hwmgr: the address of the powerplay hardware manager.
+ * @speed: is the percentage value (min - max) to be set.
+ * Exception: Fails is the speed not lie between min and max.
+ */
 int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 {
 	uint32_t tach_period;
@@ -291,10 +291,10 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 }
 
 /**
-* Reads the remote temperature from the SIslands thermal controller.
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * smu7_thermal_get_temperature - Reads the remote temperature from the SIslands thermal controller.
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 int smu7_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 {
 	int temp;
@@ -314,12 +314,13 @@ int smu7_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set the requested temperature range for high and low alert signals
-*
-* @param    hwmgr The address of the hardware manager.
-* @param    range Temperature range to be programmed for high and low alert signals
-* @exception PP_Result_BadInput if the input data is not valid.
-*/
+ * smu7_thermal_set_temperature_range - Set the requested temperature range for high and low alert signals
+ *
+ * @hwmgr: The address of the hardware manager.
+ * @low_temp: Temperature to be programmed for high alert signals
+ * @high_temp: Temperature to be programmed for low alert signals
+ * Exception: PP_Result_BadInput if the input data is not valid.
+ */
 static int smu7_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		int low_temp, int high_temp)
 {
@@ -350,10 +351,10 @@ static int smu7_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 }
 
 /**
-* Programs thermal controller one-time setting registers
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * smu7_thermal_initialize - Programs thermal controller one-time setting registers
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 static int smu7_thermal_initialize(struct pp_hwmgr *hwmgr)
 {
 	if (hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolution)
@@ -369,10 +370,10 @@ static int smu7_thermal_initialize(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Enable thermal alerts on the RV770 thermal controller.
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * smu7_thermal_enable_alert - Enable thermal alerts on the RV770 thermal controller.
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 static void smu7_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 {
 	uint32_t alert;
@@ -388,9 +389,9 @@ static void smu7_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Disable thermal alerts on the RV770 thermal controller.
-* @param    hwmgr The address of the hardware manager.
-*/
+ * smu7_thermal_disable_alert - Disable thermal alerts on the RV770 thermal controller.
+ * @hwmgr: The address of the hardware manager.
+ */
 int smu7_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 {
 	uint32_t alert;
@@ -406,10 +407,10 @@ int smu7_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Uninitialize the thermal controller.
-* Currently just disables alerts.
-* @param    hwmgr The address of the hardware manager.
-*/
+ * smu7_thermal_stop_thermal_controller - Uninitialize the thermal controller.
+ * Currently just disables alerts.
+ * @hwmgr: The address of the hardware manager.
+ */
 int smu7_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 {
 	int result = smu7_thermal_disable_alert(hwmgr);
@@ -421,14 +422,10 @@ int smu7_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
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
+ * smu7_thermal_start_smc_fan_control - Start the fan control on the SMC.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * Return:   result from set temperature range routine
+ */
 static int smu7_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 {
 /* If the fantable setup has failed we could have disabled
-- 
2.25.1

