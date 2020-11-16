Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0392E2B4D77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbgKPRh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387483AbgKPRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE73BC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so19605648wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iA8Mvpk+iDAEBWD7dp99arFLgzTdygtvzraETkCMvqc=;
        b=dijXs9QiY2YXee7k4ar4kZpC/iWAoR/rUJaCG/bm3xdVuD56N7C4g2AbD8l6Rg1F5I
         h/beRtehlTdiOWth53tPXNugomaBdkgnhwc+OIwP2ppTAR82r9TWy+dNU/tvjJ1hryOl
         F9U4CG8GWwCQFEXGp9TZv0LJOHDnldMrO7yB5HhBCwWZFY2yt1+yiiG8tzrXxfd0PtB4
         x/2+eZjAB1JQbGHmZOyi9BmYaLUaN1H29pJ8ejLS2fPn1DIfYotLyuNytcIv0ee+CeKg
         KWnpaI5bARlLKgtQ61kjceE1PZaRc8z/5iJtMTJ8+gq7T5IuoW2AMHscNnMLssfGLE3/
         bMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iA8Mvpk+iDAEBWD7dp99arFLgzTdygtvzraETkCMvqc=;
        b=sXpEoqpu4Olt1V8N5LGteCbrbM5Q7af2OPFU+c9ux+0edZEaNmIjrhOkHKOSY0G3cI
         2554yH7URTYlCMN0sF8W1ay29LVsQyXWnPYHU5/QCraGjR5CFsc7MDb4zlHOWNDCQitl
         vH8DxbF6Zj9OM6dJ0yg6OElWQ9xBHI2VNM6LjVw3CvJ+FtGjoRBNjurZt/H8pEN7/j9Y
         G0GH7hIpLmashALv4L+6FzYa3eqOpmyreuQM24Vl9Ty2WaA5qsFGbDkBv/hM0LWCXu2z
         tn/b7p5Oj2hL+pVv/NtAeClvypCL+4YD5sbRAbyqzD7o83NALvwIjXR591TvshsvxMK3
         GqQw==
X-Gm-Message-State: AOAM533D5xJCunXmPEN2N9vFV5Zrj6sHgbHPL7aeUv2G9sU3YQyYpHQS
        ToVsEDESfxS7EG60p70eCvkgeA==
X-Google-Smtp-Source: ABdhPJz/Ubpbh9TF4Mn1AqUV5qJ8i9W/6frkGaLZmvM//1p2FByWTWdexEYFjUR1t3VoEx2XWvbmOA==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr20099999wrj.162.1605548269524;
        Mon, 16 Nov 2020 09:37:49 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Slava Grigorev <slava.grigorev@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 33/43] drm/radeon/radeon_audio: Move 'dce6_*()'s prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:50 +0000
Message-Id: <20201116173700.1830487-34-lee.jones@linaro.org>
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
index 3cc53db04d645..785c23cb30589 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -25,6 +25,7 @@
 #include <linux/gcd.h>
 
 #include <drm/drm_crtc.h>
+#include "dce6_afmt.h"
 #include "evergreen_hdmi.h"
 #include "radeon.h"
 #include "atom.h"
@@ -34,26 +35,10 @@ void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
 		u8 enable_mask);
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
 void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
-void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
-void dce6_dp_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
 void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
 	unsigned char *buffer, size_t size);
 void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
-- 
2.25.1

