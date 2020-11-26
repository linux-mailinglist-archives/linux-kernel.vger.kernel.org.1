Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C902C5652
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390971AbgKZNoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390660AbgKZNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:33 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6729C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:31 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 64so2175423wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noGA3E/AB1B64F/JwbdkWEfwXVhCmBFBJIPeh1+Apks=;
        b=h7/b7Q13ulVO3nAVpIgUkaCmxcL2QCAFnLIMbYQfhHQheIy5qqTibv2rMfHWV6f9XQ
         HZZK/c/tXEttTZe8ktoiWGX+RjM/4IlREpcV6HbTomyYnjJ74N7M4U48ahTK61qX94vF
         o9hEXLXGjGwZVhxf9rDSLVUIkDBFRZzQnigiPYL3qJpPlQw6R0WLLRdoNc2rf8yoTgZw
         9deI72uqwb39WlHzAJwTdcQR6aWgh2+rARQf6Kig5kmnsDyrfVpQyZyNCHV1WsrMHDnn
         OKEmEckh42lnWp4dXRqczSV6V8VInFXNXSh0+5L5XYn0yrMdMGXwjUe/5mm+KmZu5ywf
         Wlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noGA3E/AB1B64F/JwbdkWEfwXVhCmBFBJIPeh1+Apks=;
        b=ChK+QEFtTTZT2rKFZ/ryz2HyT2VmwQsp0VGj2/7fw6uCzrOaFV4V79c7mW534bGtzF
         KDFYD7WKPx1Q4LEMPV+5T7Zzzek2d8e27JI8/Cpy7P3XQ6QGJ7MkyP5AjZGbxhVSvxh4
         QqZBmPiQohLT1TrebeEdq80TDr/KuglAoi0WCcLMOnimMqNjKVg4NcBnbpwiZzZ+MIQN
         A5DeXUn7nTKHAAddoZkzOKBXjjsu9JmRIaNk+K2bEW1nzFXGkDDnGGW99CehEDwQrtbB
         0FAYhOAiwxuqWqQfitoiJ56qUf4aWilQAFs5Z2NUgRS3BCdKA6kWCZfSEIYAYCOpHi35
         Nk2g==
X-Gm-Message-State: AOAM531A2L42bhkNGK6uO0ed9a46dPHvzFzBkPWLQpc4EF0L2w/EmhTp
        vWkEXaWYUDz26xgyM4YHTHZO7g==
X-Google-Smtp-Source: ABdhPJzwavga51jWqfinazCp3/eMo/sTCGb7UUcbeOb4eIhyF7dgAWsftaGUR6TDaz3tUrW70h9G4A==
X-Received: by 2002:a5d:654b:: with SMTP id z11mr3865038wrv.291.1606398210469;
        Thu, 26 Nov 2020 05:43:30 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 30/40] drm/amd/pm/powerplay/hwmgr/vega12_thermal: Fix some outdated function documentation
Date:   Thu, 26 Nov 2020 13:42:30 +0000
Message-Id: <20201126134240.3214176-31-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:63: warning: Cannot understand  * @fn vega12_enable_fan_control_feature
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:137: warning: Function parameter or member 'hwmgr' not described in 'vega12_fan_ctrl_reset_fan_speed_to_default'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:147: warning: Function parameter or member 'hwmgr' not described in 'vega12_thermal_get_temperature'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:172: warning: Function parameter or member 'hwmgr' not described in 'vega12_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:172: warning: Function parameter or member 'range' not described in 'vega12_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:208: warning: Function parameter or member 'hwmgr' not described in 'vega12_thermal_enable_alert'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:226: warning: Function parameter or member 'hwmgr' not described in 'vega12_thermal_disable_alert'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:240: warning: Function parameter or member 'hwmgr' not described in 'vega12_thermal_stop_thermal_controller'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:256: warning: Function parameter or member 'hwmgr' not described in 'vega12_thermal_setup_fan_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:279: warning: Function parameter or member 'hwmgr' not described in 'vega12_thermal_start_smc_fan_control'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../amd/pm/powerplay/hwmgr/vega12_thermal.c   | 82 ++++++++-----------
 1 file changed, 36 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
index 7ace439dcde7a..0dc16f25a463b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
@@ -60,11 +60,10 @@ int vega12_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
 }
 
 /**
- * @fn vega12_enable_fan_control_feature
- * @brief Enables the SMC Fan Control Feature.
+ * vega12_enable_fan_control_feature -Enables the SMC Fan Control Feature.
  *
- * @param    hwmgr - the address of the powerplay hardware manager.
- * @return   0 on success. -1 otherwise.
+ * @hwmgr: the address of the powerplay hardware manager.
+ * Return:   0 on success. -1 otherwise.
  */
 static int vega12_enable_fan_control_feature(struct pp_hwmgr *hwmgr)
 {
@@ -129,20 +128,20 @@ int vega12_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Reset Fan Speed to default.
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @exception Always succeeds.
-*/
+ * vega12_fan_ctrl_reset_fan_speed_to_default - Reset Fan Speed to default.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * Exception Always succeeds.
+ */
 int vega12_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr)
 {
 	return vega12_fan_ctrl_start_smc_fan_control(hwmgr);
 }
 
 /**
-* Reads the remote temperature from the SIslands thermal controller.
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega12_thermal_get_temperature - Reads the remote temperature from the SIslands thermal controller.
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega12_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -160,13 +159,13 @@ int vega12_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set the requested temperature range for high and low alert signals
-*
-* @param    hwmgr The address of the hardware manager.
-* @param    range Temperature range to be programmed for
-*           high and low alert signals
-* @exception PP_Result_BadInput if the input data is not valid.
-*/
+ * Set the requested temperature range for high and low alert signals
+ *
+ * @hwmgr: The address of the hardware manager.
+ * @range: Temperature range to be programmed for
+ *           high and low alert signals
+ * Exception: PP_Result_BadInput if the input data is not valid.
+ */
 static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
@@ -200,10 +199,10 @@ static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 }
 
 /**
-* Enable thermal alerts on the RV770 thermal controller.
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega12_thermal_enable_alert - Enable thermal alerts on the RV770 thermal controller.
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 static int vega12_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -219,9 +218,9 @@ static int vega12_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Disable thermal alerts on the RV770 thermal controller.
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega12_thermal_disable_alert - Disable thermal alerts on the RV770 thermal controller.
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega12_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -232,10 +231,10 @@ int vega12_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Uninitialize the thermal controller.
-* Currently just disables alerts.
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega12_thermal_stop_thermal_controller - Uninitialize the thermal controller.
+ * Currently just disables alerts.
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega12_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 {
 	int result = vega12_thermal_disable_alert(hwmgr);
@@ -244,14 +243,9 @@ int vega12_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
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
+ * vega12_thermal_setup_fan_table - Set up the fan table to control the fan using the SMC.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ */
 static int vega12_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 {
 	int ret;
@@ -267,14 +261,10 @@ static int vega12_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
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
+ * vega12_thermal_start_smc_fan_control - Start the fan control on the SMC.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * Return:  result from set temperature range routine
+ */
 static int vega12_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 {
 	/* If the fantable setup has failed we could have disabled
-- 
2.25.1

