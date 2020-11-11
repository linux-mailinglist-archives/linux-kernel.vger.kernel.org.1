Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058062AF82E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKKSgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgKKSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:06 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA47C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so3174721wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+2/74QrDEEKKJXkOkI83hXV4pIp2Mbn56f+kjUKQmw=;
        b=HTWXyLmbRrgE4PKmA7/WG+a0iz/P94gk0iGkTjccCVy/t4igMz5c/KjOl+W5iEMFpm
         oRnVq2a1lcPn6JVUBWZMkgw7mezOKW7eJLebqzp1adFNR0kxGH91hiUt4ypUwmEgBaTM
         ewBI8uIgWOfYdhJfI26BSk2Hz/sV07h/LmcHrbP6rrVFmQgiv+upd4Orqn6erjuAaWSf
         wSPjOxmulTrlHxBpZFWhHZ/OhKtPo5OufF/JDnMnbS4e27uI47M4BEM7ycczUnfUUJMo
         /iAj8eiP0FA2g01MkY+agP870L7Vg9iqCI1zBqkEcTlAFHDc4GgoHfo64C67N80MCVRi
         zf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+2/74QrDEEKKJXkOkI83hXV4pIp2Mbn56f+kjUKQmw=;
        b=PLJKKeHpsnaOf/pTsfRZYuGjC+nV0qoGzojrdUgprPqM+IpecGPcAo2CpS9SEXvjGE
         Z5TyVNn9xODdtSKfiYJU+447NbcSULC/al+ArRLf8C20e//YDnhglroSGUlzM6VAjuF+
         KmrGdlW9fOEWLFfX3166RLro5UakNMKY5P/+Z4Hq4bCGeQJnjeMQ/gWHmUU/pvpouD+z
         iPTYo07a3PcMwRKpSOUM7XWlnmH1+6BnweEC0s/MaA2o+h5REvZwBUzAEipMfSgv9aX3
         l2/qjkL5zHLmqiKrFZRp6k68TpmmtMel5G0H9KgFgnozP2ZxeR2L3Y+qLKT/A/eT9SPQ
         g70g==
X-Gm-Message-State: AOAM531pshrTvrGOI6tB8oUivfbjWsE1Ss8nP4A1tvuP0BuaLaNTbG4V
        5QXVhqSYdrUT2aS6YjrwvNDmCg==
X-Google-Smtp-Source: ABdhPJx/6GPD5bNUEzgf1RBlqlRgS1CUI9NasMu1q7fYRmdc39AH0cYwygHMY3Bg2shroUKYe8nsmA==
X-Received: by 2002:a1c:6654:: with SMTP id a81mr5827678wmc.104.1605119764891;
        Wed, 11 Nov 2020 10:36:04 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Slava Grigorev <slava.grigorev@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/19] drm/radeon/radeon_audio: Move 'dce6_*()'s prototypes to shared header
