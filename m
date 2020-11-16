Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939EF2B4CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgKPRaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732908AbgKPRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:30:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4FC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so19637097wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmKc1pxfWNIhhVZbat4IeYMq2SqMBDzsHL5Wfk03ato=;
        b=ZrJ7nX+Ss2SwWtGJ5a77Xmq6naZYfFaODqVex6B0ksRVu6CPODbPoqrLXrQzYtwaPO
         g2v5cNvW2Nq96enR9+AbUk3KUpTCjHRBie7PJXTRF2+zjdR2dFZ5wzFfvYmprBW28PPX
         gd8RqEttaE44L9FUKUGhdDo3sNt32I5PLbysKwTyGi5YOJN+PueBEhdW4f9haTBRn06T
         /iMwHs1+TC6BEalMW/9cWcHAGfDzJnRwWBoQBrZ8mIkc02e5cKDWTcy2S2gs04DAvUAv
         N8Kv7DD+nUHndcbDQag4Pqnp55eMgu8spglrTL8SXYWmnuOdWnT07R02S97rOIad1pmx
         XPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmKc1pxfWNIhhVZbat4IeYMq2SqMBDzsHL5Wfk03ato=;
        b=OHbHusykpQ8CXqqx/UiJDfpSCPHo+fW//NkVBV8mPJobuxIsTenR/xjvIayK3ZYO3P
         zwFSRbiAQ5oPkiWME0kx6e50xZsnPpqtmFeFbIXcmRAwXkgm2uMEnHqq3t5ZsmycD2jt
         fFq8Gx9HLP4/RRK9rSwBf91iV4Up2lwNxRP5McZXp73cTa5XDjZN9YlNyh2eI/H6cyZy
         tnoXvIsQDqcqNQxKb5kHqqvK2oBMvR19mLD7nNMHCoZH3h2CJ7zIQs0QGDi8PyAQC9h6
         da0jJBBcxEVGIGnBts5aAzPjfc1lKb85iSs+mHtEke8TpecLbNusEeeUMZ4pjQCN6F1O
         EOgQ==
X-Gm-Message-State: AOAM533j9ue4B392Y9oG6jfiS3uJ0TUXLLzYVO3Pa6w+X8/m4dZdTtgv
        wDSApzCaQRR0MjsiL39beKdUeg==
X-Google-Smtp-Source: ABdhPJxDW0C9hokk5Jgdhjsw1VAWin7x+QtQzgHNDV1EILyPJhWE374L4EcFm7kOrhI0qm1a5ONMjQ==
X-Received: by 2002:adf:e287:: with SMTP id v7mr21597907wri.252.1605547813193;
        Mon, 16 Nov 2020 09:30:13 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:30:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 03/43] drm/radeon/radeon_kms: Move 'radeon_*_kms' prototypes to shared header
Date:   Mon, 16 Nov 2020 17:29:25 +0000
Message-Id: <20201116173005.1825880-4-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_kms.c:756:5: warning: no previous prototype for ‘radeon_get_vblank_counter_kms’ [-Wmissing-prototypes]
 756 | u32 radeon_get_vblank_counter_kms(struct drm_crtc *crtc)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_kms.c:826:5: warning: no previous prototype for ‘radeon_enable_vblank_kms’ [-Wmissing-prototypes]
 826 | int radeon_enable_vblank_kms(struct drm_crtc *crtc)
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_kms.c:853:6: warning: no previous prototype for ‘radeon_disable_vblank_kms’ [-Wmissing-prototypes]
 853 | void radeon_disable_vblank_kms(struct drm_crtc *crtc)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_display.c |  1 +
 drivers/gpu/drm/radeon/radeon_kms.c     |  1 +
 drivers/gpu/drm/radeon/radeon_kms.h     | 35 +++++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 drivers/gpu/drm/radeon/radeon_kms.h

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index eb0d4cb95f0a6..3a6fedad002d7 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -44,6 +44,7 @@
 
 #include "atom.h"
 #include "radeon.h"
+#include "radeon_kms.h"
 
 static void avivo_crtc_load_lut(struct drm_crtc *crtc)
 {
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 3d31c04e4b3db..001940bca90a6 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -41,6 +41,7 @@
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_drv.h"
+#include "radeon_kms.h"
 
 #if defined(CONFIG_VGA_SWITCHEROO)
 bool radeon_has_atpx(void);
diff --git a/drivers/gpu/drm/radeon/radeon_kms.h b/drivers/gpu/drm/radeon/radeon_kms.h
new file mode 100644
index 0000000000000..36e73cea92154
--- /dev/null
+++ b/drivers/gpu/drm/radeon/radeon_kms.h
@@ -0,0 +1,35 @@
+/* radeon_kms.h -- Private header for radeon driver -*- linux-c -*-
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
+#ifndef __RADEON_KMS_H__
+#define __RADEON_KMS_H__
+
+u32 radeon_get_vblank_counter_kms(struct drm_crtc *crtc);
+int radeon_enable_vblank_kms(struct drm_crtc *crtc);
+void radeon_disable_vblank_kms(struct drm_crtc *crtc);
+
+#endif				/* __RADEON_KMS_H__ */
-- 
2.25.1

