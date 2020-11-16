Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A82B4D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgKPRiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387483AbgKPRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:38:03 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B290C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:38:03 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so19652277wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6EGHBJr/siM/pdwXEUEQclk4ZNpHlp4udszmTbY7hrM=;
        b=UuKytIDbOl5cWtgBiIsWcmk9ftgGmt0ocZumuYxm/bwx2yewiFf7ODuEWIWUObEHwt
         u/6foaKVEKE7gFlKbWuWb0Y7knKW8H+gYjQY8UEn4ujHVnNw5RXWGtFUC6ISAdzmwmS7
         +3KmvW/h75YvcbtZcJoSTl0bs3A2kvABq1p1AuAdFzEnSvx8QjhtCxz7Bo7ZoPVxkzbi
         O8qEVO0+JppHqjPK2rDiYgMvBNL6IEwVh5R5YP5L5vGzYCyEc8RMaYWqnmkwkaJoYA/1
         6gcjOKEOJXxmVUbCAj/WEQRbp0GDt435I6cxJCgWzRVcdAO/isl87S9qubkTrh8VFn5S
         VD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6EGHBJr/siM/pdwXEUEQclk4ZNpHlp4udszmTbY7hrM=;
        b=ZuMUYfxPRWQTknwAja7tTIk6cfb1Be0o662e8s2dumfOU/w6j1KsB/spDidjHvoSIr
         CKAnDLAOu76d7KdfXBlfKH22/Llwsl9byUt5A6UFHcoyfUOEQQtLKToVkCXg3QIvLlD2
         sNU5V33+KvroUXVMM9xyDmPK0DPDGczzYzJkIYvPV6yMp7YXWzpPsC1Sbkpd+nbILosV
         nxiF5IvnSlATkZGVxj0c8XYmLaZR7czzHWdqjIu6NrAjL+mwW3rCmWPA7hwBymULpKHH
         M9adY9Nxvx/LUln6v2bUFIpf/sA8EZaWUjUJcTTvTwecfbRNbszHwInnHfOGxiTyZHij
         fEIg==
X-Gm-Message-State: AOAM530kjBrVmLpAholSfmlHrvIo/pmqytv7eScenzwR9Duw+2tBo09c
        FcgqS5H98OA5T9gsUYPaZ7ScBA==
X-Google-Smtp-Source: ABdhPJxzfocDhqgLAmUd/wvU5bZO7g89veQLZYQ5qcY6PqsH7itoImCY2hfETUgl3Ai7qVPqGfFApg==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr21997979wre.55.1605548282267;
        Mon, 16 Nov 2020 09:38:02 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:38:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 43/43] drm/radeon/radeon_drv: Move 'radeon_gem_prime_import_sg_table()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:37:00 +0000
Message-Id: <20201116173700.1830487-44-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_prime.c:43:24: warning: no previous prototype for ‘radeon_gem_prime_import_sg_table’ [-Wmissing-prototypes]
 43 | struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_device *dev,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c   | 4 +---
 drivers/gpu/drm/radeon/radeon_prime.h | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 211932d73b191..7a0989b397da1 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -55,6 +55,7 @@
 #include "radeon_ttm.h"
 #include "radeon.h"
 #include "radeon_device.h"
+#include "radeon_prime.h"
 
 /*
  * KMS wrapper.
@@ -129,9 +130,6 @@ int radeon_mode_dumb_mmap(struct drm_file *filp,
 int radeon_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args);
-struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_device *dev,
-							struct dma_buf_attachment *,
-							struct sg_table *sg);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/radeon/radeon_prime.h b/drivers/gpu/drm/radeon/radeon_prime.h
index 11b7f80987834..24ddfd4b48a6d 100644
--- a/drivers/gpu/drm/radeon/radeon_prime.h
+++ b/drivers/gpu/drm/radeon/radeon_prime.h
@@ -35,5 +35,8 @@ int radeon_gem_prime_pin(struct drm_gem_object *obj);
 void radeon_gem_prime_unpin(struct drm_gem_object *obj);
 void *radeon_gem_prime_vmap(struct drm_gem_object *obj);
 void radeon_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
+struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_device *dev,
+							struct dma_buf_attachment *,
+							struct sg_table *sg);
 
 #endif				/* __RADEON_PRIME_H__ */
-- 
2.25.1

