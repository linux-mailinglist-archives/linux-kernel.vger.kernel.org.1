Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848F72B4D68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgKPRhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733233AbgKPRhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:24 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:24 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so37239wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOhlVom8ArIcUSlzkbPekEoXplId4I2upAMKLydb2GM=;
        b=CmPxnfrb0iveHS+EM+94RdsbI4La2NMSex8aL0XxYO+VsmiHxb1T/B0NVOroiN4eNy
         znBmDRIvsBXEblbIonPmhP54WgoTytMUlbfC+xD/LJkUwRKBoi5dfGThNDnjMMn1GPZQ
         HURBVacMhPpsqtVDiGkQdoi8T9Hvgq0fwOQyAVwuw7HQ1SQao+jOshpXOjMsm9DX+Jlo
         RBt20P0RIfkJ+fsKhkZNswBsAgph2o0G2IjIaLW5x+5Z0yIeauoJsnQIBu/uClSaKxod
         euCSaxmgg0cNnMcDKWUevDeoTsfpdsYbqv6Mrdxk8hn0lbFaeOjLcxwg/65wZ2ZVl5ti
         k8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOhlVom8ArIcUSlzkbPekEoXplId4I2upAMKLydb2GM=;
        b=raYlLcJmLi/8nXQpwkyt8+Pezf85DHYQDYwQ7t8g7oRconOupqJS12aoDNQjycNQpG
         tB1OG1q7o1kcwvB6oDvfD/ZeOeAmfaS7KExwMZDrzvoaZVZ3KVRcK41/vViIPj2hrHfz
         9WjNM1+UtI8g5BDakeZ1PE73+C9CT2AnUZ2tYQj10zWd8IldrG7BbneflYnx76F1CDNd
         uCuepDtwhbATfNK+PSF1oCfO2sN22UQrFfviLLyCKzOs9btIJdxN36UU7hE4MvhZPHAb
         SbKpjQ10NPW+IazFFD/JHkWr3akLuf+hLAgJp0dHuPZn9MAxN3CxCTucFyovRbvRDp5I
         M6Nw==
X-Gm-Message-State: AOAM530fN3XcbmOU0/0i+rMZ5j6J+fUiwHb87VTUAHJP+NJPn4Sdd2fq
        uN1t36X6/8Qee2l3zV9oDMmiWg==
X-Google-Smtp-Source: ABdhPJzjyUh+LR9GJPN71pkjIX+r0WRrnEuSfi4PJuZCXq3w8Q9K/MPiknpf2qjWiSC6Jg5OmyyMQQ==
X-Received: by 2002:a1c:bcc1:: with SMTP id m184mr5069wmf.132.1605548243272;
        Mon, 16 Nov 2020 09:37:23 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 14/43] drm/radeon/radeon_drv: Move 'radeon_driver_irq_handler_kms's prototype into shared header
Date:   Mon, 16 Nov 2020 17:36:31 +0000
Message-Id: <20201116173700.1830487-15-lee.jones@linaro.org>
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
index a242b6053d47e..b8b7f627f0a9c 100644
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

