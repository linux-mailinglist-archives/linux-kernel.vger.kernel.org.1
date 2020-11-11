Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B22AF840
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKKShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKSgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:09 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C2C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so3503255wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noNY+SglbM8aEsCCdAF8dY+Y+lbfpcrhUN1CWHwGoPw=;
        b=otqPagV4SXXd1S4bOoNcEs67FQlaLvEbku6qmOoK8aE1zjdLYKVfZt2v7JkFaWtoGt
         doYNKSwpGKD6zLqXc1RSr97zszWJFrqrtVFwB+HAQ7qkJvhfIaU9qI9XjbLIi2Op/aL9
         TrIP0kutM2A86a1F2u6S3zDK33RL70wJY9BMgSuSjYlf0dBV8/pwJA18QUXQJvUpAGEb
         1ZKO9CR685LbV9yHiwaEocPif42d5g7zo9lzvVZs5Ni7nLvTPgjAT8U2kUchMUnD98Ka
         qf4zusM43Z6CxOQbTVYWg15XQw4u+Kj1yRWp+rOBegM5YgeBcvj02UUQMWNw2YA2bwLV
         P10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noNY+SglbM8aEsCCdAF8dY+Y+lbfpcrhUN1CWHwGoPw=;
        b=PwRCK3JS7ZH3EB3U9etjAZY+eclo4O7mwm1II/y2HJnEL8cX+vMCAi1EmIk1EzybXa
         X4XDum5naEpuUjbDBNEY/X6cUECfvhrIC+7km01zXcAW1JVsehuzO0FmfppCPl4yocHo
         j/bOWBq7eyB1zxLdIok7m3iYfc4WBHexjWpfn35/UbKqxuePwsuiNJl/ZKGDsCcoGNI+
         Z6dYm6c9CGFoxOhpoDWa3nk3Xqjnno0vo6ZUnNOD5uoJvZNMJcVZrnF/EcKtJPboWxEn
         f18jyz/0tJAAyihFa5aeJ7cO8UMFWwPB1v5IUEqNTZW39XFYuK5W+I793eBvnFqTTvlV
         Qdnw==
X-Gm-Message-State: AOAM533mTXPiYCugL+vb1NrIJ0Tpv5E2LgxGaJZ9zm7veBJnWmIOy3nY
        UCwjwTwquoU/6FGhZ4QCiu29Fw==
X-Google-Smtp-Source: ABdhPJyk4VxvkBNZmksenUKCaiv2Wpy5d4pXVvx1cgMaTTxc+0LopcRB94p7eD8HmBeh7yJOV7L25w==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr32946201wrx.164.1605119767603;
        Wed, 11 Nov 2020 10:36:07 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/19] drm/radeon/cik_sdma: Move 'amdgpu_cik_gpu_check_soft_reset()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:39 +0000
Message-Id: <20201111183545.1756994-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111183545.1756994-1-lee.jones@linaro.org>
References: <20201111183545.1756994-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/cik.c:4845:5: warning: no previous prototype for ‘cik_gpu_check_soft_reset’ [-Wmissing-prototypes]
 4845 | u32 cik_gpu_check_soft_reset(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/cik.h      | 1 +
 drivers/gpu/drm/radeon/cik_sdma.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.h b/drivers/gpu/drm/radeon/cik.h
index 297b3c1ff804f..6630b9da9e7aa 100644
--- a/drivers/gpu/drm/radeon/cik.h
+++ b/drivers/gpu/drm/radeon/cik.h
@@ -29,5 +29,6 @@ void cik_enter_rlc_safe_mode(struct radeon_device *rdev);
 void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
 int ci_mc_load_microcode(struct radeon_device *rdev);
 void cik_update_cg(struct radeon_device *rdev, u32 block, bool enable);
+u32 cik_gpu_check_soft_reset(struct radeon_device *rdev);
 
 #endif                         /* __CIK_H__ */
diff --git a/drivers/gpu/drm/radeon/cik_sdma.c b/drivers/gpu/drm/radeon/cik_sdma.c
index 3c709ebe8d1ab..919b14845c3c7 100644
--- a/drivers/gpu/drm/radeon/cik_sdma.c
+++ b/drivers/gpu/drm/radeon/cik_sdma.c
@@ -27,14 +27,13 @@
 #include "radeon_ucode.h"
 #include "radeon_asic.h"
 #include "radeon_trace.h"
+#include "cik.h"
 #include "cikd.h"
 
 /* sdma */
 #define CIK_SDMA_UCODE_SIZE 1050
 #define CIK_SDMA_UCODE_VERSION 64
 
-u32 cik_gpu_check_soft_reset(struct radeon_device *rdev);
-
 /*
  * sDMA - System DMA
  * Starting with CIK, the GPU has new asynchronous
-- 
2.25.1

