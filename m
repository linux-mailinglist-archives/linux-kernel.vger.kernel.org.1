Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256682ADF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbgKJTbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbgKJTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:47 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD96C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:46 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so13206005wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVg0DFwyE/SgrsDhpoYtlBvB7g78lLsCkWm+YVU0fXA=;
        b=ksFQ83FlIf3YwYoXo3QvMRd8PasXwtNX1dm6FiISlgeWZKjLdanxdF4/UcxHNxb99q
         EwrNKJmxIDt47d9KkwcQ26zRwCKLjDVkOPK9a/W7xNlujwKIY4cCPUnEj0mFxje1M3wy
         oaW3qs9MkWucXcHMT8eS2bN90+SkftCPfmxVGPGMkmkyRzc6hpKuqX0WV1ylvrzl7Cu3
         Q2yUsT5PzovRZh8eMBzigwQWrXwFat8shXLhBgkJbw+RUlZAt4t3dj6ty8nM5SbpqOE8
         fT8xpFpvFXUAMbPpuigkQChSHHdPxMtAFOooRaVAUzuPukZ9+AJaLCCg59vXpQ26MhO3
         QYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVg0DFwyE/SgrsDhpoYtlBvB7g78lLsCkWm+YVU0fXA=;
        b=IsAnUxUPga3KftZXLBNpcPQsD+75at6oo7TIf+lKFQl70PA7bF8KIn32tHFQEQeyB6
         R0LicdJf7oiMRlMKNOai2W39bYtjHsY6kCdIQCh1m/Vev/6qUD9EXxJGL4o8jc/029sJ
         RJMHNt/6q+iley5SVDU041NT42ehMEF45a9MyOI5QQ5y5B/qcvTUPgv/5EDatFSzbyz5
         LSHRlyS2sy+xLR3aOOLycBB9laUJts18lFvOvEEseHRVLBJqWHKDQmKFP+32CWCQKg6I
         Iz58tQYjaKgkULkxbMrgA0wOPBhgmFH4LXX8aCU7fNu8ik3S3TgMA2S1atsMxcJXIKa6
         yNow==
X-Gm-Message-State: AOAM530by7CWkUCn39RtZG+jKfvNCfzJvEdPlP1Zv3zpJiz+8W7cqPP0
        CRsB90H1Nl97jidoLjhMccX1AlgXoYHIkze3
X-Google-Smtp-Source: ABdhPJygMmpNGiYwyY9Hp8c8g5cYN5O03+XVkZ7r9rAV7oETs5rFaIzRIiwpnXSBsMSvpLOffHqnvg==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr8802372wru.204.1605036704855;
        Tue, 10 Nov 2020 11:31:44 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 23/30] drm/radeon/evergreen_hdmi: Move 'evergreen_*()' and 'dce4_*()' HDMI prototypes to shared header
Date:   Tue, 10 Nov 2020 19:31:05 +0000
Message-Id: <20201110193112.988999-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/evergreen_hdmi.c:37:6: warning: no previous prototype for ‘dce4_audio_enable’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:67:6: warning: no previous prototype for ‘evergreen_hdmi_update_acr’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:97:6: warning: no previous prototype for ‘dce4_afmt_write_latency_fields’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:119:6: warning: no previous prototype for ‘dce4_afmt_hdmi_write_speaker_allocation’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:137:6: warning: no previous prototype for ‘dce4_afmt_dp_write_speaker_allocation’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:155:6: warning: no previous prototype for ‘evergreen_hdmi_write_sad_regs’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:208:6: warning: no previous prototype for ‘evergreen_set_avi_packet’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:227:6: warning: no previous prototype for ‘dce4_hdmi_audio_set_dto’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:270:6: warning: no previous prototype for ‘dce4_dp_audio_set_dto’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:306:6: warning: no previous prototype for ‘dce4_set_vbi_packet’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:317:6: warning: no previous prototype for ‘dce4_hdmi_set_color_depth’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:354:6: warning: no previous prototype for ‘dce4_set_audio_packet’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:389:6: warning: no previous prototype for ‘dce4_set_mute’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:400:6: warning: no previous prototype for ‘evergreen_hdmi_enable’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/evergreen_hdmi.c:440:6: warning: no previous prototype for ‘evergreen_dp_enable’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen_hdmi.c |  1 +
 drivers/gpu/drm/radeon/evergreen_hdmi.h | 69 +++++++++++++++++++++++++
 drivers/gpu/drm/radeon/radeon_audio.c   | 26 +---------
 3 files changed, 71 insertions(+), 25 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/evergreen_hdmi.h

