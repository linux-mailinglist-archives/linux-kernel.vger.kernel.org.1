Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619442B4DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgKPRjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733279AbgKPRh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:27 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12244C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:27 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so19663259wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZB9hYDRdCmOkwqHlGjcs4P6f6PN70ruIEMJUcMVmENQ=;
        b=hZVLMix1qZXuOVledxd2pSvUCKHQwD1kkJJOi+0dzOiRZWtJzU6UHoOXvxWRs0/GcW
         yFlNWsBkdSrSq/mxr6HCuk6ZLzSLP3sSthyILxjtGJCBetdfhF9kSyv9F0CEQW7V6N1r
         CZBQP/LlSmmkZWzV4UOV0pCYavCl/esO2zH3MHWnY8aK8hGIE5gH8a7mE3lc0HRsZxfR
         f7Vkt/kyfkxpJg7u/yMSOHcb7IWtXceYip3tFAxmngjh/tsCk3Xph+1PeS1GTEXNqq3R
         fSySmp9Ht+PyBmgCj5THCOIIZB7U/be1M7R15riXasVAZzNzd7561n1QB16RiepLN97K
         dboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZB9hYDRdCmOkwqHlGjcs4P6f6PN70ruIEMJUcMVmENQ=;
        b=IXjXcXwJyAgDUMR+EO7gOvIhT3bScqiJYnEDNPHKcvRNEZbbUY8YjTUq2pvCi3pFX5
         KNN1ofgcFJxcGPmP3jw8khdgg+KFcFwCjFkFtboi2vt9cPOTWJdudaQGRAozNaiaGZfw
         X6ApmSDJn/zaSapabMxLKp8TF3p4bnhvdMb072P7YqM1g/1fcRQaa6+SJAR1o3e8Vd5S
         5MaEg3Yelwzmm6GRTq2z/4oDhIQrBVL4wv/OWhEEAqKM9jrFvbUbd5aAs+piYZxl7LkY
         6WG6QVyc2UQLH334TvC7Roq6hcG6sOy+Lt10Xi+ODJHErU32qDb5iGmEcIKDuYPFMhos
         wG3Q==
X-Gm-Message-State: AOAM532wHJ53k9T/SmY0xSx7sLqpqB7kE2zDWVRAIYofwSfjpnAt+eaP
        LvLgVCSP10VMu3EaZCEzVpviqw==
X-Google-Smtp-Source: ABdhPJydVhYVQplr9ob8iExHsLg/heD2iZQeiyoF2zK3gQ9KqSr1EMIhtlHB/PvQg1QOb8r4EHIfmw==
X-Received: by 2002:adf:f881:: with SMTP id u1mr21825293wrp.103.1605548245824;
        Mon, 16 Nov 2020 09:37:25 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 16/43] drm/radeon/radeon_gem: Move 'radeon_gem_prime_*()'s prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:33 +0000
Message-Id: <20201116173700.1830487-17-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_prime.c:34:18: warning: no previous prototype for ‘radeon_gem_prime_get_sg_table’ [-Wmissing-prototypes]
 34 | struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *obj)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_prime.c:42:7: warning: no previous prototype for ‘radeon_gem_prime_vmap’ [-Wmissing-prototypes]
 42 | void *radeon_gem_prime_vmap(struct drm_gem_object *obj)
 | ^~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_prime.c:55:6: warning: no previous prototype for ‘radeon_gem_prime_vunmap’ [-Wmissing-prototypes]
 55 | void radeon_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 | ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_prime.c:62:24: warning: no previous prototype for ‘radeon_gem_prime_import_sg_table’ [-Wmissing-prototypes]
 62 | struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_device *dev,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_prime.c:86:5: warning: no previous prototype for ‘radeon_gem_prime_pin’ [-Wmissing-prototypes]
 86 | int radeon_gem_prime_pin(struct drm_gem_object *obj)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_prime.c:104:6: warning: no previous prototype for ‘radeon_gem_prime_unpin’ [-Wmissing-prototypes]
 104 | void radeon_gem_prime_unpin(struct drm_gem_object *obj)
 | ^~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_prime.c:120:17: warning: no previous prototype for ‘radeon_gem_prime_export’ [-Wmissing-prototypes]
 120 | struct dma_buf *radeon_gem_prime_export(struct drm_gem_object *gobj,
 | ^~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c   |  1 +
 drivers/gpu/drm/radeon/radeon_prime.c |  1 +
 drivers/gpu/drm/radeon/radeon_prime.h | 39 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 drivers/gpu/drm/radeon/radeon_prime.h

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index d2876ce3bc9e2..b6b21d2e72624 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -35,6 +35,7 @@
 #include <drm/radeon_drm.h>
 
 #include "radeon.h"
+#include "radeon_prime.h"
 
 struct dma_buf *radeon_gem_prime_export(struct drm_gem_object *gobj,
 					int flags);
diff --git a/drivers/gpu/drm/radeon/radeon_prime.c b/drivers/gpu/drm/radeon/radeon_prime.c
index 088d39a51c0d2..dd482edc819c5 100644
--- a/drivers/gpu/drm/radeon/radeon_prime.c
+++ b/drivers/gpu/drm/radeon/radeon_prime.c
@@ -30,6 +30,7 @@
 #include <drm/radeon_drm.h>
 
 #include "radeon.h"
+#include "radeon_prime.h"
 
 struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
diff --git a/drivers/gpu/drm/radeon/radeon_prime.h b/drivers/gpu/drm/radeon/radeon_prime.h
new file mode 100644
index 0000000000000..11b7f80987834
--- /dev/null
+++ b/drivers/gpu/drm/radeon/radeon_prime.h
@@ -0,0 +1,39 @@
+/* radeon_prime.h -- Private header for radeon driver -*- linux-c -*-
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
+#ifndef __RADEON_PRIME_H__
+#define __RADEON_PRIME_H__
+
+struct dma_buf *radeon_gem_prime_export(struct drm_gem_object *gobj,
+					int flags);
+struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *obj);
+int radeon_gem_prime_pin(struct drm_gem_object *obj);
+void radeon_gem_prime_unpin(struct drm_gem_object *obj);
+void *radeon_gem_prime_vmap(struct drm_gem_object *obj);
+void radeon_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
+
+#endif				/* __RADEON_PRIME_H__ */
-- 
2.25.1

