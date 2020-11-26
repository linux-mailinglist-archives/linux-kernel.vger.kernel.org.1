Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220722C5653
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390985AbgKZNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390693AbgKZNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:29 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF7C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:29 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so3693131wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0apstHJcdeOJJW9Rp51CgUS07wmlnhOot/Yb8U7ShY=;
        b=R+ke7JtZPgsc78EmFR6U0OdvfKYXOPVsJWKDRwLe3Ib/J8HQUt/IyO9zTCBy6ycOwp
         3W6aObfhdCgvjBaLbR9kCaf+DYxtlxZGQ1ThIPq8Vds/1uNBJWazJO23cK6YqcZ3c+Yc
         MqfvUgwieLkQBpToE6a7CdkpYbfdLiWr5VWEPlODGD5Zk31w7mwaLI/kjS7sA2rMeum0
         1S3ERwYCziOtrYZLOk9P+xCMMFHkzDKyBpVRoDA4vmDWdGi9vr0zYxIMCGF3GF85HU6U
         EuaaisE1ndR/xqpCDhrU3qdVwT5AsQIhI1HHu6GIos3y7XyF9T0c5b90tmIIEGgwTWJ8
         621Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0apstHJcdeOJJW9Rp51CgUS07wmlnhOot/Yb8U7ShY=;
        b=BT/65fAwH3KEzJHJac1sppuimft5Syr4w0vGIdXs9s5M9ZWPvXbbIyYr/Hzc74QNNJ
         Pk9zF2YshVw3vFtQGarReyYK2ABhnw0VXRffDBYWBGWgl4TyPSL4WBIL5qrh8XjDEtrW
         6CMA2qy0vOK2jLCsc3w7T0h/8OtdPGYbeHupdxOP3SIa4VLqbqnUOhXd2xmOVVcLqYhl
         X4Gt1Evwqimi3xxYCUd6VpjsYaugtIVbT3ie/ZjAHwJeQgnUTCHvvUYPxAOligkfPSzj
         B97SncFXR+AzEaF5UqCDX4RjbFT6LXYfoa7WjdR6tQh9Z2g2GcwwjxYB5YIuV4Y9ykKG
         X4wA==
X-Gm-Message-State: AOAM530M4RFg8j/MTt+uCVKLDNPwLyO56eLKRWz0Kii11wjvKqQh7/a4
        qT8Kmef8fAzdIjYsl1/VXqEpFg==
X-Google-Smtp-Source: ABdhPJzlIHc2c/XjQl02c0jI8u0yuAVD3Oew92DIaDaYRljVrBeZBuPDQMsWkUM7OAdpfTfPo5rbqg==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr3666442wmj.36.1606398207768;
        Thu, 26 Nov 2020 05:43:27 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/40] drm/amd/pm/powerplay/hwmgr/smu_helper: Demote or fix kernel-doc headers
Date:   Thu, 26 Nov 2020 13:42:28 +0000
Message-Id: <20201126134240.3214176-29-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:112: warning: Function parameter or member 'hwmgr' not described in 'phm_wait_on_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:112: warning: Function parameter or member 'index' not described in 'phm_wait_on_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:112: warning: Function parameter or member 'value' not described in 'phm_wait_on_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:112: warning: Function parameter or member 'mask' not described in 'phm_wait_on_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warning: Function parameter or member 'hwmgr' not described in 'phm_wait_on_indirect_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warning: Function parameter or member 'indirect_port' not described in 'phm_wait_on_indirect_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warning: Function parameter or member 'index' not described in 'phm_wait_on_indirect_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warning: Function parameter or member 'value' not described in 'phm_wait_on_indirect_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warning: Function parameter or member 'mask' not described in 'phm_wait_on_indirect_register'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:494: warning: Function parameter or member 'hwmgr' not described in 'phm_initializa_dynamic_state_adjustment_rule_settings'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 2a0ca5194bbe9..bfe80ac0ad8c8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -103,7 +103,7 @@ uint32_t phm_set_field_to_u32(u32 offset, u32 original_data, u32 field, u32 size
 	return original_data;
 }
 
-/**
+/*
  * Returns once the part of the register indicated by the mask has
  * reached the given value.
  */
@@ -132,7 +132,7 @@ int phm_wait_on_register(struct pp_hwmgr *hwmgr, uint32_t index,
 }
 
 
-/**
+/*
  * Returns once the part of the register indicated by the mask has
  * reached the given value.The indirect space is described by giving
  * the memory-mapped index of the indirect index register.
@@ -486,9 +486,9 @@ int phm_get_sclk_for_voltage_evv(struct pp_hwmgr *hwmgr,
 }
 
 /**
- * Initialize Dynamic State Adjustment Rule Settings
+ * phm_initializa_dynamic_state_adjustment_rule_settings - Initialize Dynamic State Adjustment Rule Settings
  *
- * @param    hwmgr  the address of the powerplay hardware manager.
+ * @hwmgr:  the address of the powerplay hardware manager.
  */
 int phm_initializa_dynamic_state_adjustment_rule_settings(struct pp_hwmgr *hwmgr)
 {
-- 
2.25.1

