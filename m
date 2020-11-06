Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B282A9F77
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgKFVuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgKFVuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:14 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF71C0613D3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:13 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w1so2793804wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XN+cgxXjY3IWekASuJPYqV0dOA81c47vUDG0BBQb6c0=;
        b=HCGvUbcx5ZEN2tfKGwHJicVvv+pm5x43BHYd0mWRsxxz1IOqVirgnGczw7oawgtQXB
         7UygpB7ndYtvwbAuuhuaC6Qb2sfQK60p1OUOxbmCjKhcxzjmmm4TTDd1LFZtaWUZIudH
         GCsTzPE/zuBUGTLoiaFz52M0clHGNBXnsdLFW2mOxaO0RaV/pUYsX07zEX7Z0XNI/n1q
         AgU2ChqZX7giA7oo56qtWu8HkTrMDdt2oxJk+AYpkaHiYP0Ns4cEFV9WglGGP6sGMmVL
         FmVkjlPKqeawp62wfvotAn2I65hfXYwautS3PIWf0NqQV4Ei7ry86OU7eRNamQLgA1q1
         3crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XN+cgxXjY3IWekASuJPYqV0dOA81c47vUDG0BBQb6c0=;
        b=rX7PW1nVL+EvIeAI2vi+7d5KHAAlNaseezG/Sn0Cc8hkyY9gbikxl4NfaCwONhqzjN
         1Lq0+lsiIiihiY+RtV9Pj7dhXehSTyvqIyu3ofR76b8Alq7r62CSMhdSt8H+ym3zmRqj
         pw6B7Qf2dwKeLgyP+brWNz589DSl5buWl24TTrvmv3Q69P7NX+PqGPEWt6j6mN1fYzBi
         kz499WDCMfDgd98LY0DVKqE9lTYzTDy1x2Z13csmIJnWtBQOSLXWKxbxKayBjRBLA93n
         bm078MeeGBZj0Eig/LxIUOadKapDYfiGIrQ/UYRcfiiGLYSEFeH7VoRPGGi8yjl5fQtB
         NE3g==
X-Gm-Message-State: AOAM531OwrSVSy3c40v/so9PxP+vEcPtypGdgsi2i+iKJCVm0duWzNC/
        3ZFHuILIIFvZrKJpL8Csh3gqpEdWkK3/3q9M
X-Google-Smtp-Source: ABdhPJz9VXDl2U52UY4eXa5169UHGNjCTgPviCAyaRgtL3TzMxHGPQw76W+ApIl3BeVptCZSq2myUQ==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr4927117wrp.426.1604699412401;
        Fri, 06 Nov 2020 13:50:12 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:11 -0800 (PST)
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
Subject: [PATCH 15/19] drm/radeon: Move prototypes to shared header
Date:   Fri,  6 Nov 2020 21:49:45 +0000
Message-Id: <20201106214949.2042120-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_kms.c:756:5: warning: no previous prototype for ‘radeon_get_vblank_counter_kms’ [-Wmissing-prototypes]
 756 | u32 radeon_get_vblank_counter_kms(struct drm_crtc *crtc)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_kms.c:826:5: warning: no previous prototype for ‘radeon_enable_vblank_kms’ [-Wmissing-prototypes]
 826 | int radeon_enable_vblank_kms(struct drm_crtc *crtc)
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_kms.c:853:6: warning: no previous prototype for ‘radeon_disable_vblank_kms’ [-Wmissing-prototypes]
 853 | void radeon_disable_vblank_kms(struct drm_crtc *crtc)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

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
 drivers/gpu/drm/radeon/radeon.h         | 6 ++++++
 drivers/gpu/drm/radeon/radeon_display.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index e1132d86d2507..961a31b8805c2 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2832,6 +2832,12 @@ extern void radeon_program_register_sequence(struct radeon_device *rdev,
 					     const u32 array_size);
 struct radeon_device *radeon_get_rdev(struct ttm_bo_device *bdev);
 
+/* KMS */
+
+u32 radeon_get_vblank_counter_kms(struct drm_crtc *crtc);
+int radeon_enable_vblank_kms(struct drm_crtc *crtc);
+void radeon_disable_vblank_kms(struct drm_crtc *crtc);
+
 /*
  * vm
  */
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index b79686cf8bdbd..bd60f16fd0d78 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -45,10 +45,6 @@
 #include "atom.h"
 #include "radeon.h"
 
-u32 radeon_get_vblank_counter_kms(struct drm_crtc *crtc);
-int radeon_enable_vblank_kms(struct drm_crtc *crtc);
-void radeon_disable_vblank_kms(struct drm_crtc *crtc);
-
 static void avivo_crtc_load_lut(struct drm_crtc *crtc)
 {
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
-- 
2.25.1

