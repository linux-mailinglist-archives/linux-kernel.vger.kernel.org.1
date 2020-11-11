Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF22AF829
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKKSgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKKSgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:00 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F9C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:59 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b6so3519127wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5cdr3xq36okPI4QzX5zrw2cP/RfIKuDYtKma5kBVEI=;
        b=lmJGhgGzkUlMORHmRw0waBQnbWjKPoD+noPk/XBK4aL+OSKBkstdqDh4ByHmbSo2ar
         60EdFYIXNiwFZcEg+M+bBI6h8SPfZwfp5cq/oKW/QyJpd1H6hhyVpUmWXEyuKB4w8fOL
         NhnB6u+8hDqSoTzKfRyXWmbL2jZ0vUDmDXgkUVsK95jmI6I9WDj/6+ebn4LGDrcpq7jE
         NvQxmIzA/j9gtNRSfiSHk0pg3J1HKpppJB/mLj2mYZngu1IKoP5kkOxoFx/dtMPGVOJ0
         COWd4EM3HSU+y2K2q4qOZkVUKW+XXuMrGVyFYFvW1WfOWpZN09IcPnmOaFi0c1l+2Av0
         etSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5cdr3xq36okPI4QzX5zrw2cP/RfIKuDYtKma5kBVEI=;
        b=UQNCAoKIcuyJcSW4StlL+RKbSH2WoUhjyQ/NLg/8GIsZYFzrtsQcOafIwqaPiV2w1H
         Gdmn+xFtUyAvHYW1Mc4rICBuFWcMfF3ybPZW4GHr/Y3v05L7I5Jv39CiAtjOBc7qzqIn
         jO1skIKN1UQ7yzB7N5tO3AdDaz4zPM4YfsfLV0vtmQ5b94opSsc+PEfQSIzmnZIhqFR8
         aueB0S4PKb1Du1B4kg+X11m9g3YaPU6g3lAb8TKBAjjhy8+412qWh7f6iwuH6lGEmlxJ
         EjIAdrNdnVEDBSRBVVv1o4kGIgNFykPAi8JbeU+OtD7gcH/WZU9qpIc4cVjaNcUBsrCO
         7VFg==
X-Gm-Message-State: AOAM530jRUgwZlUNjZMzeYBDI8++36RLgdb3BkEQcLjn8F9PnoJN6N8V
        BDCCsa2RHLeGFP+o/kIuzWjpZA==
X-Google-Smtp-Source: ABdhPJxMaiJ1AksolhCxymXkqd70nJ3i/ThtU9cSJxNHNdQQMgIXXrHhfwAMJry873sgrXrp5DLP6Q==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr18034885wrq.424.1605119758267;
        Wed, 11 Nov 2020 10:35:58 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:35:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/19] drm/radeon/ci_dpm: Move 'ci_*()'s prototypes to shared header
Date:   Wed, 11 Nov 2020 18:35:32 +0000
Message-Id: <20201111183545.1756994-7-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/cik.c:1868:5: warning: no previous prototype for ‘ci_mc_load_microcode’ [-Wmissing-prototypes]
 1868 | int ci_mc_load_microcode(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/cik.c:5847:6: warning: no previous prototype for ‘cik_enter_rlc_safe_mode’ [-Wmissing-prototypes]
 5847 | void cik_enter_rlc_safe_mode(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/cik.c:5868:6: warning: no previous prototype for ‘cik_exit_rlc_safe_mode’ [-Wmissing-prototypes]
 5868 | void cik_exit_rlc_safe_mode(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/cik.c:6286:6: warning: no previous prototype for ‘cik_update_cg’ [-Wmissing-prototypes]
 6286 | void cik_update_cg(struct radeon_device *rdev,
 | ^~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/ci_dpm.c |  7 +------
 drivers/gpu/drm/radeon/cik.c    |  1 +
 drivers/gpu/drm/radeon/cik.h    | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/cik.h

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 8324aca5fd006..a9fc0a552736c 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -27,6 +27,7 @@
 
 #include "atom.h"
 #include "ci_dpm.h"
+#include "cik.h"
 #include "cikd.h"
 #include "r600_dpm.h"
 #include "radeon.h"
@@ -157,12 +158,6 @@ extern u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mode);
 extern void si_trim_voltage_table_to_fit_state_table(struct radeon_device *rdev,
 						     u32 max_voltage_steps,
 						     struct atom_voltage_table *voltage_table);
-extern void cik_enter_rlc_safe_mode(struct radeon_device *rdev);
-extern void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
-extern int ci_mc_load_microcode(struct radeon_device *rdev);
-extern void cik_update_cg(struct radeon_device *rdev,
-			  u32 block, bool enable);
-
 static int ci_get_std_voltage_value_sidd(struct radeon_device *rdev,
 					 struct atom_voltage_table_entry *voltage_table,
 					 u16 *std_voltage_hi_sidd, u16 *std_voltage_lo_sidd);
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 377c3f0c9d316..af08d6f1be53e 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -32,6 +32,7 @@
 #include "atom.h"
 #include "evergreen.h"
 #include "cik_blit_shaders.h"
+#include "cik.h"
 #include "cikd.h"
 #include "clearstate_ci.h"
 #include "r600.h"
diff --git a/drivers/gpu/drm/radeon/cik.h b/drivers/gpu/drm/radeon/cik.h
new file mode 100644
index 0000000000000..297b3c1ff804f
--- /dev/null
+++ b/drivers/gpu/drm/radeon/cik.h
@@ -0,0 +1,33 @@
+/* cik.h -- Private header for radeon driver -*- linux-c -*-
+ * Copyright 2012 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __CIK_H__
+#define __CIK_H__
+
+struct radeon_device;
+
+void cik_enter_rlc_safe_mode(struct radeon_device *rdev);
+void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
+int ci_mc_load_microcode(struct radeon_device *rdev);
+void cik_update_cg(struct radeon_device *rdev, u32 block, bool enable);
+
+#endif                         /* __CIK_H__ */
-- 
2.25.1

