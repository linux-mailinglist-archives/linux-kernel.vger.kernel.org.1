Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209CC2A9F83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgKFVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgKFVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:07 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F9CC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:07 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so2848251wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xaVwrMr6e/jbnTc5qGRYSEriQiljvoWqO6b2JcTWvj4=;
        b=eXZxFJ0DJnXnG4PTRnW4zbY40yCi26ZRguq8FgTlJbA5SNWLBT9jWR5zy1R2sUX1TM
         CMHOP+N7nrftop8HRYZB+EagLdSwgk3Z/SXWWqj/O97kqn1n+TDDyqo8b0KoNy3bReyb
         HPe4pHgcNYeo3m2J+aH4PH4Lc+6HNLQwlmWJ1Yqo5OXuPcc336PxwRnc7u3uPpoqoeQm
         EcbvtA9V1xc983pr9fJX2OQTH+ogpHZKb4opW6oKP9iDkH2ZS+wUuhPTYB4AH4SQRTiJ
         i7HVBe4elFUAD88VJK0DZAAZSjIQE0ehoP3LF/KWBD7ru9eGI0jGKdsWChjT9uWyOavh
         emoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xaVwrMr6e/jbnTc5qGRYSEriQiljvoWqO6b2JcTWvj4=;
        b=OSIMGc6QYVl/vuhflZyCxg/Ex68N+wgFoL2z3JmainFRDCBC2v+Dwd/WRK1Zk9pUAG
         6KfDCU7jvf0CL/HiCUFEtgHIFy5m7wiIpFtn8Hs8Ej7KYIKXMVaQzqQOZcoEOFA49Qzb
         9SvMtgQmHxPNcEc0Rt5C1zSZM9H9JNy2QXJ8G/A9XwnQ6NdzPB/xipB0bWy/VWHFMOwy
         pHI0Kj91TezjxMS1MAeuN04fvu7QPSthgxNYvDzIid9Ow947FWQGYqOXr7xJCyTbz6RE
         vQ26+/HRywcXJtjSqf4fSqhc7T5JMf6xPp8jOlo641CGOMAU0v5erZeKWaMDGFD7ccSG
         uwpA==
X-Gm-Message-State: AOAM5329w4IWDA4GwADWRfoIU2If0pasWoSDvQjDeo0BpY06QxfpKJSk
        ABxOIL4xoo7RvNMQsv8yNyxfeQ==
X-Google-Smtp-Source: ABdhPJxTmyerXkl8RR0eJrnwM1v2u23YYZVK3Ps71Ip7mBI6xQdbKTgb9Ow5+TUh5vKokN7ikvoPkg==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr1502624wmb.99.1604699406015;
        Fri, 06 Nov 2020 13:50:06 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:05 -0800 (PST)
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
Subject: [PATCH 10/19] drm/radeon/radeon: Move prototype into shared header
Date:   Fri,  6 Nov 2020 21:49:40 +0000
Message-Id: <20201106214949.2042120-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, a suitable one didn't already exist.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_device.c:637:6: warning: no previous prototype for ‘radeon_device_is_virtual’ [-Wmissing-prototypes]
 637 | bool radeon_device_is_virtual(void)
 | ^~~~~~~~~~~~~~~~~~~~~~~~

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
 drivers/gpu/drm/radeon/radeon_device.c |  1 +
 drivers/gpu/drm/radeon/radeon_device.h | 32 ++++++++++++++++++++++++++
 drivers/gpu/drm/radeon/radeon_drv.c    |  3 +--
 3 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/radeon_device.h

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 7f384ffe848a7..ad572f965190b 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -42,6 +42,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/radeon_drm.h>
 
+#include "radeon_device.h"
 #include "radeon_reg.h"
 #include "radeon.h"
 #include "atom.h"
diff --git a/drivers/gpu/drm/radeon/radeon_device.h b/drivers/gpu/drm/radeon/radeon_device.h
new file mode 100644
index 0000000000000..c8e6dd2005224
--- /dev/null
+++ b/drivers/gpu/drm/radeon/radeon_device.h
@@ -0,0 +1,32 @@
+/* radeon_drv.h -- Private header for radeon device -*- linux-c -*-
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
+ */
+
+#ifndef __RADEON_DEV_H__
+#define __RADEON_DEV_H__
+
+bool radeon_device_is_virtual(void);
+
+#endif				/* __RADEON_DEV_H__ */
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index f5f1cb700d873..560267cc25892 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -51,6 +51,7 @@
 #include <drm/radeon_drm.h>
 
 #include "radeon_drv.h"
+#include "radeon_device.h"
 
 /*
  * KMS wrapper.
@@ -300,8 +301,6 @@ MODULE_DEVICE_TABLE(pci, pciidlist);
 
 static struct drm_driver kms_driver;
 
-bool radeon_device_is_virtual(void);
-
 static int radeon_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
-- 
2.25.1

