Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D82B4CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbgKPRa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732994AbgKPRa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:30:26 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE65C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:24 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so19583344wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Em7SluU2l3ftJ+gF09xUH3G2q3trrqCt+WUDKP2B/us=;
        b=mk+//APTyPDZh9XKgwaFWLCLR0i63D5KO+mrf/fczt5j3iHIWaWmHSN9hpuKceQt0z
         /F4Lf873Ni/jDpPGpjZ66Yt529P0Pync7BDAyLV02jsKJiLKh59oQbuj1f1xbES68bQ4
         XGTcqT0BnX1D/wo9PKt/cuUcfPmfhXYpxa7qYt42+HuQJIgga4xVfISU5ualkWcDy2qf
         d13FYI2/NWmwXFeOI8V0Rc4kk+wTQe5xDGbgNBJ7Ta1ww+vK5JKgri6EvuA6EF95szIV
         2db48IppAEgbC9ueOh1S2t1tlCaKf5BW1sRepPAQd0mSYrF5Cd4HtaBsqcaOoCon6W3p
         LfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Em7SluU2l3ftJ+gF09xUH3G2q3trrqCt+WUDKP2B/us=;
        b=cgTKNt0JgCGTAdxlDKlQP5/hqjDcR/UaKN08vZJj0IrKEflCUP3LXi+k8HOpqJ4y4E
         O+ncN2raz09k/VnVGzP5BQkM64bbmntVNa9MPjtShS0R6zWrFuIHnTxSqIbclPt9NfIV
         lWri5xyXaf993ABB0g7kIvP25vhU2cX3wBW1EPRgEMu++L2SyqLQLGDJUVudELCQzO5H
         d+DVI0gNUaDzYldsSe30H7Hbwt1M9gjA29MyJda7Irei7HCzwfC7qPDrIlhsPhkmXLo2
         ofkT+7gG2loJsN0Ql3zzNH3FoidPxxVDyJjXwFtqwqYpNP0sA2wQmhHmZAFXgMK+zDdc
         mSfA==
X-Gm-Message-State: AOAM532m3mVcfHfz9sZnz2C74xYMNcARLVZXAjL+NL8NmSDQic8FegFd
        WO5TUnUftO9ImLHcGQLBLEkUgg==
X-Google-Smtp-Source: ABdhPJxTCIfplEbyVlQoVTjvbfKjfrKOMVaQexUtcrEx9Pdke8y5vpHyzEBLyi5vy0OHdioh9uR1bw==
X-Received: by 2002:adf:9544:: with SMTP id 62mr20166979wrs.223.1605547823586;
        Mon, 16 Nov 2020 09:30:23 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:30:22 -0800 (PST)
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
Date:   Mon, 16 Nov 2020 17:29:33 +0000
Message-Id: <20201116173005.1825880-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173005.1825880-1-lee.jones@linaro.org>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
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

