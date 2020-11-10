Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF08D2ADF86
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbgKJTcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732004AbgKJTbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:52 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96118C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so14004406wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ty8003+O/JEDF7pP5AXz413pW2AvyhRU/ye41tnDsWk=;
        b=s94k4AARJMH88KYy14FAytQBhgRQtu3mTNFlcsB9Kqq5TY/VRHY5hI6N3PgVumpWdO
         im8vg1vZ+ZGC4yz6nlyQVcIYavBOHzzaQ65IxiTxlo/sCRUAeiG0edibCz2eH2Sw5kcl
         +bTTJZsFaKgNRG8vnbHC3bbw1UkR9F5edeItMAxcHDr+m1Ztq6tSrnR38WlZWCfzw3j5
         NUnTWNVeu2Y3zuFuQthNbDIC9JSOTFNtR2T/9D3K5HYaluTauVShQqzHnTC5+zf/pinF
         U3rUsgYEZRkTe4oHAdvU4xBCIHJTQITkiYwAbNvLwNkPoFU+2A5y8hDQDVcOCTBVEcWf
         fHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ty8003+O/JEDF7pP5AXz413pW2AvyhRU/ye41tnDsWk=;
        b=pkbqVYX1OnliUtd2jpzpWvXLFSeRXXw/Oq1asgYfzWZlz+3dKeQPq9iFvcZCK/GFs7
         eeL1yzjKf+d7X4Y7NtnOYSu3FEr2w5DEvlkbazkFQRZ/z+imPxIo4c/dVtcR3nXDKmSG
         HpsTbvjBOyo52GnYVPqgvvs8vYGgBMQob8hvdWk6fjWJBZPWk1AOhwHAKZTEDu9Bzxsg
         9EW7XHuKC146DL+TPIsKd8Cdwv7NhZ/+LYS0GgWVa18Jzr7FR1tiZcul8cYP+F2Rx1oE
         s4YqYJVLMLtPpw7XryvLjaTVhG2H9XbRlFahD8Gv1y6av3e4xILQ/brdn+wEHHCdTb+c
         ks3Q==
X-Gm-Message-State: AOAM531YXDhPB5OtBeDwzOsL2ZlbiU3ORueaKjTDISqhe32D42pwymrX
        vj71soC9KadhW0AkqyDb4/2H5A==
X-Google-Smtp-Source: ABdhPJwXZzmApbHRmw9IH4dWPxdKtvDjoHbg5PwPKccSXvb0iKSosbsELwUyTm0FQ32kXfNagjWGxw==
X-Received: by 2002:a5d:62c3:: with SMTP id o3mr13434790wrv.300.1605036711258;
        Tue, 10 Nov 2020 11:31:51 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/30] drm/radeon/evergreen: Move 'cayman_*()'s prototypes to shared header
Date:   Tue, 10 Nov 2020 19:31:10 +0000
Message-Id: <20201110193112.988999-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/ni.c:1378:6: warning: no previous prototype for ‘cayman_cp_int_cntl_setup’ [-Wmissing-prototypes]
 1378 | void cayman_cp_int_cntl_setup(struct radeon_device *rdev,
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/ni.c:1732:5: warning: no previous prototype for ‘cayman_gpu_check_soft_reset’ [-Wmissing-prototypes]
 1732 | u32 cayman_gpu_check_soft_reset(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen.c |  5 +----
 drivers/gpu/drm/radeon/ni.c        |  1 +
 drivers/gpu/drm/radeon/ni.h        | 36 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/ni.h

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index efb19c445e48f..28830f4ef95e3 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -31,6 +31,7 @@
 
 #include "atom.h"
 #include "avivod.h"
+#include "ni.h"
 #include "rv770.h"
 #include "evergreen.h"
 #include "evergreen_blit_shaders.h"
@@ -215,10 +216,6 @@ static void evergreen_gpu_init(struct radeon_device *rdev);
 void evergreen_fini(struct radeon_device *rdev);
 void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
 void evergreen_program_aspm(struct radeon_device *rdev);
-extern void cayman_cp_int_cntl_setup(struct radeon_device *rdev,
-				     int ring, u32 cp_int_cntl);
-extern void cayman_vm_decode_fault(struct radeon_device *rdev,
-				   u32 status, u32 addr);
 void cik_init_cp_pg_table(struct radeon_device *rdev);
 
 extern u32 si_get_csb_size(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 1c9030a4631b8..ab7bd30802176 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -33,6 +33,7 @@
 #include "cayman_blit_shaders.h"
 #include "clearstate_cayman.h"
 #include "evergreen.h"
+#include "ni.h"
 #include "ni_reg.h"
 #include "nid.h"
 #include "radeon.h"
diff --git a/drivers/gpu/drm/radeon/ni.h b/drivers/gpu/drm/radeon/ni.h
new file mode 100644
index 0000000000000..bb03ac702b1cc
--- /dev/null
+++ b/drivers/gpu/drm/radeon/ni.h
@@ -0,0 +1,36 @@
+/* ni.h -- Private header for radeon driver -*- linux-c -*-
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
+#ifndef __NI_H__
+#define __NI_H__
+
+void cayman_cp_int_cntl_setup(struct radeon_device *rdev,
+			      int ring, u32 cp_int_cntl);
+void cayman_vm_decode_fault(struct radeon_device *rdev,
+			    u32 status, u32 addr);
+
+#endif				/* __NI_H__ */
-- 
2.25.1

