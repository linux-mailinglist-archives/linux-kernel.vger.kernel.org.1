Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587FB2C0475
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgKWLVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgKWLTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:42 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD93C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:42 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so18262041wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCouInRUErRLohKUWgZ5Rh5LGuUuX53SkzhdYyO1Qd0=;
        b=WITwZARmzl597oEYyJmeZtf/keRxKZyhTRuWl1mJR4gcvc8Z6HR6kWimUTc8NeVl2P
         dg/AUfJrtW1uCMrPRzSENfLDfQEyk8XZ6SGAmKMuxmFaJQJm5/6xNl/fsKPFoID0ZSjF
         npNOQ7GumEsDb2tI+GL2YC4/1jPxhic8iiWDKmLtnEZn5zejduqkH7XTfKQOVnmBFxrA
         p7aRY4hduVmhmwQTSOSBKFvzGhZE7ESKJmfmBjbmVUZBxs/058qFR92RJy8seJeedXk+
         mNYLKHoVnB5NyUN8MP8GaXzvIWJ+I2bIvC79FcXHl/ajfJXM2YbR98Wxk8SVkRs3hSVP
         E+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCouInRUErRLohKUWgZ5Rh5LGuUuX53SkzhdYyO1Qd0=;
        b=nS/6c3NYu6a5Q8oKzYzQGKycI3DYNs0h0QToCtiPHqxG/CHaSvl4/E23mDM7ZZ9HyZ
         n94oeOHZAwfozx+7uxQnhgbcSbQxRDFhG3xWIGXequUCvT57KEFJExdkjfWvygWQZwoC
         5IKYeLcgvPRhfMwcxOB4iZgagrAUNClVS9D542KOTgP4s2VNOfQlLQSOkWVwGZYst3bd
         01RgKXgn6Xzeo8LBrazxJQ0t8As8L30KHayJDTky+DskHuvgvx4SYohBoF8XrFcGSFwx
         O/2AK3mFgPd37kJAiMS8otpFU3N28wJ2whMZWpATpMbvcZrH05kopdke3uaZ11ZvVDXG
         UQLg==
X-Gm-Message-State: AOAM531aNCGUqwgDyvE0oRjDWycukXmeHkWVQN/RDVVvkIvrul24LTDV
        /OpRPz9X4Zl3r/NBPaprxe1BgA==
X-Google-Smtp-Source: ABdhPJwRB/ivJcm9IasBeFeTCCH9XybuGLjGQUptEZrDvk/mQPa3TaDOEuCyEpAykvJXnNNQRSiIcA==
X-Received: by 2002:adf:9cc6:: with SMTP id h6mr30900317wre.341.1606130380725;
        Mon, 23 Nov 2020 03:19:40 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 14/40] drm/msm/disp/dpu1/dpu_hw_catalog: Move definitions to the only place they are used