Date:   Wed, 11 Nov 2020 18:35:37 +0000
Message-Id: <20201111183545.1756994-12-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/dce6_afmt.c:32:5: warning: no previous prototype for ‘dce6_endpoint_rreg’ [-Wmissing-prototypes]
 32 | u32 dce6_endpoint_rreg(struct radeon_device *rdev,
 | ^~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce6_afmt.c:46:6: warning: no previous prototype for ‘dce6_endpoint_wreg’ [-Wmissing-prototypes]
 46 | void dce6_endpoint_wreg(struct radeon_device *rdev,
 | ^~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce6_afmt.c:110:6: warning: no previous prototype for ‘dce6_afmt_select_pin’ [-Wmissing-prototypes]
 110 | void dce6_afmt_select_pin(struct drm_encoder *encoder)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce6_afmt.c:123:6: warning: no previous prototype for ‘dce6_afmt_write_latency_fields’ [-Wmissing-prototypes]
 123 | void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce6_afmt.c:152:6: warning: no previous prototype for ‘dce6_afmt_hdmi_write_speaker_allocation’ [-Wmissing-prototypes]
 152 | void dce6_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce6_afmt.c:177:6: warning: no previous prototype for ‘dce6_afmt_dp_write_speaker_allocation’ [-Wmissing-prototypes]
 177 | void dce6_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce6_afmt.c:202:6: warning: no previous prototype for ‘dce6_afmt_write_sad_regs’ [-Wmissing-prototypes]
 202 | void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce6_afmt.c:268:6: warning: no previous prototype for ‘dce6_hdmi_audio_set_dto’ [-Wmissing-prototypes]
 268 | void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
 | ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce6_afmt.c:287:6: warning: no previous prototype for ‘dce6_dp_audio_set_dto’ [-Wmissing-prototypes]
 287 | void dce6_dp_audio_set_dto(struct radeo_device *rdev,
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Slava Grigorev <slava.grigorev@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/dce6_afmt.c    |  1 +
 drivers/gpu/drm/radeon/dce6_afmt.h    | 52 +++++++++++++++++++++++++++
 drivers/gpu/drm/radeon/radeon_audio.c | 17 +--------
 3 files changed, 54 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/dce6_afmt.h

diff --git a/drivers/gpu/drm/radeon/dce6_afmt.c b/drivers/gpu/drm/radeon/dce6_afmt.c
index eec5d7a627388..4a1d5447eac17 100644
--- a/drivers/gpu/drm/radeon/dce6_afmt.c
+++ b/drivers/gpu/drm/radeon/dce6_afmt.c
@@ -22,6 +22,7 @@
  */
 #include <linux/hdmi.h>
 
+#include "dce6_afmt.h"
 #include "radeon.h"
 #include "radeon_audio.h"
 #include "sid.h"
diff --git a/drivers/gpu/drm/radeon/dce6_afmt.h b/drivers/gpu/drm/radeon/dce6_afmt.h
new file mode 100644
index 0000000000000..176a538664a27
--- /dev/null
+++ b/drivers/gpu/drm/radeon/dce6_afmt.h
@@ -0,0 +1,52 @@
+/* dce6_afmt.h -- Private header for radeon driver -*- linux-c -*-
+ *
+ * Copyright 2013 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#ifndef __DCE6_AFMT_H__
+#define __DCE6_AFMT_H__
+
+struct cea_sad;
+struct drm_connector;
+struct drm_display_mode;
+struct drm_encoder;
+struct radeon_crtc;
+struct radeon_device;
+
+u32 dce6_endpoint_rreg(struct radeon_device *rdev, u32 offset, u32 reg);
+void dce6_endpoint_wreg(struct radeon_device *rdev, u32 offset, u32 reg, u32 v);
+void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
+			      struct cea_sad *sads, int sad_count);
+void dce6_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
+					     u8 *sadb, int sad_count);
+void dce6_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
+					   u8 *sadb, int sad_count);
+void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
+				    struct drm_connector *connector,
+				    struct drm_display_mode *mode);
+void dce6_afmt_select_pin(struct drm_encoder *encoder);
+void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
+			     struct radeon_crtc *crtc, unsigned int clock);
+void dce6_dp_audio_set_dto(struct radeon_device *rdev,
+			   struct radeon_crtc *crtc, unsigned int clock);
+
+#endif                         /* __DCE6_AFMT_H__ */
diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 9d9a5b3251de3..7c5e80d03fc90 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -25,6 +25,7 @@
 #include <linux/gcd.h>
 
 #include <drm/drm_crtc.h>
+#include "dce6_afmt.h"
 #include "evergreen_hdmi.h"
 #include "radeon.h"
 #include "atom.h"
@@ -33,24 +34,8 @@
 
 void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
 		u8 enable_mask);
-u32 dce6_endpoint_rreg(struct radeon_device *rdev, u32 offset, u32 reg);
-void dce6_endpoint_wreg(struct radeon_device *rdev,
-		u32 offset, u32 reg, u32 v);
-void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
-		struct cea_sad *sads, int sad_count);
-void dce6_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
-		u8 *sadb, int sad_count);
-void dce6_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
-		u8 *sadb, int sad_count);
-void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
-		struct drm_connector *connector, struct drm_display_mode *mode);
 struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
 struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
-void dce6_afmt_select_pin(struct drm_encoder *encoder);
-void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
-void dce6_dp_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
 static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
 static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
-- 
2.25.1

