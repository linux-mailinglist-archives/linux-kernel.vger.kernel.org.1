Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342D02B4D73
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbgKPRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbgKPRhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:43 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26201C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:43 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 19so36953wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3URZpu7tsjM6Y8F+U84uwe7BiqZoOF3VMCws5wVhmBo=;
        b=hJrk2c+MVVdRgOF38FOlxwZWmiyLarfSS1Z8YpKs4nyoSArMJJWYspiabittQjN7ge
         PEYx4sy7GfltMkTs9r1iIcNL2prnE133gYn55x1A92PuiVhze7KyJISv2G5hxR1c7tCo
         TKcGtqO9xPjRvnmgCca27nh5qDlemubQhWynuDC2ye9xIbz/1WKREnvkFuPTp9lqSJwB
         Lyt32RJ0UiU6AlAnqUlzu9N9RhT8UVpqrogxW+yNJyDb0z++8MYJYiULpdVM1c+b1Itw
         dDOykSolZ5VlKqsKfFuGndE76bz3Jj2OUe0QbLhyi1VnQlFaMcjB2sOqdiKFpvWAzWNg
         XXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3URZpu7tsjM6Y8F+U84uwe7BiqZoOF3VMCws5wVhmBo=;
        b=p/J0W6vYqEkWt+tw2bBw1CCfFwUbKe4FRiuRTduEfn7Q6wSJ6sO3nOW/R4kkgYUzTh
         fwEhxNL/j4TT4uEZ+tGDPOU6GLE5kSvTP+wKU/uw9xSlQxcOBGNWZ5D0Wdz0jVYZ2IV6
         dOSedjFFuwoKOKJmDi1Ndg65hKwKgP+Kd31rSTmhprksW7GMB8KylSpaFDbCIpzcW99l
         xVNNoF3dYcF/X0u+ZhbXjLKWIKFp/GYNfpm0mx9NfxXXJGpvLutjoZsmtyciU1RrKh0a
         v5QxLFuRqYOj6thYi6tPohip7d1tcqU0QRdbqn3R5LCzdgQ/pCHbEVBaCHozZeoUKhJF
         gOLQ==
X-Gm-Message-State: AOAM532XvqrLIDkVkuw4YyjunD1scWVbao6xUJvDp7itJBOy+Xl0FvNL
        H1qB62fmEXu9R/ikprY54i2dPQ==
X-Google-Smtp-Source: ABdhPJzLMcGyo4T2FArxObi4BCVhAjl+Vji/+nc2gO0MsC3VaYvnAWIHq1QwuCtwUjOfPKwM9a5FlQ==
X-Received: by 2002:a1c:97:: with SMTP id 145mr18960wma.72.1605548261899;
        Mon, 16 Nov 2020 09:37:41 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/43] drm/radeon/radeon_encoders: Move 'radeon_atom_backlight_init's prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:44 +0000
Message-Id: <20201116173700.1830487-28-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/atombios_encoders.c:186:6: warning: no previous prototype for ‘radeon_atom_backlight_init’ [-Wmissing-prototypes]
 186 | void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_atombios.h | 4 ++++
 drivers/gpu/drm/radeon/radeon_encoders.c | 6 +-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.h b/drivers/gpu/drm/radeon/radeon_atombios.h
index a895a7002c3d3..fd03755e6fa2c 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.h
+++ b/drivers/gpu/drm/radeon/radeon_atombios.h
@@ -28,14 +28,18 @@
 #ifndef __RADEON_ATOMBIOS_H__
 #define __RADEON_ATOMBIOS_H__
 
+struct drm_connector;
 struct drm_device;
 struct drm_display_mode;
 struct radeon_device;
+struct radeon_encoder;
 
 bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
 				struct drm_display_mode *mode);
 void radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_enum,
 			     uint32_t supported_device, u16 caps);
+void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
+				struct drm_connector *drm_connector);
 
 
 #endif                         /* __RADEON_ATOMBIOS_H__ */
diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
index b60a373d3ead3..46549d5179ee9 100644
--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -31,14 +31,10 @@
 #include <drm/radeon_drm.h>
 
 #include "radeon.h"
+#include "radeon_atombios.h"
 #include "radeon_legacy_encoders.h"
 #include "atom.h"
 
-extern void
-radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
-			   struct drm_connector *drm_connector);
-
-
 static uint32_t radeon_encoder_clones(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-- 
2.25.1

