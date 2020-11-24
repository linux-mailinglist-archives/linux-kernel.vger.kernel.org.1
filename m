Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC412C311F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgKXTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgKXTot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:49 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35EC08E85E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:48 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so4503195wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfvfRQ7PcXeWjD8kLGjroSyeWiIdkNR2GVd+kakULXA=;
        b=GyUSflYAhp72ymYdK/TLzXTC6jnA3PL8lz6LGThanbH/oCVxl6fYwFpyukGz69I60t
         DezilZrVxmnNrP9s53T07U8j1EadxyiUhAUlmdVbaHS1roFKfuYZvXrTgtBUdcbcMUgB
         6OJnw+uSvL/4ILJOe8BZfP/YE/UnULd86LklD5mgfYSI5ngdwFDBE28hJwm0ClZJC71o
         xpc00paWjoWJ4v/4dfrZpXnfHsrko2HQFsaV84ZIOx8CMMvauYY4PrQYZww9jyfQfZVv
         qCEwhcqAARpGqb1kLIJoNDW2udIUS/DiqrH4EV/xt/8Sn0f3d2s2igUUP3ofNYBfv0CY
         B1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfvfRQ7PcXeWjD8kLGjroSyeWiIdkNR2GVd+kakULXA=;
        b=V1E8XPioYYEW2YlQ3N7TEEAAxqoTJfd9EfPuSHlo3d52Y+bbhsve4I1U9ZjYfA1va0
         vwRGPIcMPC1A6V2Z2daB/vfr2mqK/G4mDHfLLI+dbLpz8cYO7ob7oik3uWgC6/7SPn3f
         11bAvRgmFozKf48baxHUL/HVhLmY5qqMU0S2YmrSkBAtI22OSajbV39dgS1sJNmxeUhz
         hHBJCQccy2LGONuK6yxX9O9L/vZWQM1h+LpMzN+qNSqmp78vNaQGcoCbG8v9ZLkEgjdX
         d27c9URjntHyaq17xAwpnQx1g5i3H+gEZWYVARTAgiGBP/XiHXmUjrpM+fZHtJbE7pYR
         Cm4Q==
X-Gm-Message-State: AOAM5321R/XJ3YpzCvixc9qCm/7fEPLzwLzZtnhZs0BaQaloVXEX0Aop
        jRlOlsFA43mly+nB1z9fWM/WEg==
X-Google-Smtp-Source: ABdhPJyJjV23yZdohN2gtkIsTOcuofWR2WSH8duGcXFhvLfLZcGvGem4By7WDfHpInOfxrtBJiKFMg==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr124603wrr.64.1606247087673;
        Tue, 24 Nov 2020 11:44:47 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 39/40] drm/amd/pm/powerplay/smumgr/fiji_smumgr: Remove unused variable 'result'
Date:   Tue, 24 Nov 2020 19:38:23 +0000
Message-Id: <20201124193824.1118741-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/fiji_smumgr.c: In function ‘fiji_populate_smc_boot_level’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/fiji_smumgr.c:1603:6: warning: variable ‘result’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c   | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
index fef9d3906fccd..fea008cc1f254 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
@@ -1600,20 +1600,19 @@ static int fiji_populate_smc_uvd_level(struct pp_hwmgr *hwmgr,
 static int fiji_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 		struct SMU73_Discrete_DpmTable *table)
 {
-	int result = 0;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
 	table->GraphicsBootLevel = 0;
 	table->MemoryBootLevel = 0;
 
 	/* find boot level from dpm table */
-	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
-			data->vbios_boot_state.sclk_bootup_value,
-			(uint32_t *)&(table->GraphicsBootLevel));
+	phm_find_boot_level(&(data->dpm_table.sclk_table),
+			    data->vbios_boot_state.sclk_bootup_value,
+			    (uint32_t *)&(table->GraphicsBootLevel));
 
-	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
-			data->vbios_boot_state.mclk_bootup_value,
-			(uint32_t *)&(table->MemoryBootLevel));
+	phm_find_boot_level(&(data->dpm_table.mclk_table),
+			    data->vbios_boot_state.mclk_bootup_value,
+			    (uint32_t *)&(table->MemoryBootLevel));
 
 	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
-- 
2.25.1

