Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C474B2ADF90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbgKJTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbgKJTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:45 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5254C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so9605673wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQd0T6EZFrZfchicFX37ZuWoOJNv6vhATW4C3kJNXAM=;
        b=NfPbVfYFBBBjkxCWTq+m/TLJOAQordAJBmRq0U/vnLCAcBmtoGC1b1qlMvfFXFQrVt
         p7/xW3rweSPZZwDy2lSQOcqGTViIRaNzSQ1L4gV9a2kgTTxnMUEI/2fB6qRWo6j+p5Xq
         HOsgh5DQ2J1NLmbacVB/ITLusVLkNvBQ+JSuJx4jaS8YsqR18Z0DjOVsYTlaN5m6dgBj
         trLQja4ZJ3AGuFfnuSKzfaVj3Y1yJOUTt5vsvDhhP5mhX7/4dFNHIGE6XsfI+slaMeBO
         CzoZSruaj/XMeNLQysRevchaQDjeznR+Bh1S3yaLc9CJKixBLNMGDpnN4ItSOm69SnGo
         /QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQd0T6EZFrZfchicFX37ZuWoOJNv6vhATW4C3kJNXAM=;
        b=bTMTIdC2MaGi4x8Sr7gaf8utxrJM//0TpH0MdNUqH4HTTX1XJ521tUfCs7dHYQcyy7
         Lj09gb0yFLh4RVdNrBfbGK/RHOR5APeTANOMjEF9b4U2hEkgiOVF1RFYQs7Qa8lQH6JY
         xuMnAT5FXDxLBfNXQUsUAQXc+SeXKgpENccQ7vq7LKYqL0JdqVjD8BmtzjlwHAnTuHz0
         9gwNV4butQcNkTeOCN7oVLoWKS4MCnfWEP9DPSNqc1lyRi1JQUdF9B/YHZgdfnmobdkf
         QnEvrlPAj2YOgOsEVZcV0ut6Ov4qGEDT4Ajy4ADnwNEGC/QC7sNNdRQJif4Dxp5yFR1I
         wALQ==
X-Gm-Message-State: AOAM531gS0dr94KUocCqzlCPoClxqvHYeQ0Wu4y/UpiXjh3x8yHzBmse
        4qSX8SpZqnHC40YCJzL30Aplyg==
X-Google-Smtp-Source: ABdhPJyWRZfDxpuBUrY4O3jPEFdQHh2/tXUGRGyJsPU87lKC+HnGc+0Ov8H6i8WFesbdAxKyzE7YxA==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr25262268wrr.161.1605036703586;
        Tue, 10 Nov 2020 11:31:43 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 22/30] drm/radeon/radeon_gem: Move 'radeon_gem_prime_*()'s prototypes to shared header
Date:   Tue, 10 Nov 2020 19:31:04 +0000
Message-Id: <20201110193112.988999-23-lee.jones@linaro.org>
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
 drivers/gpu/drm/radeon/radeon_gem.c   |  9 +------
 drivers/gpu/drm/radeon/radeon_prime.c |  1 +
 drivers/gpu/drm/radeon/radeon_prime.h | 39 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/radeon_prime.h

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 0ccd7213e41ff..6db11e357565b 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -34,14 +34,7 @@
 #include <drm/radeon_drm.h>
 
 #include "radeon.h"
-
-struct dma_buf *radeon_gem_prime_export(struct drm_gem_object *gobj,
-					int flags);
-struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *obj);
-int radeon_gem_prime_pin(struct drm_gem_object *obj);
-void radeon_gem_prime_unpin(struct drm_gem_object *obj);
-void *radeon_gem_prime_vmap(struct drm_gem_object *obj);
-void radeon_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
+#include "radeon_prime.h"
 
 static const struct drm_gem_object_funcs radeon_gem_object_funcs;
 
diff --git a/drivers/gpu/drm/radeon/radeon_prime.c b/drivers/gpu/drm/radeon/radeon_prime.c
index b9de0e51c0be9..789e076efbdc6 100644
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

