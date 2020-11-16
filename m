Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD82B4D62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbgKPRhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733232AbgKPRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27186C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so2454912wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEdGEUBcwEa3ohTuW8AeQ9rcZ1jBGC5RhjVmwh26pbA=;
        b=hTWZaiHU5fA5ZEMniy8xudnbSwhiny/zhSVePhdiq89nhCPAqFfplsSB+RtBDA9Swn
         juht6Ir7HpAMfXv4ScFXAsNlO84L9fi8UKMVHx0469PTgEnG7RU+JC3CcpdCemKIZXx8
         vm6UZT1j4n7/Za58lJeoGRUQL0XZbOjAfrAjAnTcihGjkQt0n2vkQzHJkumvOskI0GMu
         wCvk4wvT0a9BK+yMiaMCGStDtdCsu92UEgPHSneLHt3Val2FZknJqkH7U9a/Pvg627BP
         zikms0bVWuvecz6aP5XLhupjyFpePbGYDowsuDLp91S09GlZeFTh1psutp5sMF3tqsVc
         I5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEdGEUBcwEa3ohTuW8AeQ9rcZ1jBGC5RhjVmwh26pbA=;
        b=HAYbR9iEU/e7xmiHqK0RUa/EFQlhnclU8BT/XeZiEs2CuIbnWHF6S7ecti4W0Pmhfn
         rBStIsu6WYf0FQqhUPT81mabV1VIyOFDhIopNmrMVb8br7aNhYlASeVGB0p/Ivyj+zDK
         bp1McYrQUx3qdWwCOreNIxA2o74qLMwpR1U/aXvd+RDWBv9xZpet4viJnxxdFUewrbJa
         h2w6txrIW+eQlSxdNiH++Q57x0O/BNVVCVTCHZ43f/LRCXfiXly+FqUIEmni1ct2Y5cT
         xkNAqxbKBymWehefjPqrsIcDRpvsve2p4TqRDLn3gfKNAnAb7QppolYKRHbW8Pz/YK1K
         lB1A==
X-Gm-Message-State: AOAM530+sBO2BUDDOzTrzrXQq2CfIt8cVtuFdp/7Udzwzx023jg4z1mH
        XyHg4prxaS2FTI2mvI7Y2AkBvg==
X-Google-Smtp-Source: ABdhPJxK86tNpaYZzkU5H14VhFrpzSs1zfiylnszNRxTdZ68f+BxhRrbvIkmhcTtIF49DCVZzT3W1A==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr20423096wrv.258.1605548236915;
        Mon, 16 Nov 2020 09:37:16 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/43] drm/radeon/rv770: Move 'rv770_set_clk_bypass_mode' prototype to shared location
Date:   Mon, 16 Nov 2020 17:36:26 +0000
Message-Id: <20201116173700.1830487-10-lee.jones@linaro.org>
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

