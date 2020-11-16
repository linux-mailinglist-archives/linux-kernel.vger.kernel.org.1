Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D822A2B4D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgKPRhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbgKPRh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:29 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47418C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:28 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so19620822wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSXwzYYa3bheoqJKyaC1w7673tL6Q8v8SIpeWSSUs90=;
        b=pXl4sHfMaTKTY9Q0Zsn5yjN7hRjS/IdOzo8DPxbXOdgZOx/98qBDGLun2ASDG/w1/4
         unDvFLcXrDlaDp1M9162PTpxW5DdxUsm5DSJzpbR1IcVBMgVRvNwvbw+0RJKpXIEDqRV
         KqpVTwjZs4/exFk99wUJWk01rrCbkTIU1bXQf/9THZKimB9UuJEooP+AaLsjDtHRKA7R
         qRIjZNpT+e0aWaANN0IZBWhp7bwPEwdV3UjMD+5JO1JIBGe9ora8sJaL8wEr5pC6xQcB
         u2nqq4Z6lzwq1yfln34quSTp7gzwBDuO8YIrfTApoTFPaxdtWk4ymweyF/4FPk6nGkcD
         lk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSXwzYYa3bheoqJKyaC1w7673tL6Q8v8SIpeWSSUs90=;
        b=c4F4nBNFRtzvbhZFEqrhU1ycccRnAjrqAzVKvX1RZPVHfnPavi13gOr/XynTynkmMA
         n7vpkVIiv2mTXcdjl5/3AzgXfZK2vdM/pC3fDluEaqWgR3OWQcj7A9hKrFnFXdTOKGYj
         Lf0SkrdVxNFCMtVohl/t7JCAsbU316Dma2NS75JCYAXKFBm/agSeof4ztFGZF1u+GzDH
         QG+bUs/yYO5L+rMj7bDRVbehPbhIWjl9zxuBBos0SWb2A5bX0ZKO4kn4wCpNarNelad/
         JRFVX8S1SnqmS8UCmhQQLUk6qwurpwIVzHkpAYHjSosiGeLB8Wt7sWQo0zXpMUGVGn1s
         HVDw==
X-Gm-Message-State: AOAM532LAAPMRTQB4oSaVs77O5gEFkG/kadGZdTOynogCLOnSdZ+cRx/
        z1UAsCA9VLFATa7bkC77rNddj3zZA/WPCyoz
X-Google-Smtp-Source: ABdhPJzpL+DSQpluUPonMO0JgVdJwq3bt4AqIcOQaElqxHe9h1HE2R1m3A0L1WgTTIy/uy6vQajzFg==
X-Received: by 2002:a05:6000:347:: with SMTP id e7mr20164454wre.35.1605548247016;
        Mon, 16 Nov 2020 09:37:27 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/43] drm/radeon/evergreen_hdmi: Move 'evergreen_*()' and 'dce4_*()' HDMI prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:34 +0000
Message-Id: <20201116173700.1830487-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
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
index f6c783e19c988..3cc53db04d645 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -25,33 +25,24 @@
 #include <linux/gcd.h>
 
 #include <drm/drm_crtc.h>
+#include "evergreen_hdmi.h"
 #include "radeon.h"
 #include "atom.h"
 #include "radeon_audio.h"
 
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
@@ -59,37 +50,22 @@ struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
 void dce6_afmt_select_pin(struct drm_encoder *encoder);
 void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
-void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
-void dce4_dp_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
 void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
 void dce6_dp_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
 void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
 	unsigned char *buffer, size_t size);
-void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
-	unsigned char *buffer, size_t size);
 void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 	const struct radeon_hdmi_acr *acr);
-void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
-	const struct radeon_hdmi_acr *acr);
 void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
-void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
-void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
-	u32 offset, int bpc);
 void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
-void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
 void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
-void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
 static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
 void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
-void evergreen_hdmi_enable(struct drm_encoder *encoder, bool enable);
-void evergreen_dp_enable(struct drm_encoder *encoder, bool enable);
 
 static const u32 pin_offsets[7] =
 {
-- 
2.25.1

