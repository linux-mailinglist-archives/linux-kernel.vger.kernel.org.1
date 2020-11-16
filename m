Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E902B4D96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbgKPRi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbgKPRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:44 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so19664989wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Szxzlxe07MDq6GBf9WMTaGmfQZg98jXh/8U8Q7NRl8=;
        b=cWujCKLBBVgUQyRuw5USqQWff0TcZh9I2YvP7MjQJxWb76ShqJ+IIoOaTqiIifIUew
         3dmTGfDKzlLil/pvr+g3YM2kyz7IPMyOlgZ3Hpuz8UQNNQSKtZmQRyxRawukvN3mzNnW
         go0QG1im5Pw9V1O65u+trn3gHzHTCbxX4uMLMVodj64bU+Bq3St5yZIvclTzBB+BR3xr
         pFPv+kFHHilL6Y6XXtL71jf+P4dcGPbkpHMp0wJzQt85DUSg8Q4bo523tThzUHDK2UCT
         J4w2a3gB2yNwrmIx0rCsCSDi4Pg6d0LUMsRtAq3Tv1Nnzj9Satc3yADiahzAj1Ix67ZK
         fy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Szxzlxe07MDq6GBf9WMTaGmfQZg98jXh/8U8Q7NRl8=;
        b=EK0nULHS6KUX8XSS67Z4Oara5rl6CrX085Blab0JrmSiSaxS1Mcp78WLgvW1OUjhDA
         dUBANQPaSdwXKATnbxuqZcnc6l+HbYj3+D6mOya1xaHwAu59NhT55n2dvre0fggGTpZF
         MB1t/BGFsMew8XVYPVSTNSOc1qJclDac8/Iq2VP4Jur9Uxu8G070BfyhVdH+EsgSu7xY
         f4w6Do2XPDtWCHZ7QaJLMGiLyu9mAqnw5H7Xduh1WkGPcrgR4EwCJkd7NcbMWpXh5Osx
         2Dz6bsqXVodKKvwJQQR02LIJ+xO9jbCdHK0U9XWiNMWW87pd7l4m829tMfdpvcT3RaCs
         GuPg==
X-Gm-Message-State: AOAM532b4TtX6O85TzEfJRCSyS56eye36iCe5aKYnqL7y+3LX8tgtyQ4
        GHfMDwrLq0OXJBT7vVlRE5OVpw==
X-Google-Smtp-Source: ABdhPJzXAtRq0zYeFBAml96Y8txKNsywwbSbgqgvHTz9nvFtZZ6Pi2JjMDBvw0Vqc9nVgFu7JzCDgQ==
X-Received: by 2002:adf:d18a:: with SMTP id v10mr20186934wrc.325.1605548263095;
        Mon, 16 Nov 2020 09:37:43 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/43] drm/radeon/ci_dpm: Move 'ci_*()'s prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:45 +0000
Message-Id: <20201116173700.1830487-29-lee.jones@linaro.org>
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
index 980b50d046cbc..ae020ad7b3185 100644
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

