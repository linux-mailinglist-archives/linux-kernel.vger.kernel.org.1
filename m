Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786FA2B4CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbgKPRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732952AbgKPRaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:30:18 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32607C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so19594973wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sc1pkIB+FW/k5gLv6YQPQhC4CZ1RwfaoeaGhthq0b4c=;
        b=DMsL8W/H8v62ShBaaWAxP3uZBR/lVSr8Xmtid89duoKrUS8TIIJJc8hjjHAzNkoaqV
         6xl4sDIbSdq2nH8VZgFLXQYq5i/nD9XKKjLnmTVADYJzDnpYjTn/uwNUC2O9O/fFnVUk
         QrAGaz/FLDqVcczS7WhDfb0jI4hAhu6qCh3bidhiLGG/5hG35VAMD1+to2IBioYZrjpa
         OSWCxy0hpsJgxfIm3fMU15E6eAHDBXyCbUNl+fFkoyVYwfEYmVw5ZSzYCursf42G0E2X
         KphyNbe2w2DwCNofaQ36mvlqAuk1R8F546oYg/wa7OS3XjTuWwqS8LIgRk2zWXJ6uqMC
         DaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sc1pkIB+FW/k5gLv6YQPQhC4CZ1RwfaoeaGhthq0b4c=;
        b=d3/i/jqqi6rbjS6kZcnaYaRZp6bzYx/AojJYNvg0BAcgvjFUiB7FYIBZ5jWxsIdDE5
         4sdPGDeQXVT2b2gz/oXdUnXSSW21teWRsp423eX5uwT65aaQ2uzUTd1/gMffeFr0E4V6
         OCl4tH5VttcAEi6BBJ6DM7WVClbikeHo10iO0uaXjCcGsmSWWL6CA6YsTdIXiwZ3yCdA
         cIVb4JGQcRbbeyUBvD2Ptikkucgj0vjM66mlTpz99ISEdeQ6qku8d37NytQUHOHU9pX1
         uduI/1zeIfEyN7q2iICsMwHo8lriw5socktRqRvGwDrFOxsn3/Sqcbr+jlV8Kqoth+2a
         RyJA==
X-Gm-Message-State: AOAM531w3vfBygTu4lk6yy07ymGHUDCILUjOfcTfHXYbNxmgpn8dh4Y0
        KgcDngCMDlWBIYel1t5X1xl2jA==
X-Google-Smtp-Source: ABdhPJzEjh5/6VKYHCgw5AUCL3QFWv3CeW+3HVK4y5KST6szXd0HD0BZPe4mBpI01QnXZOFKiYRd7w==
X-Received: by 2002:adf:f208:: with SMTP id p8mr19655214wro.280.1605547815889;
        Mon, 16 Nov 2020 09:30:15 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:30:15 -0800 (PST)
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
Subject: [PATCH 05/43] drm/radeon: Move radeon_ttm{init,fini} to shared location
Date:   Mon, 16 Nov 2020 17:29:27 +0000
Message-Id: <20201116173005.1825880-6-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_ttm.c: At top level:
 drivers/gpu/drm/radeon/radeon_ttm.c:817:5: warning: no previous prototype for ‘radeon_ttm_init’ [-Wmissing-prototypes]
 817 | int radeon_ttm_init(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_ttm.c:878:6: warning: no previous prototype for ‘radeon_ttm_fini’ [-Wmissing-prototypes]
 878 | void radeon_ttm_fini(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~

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
 drivers/gpu/drm/radeon/radeon_object.c |  3 +--
 drivers/gpu/drm/radeon/radeon_ttm.c    |  1 +
 drivers/gpu/drm/radeon/radeon_ttm.h    | 36 ++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/radeon_ttm.h

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index ab81e35cb0606..8bc5ad1d65857 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -40,9 +40,8 @@
 
 #include "radeon.h"
 #include "radeon_trace.h"
+#include "radeon_ttm.h"
 
-int radeon_ttm_init(struct radeon_device *rdev);
-void radeon_ttm_fini(struct radeon_device *rdev);
 static void radeon_bo_clear_surface_reg(struct radeon_bo *bo);
 
 /*
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 2939e71ceb700..28b300ed200ea 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -51,6 +51,7 @@
 
 #include "radeon_reg.h"
 #include "radeon.h"
+#include "radeon_ttm.h"
 
 static int radeon_ttm_debugfs_init(struct radeon_device *rdev);
 static void radeon_ttm_debugfs_fini(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.h b/drivers/gpu/drm/radeon/radeon_ttm.h
new file mode 100644
index 0000000000000..91ea7141bc812
--- /dev/null
+++ b/drivers/gpu/drm/radeon/radeon_ttm.h
@@ -0,0 +1,36 @@
+/* radeon_ttm.h -- Private header for radeon driver -*- linux-c -*-
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
+#ifndef __RADEON_TTM_H__
+#define __RADEON_TTM_H__
+
+struct radeon_device;
+
+int radeon_ttm_init(struct radeon_device *rdev);
+void radeon_ttm_fini(struct radeon_device *rdev);
+
+#endif				/* __RADEON_TTM_H__ */
-- 
2.25.1

