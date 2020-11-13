Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478972B1CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgKMNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgKMNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:49 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2970C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:48 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so8199700wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+yLMECfz4SQeh3+r6t6vIS8Tp4hfLiHYcv2v7xPbbH8=;
        b=XwFxvGa9Xc8VSIwGJA9BMdIQW9mUlNFmQAqTyunI02+OZcgeOhYLBswJPnWTzruwhx
         mo2BJ/8T2PrZu9oTvXUxAG0l3V9EYDdFyx7DsRMMIdRybw/crYokPbqPGjgsX1OrvKg4
         EuqJPpQkRnhM/0e2vZJTF4poIpcDRj4YipAu3SOfO88BrBy4UvVqd6Oj6r7hGQb0nBCl
         G7TVdOXrrDTrsVtibgzInH4IYVN7myIIjGIn1Azb4qlkyWs2s5seN8RWVtcVNwjVALRa
         WnWakzteQsdODnVicJ5uPCUXG2Htl3eFcSD+gBt//wKClhkOCRFtaX3Pdpj9eQAFs918
         VaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+yLMECfz4SQeh3+r6t6vIS8Tp4hfLiHYcv2v7xPbbH8=;
        b=p/ZDbQ9HW/U4pE7rh/PbDVbJISg7IE6Uub3qCrH9F28q2qSJZI576aSNDnQls6LgkH
         JfzG1p8EenynAxrMWAjlEvc24kVi/gg3jQuLI2j3EMUF3C4ZkeajMPLUtkO5KHVHMRry
         bA/YYx41IPE3QUY+UtiC5pNwkIhwK9FtRaq5QTzPC4SeeVtO1/vttC+iZsl1kKY+P1bi
         1sDoAJstxABSxkMbwxtWTQ9sKjSDGw+CsZO+3isyJgCChITdW5uX9u3lhY8lwxfI28EZ
         bLBjdOuMCYy+fkOSZVAn1e4aApB11nDarwxduT6ADbSySJtpOgje+2y/UY/GIuJP0h6w
         cEyg==
X-Gm-Message-State: AOAM533AnsiVwROJ39IiaUUFsoLwO26c6npaQb6jxm5bixGTXbgVxYDa
        Uk1/T6/eGmZFvEe4lyuvtYrgSg==
X-Google-Smtp-Source: ABdhPJx+1sAzkV64JF8F64spUR6Uwp5TXog7Wm8TUi4ys94jGGva4WCiRiKmB8JtjjfXmRWCmxKYsA==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr2593413wmf.76.1605275387562;
        Fri, 13 Nov 2020 05:49:47 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amd/amdgpu/amdgpu_drv: Move 'amdgpu_info_ioctl()'s prototype to shared header
Date:   Fri, 13 Nov 2020 13:49:02 +0000
Message-Id: <20201113134938.4004947-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:486:5: warning: no previous prototype for ‘amdgpu_info_ioctl’ [-Wmissing-prototypes]
 486 | int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 | ^~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h | 31 +++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1dfea15bbec36..afd357df0f886 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -43,7 +43,7 @@
 #include "amdgpu_sched.h"
 
 #include "amdgpu_amdkfd.h"
-
+#include "amdgpu_kms.h"
 #include "amdgpu_ras.h"
 
 /*
@@ -1521,8 +1521,6 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
 	return 0;
 }
 
-int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-
 const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_CREATE, amdgpu_gem_create_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_CTX, amdgpu_ctx_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 98721ae931841..54c4ee6d230d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -41,6 +41,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
+#include "amdgpu_kms.h"
 #include "amdgpu_ras.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h
new file mode 100644
index 0000000000000..f3111aef76cae
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h
@@ -0,0 +1,31 @@
+/* amdgpu_kms.h -- Private header for radeon driver -*- linux-c -*-
+ *
+ * Copyright 2008 Advanced Micro Devices, Inc.
+ * Copyright 2008 Red Hat Inc.
+ * Copyright 2009 Jerome Glisse.
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
+#ifndef __AMDGPU_KMS_H__
+#define __AMDGPU_KMS_H__
+
+int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
+#endif                         /* __AMDGPU_KMS_H__ */
-- 
2.25.1

