Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280022C5648
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbgKZNng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390631AbgKZNna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:30 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11CC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:30 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so2447789wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvOq+Zi/CHrahUTvogxV5HI9MG7ly8TSlygcZpw2NKU=;
        b=BL/MSEaJ1vyfc+neXkZo3m2nXS6eZ0aJq2FC5IT/mKUL820jhA/u5feEKiEunlhQRe
         zQrtJgdxtDbBbMGMltY+M+UE1ZOxrt6k/gNz9P0FfECY5oyB4sDDv7+66Ae46DZz4Qp0
         b1Ar6OuLKkVNwStteZF2zRBJeM/zrcA0Mtl5wYiafW4xHVcUtedPiY5MYyHCl7cR04vj
         mb9nYE8psZSo9d2mVOkW2q7GN5lvN+nEfn8jAA06B1euZfaZhEISLXjJ715JbAA/JzHX
         3kJc56w90k8d1spd6D5S+No6Ueg3J+iR9U5lQiZXI/MZ+1ZjWTOQgvohp8+OCdo56Whl
         n3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvOq+Zi/CHrahUTvogxV5HI9MG7ly8TSlygcZpw2NKU=;
        b=NxcR1PFvX1oenmo9+S5HFvCU3o29N5a+5aWatqUDhWno0urXSha4jFMmZGr3pIa0h+
         8eBYIN///d6chNy3WFfoxdvjcvMoXlXIl2ktLMYHrrc/ZjBBCOkV6miu4NbmET928gUf
         L0FXvdI/oAKb+GlgUItgUpvj8r8Q/rqauhgXjuO8w6MgDc1xBqO3RH4z6PHRbWqhEUY/
         aDRrNTqIGpor+ZK9LD92OSs4o6wD1VuYZnC8PFIfqSqpRhNdr9b7j52CsadmFfr3msS6
         dESBxiQF7qAk0GRyw2iieKCxA8ND3QMLcpInpy2o7uULP7K4M9QtTBt3CKbwR8XnPdME
         seag==
X-Gm-Message-State: AOAM5308vCDUPCH3OiFUdZEHn+t7DmmwGogk8MHS3j7DmJw1n6q6k1oh
        LZNnoQvYX7+xCr2izzSmWQMHQQ==
X-Google-Smtp-Source: ABdhPJzG5LaxzYXvTa7sgaqLrCNzC5Gk/aJzsaBAtTWCgP/By2jMU7TL9EJUN+g6ApNOSDgwYa3RsQ==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr3451218wmf.37.1606398209121;
        Thu, 26 Nov 2020 05:43:29 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 29/40] drm/amd/pm/powerplay/hwmgr/vega20_thermal: Fix some outdated function documentation
Date:   Thu, 26 Nov 2020 13:42:29 +0000
Message-Id: <20201126134240.3214176-30-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:217: warning: Function parameter or member 'hwmgr' not described in 'vega20_thermal_get_temperature'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:242: warning: Function parameter or member 'hwmgr' not described in 'vega20_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:242: warning: Function parameter or member 'range' not described in 'vega20_thermal_set_temperature_range'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:278: warning: Function parameter or member 'hwmgr' not described in 'vega20_thermal_enable_alert'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:296: warning: Function parameter or member 'hwmgr' not described in 'vega20_thermal_disable_alert'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:310: warning: Function parameter or member 'hwmgr' not described in 'vega20_thermal_stop_thermal_controller'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:326: warning: Function parameter or member 'hwmgr' not described in 'vega20_thermal_setup_fan_table'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../amd/pm/powerplay/hwmgr/vega20_thermal.c   | 54 +++++++++----------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index 364162ddaa9c6..269dd7e95a445 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -209,10 +209,10 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 }
 
 /**
-* Reads the remote temperature from the SIslands thermal controller.
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega20_thermal_get_temperature - Reads the remote temperature from the SIslands thermal controller.
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega20_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -230,13 +230,12 @@ int vega20_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Set the requested temperature range for high and low alert signals
-*
-* @param    hwmgr The address of the hardware manager.
-* @param    range Temperature range to be programmed for
-*           high and low alert signals
-* @exception PP_Result_BadInput if the input data is not valid.
-*/
+ * vega20_thermal_set_temperature_range - Set the requested temperature range for high and low alert signals
+ *
+ * @hwmgr: The address of the hardware manager.
+ * @range: Temperature range to be programmed for high and low alert signals
+ * Exception: PP_Result_BadInput if the input data is not valid.
+ */
 static int vega20_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
@@ -270,10 +269,10 @@ static int vega20_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 }
 
 /**
-* Enable thermal alerts on the RV770 thermal controller.
-*
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega20_thermal_enable_alert - Enable thermal alerts on the RV770 thermal controller.
+ *
+ * @hwmgr: The address of the hardware manager.
+ */
 static int vega20_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -289,9 +288,9 @@ static int vega20_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Disable thermal alerts on the RV770 thermal controller.
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega20_thermal_disable_alert - Disable thermal alerts on the RV770 thermal controller.
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega20_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -302,10 +301,10 @@ int vega20_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Uninitialize the thermal controller.
-* Currently just disables alerts.
-* @param    hwmgr The address of the hardware manager.
-*/
+ * vega20_thermal_stop_thermal_controller - Uninitialize the thermal controller.
+ * Currently just disables alerts.
+ * @hwmgr: The address of the hardware manager.
+ */
 int vega20_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 {
 	int result = vega20_thermal_disable_alert(hwmgr);
@@ -314,14 +313,9 @@ int vega20_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
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
+ * vega20_thermal_setup_fan_table - Set up the fan table to control the fan using the SMC.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ */
 static int vega20_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 {
 	int ret;
-- 
2.25.1

