Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2112AF845
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgKKShh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgKKSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:35:58 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EEBC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:57 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so3158325wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3URZpu7tsjM6Y8F+U84uwe7BiqZoOF3VMCws5wVhmBo=;
        b=NwSfZcUBkZP1B3bjdQpFGUbvYxY2on6Vnsld+oALrNLXef2TBlHsg9YkXO7WHGcLx9
         bGcznb7awz7rQ7aaQR5UX0KF45TaerbkAayc+4dVR5LhAMdv1ILTvGbbBLPii3oga4rz
         532wAYa4d9W06NIt3THXNul+qgEaZOA8jGQ9XNKjwRsjUWof8uq3GZ8p/h3MwP3TebSR
         RlnyfgsYbd3/wDW9TWSGaEjL4q2ACna09McJCVHevo90DxkZh3hqnNbVh2ed2ClFb8hi
         rhtJ8kFUsggqFT8wgGvXYnGhEklNgHV5ahw7FUzJndF+c/JKaMIGqKwfEAU55BsxMUxe
         1Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3URZpu7tsjM6Y8F+U84uwe7BiqZoOF3VMCws5wVhmBo=;
        b=O+CIPJZ0peXYCjeytP1ktFYZs5HwwzZrjf+TqRiEfZGB7Ct4apWSLftWyOv9VRTgwz
         QDMC5PDGEd/pKvVdcWp2H2paOEUm2zki0tiyc198SKLm1bIVt5Vt6J4FMHyiATwEw9V8
         PpdEUsgIWg35VcDMJrhq1AJzfNCFXRs2JXZSRzblfAWIXh+7Q/+bc94Qe/NPCBKwjPHl
         5nh9cpi1TAWXo2f8t2Bhp0xFAPm/9DSuOLKWX40Eg2Mhwpmv07qmcV5HbaHThkMcz4gs
         STIXB0eUhvkVX6KioLtDwv/OIJ2LoEQUZmDYvhut4skY8hMintcnGBCnoAEgVeGKFHBa
         N8jQ==
X-Gm-Message-State: AOAM5300zlpo1NvmVo63A1A4CsGd+nv2zeNWtTtsm/XGhz+QO6dORGSY
        ECzAJYLb4tZkxPVcCiqBzGeTgA==
X-Google-Smtp-Source: ABdhPJwmiXHWCPlzC64u5QHSfF1ooLmZ1m+KcXjnM8pPY7ckYvdq1Z9fUR0fYEQtGUA7Xw0zU7S8Tg==
X-Received: by 2002:a1c:1f05:: with SMTP id f5mr5424835wmf.98.1605119756738;
        Wed, 11 Nov 2020 10:35:56 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:35:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/19] drm/radeon/radeon_encoders: Move 'radeon_atom_backlight_init's prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:31 +0000
Message-Id: <20201111183545.1756994-6-lee.jones@linaro.org>
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

