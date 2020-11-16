Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312982B4D65
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbgKPRhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733233AbgKPRhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:21 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA918C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:20 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so19605433wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Em7SluU2l3ftJ+gF09xUH3G2q3trrqCt+WUDKP2B/us=;
        b=lPZeyl6uWi7xUQZkvOEt0UCMHVHP8990HNpdrvYMl0WHli7nvkcSvo+7bls/hlxqxT
         qkgThfDFvUQ8SDqwIBkFEpuHOEUhvXzbRixLcrE6I/elSkxeC++BarR6XIfDpg4pP3nO
         hBBh/5d2rUqef+FimPU5R7CTZX4OQkk3lHX4MsxeBA35z++/uBsA+Aa+Oa/wq+5pegqd
         sULjOoyhyBSnknx+UyluYSKwpT/FBRQQaZ3zOcZlWnwPD3jNlj9ld2R1xSnL1WnvLBtV
         b5eCsQaKfT6kCOCWgevMTEGEoRlmqmiOsnnsbzQ9jM2y2bwesu31jcvq8mlUqPxjw0os
         BdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Em7SluU2l3ftJ+gF09xUH3G2q3trrqCt+WUDKP2B/us=;
        b=lip025V7HmifxO44nORK6kSwx+/p6FphCFeipT6pFx4hyvhnOFIMBktsOeZaN4rMW2
         PLyOhQA3U7z3vZFdzWuvMZGB8f9YDclGL01B9Xba4unqcPOdq38cPU4nIyrB6SBFDxmJ
         Eb1T7s3/Smm/9XT9flmWpP50d8wsL4Uxr0M97j/4433QpuOIlGJOgC6CZdppx8MTueSf
         GQ+0lHbpoINBrwsSiQWcdS1sKHY7Lh8E99mw1ZyJMxHtarUBZ/+EG2FA1f4NKp+Vxisg
         xzKzpcLX3xO2g0K2MflLQDPIw9pKvpiheGLV7/T5fU8uX7lWSS+PQIkkLtK4I3q2qeVb
         zjVQ==
X-Gm-Message-State: AOAM532D8oqZalK0xU8g3H624y1ExSfSeP7rFts/7Pre5M2RzzlvuVUC
        /nrrY1huK3Mni13AjtZsTxuIDw==
X-Google-Smtp-Source: ABdhPJwXIZLoXsynjbHEmc3+1z3zdclGhSCg3QJ1hmwzfWitxIHK8n69nRA+7CniOhIhL+gzgUOKkQ==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr13254833wrp.176.1605548239475;
        Mon, 16 Nov 2020 09:37:19 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Slava Grigorev <slava.grigorev@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/43] drm/radeon/radeon_audio: Move 'dce3_2_*' prototypes to shared location
Date:   Mon, 16 Nov 2020 17:36:28 +0000
Message-Id: <20201116173700.1830487-12-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/dce3_1_afmt.c:30:6: warning: no previous prototype for ‘dce3_2_afmt_hdmi_write_speaker_allocation’ [-Wmissing-prototypes]
 30 | void dce3_2_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce3_1_afmt.c:48:6: warning: no previous prototype for ‘dce3_2_afmt_dp_write_speaker_allocation’ [-Wmissing-prototypes]
 48 | void dce3_2_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce3_1_afmt.c:66:6: warning: no previous prototype for ‘dce3_2_afmt_write_sad_regs’ [-Wmissing-prototypes]
 66 | void dce3_2_afmt_write_sad_regs(struct drm_encoder *encoder,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce3_1_afmt.c:116:6: warning: no previous prototype for ‘dce3_2_audio_set_dto’ [-Wmissing-prototypes]
 116 | void dce3_2_audio_set_dto(struct radeon_device *rdev,
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce3_1_afmt.c:170:6: warning: no previous prototype for ‘dce3_2_hdmi_update_acr’ [-Wmissing-prototypes]
 170 | void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 | ^~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce3_1_afmt.c:202:6: warning: no previous prototype for ‘dce3_2_set_audio_packet’ [-Wmissing-prototypes]
 202 | void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offset)
 | ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/dce3_1_afmt.c:223:6: warning: no previous prototype for ‘dce3_2_set_mute’ [-Wmissing-prototypes]
 223 | void dce3_2_set_mute(struct drm_encoder *encoder, u32 offset, bool mute)
 | ^~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Slava Grigorev <slava.grigorev@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_audio.c | 12 ------------
 drivers/gpu/drm/radeon/radeon_audio.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 8c63ccb8b6235..f6c783e19c988 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -38,16 +38,10 @@ void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
 u32 dce6_endpoint_rreg(struct radeon_device *rdev, u32 offset, u32 reg);
 void dce6_endpoint_wreg(struct radeon_device *rdev,
 		u32 offset, u32 reg, u32 v);
-void dce3_2_afmt_write_sad_regs(struct drm_encoder *encoder,
-		struct cea_sad *sads, int sad_count);
 void evergreen_hdmi_write_sad_regs(struct drm_encoder *encoder,
 		struct cea_sad *sads, int sad_count);
 void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
 		struct cea_sad *sads, int sad_count);
-void dce3_2_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
-		u8 *sadb, int sad_count);
-void dce3_2_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
-		u8 *sadb, int sad_count);
 void dce4_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
 		u8 *sadb, int sad_count);
 void dce4_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
@@ -65,8 +59,6 @@ struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
 void dce6_afmt_select_pin(struct drm_encoder *encoder);
 void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
-void dce3_2_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
 void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
 void dce4_dp_audio_set_dto(struct radeon_device *rdev,
@@ -81,8 +73,6 @@ void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
 	unsigned char *buffer, size_t size);
 void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 	const struct radeon_hdmi_acr *acr);
-void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offset,
-	const struct radeon_hdmi_acr *acr);
 void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 	const struct radeon_hdmi_acr *acr);
 void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
@@ -90,10 +80,8 @@ void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
 void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
 	u32 offset, int bpc);
 void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
-void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offset);
 void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
 void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
-void dce3_2_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
diff --git a/drivers/gpu/drm/radeon/radeon_audio.h b/drivers/gpu/drm/radeon/radeon_audio.h
index 5c70cceaa4a6c..05e67867469b0 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.h
+++ b/drivers/gpu/drm/radeon/radeon_audio.h
@@ -81,4 +81,16 @@ void radeon_audio_mode_set(struct drm_encoder *encoder,
 void radeon_audio_dpms(struct drm_encoder *encoder, int mode);
 unsigned int radeon_audio_decode_dfs_div(unsigned int div);
 
+void dce3_2_afmt_write_sad_regs(struct drm_encoder *encoder,
+				struct cea_sad *sads, int sad_count);
+void dce3_2_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder,
+					       u8 *sadb, int sad_count);
+void dce3_2_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
+					     u8 *sadb, int sad_count);
+void dce3_2_audio_set_dto(struct radeon_device *rdev,
+			  struct radeon_crtc *crtc, unsigned int clock);
+void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offset,
+			    const struct radeon_hdmi_acr *acr);
+void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offset);
+void dce3_2_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 #endif
-- 
2.25.1

