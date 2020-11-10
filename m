Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0A2ADF75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgKJTbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbgKJTbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:42 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E0DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:42 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so4310541wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FO92cL0QjF/6Dy4FIvl+P0IasJ1CYr1sR86S5Uq88PQ=;
        b=tFqI6aqT9V0J73yOVy/As6jFhTZnzDFC3gBR73vSwhOML2NlW3/13opSb0++qsLvrq
         d6zBUZPpWQGXuYx6E5PVuNnX/o4KbeH6ZHx1M8Hz8Ek8zLEShZOcpZlXmis/hKhlod+y
         ZIIyb2JDTqXbPcX5rHohL6LOAoQuoWGtn2YbJGg8UaY9XuhZqcbkjO7zcx9Uxnb6yFRF
         NU0X0tOov9irRbLq9JiYub1od4CmmXk7ckxkzpm9LC9/WxgqHwD4/ZrU50La4T54DUOZ
         Qu3RbX8ch0cHg4o/cSUxoaWOGGMwt3D1gl/w+8JLU/AWVNdmhP0OGlZE9uNKqH320MeF
         9dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FO92cL0QjF/6Dy4FIvl+P0IasJ1CYr1sR86S5Uq88PQ=;
        b=qkOMCEAtB+c5Eo186vSPPseWz+tI4nVXygjzdEPSejkpUkvnpzDFHMNOjQcWnUV78a
         cMayyO5R9cuwSAZGPQMwcK7Cu16lRLQM3417UkQcMiy0SMZsh0t2LYC9MO1Xa130xtF0
         cVHQF9moDUPXeZPmVBelPdd9bEuxBx4dYojy1N6WzzpJqVvh/KV7VXT/6zajSZRrLW+d
         jlbLEF9uwIGc2+UZbZsIPKZl6Mt6W3CL6ncb0oscNtgyw4W+nrQ8PAjMq4NyZX+JCmoo
         3gCpnpbDMq9g1XhZErIsUqTFwr8w0eTU+R7BiYJwLWxlS9zQjhAXpG8+7L3z78ytOt7m
         1/Rw==
X-Gm-Message-State: AOAM530K83JuZ7k9V5s+aikLSVWkAK8gmoK3SokQS4fwGZJaRj703RET
        Do8APeafhrO4FpQP9ESynQI6qQ==
X-Google-Smtp-Source: ABdhPJwi0mRoMPTaC+iz+dNbvhBdCvFOfNPNWeY3B4R74Bkz1ECRu6hN6qcnliXZkCtMVHnEr+K4zw==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr742033wmf.133.1605036701212;
        Tue, 10 Nov 2020 11:31:41 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 20/30] drm/radeon/radeon_drv: Move 'radeon_driver_irq_handler_kms's prototype into shared header
Date:   Tue, 10 Nov 2020 19:31:02 +0000
Message-Id: <20201110193112.988999-21-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_irq_kms.c:53:13: warning: no previous prototype for ‘radeon_driver_irq_handler_kms’ [-Wmissing-prototypes]
 53 | irqreturn_t radeon_driver_irq_handler_kms(int irq, void *arg)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_irq_kms.c:120:6: warning: no previous prototype for ‘radeon_driver_irq_preinstall_kms’ [-Wmissing-prototypes]
 120 | void radeon_driver_irq_preinstall_kms(struct drm_device *dev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_irq_kms.c:152:5: warning: no previous prototype for ‘radeon_driver_irq_postinstall_kms’ [-Wmissing-prototypes]
 152 | int radeon_driver_irq_postinstall_kms(struct drm_device *dev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_irq_kms.c:171:6: warning: no previous prototype for ‘radeon_driver_irq_uninstall_kms’ [-Wmissing-prototypes]
 171 | void radeon_driver_irq_uninstall_kms(struct drm_device *dev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c     | 5 +----
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 1 +
 drivers/gpu/drm/radeon/radeon_kms.h     | 5 +++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 2b9deaead99b2..211932d73b191 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -51,6 +51,7 @@
 #include <drm/radeon_drm.h>
 
 #include "radeon_drv.h"
+#include "radeon_kms.h"
 #include "radeon_ttm.h"
 #include "radeon.h"
 #include "radeon_device.h"
@@ -117,10 +118,6 @@
 int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 		       bool fbcon, bool freeze);
 int radeon_resume_kms(struct drm_device *dev, bool resume, bool fbcon);
-void radeon_driver_irq_preinstall_kms(struct drm_device *dev);
-int radeon_driver_irq_postinstall_kms(struct drm_device *dev);
-void radeon_driver_irq_uninstall_kms(struct drm_device *dev);
-irqreturn_t radeon_driver_irq_handler_kms(int irq, void *arg);
 extern int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned int crtc,
 				      unsigned int flags, int *vpos, int *hpos,
 				      ktime_t *stime, ktime_t *etime,
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index 3521084030d24..7348ae52e2ef8 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -38,6 +38,7 @@
 
 #include "atom.h"
 #include "radeon.h"
+#include "radeon_kms.h"
 #include "radeon_reg.h"
 
 
diff --git a/drivers/gpu/drm/radeon/radeon_kms.h b/drivers/gpu/drm/radeon/radeon_kms.h
index 36e73cea92154..913c8239d5d8d 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.h
+++ b/drivers/gpu/drm/radeon/radeon_kms.h
@@ -32,4 +32,9 @@ u32 radeon_get_vblank_counter_kms(struct drm_crtc *crtc);
 int radeon_enable_vblank_kms(struct drm_crtc *crtc);
 void radeon_disable_vblank_kms(struct drm_crtc *crtc);
 
+irqreturn_t radeon_driver_irq_handler_kms(int irq, void *arg);
+void radeon_driver_irq_preinstall_kms(struct drm_device *dev);
+int radeon_driver_irq_postinstall_kms(struct drm_device *dev);
+void radeon_driver_irq_uninstall_kms(struct drm_device *dev);
+
 #endif				/* __RADEON_KMS_H__ */
-- 
2.25.1