Date:   Mon, 23 Nov 2020 11:18:53 +0000
Message-Id: <20201123111919.233376-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These tables are not large or overbearing, so moving them into the
source file seems like the right thing to do.  The alternative is to
use __maybe_unused, which is undesirable.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:11:
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h:7:23: warning: ‘qcom_compressed_supported_formats’ defined but not used [-Wunused-const-variable=]
 7 | static const uint32_t qcom_compressed_supported_formats[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h:48:23: warning: ‘plane_formats_yuv’ defined but not used [-Wunused-const-variable=]
 48 | static const uint32_t plane_formats_yuv[] = {
 | ^~~~~~~~~~~~~~~~~
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h:17:23: warning: ‘plane_formats’ defined but not used [-Wunused-const-variable=]
 17 | static const uint32_t plane_formats[] = {
 | ^~~~~~~~~~~~~

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 74 +++++++++++++++-
 .../drm/msm/disp/dpu1/dpu_hw_catalog_format.h | 88 -------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     | 11 ++-
 3 files changed, 83 insertions(+), 90 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index a7004f18523b0..9ed6d0c6cd9b2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -8,7 +8,6 @@
 #include <linux/platform_device.h>
 #include "dpu_hw_mdss.h"
 #include "dpu_hw_catalog.h"
-#include "dpu_hw_catalog_format.h"
 #include "dpu_kms.h"
 
 #define VIG_MASK \
@@ -62,6 +61,79 @@
 
 #define STRCAT(X, Y) (X Y)
 
+static const uint32_t plane_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_RGBX5551,
+	DRM_FORMAT_BGRX5551,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_XRGB4444,
+	DRM_FORMAT_XBGR4444,
+	DRM_FORMAT_RGBX4444,
+	DRM_FORMAT_BGRX4444,
+};
+
+static const uint32_t plane_formats_yuv[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_RGBX5551,
+	DRM_FORMAT_BGRX5551,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_XRGB4444,
+	DRM_FORMAT_XBGR4444,
+	DRM_FORMAT_RGBX4444,
+	DRM_FORMAT_BGRX4444,
+
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YVU420,
+};
+
 /*************************************************************
  * DPU sub blocks config
  *************************************************************/
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h
deleted file mode 100644
index 3766f0fd0bf08..0000000000000
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
- */
-
-#include "dpu_hw_mdss.h"
-
-static const uint32_t qcom_compressed_supported_formats[] = {
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_BGR565,
-
-	DRM_FORMAT_NV12,
-};
-
-static const uint32_t plane_formats[] = {
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_BGRA8888,
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_RGBX8888,
-	DRM_FORMAT_BGRX8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_BGR888,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_BGR565,
-	DRM_FORMAT_ARGB1555,
-	DRM_FORMAT_ABGR1555,
-	DRM_FORMAT_RGBA5551,
-	DRM_FORMAT_BGRA5551,
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_RGBX5551,
-	DRM_FORMAT_BGRX5551,
-	DRM_FORMAT_ARGB4444,
-	DRM_FORMAT_ABGR4444,
-	DRM_FORMAT_RGBA4444,
-	DRM_FORMAT_BGRA4444,
-	DRM_FORMAT_XRGB4444,
-	DRM_FORMAT_XBGR4444,
-	DRM_FORMAT_RGBX4444,
-	DRM_FORMAT_BGRX4444,
-};
-
-static const uint32_t plane_formats_yuv[] = {
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_BGRX8888,
-	DRM_FORMAT_BGRA8888,
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_RGBX8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_BGR888,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_BGR565,
-	DRM_FORMAT_ARGB1555,
-	DRM_FORMAT_ABGR1555,
-	DRM_FORMAT_RGBA5551,
-	DRM_FORMAT_BGRA5551,
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_RGBX5551,
-	DRM_FORMAT_BGRX5551,
-	DRM_FORMAT_ARGB4444,
-	DRM_FORMAT_ABGR4444,
-	DRM_FORMAT_RGBA4444,
-	DRM_FORMAT_BGRA4444,
-	DRM_FORMAT_XRGB4444,
-	DRM_FORMAT_XBGR4444,
-	DRM_FORMAT_RGBX4444,
-	DRM_FORMAT_BGRX4444,
-
-	DRM_FORMAT_NV12,
-	DRM_FORMAT_NV21,
-	DRM_FORMAT_NV16,
-	DRM_FORMAT_NV61,
-	DRM_FORMAT_VYUY,
-	DRM_FORMAT_UYVY,
-	DRM_FORMAT_YUYV,
-	DRM_FORMAT_YVYU,
-	DRM_FORMAT_YUV420,
-	DRM_FORMAT_YVU420,
-};
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 7ea90d25a3b69..c0b1d77369e53 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -19,7 +19,6 @@
 #include "dpu_kms.h"
 #include "dpu_formats.h"
 #include "dpu_hw_sspp.h"
-#include "dpu_hw_catalog_format.h"
 #include "dpu_trace.h"
 #include "dpu_crtc.h"
 #include "dpu_vbif.h"
@@ -63,6 +62,16 @@ enum {
 
 #define DEFAULT_REFRESH_RATE	60
 
+static const uint32_t qcom_compressed_supported_formats[] = {
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_BGR565,
+
+	DRM_FORMAT_NV12,
+};
+
 /**
  * enum dpu_plane_qos - Different qos configurations for each pipe
  *
-- 
2.25.1

