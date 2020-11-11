Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3772AF844
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgKKShd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbgKKSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE3FC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:00 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so3526783wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+vpUFKiF0HcP1zSRTFbAOX8pFoOA6PVK8Wzkj+zQXI=;
        b=jeGdCa0NoNUq3v4IBNq+kFqCX0O6wzIHiSzPq+rxIAFPzZ0c3KttYWZ8Hm79XPkGsR
         TOFT+rRsoYoNK23zhRzpQym2B27iatWLIVg78YGh8V8E6iOGuGvzj2wVfpFcsWEwT8n7
         HOhB3HXwoFsyYEv5nVILuX3r4vRAXkWfe4fiWJrX1RoFr+QdimVEVSOn25GzCXScyT6S
         V5P1JIzy6Gn5WS7kdxE3JqwhIqMsb4tL8gFIi5gEgvpY5v5dicbDdGGcnXSaJWChoCVn
         CHv4e3eMR0jlBUD1/ziqDXiXM2JE4yxki+c+ns6thWLWjdHzL0/n9l983FHIGIAAvbh9
         5wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+vpUFKiF0HcP1zSRTFbAOX8pFoOA6PVK8Wzkj+zQXI=;
        b=EGvP7ju62qZCu/zw/h8i0aVml6xw2VQ753N1w34Kih6v7y4/zlfscZbzxEncM92siz
         iXbQe8dpMzGO5zhKsSdTbV6vMIF3RO/PyzPJfAl26moLtxfzmYKFNM/uFTevfQ2s9HU1
         oBaIBp+Rijl4d0xEw0xIvcMnT5ArMvZEpHrEw7CHVQQqBzrUwF53HsK36BQx9B72tg01
         SX31OV1OpxO94c5udfzYbeht5Kf0SFRNwShrFG5A9Up8aKkYblHI3ACwyRNAtmobuIL9
         FwHpeLx0C0CBcNej91tXMvqgJ7dFSrIW5aJCVPHv56EV07VfSVyZ4nTzjV8HVWzp9Poe
         bXmA==
X-Gm-Message-State: AOAM532JjAaD4B4Kzrjq0M8/w0LaGk8xQwAx0ll7ojBhL402OA4fmWo0
        kCWdsr//qxrFZBZygcWjjuepB2dFNXu+H94c
X-Google-Smtp-Source: ABdhPJxuL3j8SAz2c+7zKK78PcV84iIcwyLkjoqpK4Yb0pYDqOIuwBP5Vzr3Sy4M0XLBM8Bn2/NrPA==
X-Received: by 2002:adf:fd0d:: with SMTP id e13mr29324843wrr.85.1605119759656;
        Wed, 11 Nov 2020 10:35:59 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:35:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/19] drm/radeon/si_dpm: Move 'si_mc_load_microcode()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:33 +0000
Message-Id: <20201111183545.1756994-8-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/si.c:1570:5: warning: no previous prototype for ‘si_mc_load_microcode’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/si.c     |  1 +
 drivers/gpu/drm/radeon/si.h     | 31 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/radeon/si_dpm.c |  2 +-
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/radeon/si.h

diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index d0407145c07b5..88731b79c8f57 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -39,6 +39,7 @@
 #include "radeon_audio.h"
 #include "radeon_ucode.h"
 #include "si_blit_shaders.h"
+#include "si.h"
 #include "sid.h"
 
 
diff --git a/drivers/gpu/drm/radeon/si.h b/drivers/gpu/drm/radeon/si.h
new file mode 100644
index 0000000000000..0a5018ef166e2
--- /dev/null
+++ b/drivers/gpu/drm/radeon/si.h
@@ -0,0 +1,31 @@
+/* si.h -- Private header for radeon driver -*- linux-c -*-
+ *
+ * Copyright 2011 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __SI_H__
+#define __SI_H__
+
+struct radeon_device;
+
+int si_mc_load_microcode(struct radeon_device *rdev);
+
+#endif                         /* __SI_H__ */
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index c68ab2fb1ac23..32b697965c064 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -32,6 +32,7 @@
 #include "radeon_asic.h"
 #include "ni_dpm.h"
 #include "si_dpm.h"
+#include "si.h"
 #include "sid.h"
 
 #define MC_CG_ARB_FREQ_F0           0x0a
@@ -1721,7 +1722,6 @@ static const struct si_powertune_data powertune_data_hainan =
 
 struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
 
-extern int si_mc_load_microcode(struct radeon_device *rdev);
 extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable);
 
 static int si_populate_voltage_value(struct radeon_device *rdev,
-- 
2.25.1