diff --git a/drivers/gpu/drm/radeon/evergreen_hdmi.c b/drivers/gpu/drm/radeon/evergreen_hdmi.c
index 739336a48d085..5f3078f8ab950 100644
--- a/drivers/gpu/drm/radeon/evergreen_hdmi.c
+++ b/drivers/gpu/drm/radeon/evergreen_hdmi.c
@@ -27,6 +27,7 @@
 #include <linux/hdmi.h>
 
 #include <drm/radeon_drm.h>
+#include "evergreen_hdmi.h"
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_audio.h"
diff --git a/drivers/gpu/drm/radeon/evergreen_hdmi.h b/drivers/gpu/drm/radeon/evergreen_hdmi.h
new file mode 100644
index 0000000000000..c86276b8d7f58
--- /dev/null
+++ b/drivers/gpu/drm/radeon/evergreen_hdmi.h
@@ -0,0 +1,69 @@
+/* evergreen_hdmi.h -- Private header for radeon driver -*- linux-c -*-
+ *
+ * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
+ * Copyright 2000 VA Linux Systems, Inc., Fremont, California.
+ * All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * PRECISION INSIGHT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __EVERGREEN_HDMI_H__
+#define __EVERGREEN_HDMI_H__
+
+struct cea_sa;
+struct cea_sad;
+struct drm_connector;
+struct drm_display_mode;
+struct drm_encoder;
+struct r600_audio_pin;
+struct radeon_crtc;
+struct radeon_device;
+struct radeon_hdmi_acr;
+
+void evergreen_hdmi_write_sad_regs(struct drm_encoder *encoder,
+				   struct cea_sad *sads, int sad_count);
+void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
+			      unsigned char *buffer, size_t size);
+void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
+			       const struct radeon_hdmi_acr *acr);
+void evergreen_hdmi_enable(struct drm_encoder *encoder, bool enable);
+void evergreen_dp_enable(struct drm_encoder *encoder, bool enable);
+
+void dce4_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
+		       u8 enable_mask);
+void dce4_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
+					     u8 *sadb, int sad_count);
+void dce4_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
+					   u8 *sadb, int sad_count);
+void dce4_afmt_write_latency_fields(struct drm_encoder *encoder,
+				    struct drm_connector *connector,
+				    struct drm_display_mode *mode);
+void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
+			     struct radeon_crtc *crtc, unsigned int clock);
+void dce4_dp_audio_set_dto(struct radeon_device *rdev,
+			   struct radeon_crtc *crtc, unsigned int clock);
+void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
+void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
+			       u32 offset, int bpc);
+void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
+void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
+
+#endif				/* __EVERGREEN_HDMI_H__ */
diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 18228b366752e..7a59028f64fbc 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -25,6 +25,7 @@
 #include <linux/gcd.h>
 
 #include <drm/drm_crtc.h>
+#include "evergreen_hdmi.h"
 #include "radeon.h"
 #include "atom.h"
 #include "r600d.h"
@@ -32,55 +33,30 @@
 
 void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
 		u8 enable_mask);
-void dce4_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
-		u8 enable_mask);
 void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
 		u8 enable_mask);
 u32 dce6_endpoint_rreg(struct radeon_device *rdev, u32 offset, u32 reg);
 void dce6_endpoint_wreg(struct radeon_device *rdev,
 		u32 offset, u32 reg, u32 v);
-void evergreen_hdmi_write_sad_regs(struct drm_encoder *encoder,
-		struct cea_sad *sads, int sad_count);
 void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
 		struct cea_sad *sads, int sad_count);
-void dce4_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
-		u8 *sadb, int sad_count);
-void dce4_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
-		u8 *sadb, int sad_count);
 void dce6_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
 		u8 *sadb, int sad_count);
 void dce6_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
 		u8 *sadb, int sad_count);
-void dce4_afmt_write_latency_fields(struct drm_encoder *encoder,
-		struct drm_connector *connector, struct drm_display_mode *mode);
 void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
 		struct drm_connector *connector, struct drm_display_mode *mode);
 struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
 struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
 void dce6_afmt_select_pin(struct drm_encoder *encoder);
-void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
-void dce4_dp_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
 void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
 void dce6_dp_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
-void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
-	unsigned char *buffer, size_t size);
-void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
-	const struct radeon_hdmi_acr *acr);
-void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
-void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
-	u32 offset, int bpc);
-void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
-void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
 static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
-void evergreen_hdmi_enable(struct drm_encoder *encoder, bool enable);
-void evergreen_dp_enable(struct drm_encoder *encoder, bool enable);
 
 static const u32 pin_offsets[7] =
 {
-- 
2.25.1

