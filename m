Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7282AC6FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgKIVTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbgKIVTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:39 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BC2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:39 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so10376953wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivs8p7JDCUXGc2cgIvVJmvGG5nx3ukesj4jjJvZ5SP0=;
        b=WfKgy4obnGDp3z2oavqhYPYCnFzdi0qq4fJnhQ/qoTHYWdV0//xXiGiEEle9NiiUdZ
         7dFOlv+0axSe3ldGBfDxL6JFPqmKylN+1qiz31crs+9Rpb6qTonbnnaSJGwZgB8hjo9h
         +zc49rSeTioIFp/20IaE0nrHmEZIYDpK932ajCNpkShNuDH8ULLH6laIlgPbR0ybXA4M
         FXweYKCt20GRWBnyc3Us0WylLtxa+svuwY24ACCllfgCkR1QvJPG+XRSEFN8fjIBoSWb
         othWv9Mrh390+GEdfa+GqnLN0EeG0Cuq7ydmY0zStvVzoKjklBlDW756Zg6K/Kig8v/I
         4MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivs8p7JDCUXGc2cgIvVJmvGG5nx3ukesj4jjJvZ5SP0=;
        b=lFi+3CS8tJHVUYhcKIgdOacR6D5YWwLLQ8zq3592772nzu5LmqoXgTwgE62UY6blWx
         8qYWqzYOyEbA1PzlkgP+CLOGGN5AJ4U20XiNqHyZJ6HmEx8furzFMI2fSyQtm+lYvXar
         ZZCZbY9WASikQxfEmES59DKWJbjiA+qftJfwPhmS3oynW4EAhdnHw/NqQBMVkjKUOycC
         vh0bx8JtQ/zMu6ZFoj1m+pTLXdHgb+86S5wuwbRI3nFoKv9aeXMffax1baM6zXcZ3oAx
         sbpU/nXOsBJTCebIjjn7YmJOr5hf6B6CzH56DaisJ83RWF2Ym2urDElW7jryjbThS8NM
         cIWg==
X-Gm-Message-State: AOAM531MKuwMTLpK9mR2jBtjOs9j7aRuXSGvbsPKHHlQhQfW1kjcg034
        RO1QvtLNIf9Z74ejt209HsHyjg==
X-Google-Smtp-Source: ABdhPJx0A9zT2NrD4J/aNS6cLETDCC/rZ7lhnojY34EtXNy+BaoSuQY+giUUv2Lo1M1WMSZl+UXD9w==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr13994595wrv.355.1604956777979;
        Mon, 09 Nov 2020 13:19:37 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 15/20] drm/radeon/r600d: Move 'rc600_*' prototypes into shared header
Date:   Mon,  9 Nov 2020 21:18:50 +0000
Message-Id: <20201109211855.3340030-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/r600_hdmi.c:177:6: warning: no previous prototype for ‘r600_hdmi_update_acr’ [-Wmissing-prototypes]
 177 | void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/r600_hdmi.c:217:6: warning: no previous prototype for ‘r600_set_avi_packet’ [-Wmissing-prototypes]
 217 | void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
 | ^~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/r600_hdmi.c:314:6: warning: no previous prototype for ‘r600_hdmi_audio_set_dto’ [-Wmissing-prototypes]
 314 | void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
 | ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/r600_hdmi.c:340:6: warning: no previous prototype for ‘r600_set_vbi_packet’ [-Wmissing-prototypes]
 340 | void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset)
 | ^~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/r600_hdmi.c:351:6: warning: no previous prototype for ‘r600_set_audio_packet’ [-Wmissing-prototypes]
 351 | void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset)
 | ^~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/r600_hdmi.c:393:6: warning: no previous prototype for ‘r600_set_mute’ [-Wmissing-prototypes]
 393 | void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute)
 | ^~~~~~~~~~~~~
 drivers/gpu/drm/radeon/r600_hdmi.c:469:6: warning: no previous prototype for ‘r600_hdmi_enable’ [-Wmissing-prototypes]
 469 | void r600_hdmi_enable(struct drm_encoder *encoder, bool enable)
 | ^~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/r600d.h        | 14 ++++++++++++++
 drivers/gpu/drm/radeon/radeon_audio.c | 11 +----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600d.h b/drivers/gpu/drm/radeon/r600d.h
index 2e00a5287bd2d..db4bcc8bee4e5 100644
--- a/drivers/gpu/drm/radeon/r600d.h
+++ b/drivers/gpu/drm/radeon/r600d.h
@@ -27,6 +27,20 @@
 #ifndef R600D_H
 #define R600D_H
 
+struct radeon_crtc;
+struct radeon_hdmi_acr;
+
+void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
+void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
+void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
+	struct radeon_crtc *crtc, unsigned int clock);
+void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
+	unsigned char *buffer, size_t size);
+void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
+	const struct radeon_hdmi_acr *acr);
+void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
+void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
+
 #define CP_PACKET2			0x80000000
 #define		PACKET2_PAD_SHIFT		0
 #define		PACKET2_PAD_MASK		(0x3fffffff << 0)
diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 8c63ccb8b6235..a2be60aa3cec4 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -27,6 +27,7 @@
 #include <drm/drm_crtc.h>
 #include "radeon.h"
 #include "atom.h"
+#include "r600d.h"
 #include "radeon_audio.h"
 
 void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
@@ -63,8 +64,6 @@ void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
 struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
 struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
 void dce6_afmt_select_pin(struct drm_encoder *encoder);
-void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
 void dce3_2_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
 void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
@@ -75,31 +74,23 @@ void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
 void dce6_dp_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
-void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
-	unsigned char *buffer, size_t size);
 void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
 	unsigned char *buffer, size_t size);
-void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
-	const struct radeon_hdmi_acr *acr);
 void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 	const struct radeon_hdmi_acr *acr);
 void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 	const struct radeon_hdmi_acr *acr);
-void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
 void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
 void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
 	u32 offset, int bpc);
-void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
 void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offset);
 void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
-void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 void dce3_2_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
 static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
-void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
 void evergreen_hdmi_enable(struct drm_encoder *encoder, bool enable);
 void evergreen_dp_enable(struct drm_encoder *encoder, bool enable);
 
-- 
2.25.1

