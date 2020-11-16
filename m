Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38002B4D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbgKPRhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733296AbgKPRhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27267C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so19663846wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDrg++qLU9iWkSFdQ/o4AXQ/+Fr9yLOD8f+3Y4A/s60=;
        b=vwvgWAZGXD4csTPpegSaVxc/aaIE61/wEIzVAf+2aIeheouwTAKWMFK5gbwrQjoQUC
         YdTFhAt1VDsys1Z/ImgXTKOzBc2AWRzQVNoMrWf1hMFn3oqRe39Y+qv/7ftRdB5RjrwM
         qeKk/P7e1p2zk6ZSTnPYROFWXqlzY0IdYWlMrmnPef+a1Kj2Ndxum3XecLXSaYL1un2X
         JoPscjjZRvLnSz3JVckM4EzRhIOr8r2t6LRylc4WD2587o1UXUioWKXijdBk6/chWToB
         v3ot2jQMmUiu9bAoCQtpMxCFIUZ3GWMT6j0se+pwLnhQHVV/IcQyGv1LJVZmYvrjECrD
         5IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDrg++qLU9iWkSFdQ/o4AXQ/+Fr9yLOD8f+3Y4A/s60=;
        b=t50XcFNk19yxu58+kb1Ovuvu8EGK+pDalfiIhm0pO81lqLHFvkEMG8nciua+jl4hOh
         ZyBIyPO/cb+p7ZweuZ3RA4eHQUKmZOxQbSF2TH9dsgz+xnhwILIVnTSGMGVTgCHLJkjY
         +guMiIanTyqMyd/gyGg7BGqXpVjOtFT4hnj6onzmVId+1OAlkMU3qltwNypqCEU0bie3
         pFoZ8Zp0oqhauFYnrBRO/soPXGvNFqVnoq5MRJDQcICHRetpkdXLs8EWQ4tBgDk7D7Nt
         ej1I+C3esA/b/LDqPpxc7UYrJ38djg9yN/6h+R/OmDuC0FpTD88sRgjaTA7bO9jUazZn
         h8gA==
X-Gm-Message-State: AOAM530xI0biwrtCUo3NbOUEwrTvjy4YZEVvTg/90HW5UA30+rUtCXZe
        sPzANlYGEEJpMkMw8IwCyrmZUA==
X-Google-Smtp-Source: ABdhPJyG4oeTy0mFHPZhi+51SqInZVQyTQBRKJOc4lC6U7QCDZ6UDjEgSCT1UPyVIvqKHuuZkFnevg==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr20140228wrv.243.1605548251806;
        Mon, 16 Nov 2020 09:37:31 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/43] drm/radeon/evergreen: Move 'cayman_*()'s prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:37 +0000
Message-Id: <20201116173700.1830487-21-lee.jones@linaro.org>
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
 drivers/gpu/drm/radeon/evergreen.c |  5 +---
 drivers/gpu/drm/radeon/ni.c        |  1 +
 drivers/gpu/drm/radeon/ni.h        | 38 ++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/ni.h

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index f860f5ef2df88..8fb0b8c3db5b5 100644
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
index 0000000000000..d63be1c88c0f1
--- /dev/null
+++ b/drivers/gpu/drm/radeon/ni.h
@@ -0,0 +1,38 @@
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
+struct radeon_device;
+
+void cayman_cp_int_cntl_setup(struct radeon_device *rdev,
+			      int ring, u32 cp_int_cntl);
+void cayman_vm_decode_fault(struct radeon_device *rdev,
+			    u32 status, u32 addr);
+
+#endif				/* __NI_H__ */
-- 
2.25.1

