Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA62B4D99
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbgKPRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733301AbgKPRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:35 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:35 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so26507wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUgD99dAZfuLWNam3kGxkjEykoel9F1pl4Jg76K7MCg=;
        b=A8HzgcFmHJlDoRnxOLVZNJsNZd5RSaDMhSbJjyA6Zsf+uOVZiwxgsrZ3qS/yomov6M
         ImfkYga1c9za82A3rxY+3q1sgd1dKCR4FLFTq54FzNvsOXjP4jT3rk7iNq4V+OfNY1qz
         HA3Guu8rubwWPgTwa96fKsPnDlmxn4lljezuu9Htm+kOdivDmj83mDkrl9I0Lgmt7hAI
         NcjebhEvuNFy98kZ0fjw6avLJaR4r/+QtLJqJbYxr/c1rqXQdoPd7Z2LCUKWcWb219aN
         MtgPdH+xHTSR3WfhZ6yXP6rToCbCsx2/OQ7yUsk6/6IyW62TPiCBhsUK01Z3RQsgytV9
         pl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUgD99dAZfuLWNam3kGxkjEykoel9F1pl4Jg76K7MCg=;
        b=czs99fJy6T+EnhXDvE3WMv+B7IpNZhKmfFQQ0UuZ+4dxdcH4wSrA+mBWDJJRygmaLi
         MV0vywcS4KPgeNwXZa0JNfWpS3YDK4Gdiaxr8pCLufsq5f6Ho/ll3ITOBxuxlszfqtgx
         lbMlPQ2H1OmUbou7dafOb1fdiQoNA7SHk52wQcp+ajCO52cSjsvDJOktFUcTsft5JHOp
         +b+sUdABCgD9r7QVF7PsODMbf11J5u2EG5F8CnZ+K3jJn1/14b4D6ZfcMmyChow6yRtM
         k8VlTtDBk2VAMs5crr2JUCc8pCCF4WT3JZTGAd8hXrCLjroZofOwHrif+XZ2cyzkOebN
         l3XA==
X-Gm-Message-State: AOAM533+9AVFuPkMPqtdNzMRXGsFfyl7MzDTTFxpnNr+JyZTC3u+VgVd
        NCcut6fdQ+sYM8hX9TUCmaAAXw==
X-Google-Smtp-Source: ABdhPJxlyykqsXt354bAFqYf+ZEcs9kf2t4KuZ489r99dtOsPjsfVIxOwBijBEqB1CWFQJ+qtJiSng==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr15910947wml.57.1605548254381;
        Mon, 16 Nov 2020 09:37:34 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:33 -0800 (PST)
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
Subject: [PATCH 21/43] drm/radeon/r600_dma: Move 'r600_gpu_check_soft_reset()'s prototype to shared location
Date:   Mon, 16 Nov 2020 17:36:38 +0000
Message-Id: <20201116173700.1830487-22-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/r600.c:1615:5: warning: no previous prototype for ‘r600_gpu_check_soft_reset’ [-Wmissing-prototypes]
 1615 | u32 r600_gpu_check_soft_reset(struct radeon_device *rdev)
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
 drivers/gpu/drm/radeon/r600.c     |  1 +
 drivers/gpu/drm/radeon/r600.h     | 35 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/radeon/r600_dma.c |  3 +--
 3 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/r600.h

diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index f09b6dc5cbeb3..94e8815e5067d 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -39,6 +39,7 @@
 
 #include "atom.h"
 #include "avivod.h"
+#include "r600.h"
 #include "r600d.h"
 #include "rv770.h"
 #include "radeon.h"
diff --git a/drivers/gpu/drm/radeon/r600.h b/drivers/gpu/drm/radeon/r600.h
new file mode 100644
index 0000000000000..2a3915f0039e4
--- /dev/null
+++ b/drivers/gpu/drm/radeon/r600.h
@@ -0,0 +1,35 @@
+/* r600.h -- Private header for radeon driver -*- linux-c -*-
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
+#ifndef __R600_H__
+#define __R600_H__
+
+struct radeon_device;
+
+u32 r600_gpu_check_soft_reset(struct radeon_device *rdev);
+
+#endif				/* __R600_H__ */
diff --git a/drivers/gpu/drm/radeon/r600_dma.c b/drivers/gpu/drm/radeon/r600_dma.c
index af6c0da45f28a..89ca2738c5d4c 100644
--- a/drivers/gpu/drm/radeon/r600_dma.c
+++ b/drivers/gpu/drm/radeon/r600_dma.c
@@ -24,10 +24,9 @@
 
 #include "radeon.h"
 #include "radeon_asic.h"
+#include "r600.h"
 #include "r600d.h"
 
-u32 r600_gpu_check_soft_reset(struct radeon_device *rdev);
-
 /*
  * DMA
  * Starting with R600, the GPU has an asynchronous
-- 
2.25.1

