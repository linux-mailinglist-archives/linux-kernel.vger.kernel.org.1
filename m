Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB62B4CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbgKPRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbgKPRaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:30:22 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CD4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:22 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so19652825wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEdGEUBcwEa3ohTuW8AeQ9rcZ1jBGC5RhjVmwh26pbA=;
        b=MH+f+Sm0LLQRTh9iWew0DtLlUhhW8oHlovfsPBNmPolwL17i7Gu6Fbvk6lr0xb8TD2
         cQ9CuBZv66bQplnJ0/6Vbgdrj8mcy4+YI9UPVN0//u1bYGJnNVqYh7vKtey0uJfssem/
         ijoKKyRzcP0SK5uRDsOYJAby+Dc+8P0hyNFUc5Ts4HY4BwTRxReA3c2KBHmXTfBS0Acb
         78N1TWh8hkraQBZJxy6B4Llsw87P+vrg8vR8gnEm8yQ6n8j1j8zuLidX1kXjJMzbEDvx
         10ZluVMeRVZKYM5BpiHMhQaJvnt6nQ/5NN3L8XLbLxM2sZ/uY/ALE4qjbwZpoM9iHlz0
         I16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEdGEUBcwEa3ohTuW8AeQ9rcZ1jBGC5RhjVmwh26pbA=;
        b=saXXcE07azAGszDYa3mj3oMs5qX5KBkW8XxTtpC0gAt8lQIzEOAk2Eubx8W7+Sb57t
         Nr8tmDAk5bfbRUvdL0497SMLQsM2Db9qAJwaMeaOx1oCq6Jh+D1rUd3JCoj4fNFcVKcL
         MER4tKKeyLtOiRdxoVTX9Z7nA6+bNE99HwmgpBp4x1HCLOOiSGYKE0hQAbLXuCcbZqAw
         apwxuz4BiARZAVZQyBkp27N3CWJu6YIuIqnwi3L+/ylC+rQEQE1T2QUZ7/s1n5ZMqqW6
         DbL4dxbdrN/sN/7PujIUVnzf/rPjyXXKCUuiIdoz4iMhP8ARunKOhE+fxZ4OP8qlWN7C
         /vAQ==
X-Gm-Message-State: AOAM530s9PeGzXJk9F+gipuqstAApowB8J5o9wZ+EIwV+8LG93Hsf2QH
        X4Tf7sxpxgden+Z5gNs8yQWYRQ==
X-Google-Smtp-Source: ABdhPJw2Dw6Jy2671RSR5mnQeuBOPEihwV92+AMlw871nEIFzH7ZpKtVFzrpHYhIOTq4Iq0Myn0HqA==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr20339054wru.405.1605547820954;
        Mon, 16 Nov 2020 09:30:20 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:30:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/43] drm/radeon/rv770: Move 'rv770_set_clk_bypass_mode' prototype to shared location
Date:   Mon, 16 Nov 2020 17:29:31 +0000
Message-Id: <20201116173005.1825880-10-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/rv770.c:1138:6: warning: no previous prototype for ‘rv770_set_clk_bypass_mode’ [-Wmissing-prototypes]
 1138 | void rv770_set_clk_bypass_mode(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen.c |  2 +-
 drivers/gpu/drm/radeon/r600.c      |  2 +-
 drivers/gpu/drm/radeon/rv770.c     |  1 +
 drivers/gpu/drm/radeon/rv770.h     | 35 ++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/rv770.h

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 1f2acca437abd..9a1e240b07234 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -31,6 +31,7 @@
 
 #include "atom.h"
 #include "avivod.h"
+#include "rv770.h"
 #include "evergreen_blit_shaders.h"
 #include "evergreen_reg.h"
 #include "evergreend.h"
@@ -223,7 +224,6 @@ extern u32 si_get_csb_size(struct radeon_device *rdev);
 extern void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
 extern u32 cik_get_csb_size(struct radeon_device *rdev);
 extern void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
-extern void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
 
 static const u32 evergreen_golden_registers[] =
 {
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 12a918335ac7b..f09b6dc5cbeb3 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -40,6 +40,7 @@
 #include "atom.h"
 #include "avivod.h"
 #include "r600d.h"
+#include "rv770.h"
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_audio.h"
@@ -112,7 +113,6 @@ void r600_fini(struct radeon_device *rdev);
 void r600_irq_disable(struct radeon_device *rdev);
 static void r600_pcie_gen2_enable(struct radeon_device *rdev);
 extern int evergreen_rlc_resume(struct radeon_device *rdev);
-extern void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
 
 /*
  * Indirect registers accessor
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index 21f653ae1e1bb..88e29ebaad467 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -39,6 +39,7 @@
 #include "radeon_asic.h"
 #include "radeon_audio.h"
 #include "rv770d.h"
+#include "rv770.h"
 
 #define R700_PFP_UCODE_SIZE 848
 #define R700_PM4_UCODE_SIZE 1360
diff --git a/drivers/gpu/drm/radeon/rv770.h b/drivers/gpu/drm/radeon/rv770.h
new file mode 100644
index 0000000000000..a3f2bb44979fe
--- /dev/null
+++ b/drivers/gpu/drm/radeon/rv770.h
@@ -0,0 +1,35 @@
+/* radeon_rv770.h -- Private header for radeon driver -*- linux-c -*-
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
+#ifndef __RADEON_RV770_H__
+#define __RADEON_RV770_H__
+
+struct radeon_device;
+
+void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
+
+#endif				/* __RADEON_RV770_H__ */
-- 
2.25.1

