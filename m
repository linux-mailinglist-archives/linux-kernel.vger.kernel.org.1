Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0682B4D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbgKPRiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbgKPRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:38:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A086C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:38:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so19637919wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rlEAJUPoPuRko8qcPnm4cjfW2HHwiXUkafYub7EdZfk=;
        b=APb2hd1nsrrBdjXvvVpm1+Ne8ZAFPtpGwaL1im+72RQeDbJ/GyceRoS9RYLJJEJK4Z
         4mVviBHLv+iyqw0YOEYeonP95t7J30q5lCPEx/OujgV3Mf85YTdE/7io+lmgtDTgUKgm
         Gu28kdk0RJStN0MI2VoFiR+yen487Ho05eeI0VXQMFHMttYcPBivCrMkUwic8yE2GzIS
         +DvJ/w9be7VZZyBMGpB9iy851voGvbtU57ut5qLzrte2Spy/DSeVh0SZkggXu72ATVFz
         qQWhTPrTEQqQ2C59XfUjpK/am9B6P5hsrl+i4b/Je8gDXYWUy2Q+6+rqfK5m00+4CPX2
         kxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlEAJUPoPuRko8qcPnm4cjfW2HHwiXUkafYub7EdZfk=;
        b=ZQWb0EkZdh1vQC/CASSrAaJ3/vLpX7LVgqgwEzQqzfSrmF6TqBGrtBusT8Oru2IhtF
         5V//UgVG5NuJzx6gs3iL4TyljIim/rCevFuxgfNxsJ+p7K6Vs56s7HCKY17vbM0GDGTF
         iPiEV5+i0KxlIS/6bZwzV77Dcefln5ALVAhBcCxAq0X8A7u65oQtCoF/NnuzDhXf1Tjj
         L78IaOn9toPQPXX3ZOLA54QOuIriZRB+Rvrto5HSft94Mq3+DDVRdUSGPyacceEx0BdH
         izuq+/xNhgEEyUltTsoYls8aHqPd0BgFAqXtBY63PxOgq8uM2Ek/gY4I/OtRHbpDHG1N
         sI+Q==
X-Gm-Message-State: AOAM533MF93zAuZU3K/quJSOjIU4qP27vgt4QFPiy+AvyVelLVq9UzYt
        3RNDHbYrTdaxKB46MayPqIyubA==
X-Google-Smtp-Source: ABdhPJxn9CTvzqCRbb+AYn8yUPwKxRn4jkEYqgsGCJ4kHtrqk+U1fU65HoFDJFJoL2xeTAxU5qlijQ==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr13258021wrp.176.1605548280980;
        Mon, 16 Nov 2020 09:38:00 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:38:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 42/43] drm/radeon/radeon_audio: Move 'r600_*' prototypes into shared header
Date:   Mon, 16 Nov 2020 17:36:59 +0000
Message-Id: <20201116173700.1830487-43-lee.jones@linaro.org>
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
 drivers/gpu/drm/radeon/r600.h         | 17 +++++++++++++++++
 drivers/gpu/drm/radeon/r600_hdmi.c    |  1 +
 drivers/gpu/drm/radeon/radeon_audio.c | 13 +------------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600.h b/drivers/gpu/drm/radeon/r600.h
index dbdff4568516b..22db13b256195 100644
--- a/drivers/gpu/drm/radeon/r600.h
+++ b/drivers/gpu/drm/radeon/r600.h
@@ -30,12 +30,29 @@
 
 struct radeon_bo_list;
 struct radeon_cs_parser;
+struct r600_audio_pin;
+struct radeon_crtc;
 struct radeon_device;
+struct radeon_hdmi_acr;
 
 u32 r600_gpu_check_soft_reset(struct radeon_device *rdev);
 int r600_ih_ring_alloc(struct radeon_device *rdev);
 void r600_ih_ring_fini(struct radeon_device *rdev);
 
+void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
+		       u8 enable_mask);
+void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
+void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
+void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
+			     struct radeon_crtc *crtc, unsigned int clock);
+void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
+			 unsigned char *buffer, size_t size);
+void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
+			  const struct radeon_hdmi_acr *acr);
+void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
+void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
+
 int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
 			   struct radeon_bo_list **cs_reloc);
+
 #endif				/* __R600_H__ */
diff --git a/drivers/gpu/drm/radeon/r600_hdmi.c b/drivers/gpu/drm/radeon/r600_hdmi.c
index c09549d785b54..f3551ebaa2f08 100644
--- a/drivers/gpu/drm/radeon/r600_hdmi.c
+++ b/drivers/gpu/drm/radeon/r600_hdmi.c
@@ -30,6 +30,7 @@
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_audio.h"
+#include "r600.h"
 #include "r600d.h"
 #include "atom.h"
 
diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 785c23cb30589..7c5e80d03fc90 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -29,28 +29,17 @@
 #include "evergreen_hdmi.h"
 #include "radeon.h"
 #include "atom.h"
+#include "r600.h"
 #include "radeon_audio.h"
 
-void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
-		u8 enable_mask);
 void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
 		u8 enable_mask);
 struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
 struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
-void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
-	struct radeon_crtc *crtc, unsigned int clock);
-void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
-	unsigned char *buffer, size_t size);
-void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
-	const struct radeon_hdmi_acr *acr);
-void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
-void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
-void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
 static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
 static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
-void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
 
 static const u32 pin_offsets[7] =
 {
-- 
2.25.1

