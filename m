Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A142AF838
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgKKSgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgKKSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:15 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE60C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:14 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so3282487wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BRcDWZ7aXWvQb2HLCmLDCFOcRFyEf3okEuPgH0Vsk4=;
        b=Yiw9rQWOdIRvZ8Ojv9Qwo3rXzk0WhXlopbtnHAiSY2MaaYuDQYxYpE9t8FlKVukaxa
         q0cACyMsBPucNhkk/GEIA2b6Duj4q39cgAJxoUb65GjThpVFcNxklrBO4xZjwpHpeP96
         07geHWJWkpWuTn1P2bIjY9cRzMTBmbCVrAAE0+iEWadLcrbhNoQOb+mqB7O3KCLriMLp
         aEtoZDQS6ZpUg3TuPqxJKAFisYH4If35ZF7Te3f4uxc5x6CFZE6G/LNW+ViRlcvnCyvm
         bnZDjdb+DvKsZqfw3mBI1eDjxvYS1UY7+wqZ4p2zsM//XzdxkE1RIniuKmKKU4zRky6F
         n/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BRcDWZ7aXWvQb2HLCmLDCFOcRFyEf3okEuPgH0Vsk4=;
        b=l7r89OWQAPMyxHuaWd3hF9rXa9qKJQFCw2g8HrMTh1N4nzzMBiY2YKLGu1LkpJjQwH
         Ru8rpiCbY4gwOHOsqft8Fgc1jfGZaZ1M34rNwTGjk2RAFeVzBPPgaAVG+sfz03Ik91W4
         P5vGtA6ypm7DUZMpwFOTtfB8+TFCqWUHMfFt++P6J+jL+MXhSrvo2Bd7qfStKIfhe284
         nPHRV5Wm1TdkyOC6r4gYUrFaJ+PvGexqR3v+EHTxKLI9ex5g4NOLUmyc+5+IauhvnYfr
         xrq8fekzkHgpD6VaDEt+tJ3mq36PyjpI/bp6sUrdDt4qf/fzNIVwVm2tI1kpPi7pLFB1
         iDWA==
X-Gm-Message-State: AOAM530aEJ7Y/LhG9ngPcefQx7TfvFSe/phxk689L8RoHy8MAeIW0Uma
        QR9A1rZZX3vpVxX7+mqBcCAKNw==
X-Google-Smtp-Source: ABdhPJwRhL5FRMA3tXZCwEiizu7xyL4NCRD/nQEaNuxnMC0wagzgb3Tdg/OgLoVml4sTrZugBxDb5g==
X-Received: by 2002:a1c:4888:: with SMTP id v130mr5471096wma.84.1605119773011;
        Wed, 11 Nov 2020 10:36:13 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/19] drm/radeon/si_dpm: Move 'vce_v1_0_enable_mgcg()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:43 +0000
Message-Id: <20201111183545.1756994-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111183545.1756994-1-lee.jones@linaro.org>
References: <20201111183545.1756994-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/vce_v1_0.c:102:6: warning: no previous prototype for ‘vce_v1_0_enable_mgcg’ [-Wmissing-prototypes]
 102 | void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable)
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/si_dpm.c      |  3 +--
 drivers/gpu/drm/radeon/trinity_dpm.c |  2 +-
 drivers/gpu/drm/radeon/vce.h         | 34 ++++++++++++++++++++++++++++
 drivers/gpu/drm/radeon/vce_v1_0.c    |  1 +
 4 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/vce.h

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index b4581392fbce9..cd07b06301b44 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -35,6 +35,7 @@
 #include "si_dpm.h"
 #include "si.h"
 #include "sid.h"
+#include "vce.h"
 
 #define MC_CG_ARB_FREQ_F0           0x0a
 #define MC_CG_ARB_FREQ_F1           0x0b
@@ -1721,8 +1722,6 @@ static const struct si_powertune_data powertune_data_hainan =
 	true
 };
 
-extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable);
-
 static int si_populate_voltage_value(struct radeon_device *rdev,
 				     const struct atom_voltage_table *table,
 				     u16 value, SISLANDS_SMC_VOLTAGE_VALUE *voltage);
diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeon/trinity_dpm.c
index e005c18aac00e..08ea1c864cb23 100644
--- a/drivers/gpu/drm/radeon/trinity_dpm.c
+++ b/drivers/gpu/drm/radeon/trinity_dpm.c
@@ -29,6 +29,7 @@
 #include "radeon_asic.h"
 #include "trinity_dpm.h"
 #include "trinityd.h"
+#include "vce.h"
 
 #define TRINITY_MAX_DEEPSLEEP_DIVIDER_ID 5
 #define TRINITY_MINIMUM_ENGINE_CLOCK 800
@@ -293,7 +294,6 @@ static const u32 trinity_override_mgpg_sequences[] =
 	0x00000204, 0x00000000,
 };
 
-extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable);
 static void trinity_program_clk_gating_hw_sequence(struct radeon_device *rdev,
 						   const u32 *seq, u32 count);
 static void trinity_override_dynamic_mg_powergating(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/vce.h b/drivers/gpu/drm/radeon/vce.h
new file mode 100644
index 0000000000000..1eb4f5715202e
--- /dev/null
+++ b/drivers/gpu/drm/radeon/vce.h
@@ -0,0 +1,34 @@
+/* vce.h -- Private header for radeon driver -*- linux-c -*-
+ *
+ * Copyright 2013 Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ */
+
+#ifndef __VCE_H__
+#define __VCE_H__
+
+struct radeon_device;
+
+void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable);
+
+#endif                         /* __VCE_H__ */
diff --git a/drivers/gpu/drm/radeon/vce_v1_0.c b/drivers/gpu/drm/radeon/vce_v1_0.c
index bd75bbcf5bf63..70c5da2141d75 100644
--- a/drivers/gpu/drm/radeon/vce_v1_0.c
+++ b/drivers/gpu/drm/radeon/vce_v1_0.c
@@ -30,6 +30,7 @@
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "sid.h"
+#include "vce.h"
 
 #define VCE_V1_0_FW_SIZE	(256 * 1024)
 #define VCE_V1_0_STACK_SIZE	(64 * 1024)
-- 
2.25.1

