Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675F12AC6FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgKIVTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbgKIVTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:41 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AEEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so930554wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyLIuv0VkA4024J/8Pdl2sIFaA9qPd+RCQW07HGbGvk=;
        b=c2pKONE2QnVXBi9ZaRYMHRGMIwmOfN6gN4ypT2YPgAaJYwTh7G5su4q8Io1kOPfJtb
         RZWvEr1JLtcG//QIdrYa4j6bfhlWi9L+6lJFcCVXd9fND4nUW6KjCiIu2fJu5HIvZgCs
         B2SRFUcVNHE7ostquCla/96Yh2qu/zSeIoIIWLSBUe2apPv0gLfGgLCqPqqWP6w6IbZd
         2yaRUpnkJjx/AlrfRUHzaeiY5p+muLq/bnkMb/W7oSvuX6n9WUsN6g9gygcq2EWiTG3D
         IyrWrsyjoAtF4GEe+mO3dfM1ZOLqgo4NG9Ah8Jn8R2zxLN+baf/gLxh5JwyU9D9ekria
         zNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyLIuv0VkA4024J/8Pdl2sIFaA9qPd+RCQW07HGbGvk=;
        b=R483IJ+jYXCe+fIXYd7d0j7YDlyNne4+X138J/TOQVcaYqxfFdV1XZsZKv0vyvZCOf
         VbkzftfllJII/bpFTX5FVNWD5c4EmNUJd6a9F0NPyHP0sdDw9RmzzcBos18JIl7K7A0D
         8OEFIsdvVr7CI/Z3krPnRX0XzqwI/0abo7exAIgElS3B5PuiBZu9OokJisryMAhkUh/J
         /hVdoWRKhrrqtlYCRpQitApTVvg7bnVsjbE+7MhrM2IyoJFGuG2zQEgHawmfmM7Gu1Li
         IVNhUXlIMIr99pkiD5cYDTa2MCc/LHTrbrHYZj1Jy4JfbsYi9gz8guvA+0hu7/Er9T2y
         PpHQ==
X-Gm-Message-State: AOAM531e87FYEMUPrNPRn/CxKvXVp+mWkSSooAHuLLnzXPsaU5leRPEB
        alVYqB0DdM4XTPyNHGuD8r9QDg==
X-Google-Smtp-Source: ABdhPJw/U+JvxmKAV3wQljTmmwD4VdzRN63ZA/gGSJCjEke9s1ogY739AYpfKigFq6HKl7fxWU1KJw==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr1228799wml.56.1604956779427;
        Mon, 09 Nov 2020 13:19:39 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Slava Grigorev <slava.grigorev@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 16/20] drm/radeon/radeon_audio: Move 'dce3_2_*' prototypes to shared location
Date:   Mon,  9 Nov 2020 21:18:51 +0000
Message-Id: <20201109211855.3340030-17-lee.jones@linaro.org>
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
index a2be60aa3cec4..18228b366752e 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -39,16 +39,10 @@ void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
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
@@ -64,8 +58,6 @@ void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
 struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
 struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
 void dce6_afmt_select_pin(struct drm_encoder *encoder);
-void dce3_2_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
 void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
 void dce4_dp_audio_set_dto(struct radeon_device *rdev,
@@ -76,16 +68,12 @@ void dce6_dp_audio_set_dto(struct radeon_device *rdev,
 	struct radeon_crtc *crtc, unsigned int clock);
 void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
 	unsigned char *buffer, size_t size);
-void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offset,
-	const struct radeon_hdmi_acr *acr);
 void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 	const struct radeon_hdmi_acr *acr);
 void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
 void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
 	u32 offset, int bpc);
-void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offset);
 void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
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

